<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Profile extends RestApi_Controller 
{
    function __construct() 
    {
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
        $this->load->model('auth_model');
        $this->load->model('user_model');
    }

    public function my_profile()
    {
        $userId = $this->api_auth->getUserId();
        $user = $this->user_model->find($userId);
		unset($user->pwd);
        $data = array(
           'status' => true,
           'message' => 'successfully fetched my profile',
           'data' => $user
       );

       $this->response($data, 200);
    }

    public function change_profile()
    {
        $name = $this->request->data('name');
        $email = $this->request->data('email');
        $this->form_validation->set_rules('name','Name','required');
        $this->form_validation->set_rules('email','Email','required');
        if(!$this->form_validation->run())
        {
            $errorData = array(
                'status' => false,
                'message' => 'Data is invalid',
                'data' => []
            );

            $this->response($errorData, 200);
        }

        $currentUser = OscarAuth::getInstance()->user();

        if ($currentUser['email'] != $email && $this->auth_model->checkEmailExisted($email)) {
            $responseData = array(
                'status'=>false,
                'message' => 'Email is already exists by other user',
                'data'=> []
             );
            return $this->response($responseData);
        }

        $userId = $this->api_auth->getUserId();
        $data = array(
            'name' => $name,
            'email' => $email
        );
        $this->user_model->update($userId, $data);

        $data = array(
            'status' => true,
            'message' => 'Update user successfully',
            'data' => []
        );

        $this->response($data, 200);
    }

    public function password_change()
    {
        $oldPassword = $this->request->data('password_old');
        $password = $this->request->data('password');
        $password_confirmation = $this->request->data('password_confirmation');
        $this->form_validation->set_rules('password','Password','required');
        $this->form_validation->set_rules('password_confirmation','Password','required');
        if(!$this->form_validation->run())
        {
            $errorData = array(
                'status' => false,
                'message' => 'Data is invalid',
                'data' => []
            );

            $this->response($errorData, 200);
        }

        if ($password != $password_confirmation) {
            $errorData = array(
                'status' => false,
                'message' => 'Password confirmation is not match',
                'data' => []
            );

            $this->response($errorData, 200);
        }

        $currentPassword = $this->user_model->getPassword($this->api_auth->getUserId());
        if ($currentPassword != md5($oldPassword)) {
            $errorData = array(
                'status' => false,
                'message' => 'Old password is not correct',
                'data' => []
            );

            $this->response($errorData, 200);
        }

        $this->user_model->update($this->api_auth->getUserId(), array(
            'pwd' => md5($password)
        ));

        $data = array(
            'status' => true,
            'message' => 'Update password successfully',
            'data' => []
        );

        $this->response($data, 200);
    }
}

