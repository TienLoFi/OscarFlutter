<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class BaseAdminController extends CI_Controller {
    // constructor
	function __construct() {
		parent::__construct();
        if (!isset($this->session->userdata['sign'])) {
			
			header("Location: " . base_url());
		}
		$this->load->library('pagination');
	}

	protected function pagination($total, $limit, $page, $baseUrl)
	{
        $config['base_url'] = $baseUrl;
        $config['total_rows'] = $total;
        $config['per_page'] = $limit;
        $config['use_page_numbers'] = true;
		$config['uri_segment'] = 4;
        $config['full_tag_open'] = '<ul class="pagination">';
        $config['full_tag_close'] = '</ul>';
		$config['first_tag_open'] = '<li class="paginate_button" aria-controls="datatable-editable" tabindex="0">';
		$config['first_tag_close'] = '</li>';
		$config['last_tag_open'] = '<li class="paginate_button" aria-controls="datatable-editable" tabindex="0">';
		$config['last_tag_close'] = '</li>';
		$config['cur_tag_open'] = '<li class="paginate_button active" aria-controls="datatable-editable" tabindex="0"><a>';
		$config['cur_tag_close'] = '</a></li>';
		$config['num_tag_open'] = '<li class="paginate_button" aria-controls="datatable-editable" tabindex="0">';
		$config['num_tag_close'] = '</li>';
		$config['next_tag_open'] = '<li class="paginate_button next" aria-controls="datatable-editable" tabindex="0" id="datatable-editable_next">';
		$config['next_tag_close'] = '</li>';
		$config['prev_tag_open']= '<li class="paginate_button previous" aria-controls="datatable-editable" tabindex="0" id="datatable-editable_previous">';
		$config['prev_tag_close']= '</li>';
        $this->pagination->initialize($config);
        $pagination =  $this->pagination->create_links();
		$start = ($page - 1) * $limit + 1;
		$to = $start + $limit - 1;
		if ($total == 0) $start = 0;
		if ($to > $total) $to = $total;
		return [
			'pagination' => $pagination,
			'pagination_string' => "Showing $start to $to of $total entries"
		];
	}

}