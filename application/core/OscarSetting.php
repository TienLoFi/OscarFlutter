<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class OscarSetting
{
    protected $CI;

    function __construct()
    {
        $this->CI =& get_instance();
        $this->CI->load->database();
        $this->CI->load->model('setting_model');
    }

    public function get($key)
    {
        $setting = $this->CI->setting_model->findBy($key);
        if (empty($setting)) return null;
        if ($setting->type == 1 || $setting->type == 3) return $setting->value;
        if ($setting->type == 2) {
            $value_arr = json_decode($setting->value, true);
            return $value_arr['selected_value']??null;
        }

        return null;
    }

    public static function getInstance()
    {
        return new OscarSetting();
    }
}