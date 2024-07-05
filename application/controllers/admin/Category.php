<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Category extends BaseAdminController {
	
	// constructor
	function __construct() {
		parent::__construct();
		
		$this->load->model('category_model');
		$this->load->model('user_model');
	}

    public function index()
    {
        $page = ($this->uri->segment(4)) ? $this->uri->segment(4) : 1;
        $search = $this->input->get('search');
        $limit = $this->input->get('limit');
        $status = $this->input->get('status');
        $parameter['page'] =  $page;
        $parameter['search'] =  $search;
        $parameter['limit'] =  $limit;
        $parameter['status'] =  $status;
        $mData = $this->category_model->list($parameter);
        $data['title'] = "OSCARS BALLOT- Award Categories";
        $data['isLogin'] = isset($this->session->userdata['sign']);
        $data['isActiveCategoryPage'] = true;
        $data['list'] = $mData['result'];
        $pagination = $this->pagination($mData['total'], $mData['limit'], $mData['page'], '/admin/category/index');
        $data['pagination'] = $pagination['pagination'];
        $data['pagination_string'] = $pagination['pagination_string'];
        $data['page_sizes'] = config_item('page_sizes');
        $this->load->view('admin/category/list', $data);
    }

    public function add()
    {
        $data['title'] = "OSCARS BALLOT- AWARD CATEGORY ADD";
        $data['isLogin'] = isset($this->session->userdata['sign']);
        $data['isActiveCategoryPage'] = true;
        $data['edit'] = false;
        $this->load->view('admin/category/add_edit', $data);
    }

    public function store()
    {
        $data['name'] = $this->input->post('name');
        $data['score'] = $this->input->post('score');
        $data['desc'] = $this->input->post('desc');
        $data['status'] = $this->input->post('status');
        $user = OscarAuth::getInstance()->user();
        $data['user_id'] = $user['id'];
        $data['created'] = date('y-m-d H:i:s');
        $data['updated'] = date('y-m-d H:i:s');
        $this->category_model->add($data);

        return redirect('admin/category/index');
    }


    public function edit()
    {
        $data['title'] = "OSCARS BALLOT- AWARD CATEGORY EDIT";
        $data['isLogin'] = isset($this->session->userdata['sign']);
        $data['isActiveCategoryPage'] = true;
        $data['edit'] = true;
        $id = $this->uri->segment(4);
        $category = $this->category_model->find($id);
        $data['category'] = $category;
        $this->load->view('admin/category/add_edit', $data);
    }

    public function update()
    {
        $id = $this->input->post('id');
        $data['name'] = $this->input->post('name');
        $data['score'] = $this->input->post('score');
        $data['desc'] = $this->input->post('desc');
        $data['status'] = $this->input->post('status');
        $user = OscarAuth::getInstance()->user();
        $data['user_id'] = $user['id'];
        $data['updated'] = date('y-m-d H:i:s');
        $this->category_model->update($id, $data);

        return redirect('admin/category/index');
    }


    public function delete()
    {
        $id = $this->input->post('id');
        $this->category_model->delete($id);
        return json_encode([
            'success' => true
        ]);
    }

    public function bulkDelete()
    {
        $ids = explode(',', $this->input->post('ids'));
        if (!empty($ids)) {
            foreach($ids as $id) {
                $this->category_model->delete($id);
            }
        }

        return json_encode([
            'success' => true
        ]);
    }
}