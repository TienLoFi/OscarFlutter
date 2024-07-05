<?php 

class Auth_model extends BaseModel 
{
    function __construct()
    {
        parent::__construct();
        $this->load->model('user_model');
        $this->load->model('otp_model');
    }
    
    function registerUser($data)
    {
        $this->user_model->add($data);
        $oscarSetting = OscarSetting::getInstance();
        $confirmEmailRegister = $oscarSetting->get('confirm_email_register');
        if ($confirmEmailRegister) {
            $this->sendOTP($data['email'], OTP_model::ACTION_VERIFY_EMAIL_AFTER_REGISTER);
        }
    }

    function checkLogin($data)
    {
        $this->db->where($data);
        $query = $this->db->get('tb_users');
        if($query->num_rows()==1)
        {
            return $query->row();
        }
        else 
        {
            return false;
        }
    }

    function checkEmailExisted($email)
    {
        $this->db->where(array('email' => $email));
        $query = $this->db->get('tb_users');
        if($query->num_rows() > 0) return true;
        return false;
    }

    public function passswordRemind($email)
    {
        $this->sendOTP($email, OTP_model::ACTION_FORGOT_PASSWORD);
    }

    public function sendOTP($email, $action)
    {
        $otp = Ultils::generateOTP();
        $user = $this->user_model->findByEmail($email);
        $data = array(
            'otp' => $otp,
            'user_id' => $user->id,
            'action' => $action,
            'expiry_date' => Ultils::getTimeAfterHours(1),
            'created' => date('Y-m-d H:i:s')
        );
        $this->otp_model->add($data);
        $to = $email;
        $subject = 'Verification Code';
        $message = '';
        if ($action == OTP_model::ACTION_VERIFY_EMAIL_AFTER_REGISTER) {
            $message = 'Hi '.$user->name.'!'.'<p>You or someone has used this email to sign up for an OscarBallot account. 
            To verify your account, please enter the following verification code: <b style="color:red; font-size: 18px">'. $otp.'</b></p>';
        } elseif ($action == OTP_model::ACTION_FORGOT_PASSWORD) {
            $message = 'Hi '.$user->name.'!'.'<p> You or someone is using this email to reset the password for an OscarBallot account. To verify, please enter the following code: <b style="color:red; font-size: 18px">'. $otp.'</b></p>';
        }
        EmailNotificationService::getInstance()->sendEmail($to, $subject, $message);
    }

}