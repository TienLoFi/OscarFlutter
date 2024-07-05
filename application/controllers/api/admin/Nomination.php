<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Nomination extends RestApi_Controller {
	
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
		$this->load->model('nomination_model');
        $this->load->model('category_model');
		$this->load->model('user_model');
        $this->load->model('movie_model');
	}

    public function index()
    {
        $page = ($this->uri->segment(4)) ? $this->uri->segment(4) : 1;
        $search = $this->input->get('search');
        $limit = $this->input->get('limit');
        $year = $this->input->get('year');
        $status = $this->input->get('status');
        $parameter['page'] =  $page;
        $parameter['search'] =  $search;
        $parameter['limit'] =  $limit;
        $parameter['year'] =  $year;
        $parameter['status'] =  $status;
        $mData = $this->nomination_model->list($parameter);
        $data['title'] = "OSCARS BALLOT- MOVIES";
        $data['isLogin'] = isset($this->session->userdata['sign']);
        $data['isActiveNominationPage'] = true;
        $data['list'] = $mData['result'];
        $pagination = $this->pagination($mData['total'], $mData['limit'], $mData['page'], '/admin/nomination/index');
        $data['pagination'] = $pagination['pagination'];
        $data['pagination_string'] = $pagination['pagination_string'];
        $data['page_sizes'] = config_item('page_sizes');
        $this->load->view('admin/nomination/list', $data);
    }

    public function add()
    {
        $data['title'] = "OSCARS BALLOT- ADD MOVIE";
        $data['isLogin'] = isset($this->session->userdata['sign']);
        $data['isActiveNominationPage'] = true;
        $data['edit'] = false;
        $data['year'] = date('Y');
        $data['movies'] = $this->movie_model->movies($data['year']);
        $categories = $this->category_model->all();
        $data['categories'] = $categories;
        $this->load->view('admin/nomination/add_edit', $data);
    }

    public function store()
    {
        $data['name'] = $this->input->post('name');
        $data['year'] = $this->input->post('year');
        $data['desc'] = $this->input->post('desc');
        $user = OscarAuth::getInstance()->user();
        $data['user_id'] = $user['id'];
        $data['movie_id'] = $this->input->post('movie_id');
        $data['status'] = $this->input->post('status');
        $data['created'] = date('y-m-d H:i:s');
        $data['updated'] = date('y-m-d H:i:s');
        $categoryIds = $this->input->post('category_id');
        $nomination = $this->nomination_model->add($data);
        if ($nomination && !empty($categoryIds)) {
            $this->nomination_model->insertCategoryIds($nomination->id, $categoryIds);
        }

        return redirect('admin/nomination/index');
    }

    public function edit()
    {
        $data['title'] = "OSCARS BALLOT- MOVIE EDIT";
        $data['isLogin'] = isset($this->session->userdata['sign']);
        $data['isActiveNominationPage'] = true;
        $data['edit'] = true;
        $id = $this->uri->segment(4);
        $nomination = $this->nomination_model->find($id);
        $selectedIds = $this->nomination_model->getCategoryIds($id);
        $data['nomination'] = $nomination;
        $data['selectedIds'] = $selectedIds;
        $data['movies'] = $this->movie_model->movies($nomination->year);
        $categories = $this->category_model->all();
        $data['categories'] = $categories;
        $this->load->view('admin/nomination/add_edit', $data);
    }

    public function update()
    {
        $id = $this->input->post('id');
        
        $data['name'] = $this->input->post('name');
        $data['year'] = $this->input->post('year');
        $data['desc'] = $this->input->post('desc');
        $user = OscarAuth::getInstance()->user();
        $data['user_id'] = $user['id'];
        $data['movie_id'] = $this->input->post('movie_id');
        $data['status'] = $this->input->post('status');
        $data['updated'] = date('y-m-d H:i:s');
        $this->nomination_model->update($id, $data);
        $categoryIds = $this->input->post('category_id');
        if (!empty($categoryIds)) {
            $this->nomination_model->removeCategoryIds($id);
            $this->nomination_model->insertCategoryIds($id, $categoryIds);
        }
        return redirect('admin/nomination/index');
    }

    public function delete()
    {
        $id = $this->input->post('id');
        $this->nomination_model->delete($id);
        return json_encode([
            'success' => true
        ]);
    }

    public function bulkDelete()
    {
        $ids = explode(',', $this->input->post('ids'));
        if (!empty($ids)) {
            foreach($ids as $id) {
                $this->nomination_model->delete($id);
            }
        }

        return json_encode([
            'success' => true
        ]);
    }

    public function getMovies()
    {
        $year = $this->input->get('year');
        $movies = $this->movie_model->movies($year);
        $data['movies'] = $movies;
        $this->load->view('admin/nomination/movie_options', $data);
    }

}