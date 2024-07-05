<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class BaseModel extends CI_Model {
    /**
     * Constructor
     */
	function __construct() {
		parent::__construct();
	}

    /**
     * Get Query
     */
    public function getQuery()
    {
        $query = clone $this->db;
        $query->reset_query();

        return $query;
    }

}