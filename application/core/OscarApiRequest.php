<?php

class OscarApiRequest {
    protected $data;

    function __construct($jsonString)
    {
        $this->data = json_decode($jsonString);
    }

    public function data($key =  null)
    {
        if (empty($key)) return $this->data;

        return $this->data->{$key}?? null;
    }
}