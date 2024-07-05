<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Movie extends RestApi_Controller {
	
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
		$this->load->model('movie_model');
		$this->load->model('user_model');
	}

    public function index()
    {
        $page = ($this->uri->segment(4)) ? $this->uri->segment(4) : 1;
        $search = $this->input->get('search');
        $limit = $this->input->get('limit');
        $status = $this->input->get('status');
        $year = $this->input->get('year');
        $parameter['page'] =  $page;
        $parameter['search'] =  $search;
        $parameter['limit'] =  $limit;
        $parameter['status'] =  $status;
        $parameter['year'] =  $year;
        $mData = $this->movie_model->list($parameter);
        $data['title'] = "OSCARS BALLOT- MOVIE";
        $data['isLogin'] = isset($this->session->userdata['sign']);
        $data['isActiveMoviePage'] = true;
        $data['list'] = $mData['result'];
        $pagination = $this->pagination($mData['total'], $mData['limit'], $mData['page'], '/admin/movie/index');
        $data['pagination'] = $pagination['pagination'];
        $data['pagination_string'] = $pagination['pagination_string'];
        $data['page_sizes'] = config_item('page_sizes');
        $this->load->view('admin/movie/list', $data);
    }

    public function add()
    {
        $data['title'] = "OSCARS BALLOT- MOVIE ADD";
        $data['isLogin'] = isset($this->session->userdata['sign']);
        $data['isActiveMoviePage'] = true;
        $data['edit'] = false;
        $this->load->view('admin/movie/add_edit', $data);
    }

    public function store()
    {
        $data['name'] = $this->input->post('name');
        $data['year'] = $this->input->post('year');
        $data['desc'] = $this->input->post('desc');
        $data['most_oscar'] = $this->input->post('most_oscar');
        $data['status'] = $this->input->post('status');
        $user = OscarAuth::getInstance()->user();
        $data['user_id'] = $user['id'];
        $data['created'] = date('y-m-d H:i:s');
        $data['updated'] = date('y-m-d H:i:s');
        $this->movie_model->add($data);

        return redirect('admin/movie/index');
    }


    public function edit()
    {
        $data['title'] = "OSCARS BALLOT- MOVIE EDIT";
        $data['isLogin'] = isset($this->session->userdata['sign']);
        $data['isActiveMoviePage'] = true;
        $data['edit'] = true;
        $id = $this->uri->segment(4);
        $movie = $this->movie_model->find($id);
        $data['movie'] = $movie;
        $this->load->view('admin/movie/add_edit', $data);
    }

    public function update()
    {
        $id = $this->input->post('id');
        $data['name'] = $this->input->post('name');
        $data['year'] = $this->input->post('year');
        $data['desc'] = $this->input->post('desc');
        $data['most_oscar'] = $this->input->post('most_oscar');
        $data['status'] = $this->input->post('status');
        $user = OscarAuth::getInstance()->user();
        $data['user_id'] = $user['id'];
        $data['updated'] = date('y-m-d H:i:s');
        $this->movie_model->update($id, $data);

        return redirect('admin/movie/index');
    }


    public function delete()
    {
        $id = $this->input->post('id');
        $this->movie_model->delete($id);
        return json_encode([
            'success' => true
        ]);
    }

    public function bulkDelete()
    {
        $ids = explode(',', $this->input->post('ids'));
        if (!empty($ids)) {
            foreach($ids as $id) {
                $this->movie_model->delete($id);
            }
        }

        return json_encode([
            'success' => true
        ]);
    }
}