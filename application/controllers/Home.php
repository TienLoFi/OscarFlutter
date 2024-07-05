<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Home extends CI_Controller {
    
	// constructor
	function __construct() {
		parent::__construct();
		$this->load->model('user_model');
		$this->load->model('category_model');
		$this->load->model('ballot_model');
		$this->load->model('movie_model');
		$this->load->model('awardresult_model');
	}

    public function index() {	
		$data['title'] = "OSCARS BALLOT - ADMIN";
		$data['isLogin'] = isset($this->session->userdata['sign']);
        $data['info'] = isset($this->session->userdata['sign']) ? $this->session->userdata['sign'] : null;
		$user = OscarAuth::getInstance()->user();
		if (!empty($user)) {
			$data['ballotInfo'] = $this->ballot_model->calculateBallotInfo($user['id']);
		}       
        	
		$problems = [];
        $categories = $this->category_model->all();
		
		if (!empty($user)) {
			$ballot = $this->ballot_model->findBallot($user['id'], date('Y'));
			if (!empty($ballot)) {
				$tmpAnswers = json_decode($ballot->answer, true);
				$answers = [];
				foreach($tmpAnswers as $ta) {
					$answers[$ta['category_id']] = $ta['nomination_id'];
				}
			}
		}
		

        if (!empty($categories)) {
            foreach($categories as $category) {
                $problems[$category->name] = [
					'selected_nomination_id' => $answers[$category->id]??null,
                    'category_id' => $category->id,
                    'nominations' => $this->category_model->nominations($category->id)
                ];
            }
        }
		$data['ballot'] = $ballot??null;
		$data['mostOscarMovies'] = $this->movie_model->mostOscarMovies();
        $data['problems'] = $problems;
		$data['isActiveHomePage'] = true;
		$data['user'] = $user;

		$this->load->view('home', $data);
	}

	public function store()
	{
		$categoryIds = $this->input->post('category_ids');
        $nominationIds = $this->input->post('nomination_ids');
		$answers = array();
		foreach($categoryIds as $categoryId) {
			if (!empty($nominationIds[$categoryId])) {
				$answers[] = array(
					'category_id' => $categoryId,
					'nomination_id' => $nominationIds[$categoryId]
				);
			}

		}
		$user = OscarAuth::getInstance()->user();

		$data = array(
			'answer' => json_encode($answers),
			'user_id' => $user['id'],
			'most_oscar_movie_id' => $this->input->post('most_oscar_movie_id'),
			'how_many' => $this->input->post('how_many'),
			'year' => date('Y'),
			'created' => date('Y-m-d H:i:s'),
			'updated' => date('Y-m-d H:i:s')
		);
		$this->ballot_model->add($data);

		return redirect('/');
	}

	public function update()
	{
		$id = $this->input->post('id');
		$categoryIds = $this->input->post('category_ids');
        $nominationIds = $this->input->post('nomination_ids');
		$answers = array();
		foreach($categoryIds as $categoryId) {
			if (!empty($nominationIds[$categoryId])) {
				$answers[] = array(
					'category_id' => $categoryId,
					'nomination_id' => $nominationIds[$categoryId]
				);
			}

		}
		$user = OscarAuth::getInstance()->user();

		$data = array(
			'answer' => json_encode($answers),
			'user_id' => $user['id'],
			'updated' => date('Y-m-d H:i:s')
		);
		$data['most_oscar_movie_id'] = $this->input->post('most_oscar_movie_id');
		$data['how_many'] = $this->input->post('how_many');
		$this->ballot_model->update($id, $data);

		return redirect('/');
	}
	
}