<?php

Class Setting_model extends BaseModel {
    
	function __construct() {
		parent::__construct();
	}
    
    /**
     * Find a setting
     * @param int $id
     * @return object
     */
    public function find($id)
    {
        $sql = sprintf("SELECT * FROM tb_settings WHERE id = %d", $id);
        $query = $this->db->query($sql);
        $result = $query->result();

        return $result[0]?? null;
    }

    /**
     * Find a setting
     * @param string $key
     * @return object
     */
    public function findBy($key)
    {
        $sql = sprintf("SELECT * FROM tb_settings WHERE `key` = '%s' LIMIT 1", $key);
        $query = $this->db->query($sql);
        $result = $query->result();

        return $result[0]?? null;
    }

    /**
     * Update a setting
     * @param int $id
     * @param array $data
     * @return bool
     */
    public function update($id, $data)
    {
        $query = $this->db->where('id', $id);
        $this->db->update('tb_settings', $data);
    }

    /**
     * Store data setting
     * @param array $data
     * @return array
     */
    public function store($data = array()) 
    {
        if (empty($data['lock_ballot_page'])) $data['lock_ballot_page'] = 'off';
        if (empty($data['confirm_email_register'])) $data['confirm_email_register'] = 'off';
        foreach($data as $key => $value)
        {
            $setting = $this->findBy($key);

            if (!empty($setting)) {
                if ($setting->type == 1) {
                    $this->update($setting->id, array('value' => $value));
                } elseif ($setting->type == 2) {
                    $value_arr = json_decode($setting->value, true);
                    $value_arr['selected_value'] = $value;
                    $this->update($setting->id, array('value' => json_encode($value_arr)));
                } elseif ($setting->type == 3) {
                    $v = $value == 'on'?1:0;
                    $this->update($setting->id, array('value' => $v));
                }
                
            }
            
        }
    }

    /**
     * Get all settings
     * @return array
     */
    public function allSettings()
    {
        return $this->db->from('tb_settings')->get()->result();
    }
}