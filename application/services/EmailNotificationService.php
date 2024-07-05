<?php
class EmailNotificationService {
    protected $CI;
    protected static $instance;
    function __construct()
    {
        $this->CI = & get_instance();
    }

    public function sendEmail($to , $subject , $message) {
		$oscarSetting = OscarSetting::getInstance();
		$this->CI->load->library('phpmailer_lib');
		$mail = $this->CI->phpmailer_lib->load();

		$mail->IsSMTP(); 
		$mail->SMTPAuth = true; 

		$mail->SMTPSecure = $oscarSetting->get('smtp_secure'); 
		$mail->Host = $oscarSetting->get('smtp_host');
		$mail->Port = $oscarSetting->get('smtp_port');
        $mail->SMTPOptions = array(
          'ssl' => array(
            'verify_peer' => FALSE,
            'verify_peer_name' => FALSE,
            'allow_self_signed' => TRUE
          )
        );
		$mail->Username = $oscarSetting->get('smtp_username');
		$mail->Password = $oscarSetting->get('smtp_password');
		$mail->FromName = $oscarSetting->get('from_email');
		$mail->addAddress($to);
		$mail->AddReplyTo($oscarSetting->get('reply_to_email'));

		$mail->SetFrom($oscarSetting->get('from_email'), "OscarsBallotPredictions");
		$mail->isHTML(true);
		$mail->Subject = $subject;
		$mail->Body = $message;

		try {
			return $mail->Send();
		} catch(Exception $e){
			return false;
		}
	}

    public static function getInstance()
    {
        if (is_null(self::$instance)) {
            self::$instance = new EmailNotificationService();
        }

        return self::$instance;
    }
}