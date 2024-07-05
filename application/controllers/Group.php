<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Group extends BaseAdminController {
	
	// constructor
	function __construct() {
		parent::__construct();
		
		$this->load->model('group_model');
		$this->load->model('user_model');
	}

    public function index()
    {
        $page = ($this->uri->segment(3)) ? $this->uri->segment(3) : 1;
        $search = $this->input->get('search');
        $limit = $this->input->get('limit');
        $leaderId = $this->input->get('leader_id');
        $status = $this->input->get('status');
        $parameter['page'] =  $page;
        $parameter['search'] =  $search;
        $parameter['limit'] =  $limit;
        $parameter['leader_id'] =  $leaderId;
        $parameter['status'] =  $status;
        $mData = $this->group_model->myGroups($parameter);
        $data['title'] = "OSCARS BALLOT- Groups";
        $data['isLogin'] = isset($this->session->userdata['sign']);
        $data['isActiveGroupPage'] = true;
        $data['list'] = $mData['result'];
        $pagination = $this->pagination($mData['total'], $mData['limit'], $mData['page'], '/group/index');
        $data['pagination'] = $pagination['pagination'];
        $data['pagination_string'] = $pagination['pagination_string'];
        $data['page_sizes'] = config_item('page_sizes');
        $data['users'] = $this->user_model->getAllUsers();
        $data['user'] = OscarAuth::getInstance()->user();
        $this->load->view('group/list', $data);
    }

    public function add()
    {
        $data['title'] = "OSCARS BALLOT- GROUP ADD";
        $data['isLogin'] = isset($this->session->userdata['sign']);
        $data['isActiveGroupPage'] = true;
        $data['edit'] = false;
        $data['users'] = $this->user_model->getAllUsers();
        $this->load->view('group/add_edit', $data);
    }

    public function store()
    {
        $user = OscarAuth::getInstance()->user();
        $data['name'] = $this->input->post('name');
        $data['desc'] = $this->input->post('desc');
        $data['status'] = $this->input->post('status');
        $data['leader_id'] = $user['id'];
        $data['user_id'] = $user['id'];
        $data['group_number'] = $this->input->post('group_number');
        $data['group_password'] = $this->input->post('group_password');
        $data['created'] = date('y-m-d H:i:s');
        $data['updated'] = date('y-m-d H:i:s');
        $this->group_model->add($data);

        return redirect('group/index');
    }

    public function join()
    {
        $data['isLogin'] = isset($this->session->userdata['sign']);
        $data['isActiveGroupPage'] = true;
        $data['edit'] = false;
        $this->load->view('group/join_group', $data);
    }

    public function storeJoinGroup()
    {
        $user =  OscarAuth::getInstance()->user();
        $userId = $user['id'];
        $groupNumber = $this->input->post('group_number');
        $groupPassword = $this->input->post('group_password');
        $this->group_model->joinGroup($userId, $groupNumber, $groupPassword);

        return redirect('group/index');
    }

    public function view()
    {
        $data['title'] = "OSCARS BALLOT- GROUP VIEW";
        $data['isLogin'] = isset($this->session->userdata['sign']);
        $data['isActiveGroupPage'] = true;
        $data['edit'] = false;
        $id = $this->uri->segment(3);
        $group = $this->group_model->find($id);
        $data['group'] = $group;
        $data['users'] = $this->user_model->getAllUsers();
        $this->load->view('group/view', $data);
    }

    public function edit()
    {
        $data['title'] = "OSCARS BALLOT- GROUP EDIT";
        $data['isLogin'] = isset($this->session->userdata['sign']);
        $data['isActiveGroupPage'] = true;
        $data['edit'] = true;
        $id = $this->uri->segment(3);
        $group = $this->group_model->find($id);
        $data['group'] = $group;
        $data['users'] = $this->user_model->getAllUsers();
        $this->load->view('group/add_edit', $data);
    }

    public function update()
    {
        $id = $this->input->post('id');
        
        $data['name'] = $this->input->post('name');
        $data['desc'] = $this->input->post('desc');
        $data['status'] = $this->input->post('status');
        $data['group_number'] = $this->input->post('group_number');
        $data['group_password'] = $this->input->post('group_password');
        $data['updated'] = date('y-m-d H:i:s');
        $this->group_model->update($id, $data);

        return redirect('group/index');
    }


    public function delete()
    {
        $id = $this->input->post('id');
        $this->group_model->delete($id);
        return json_encode([
            'success' => true
        ]);
    }

    public function bulkDelete()
    {
        $ids = explode(',', $this->input->post('ids'));
        if (!empty($ids)) {
            foreach($ids as $id) {
                $this->group_model->delete($id);
            }
        }

        return json_encode([
            'success' => true
        ]);
    }

    public function members()
    {
        $groupId = $this->input->get('group_id');
        $search = $this->input->get('search');
        $limit = $this->input->get('limit');
        $status = $this->input->get('status');
        $parameter['search'] =  $search;
        $parameter['limit'] =  $limit;
        $parameter['status'] =  $status;
        $mData = $this->group_model->members($groupId, $parameter);
        $data['members'] = $mData['result'];
        $data['total'] = $mData['total'];
        $pagination = $this->pagination($mData['total'], $mData['limit'], $mData['page'], '/group/members');
        $data['pagination'] = $pagination['pagination'];
        $data['pagination_string'] = $pagination['pagination_string'];
        $data['page_sizes'] = config_item('page_sizes');
        $this->load->view('group/members', $data);
    }

    public function viewMembers()
    {
        $groupId = $this->input->get('group_id');
        $search = $this->input->get('search');
        $limit = $this->input->get('limit');
        $status = $this->input->get('status');
        $parameter['search'] =  $search;
        $parameter['limit'] =  $limit;
        $parameter['status'] =  Group_model::STATUS_GROUP_ACTIVE;
        $mData = $this->group_model->members($groupId, $parameter);
        $data['members'] = $mData['result'];
        $data['total'] = $mData['total'];
        $pagination = $this->pagination($mData['total'], $mData['limit'], $mData['page'], '/group/members');
        $data['pagination'] = $pagination['pagination'];
        $data['pagination_string'] = $pagination['pagination_string'];
        $data['page_sizes'] = config_item('page_sizes');
        $this->load->view('group/view_members', $data);
    }

    public function addMember()
    {
        $data['users'] = $this->user_model->getAllUsers();
        $this->load->view('group/add_member', $data);
    }


    public function storeMember()
    {
        $memberId = $this->input->post('member_id');
        $groupId = $this->input->post('group_id');
        $status = Group_model::STATUS_GROUP_PENDING;
        $groupMember = $this->group_model->addMember($groupId, $memberId, $status);
        return json_encode([
            'success' => true,
            'data' => $groupMember
        ]);
    }

    public function deleteMember()
    {
        $memberId = $this->input->post('member_id');
        $this->group_model->deleteMember($memberId);
        return json_encode([
            'success' => true
        ]);
    }

    public function bulkDeleteMembers()
    {
        $ids = explode(',', $this->input->post('member_ids'));
        $this->group_model->removeMembers($ids);
        return json_encode([
            'success' => true
        ]);
    }
}