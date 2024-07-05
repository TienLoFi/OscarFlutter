<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Auth extends RestApi_Controller 
{
    function __construct() 
    {
        parent::__construct();
        $this->load->library('api_auth');
        $this->load->model('auth_model');
        $this->load->model('otp_model');
    }

    function register()
    {
        $username = $this->request->data('name');
        $email = $this->request->data('email');
        $password = $this->request->data('password');
        $password_confirmation = $this->request->data('password_confirmation');

        $this->form_validation->set_rules('name','Name','required');
        $this->form_validation->set_rules('email','Email','required');
        $this->form_validation->set_rules('password','Pasword','required');
        $this->form_validation->set_rules('password_confirmation','Pasword','required');
        if (!$this->form_validation->run()) {
            $responseData = array(
                'status'=>false,
                'message' => 'Please fill all the required fields',
                'data'=> []
             );
            return $this->response($responseData);
        }

        if ($password != $password_confirmation) {
            $responseData = array(
                'status'=>false,
                'message' => 'Password confirmation is not match',
                'data'=> []
             );
            return $this->response($responseData);
        }

        if ($this->auth_model->checkEmailExisted($email)) {
            $responseData = array(
                'status'=>false,
                'message' => 'Email is already exists',
                'data'=> []
             );
            return $this->response($responseData);
        }

        $data  = array(
        'name' => $username,
        'email' => $email,
        'pwd '=> md5($password),
        'verify' => 0,
        'created' => date('Y-m-d H:i:s')
        );
        $this->auth_model->registerUser($data);
        $responseData = array(
        'status'=>true,
        'message' => 'Successfully Registerd',
        'data'=> []
        );
        return $this->response($responseData, 200);
    }

    function login() 
    {

        $email = $this->request->data('email');
        $password = $this->request->data('password');
        $this->form_validation->set_rules('email','Email','required');
        $this->form_validation->set_rules('password','Pasword','required');
        $this->form_validation->run();
        if($this->form_validation->run())
        {
             $data = array(
                'email' => $email, 
                'pwd' => md5($password)
             );
             $loginStatus = $this->auth_model->checkLogin($data);
             if($loginStatus != false) 
             {
                  $userId = $loginStatus->id;
                  $bearerToken = $this->api_auth->generateToken($userId);
                  $token = str_replace('.'.$this->api_auth->encrypt($userId), '', $bearerToken); 
                  $expiryDate =  $this->api_auth->findAuthToken($token, $userId);
                  $user = $this->user_model->find($userId);
                  unset($user->pwd);
                  $responseData = array(
                    'status'=> true,
                    'message' => 'Successfully Logged In',
                    'token'=> $bearerToken,
                    'expiry_date' => $expiryDate,
                    'user' => $user
                 );
                 return $this->response($responseData, 200);
             }
             else 
             {
                $responseData = array(
                    'status' => false,
                    'message' => 'Invalid Crendentials',
                    'data'=> []
                 );
                 return $this->response($responseData);
             }
        }
        else 
        {
            $responseData = array(
                'status' => false,
                'message' => 'Email and password is required',
                'data'=> []
             );
             return $this->response($responseData);
        }
    }

    public function password_remind()
    {
        $email = $this->request->data('email');

        $this->form_validation->set_rules('email','Email','required');
        if (!$this->form_validation->run()) {
            $responseData = array(
                'status'=>false,
                'message' => 'Email is invalid',
                'data'=> []
             );
            return $this->response($responseData);
        }

        $user = $this->user_model->findByEmail($email);

        if (empty($user)) {
            $responseData = array(
                'status'=>false,
                'message' => 'User is not exist',
                'data'=> []
             );
            return $this->response($responseData);
        }

        $this->auth_model->passswordRemind($email);

        $responseData = array(
            'status'=> true,
            'message' => 'Send forgot password successfully',
         );
         return $this->response($responseData,200);
    }

    public function password_reset()
    {
        $email = $this->request->data('email');
        $password = $this->request->data('password');
        $password_confirmation = $this->request->data('password_confirmation');
        $verifyCode = $this->request->data('verify_code');

        $this->form_validation->set_rules('password','Pasword','required');
        $this->form_validation->set_rules('password_confirmation','Pasword','required');

        if (!$this->form_validation->run()) {
            $responseData = array(
                'status'=>false,
                'message' => 'Please fill all the required fields',
                'data'=> []
             );
            return $this->response($responseData);
        }

        if ($password != $password_confirmation) {
            $responseData = array(
                'status'=>false,
                'message' => 'Password confirmation is not match',
                'data'=> []
             );
            return $this->response($responseData);
        }

        if (!$this->otp_model->checkValidOTP($email, OTP_model::ACTION_FORGOT_PASSWORD, $verifyCode)) {
            $responseData = array(
                'status'=>false,
                'message' => 'Your verification code is invalid',
                'data'=> []
             );
            return $this->response($responseData);
        }
        $user = $this->user_model->findByEmail($email);
        $this->user_model->update($user->id, array(
            'pwd' => md5($password)
        ));

        
        $responseData = array(
            'status'=> true,
            'message' => 'Reset password successfully',
         );
         return $this->response($responseData, 200);
    }

    public function resend_otp()
    {
        $email = $this->request->data('email');
        $action = $this->request->data('action');
        $this->form_validation->set_rules('email','Email','required');
        $this->form_validation->set_rules('action','required');
        if (!$this->form_validation->run()) {
            $responseData = array(
                'status'=>false,
                'message' => 'Data is invalid',
                'data'=> []
             );
            return $this->response($responseData);
        }

        $this->auth_model->sendOTP($email, $action);
        $responseData = array(
            'status'=> true,
            'message' => 'Resend OTP successfully',
            'data' => []
         );
         return $this->response($responseData, 200);
    }

    public function verify_otp()
    {
        $email = $this->request->data('email');
        $action = $this->request->data('action');
        $otp = $this->request->data('otp');
        $this->form_validation->set_rules('email','Email','required');
        $this->form_validation->set_rules('action','','required');
        $this->form_validation->set_rules('otp','', 'required');
        if (!$this->form_validation->run()) {
            $responseData = array(
                'status'=>false,
                'message' => 'Data is invalid',
                'data'=> []
             );
            return $this->response($responseData);
        }

        if (!$this->otp_model->checkValidOTP($email, $action, $otp)) {
            $responseData = array(
                'status'=>false,
                'message' => 'Your verification is invalid',
                'data'=> []
             );
            return $this->response($responseData);
        }
        $user = $this->user_model->findByEmail($email);
        if ($action == OTP_model::ACTION_VERIFY_EMAIL_AFTER_REGISTER) {
            
            $this->user_model->update($user->id, array(
                'verify' => 1,
                'status' => User_model::STATUS_ACTIVE,
                'updated' => date('Y-m-d H:i:s')
            ));
        }

        $this->db->from('tb_otps')
            ->where('otp', $otp)
            ->where('user_id', $user->id)
            ->where('action', $action)->delete();
        $responseData = array(
            'status'=> true,
            'message' => 'Verify OTP successfully',
            'user' => $user
         );
         return $this->response($responseData, 200);
    }
}