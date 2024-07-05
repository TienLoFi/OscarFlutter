<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Awardresult extends RestApi_Controller {
	
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
		$this->load->model('awardresult_model');
        $this->load->model('category_model');
	}

    public function index()
    {
        $page = $this->input->get('page');
        $search = $this->input->get('search');
        $limit = $this->input->get('limit');
        $status = $this->input->get('status');
        $parameter['page'] =  $page??1;
        $parameter['search'] =  $search;
        $parameter['limit'] =  $limit;
        $parameter['status'] =  $status;
        $mData = $this->awardresult_model->list($parameter);
        $data['data'] = $mData['result'];
        $data['metadata']['page_sizes'] = config_item('page_sizes');
        $data['metadata']['statuses'] = array(
            Awardresult_model::STATUS_ACTIVE => 'Active',
            Awardresult_model::STATUS_INACTIVE => 'Inactive',
        );
        
        return json_encode([
            'status' => 'success',
            'code' => 200,
            'data' => $data
        ]);
    }

    public function add()
    {
        $data['title'] = "OSCARS BALLOT- AWARD Result ADD";
        $data['isLogin'] = isset($this->session->userdata['sign']);
        $data['isActiveAwardResultPage'] = true;
        $data['edit'] = false;
        $problems = [];
        $categories = $this->category_model->all();
        if (!empty($categories)) {
            foreach($categories as $category) {
                $problems[$category->name] = [
                    'category_id' => $category->id,
                    'nominations' => $this->category_model->nominations($category->id)
                ];
            }
        }
        $data['problems'] = $problems;
        $this->load->view('admin/awardresult/add_edit', $data);
    }

    public function store()
    {
        $data['name'] = $this->input->post('name');
        $data['desc'] = $this->input->post('desc');
        $data['status'] = $this->input->post('status');
        $user = OscarAuth::getInstance()->user();
        $data['user_id'] = $user['id'];
        $categoryIds = $this->input->post('category_ids');
        $nominationIds = $this->input->post('nomination_ids');
        $data['year'] = $this->input->post('year');
        $data['created'] = date('y-m-d H:i:s');
        $data['updated'] = date('y-m-d H:i:s');
        $awardresult = $this->awardresult_model->add($data);
        $this->awardresult_model->SaveResultItems($awardresult->id, $categoryIds, $nominationIds);
        return redirect('admin/awardresult/index');
    }


    public function edit()
    {
        $data['title'] = "OSCARS BALLOT- AWARD Result EDIT";
        $data['isLogin'] = isset($this->session->userdata['sign']);
        $data['isActiveAwardResultPage'] = true;
        $data['edit'] = true;
        $id = $this->uri->segment(4);
        $awardResult = $this->awardresult_model->find($id);
        $data['awardResult'] = $awardResult;
        $categories = $this->category_model->all();
        if (!empty($categories)) {
            foreach($categories as $category) {
                $selectedNominationItem = $this->awardresult_model->selectedNomination($awardResult->id, $category->id);
                $problems[$category->name] = [
                    'selected_nomination_id' => $selectedNominationItem->nomination_id,
                    'category_id' => $category->id,
                    'nominations' => $this->category_model->nominations($category->id)
                ];
            }
        }
        $data['problems'] = $problems;
        $this->load->view('admin/awardresult/add_edit', $data);
    }

    public function update()
    {
        $id = $this->input->post('id');
        $data['name'] = $this->input->post('name');
        $data['desc'] = $this->input->post('desc');
        $data['year'] = $this->input->post('year');
        $data['status'] = $this->input->post('status');
        $categoryIds = $this->input->post('category_ids');
        $nominationIds = $this->input->post('nomination_ids');

        $user = OscarAuth::getInstance()->user();
        $data['user_id'] = $user['id'];
        $data['updated'] = date('y-m-d H:i:s');
        $this->awardresult_model->update($id, $data);
        $this->awardresult_model->SaveResultItems($id, $categoryIds, $nominationIds);
        return redirect('admin/awardresult/index');
    }


    public function delete()
    {
        $id = $this->input->post('id');
        $this->awardresult_model->delete($id);
        return json_encode([
            'success' => true
        ]);
    }

    public function bulkDelete()
    {
        $ids = explode(',', $this->input->post('ids'));
        if (!empty($ids)) {
            foreach($ids as $id) {
                $this->awardresult_model->delete($id);
            }
        }

        return json_encode([
            'success' => true
        ]);
    }
}