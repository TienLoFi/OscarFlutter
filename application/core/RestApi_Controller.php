<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class RestApi_Controller extends CI_Controller 
{
    /**
     * @var OscarApiRequest
     */
    protected $request;

    function __construct()
    {
        parent::__construct();
        header('Access-Control-Allow-Origin: *');
		header("Access-Control-Allow-Headers: *");
        header("Access-Control-Allow-Methods: GET, PUT, POST, DELETE, PATCH, OPTIONS");
        header("Access-Control-Allow-Credentials: true");
        header("Access-Control-Max-Age: 3600");
        header('content-type: application/json; charset=utf-8');
        $this->request = new OscarApiRequest( $this->security->xss_clean($this->input->raw_input_stream));
        $data = json_decode(json_encode($this->request->data()), true);
        if (!empty($data)) {
            $this->form_validation->set_data($data);
        }
        
    }

    public function response($response, $code=401)
    {
        $this->output 
        ->set_status_header($code)
        ->set_content_type('application/json','utf-8')
        ->set_output(json_encode($response,JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE |JSON_UNESCAPED_SLASHES))
        ->_display();
        exit;
    }

}