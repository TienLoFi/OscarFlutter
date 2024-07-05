<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Group extends RestApi_Controller {
	
	// constructor
	function __construct() {
		parent::__construct();
        $this->load->library('api_auth');
        if($this->api_auth->isNotAuthenticated())
        {
            $err = array(
                'status' => false,
                'message' => 'unauthorised',
                'data' => []
            );
            $this->response($err);
        }
		$this->load->model('group_model');
		$this->load->model('user_model');
        $this->load->model('invite_model');
	}

    public function index()
    {
        $page = $this->request->data('page')??1;
        $search = $this->request->data('search');
        $limit = $this->request->data('limit');
        $leaderId = $this->request->data('leader_id');
        $status = $this->request->data('status');
        $parameter['page'] =  $page;
        $parameter['search'] =  $search;
        $parameter['limit'] =  $limit;
        $parameter['leader_id'] =  $leaderId;
        $parameter['status'] =  $status;
        $user =  OscarAuth::getInstance()->user();
        $userId = $user['id'];
        $data['invite_list_count'] = $this->group_model->inviteListCount($userId);
        $mData = $this->group_model->myGroups($parameter);
        $data['result'] = $mData;
        $data['metadata']['page_sizes'] = config_item('page_sizes');
        $data['metadata']['leaders'] = $this->group_model->getGroupLeaders();
        $data['metadata']['statuses'] = array(
            Group_model::STATUS_ACTIVE => 'Active',
            Group_model::STATUS_INACTIVE => 'Inactive',
        ); 
        $dataResult = array(
            'status' => true,
            'message' => 'Fetch group list successfully',
            'data' => $data
        );
 
        $this->response($dataResult, 200);
    }

    public function get_add_data()
    {
        $data['metadata']['statuses'] = array(
            Group_model::STATUS_ACTIVE => 'Active',
            Group_model::STATUS_INACTIVE => 'Inactive',
        ); 
        $dataResult = array(
            'status' => true,
            'message' => 'Fetch add data successfully',
            'data' => $data
        );
        $this->response($dataResult, 200);
    }

    public function add()
    {
        $user = OscarAuth::getInstance()->user();
        $data['name'] = $this->request->data('name');
        $data['desc'] = $this->request->data('desc');
        $data['status'] = $this->request->data('status');
        $data['leader_id'] = $user['id'];
        $data['user_id'] = $user['id'];
        $data['group_number'] = $this->request->data('group_number');
        $data['group_password'] = $this->request->data('group_password');
        $data['created'] = date('y-m-d H:i:s');
        $data['updated'] = date('y-m-d H:i:s');
        $group = $this->group_model->add($data);

        $dataResult = array(
            'status' => true,
            'message' => 'Add group successfully',
            'data' => $group
        );
 
        $this->response($dataResult, 200);
    }

    public function join_group()
    {
        $user =  OscarAuth::getInstance()->user();
        $userId = $user['id'];
        $groupNumber = $this->request->data('group_number');
        $groupPassword = $this->request->data('group_password');
        $this->group_model->joinGroup($userId, $groupNumber, $groupPassword);

        $dataResult = array(
            'status' => true,
            'message' => 'Join group successfully',
            'data' => []
        );
 
        $this->response($dataResult, 200);
    }

    public function detail()
    {
        $id = $this->uri->segment(5);
        $group = $this->group_model->find($id);
        $leader = $this->user_model->find($group->leader_id);
        $group->leader_name = $leader->name??'';
        $group->leader_email = $leader->email??'';
        $group->members = $this->group_model->getGroupMembers($group->id);
        $dataResult = array(
            'status' => true,
            'message' => 'Fetch group detail successfully',
            'data' => $group
        );
 
        $this->response($dataResult, 200);
    }

    public function get_edit_data()
    {
        $id = $this->uri->segment(5);
        $group = $this->group_model->find($id);
        $data['group'] = $group;
        $data['metadata']['statuses'] = array(
            Group_model::STATUS_ACTIVE => 'Active',
            Group_model::STATUS_INACTIVE => 'Inactive',
        ); 
        $dataResult = array(
            'status' => true,
            'message' => 'Fetch add data successfully',
            'data' => $data
        );
        $this->response($dataResult, 200);
    }

    public function update()
    {
        $id = $this->uri->segment(5);
        
        $data['name'] = $this->request->data('name');
        $data['desc'] = $this->request->data('desc');
        $data['group_number'] = $this->request->data('group_number');
        $data['group_password'] = $this->request->data('group_password');
        $data['updated'] = date('y-m-d H:i:s');
        $this->group_model->update($id, $data);

        $dataResult = array(
            'status' => true,
            'message' => 'Update group successfully',
            'data' => []
        );
 
        $this->response($dataResult, 200);
    }


    public function delete()
    {
        $id = $this->uri->segment(5);
        $this->group_model->delete($id);
        $dataResult = array(
            'status' => true,
            'message' => 'Delete group successfully',
            'data' => []
        );

        $this->response($dataResult, 200);
    }

    public function bulk_delete()
    {
        $ids = $this->request->data('ids');
        if (!empty($ids)) {
            foreach($ids as $id) {
                $this->group_model->delete($id);
            }
        }

        $dataResult = array(
            'status' => true,
            'message' => 'Bulk delete group successfully',
            'data' => []
        );

        $this->response($dataResult, 200);
    }

    public function members()
    {
        $groupId = $this->uri->segment(5);
        $search = $this->input->get('search');
        $status = $this->input->get('status');
        $parameter['search'] = $search;
        $parameter['status'] = $status;
        $mData = $this->group_model->members($groupId, $parameter);
        $data['metadata']['statuses'] = array(
            Group_model::STATUS_ACTIVE => 'Active',
            Group_model::STATUS_INACTIVE => 'Inactive',
        );
        $data['result'] = $mData;
        $dataResult = array(
            'status' => true,
            'message' => 'Fetch group member list successfully',
            'data' => $data
        );
        $this->response($dataResult, 200);
    }


    public function add_member()
    {
        $memberId = $this->request->data('member_id');
        $groupId = $this->request->data('group_id');
        $status = Group_model::STATUS_GROUP_PENDING;
        $this->group_model->addMember($groupId, $memberId, $status);

        $dataResult = array(
            'status' => true,
            'message' => 'Add member successfully',
            'data' => []
        );
        $this->response($dataResult, 200);
    }

    public function delete_member()
    {
        $memberId = $this->request->data('member_id');
        $groupId = $this->request->data('group_id');
        $this->group_model->removeMember($groupId, $memberId);

        $dataResult = array(
            'status' => true,
            'message' => 'Remove member successfully',
            'data' => []
        );

        $this->response($dataResult, 200);
    }


    public function search_members()
    {
        $search = $this->input->get('search');

        $data = $this->group_model->searchMembers($search);
        $dataResult = array(
            'status' => true,
            'message' => 'Search members successfully',
            'data' => $data
        );

        $this->response($dataResult, 200);
    }

    public function send_invite()
    {
        $user =  OscarAuth::getInstance()->user();
        $currentUserId = $user['id'];
        $memberIds = $this->request->data('member_ids');
        $groupId = $this->request->data('group_id');
        $group = $this->group_model->find($groupId);
        foreach($memberIds as $memberId) {
            $user = $this->user_model->find($memberId);
            $this->invite_model->add(array(
                'user_id' => $memberId,
                'group_id' => $groupId,
                'creator_id' => $currentUserId,
                'status' => Invite_model::STATUS_PENDING
            ));
            $this->group_model->addMember($groupId, $memberId, Group_model::STATUS_GROUP_PENDING);
        }
        foreach($memberIds as $memberId) {
            $to = $user->email;
            $subject = 'Group Invite';
            $message = "<p>
                You are invited to join the '$group->name' group on the OscarBallot App. Please accept the invitation on the app or join using the following information:
                <ul>
                    <li>Group Number: $group->group_number</li>
                    <li>Group Password: $group->group_password</li>
                </ul>
                </p>";
            EmailNotificationService::getInstance()->sendEmail($to, $subject, $message);
        }

        $dataResult = array(
            'status' => true,
            'message' => 'Send invite successfully',
            'data' => []
        );

        $this->response($dataResult, 200);
    }

    public function accept_invite()
    {
        $inviteId =  $this->uri->segment(5);
        $invite = $this->invite_model->find($inviteId);
        $memberId = $invite->user_id;
        $groupId = $invite->group_id;
        $this->invite_model->update($inviteId, array(
            'status' => Invite_model::STATUS_ACCEPT
        ));
        $this->group_model->updateStatusGroupMember($memberId, $groupId, Group_model::STATUS_GROUP_ACTIVE);
        $dataResult = array(
            'status' => true,
            'message' => 'Accept invite successfully',
            'data' => []
        );

        $this->response($dataResult, 200);
    }

    public function reject_invite()
    {
        $inviteId =  $this->uri->segment(5);
        $this->invite_model->update($inviteId, array(
            'status' => Invite_model::STATUS_REJECT
        ));

        $dataResult = array(
            'status' => true,
            'message' => 'Reject invite successfully',
            'data' => []
        );

        $this->response($dataResult, 200);
    }

    public function leave()
    {
        $user =  OscarAuth::getInstance()->user();
        $userId = $user['id'];
        $groupId = $this->uri->segment(5);
        $this->group_model->removeMember($groupId, $userId);
        $dataResult = array(
            'status' => true,
            'message' => 'Leave group successfully',
            'data' => []
        );

        $this->response($dataResult, 200);
    }

    public function invitation_list()
    {
        $user =  OscarAuth::getInstance()->user();
        $userId = $user['id'];
        $inviteList = $this->group_model->inviteList($userId);

        $dataResult = array(
            'status' => true,
            'message' => 'Get invitation list successfully',
            'data' => $inviteList
        );

        $this->response($dataResult, 200);
    }
}