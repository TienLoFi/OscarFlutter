<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Setting extends RestApi_Controller {
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
		$this->load->model('setting_model');
	}

    public function index()
    {
        $data['title'] = "OSCARS BALLOT- SETTING";
        $data['isLogin'] = isset($this->session->userdata['sign']);
        $data['isActiveSettingPage'] = true;
        $data['settings'] = $this->setting_model->allSettings();
        $this->load->view('admin/setting/index', $data);
    }

    public function store()
    {
        $data = $this->input->post();
        $this->setting_model->store($data);
        return redirect('admin/setting/index');
    }

}