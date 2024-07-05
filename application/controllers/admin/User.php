<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class User extends BaseAdminController {
	
	// constructor
	function __construct() {
		parent::__construct();
		
		$this->load->model('user_model');
        $this->load->model('group_model');
	}

    public function index()
    {
        $page = ($this->uri->segment(4)) ? $this->uri->segment(4) : 1;
        $search = $this->input->get('search');
        $limit = $this->input->get('limit');
        $status = $this->input->get('status');
        $roleId = $this->input->get('role_id');
        $groupId = $this->input->get('group_id');
        $parameter['page'] =  $page;
        $parameter['search'] =  $search;
        $parameter['limit'] =  $limit;
        $parameter['status'] =  $status;
        $parameter['role_id'] =  $roleId;
        $parameter['group_id'] =  $groupId;
        $mData = $this->user_model->list($parameter);
        $data['title'] = "OSCARS BALLOT- Users";
        $data['isLogin'] = isset($this->session->userdata['sign']);
        $data['isActiveUserPage'] = true;
        $data['list'] = $mData['result'];
        $pagination = $this->pagination($mData['total'], $mData['limit'], $mData['page'], '/admin/user/index');
        $data['pagination'] = $pagination['pagination'];
        $data['pagination_string'] = $pagination['pagination_string'];
        $data['page_sizes'] = config_item('page_sizes');
        $data['roles'] =  $this->user_model->roles();
        $data['groups'] =  $this->group_model->allGroups();
        $this->load->view('admin/user/list', $data);
    }

    public function add()
    {
        $data['title'] = "OSCARS BALLOT- USER ADD";
        $data['isLogin'] = isset($this->session->userdata['sign']);
        $data['isActiveUserPage'] = true;
        $data['edit'] = false;
        $data['roles'] =  $this->user_model->roles();
        $this->load->view('admin/user/add_edit', $data);
    }

    public function store()
    {
        $data['name'] = $this->input->post('name');
        $data['email'] = $this->input->post('email');
        $data['status'] = $this->input->post('status');
        $data['role_id'] = $this->input->post('role_id');
        $data['verify'] = $this->input->post('verify');
        $password = $this->input->post('password');
        if (!empty($password)) {
            $data['password'] = md5($password);
        }
        $data['created'] = date('y-m-d H:i:s');
        $data['updated'] = date('y-m-d H:i:s');
        $this->user_model->add($data);

        return redirect('admin/user/index');
    }


    public function edit()
    {
        $data['title'] = "OSCARS BALLOT- USER EDIT";
        $data['isLogin'] = isset($this->session->userdata['sign']);
        $data['isActiveUserPage'] = true;
        $data['edit'] = true;
        $id = $this->uri->segment(4);
        $user = $this->user_model->find($id);
        $data['user'] = $user;
        $data['roles'] =  $this->user_model->roles();
        $this->load->view('admin/user/add_edit', $data);
    }

    public function update()
    {
        $id = $this->input->post('id');
        $data['name'] = $this->input->post('name');
        $data['email'] = $this->input->post('email');
        $data['status'] = $this->input->post('status');
        $data['role_id'] = $this->input->post('role_id');
        $data['verify'] = $this->input->post('verify');
        $password = $this->input->post('password');
        if (!empty($password)) {
            $data['password'] = md5($password);
        }
        $data['updated'] = date('y-m-d H:i:s');
        $this->user_model->update($id, $data);

        return redirect('admin/user/index');
    }


    public function delete()
    {
        $id = $this->input->post('id');
        $this->user_model->delete($id);
        return json_encode([
            'success' => true
        ]);
    }

    public function bulkDelete()
    {
        $ids = explode(',', $this->input->post('ids'));
        if (!empty($ids)) {
            foreach($ids as $id) {
                $this->user_model->delete($id);
            }
        }

        return json_encode([
            'success' => true
        ]);
    }
}