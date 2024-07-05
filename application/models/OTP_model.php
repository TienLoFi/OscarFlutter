<?php

class Otp_model extends BaseModel {

    const ACTION_VERIFY_EMAIL_AFTER_REGISTER = 'ACTION_VERIFY_EMAIL_AFTER_REGISTER';
    const ACTION_FORGOT_PASSWORD = 'ACTION_FORGOT_PASSWORD';
    
    function __construct()
    {
        parent::__construct();
        $this->load->model('user_model');
    }

    /**
     * Add a new OTP
     * @param array $data
     * @return array
     */
    public function add($data = array())
    {
        $this->db->insert('tb_otps', $data);

        $id = $this->db->insert_id();
        return $this->find($id);
    }

    /**
     * Find a OTP by Id
     * @param int $id
     * @return array
     */
    public function find($id)
    {
        $sql = sprintf("SELECT * FROM tb_otps WHERE id = %d", $id);
        $query = $this->db->query($sql);
        $result = $query->result();
        return $result[0]?? null;
    }

    /**
     * Check valid OTP
     * @param string $email
     * @param string $action
     * @param string $otp
     * @return bool
     */
    public function checkValidOTP($email, $action, $otp)
    {
        $user = $this->user_model->findByEmail($email);
        if (empty($user)) return false;
        $currentDate = date('Y-m-d H:i:s');
        $numRow = $this->db->from('tb_otps')
            ->where('otp', $otp)
            ->where('user_id', $user->id)
            ->where('action', $action)
            ->where('expiry_date >=', $currentDate)
            ->get()
            ->num_rows() > 0;

        return $numRow > 0;
    }
}