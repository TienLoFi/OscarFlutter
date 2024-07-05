<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class OscarAuth {
    protected $CI;
    protected static $instance;
    function __construct()
    {
        $this->CI = & get_instance();
        $this->CI->load->library('api_auth');
        $this->CI->load->database();
        $this->CI->load->model('user_model');
    }
    public function user()
    {
        $user = $_SESSION['sign']?? [];
        if (empty($user)) {
            $userId = $this->CI->api_auth->getUserId();
            if (empty($userId)) return null;
            $user = $this->CI->user_model->find($userId);
            $user = json_decode(json_encode($user), true);
            unset($user['pwd']);
        }

        return $user;
    }

    public function hasRole($role)
    {
        $sql = sprintf("SELECT * FROM tb_roles WHERE code = '%s' LIMIT 1", $role);
        $query = $this->CI->db->query($sql);
        $result = $query->result();
        $roleObj = $result[0]??null;
        $user = self::user();
        return !empty($roleObj) && $roleObj->id == $user['role_id'];
    }

    public static function getInstance()
    {
        if (is_null(self::$instance)) {
            self::$instance = new OscarAuth();
        }

        return self::$instance;
    }
}