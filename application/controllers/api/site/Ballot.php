<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Ballot extends RestApi_Controller {
    
	// constructor
	function __construct() {
		parent::__construct();
		$this->load->library('api_auth');

        if($this->api_auth->isNotAuthenticated())
        {
            $err = array(
                'status' => false,
                'message' => 'unauthorised',
                'data' => []
            );
            $this->response($err);
        }
		$this->load->model('user_model');
		$this->load->model('category_model');
		$this->load->model('ballot_model');
		$this->load->model('movie_model');
		$this->load->model('awardresult_model');
		$this->load->model('nomination_model');
	}

    public function index() {	
		$user = OscarAuth::getInstance()->user();
		if (!empty($user)) {
			$data['ballot_info'] = $this->ballot_model->calculateBallotInfo($user['id']);
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
				$categoryName = $category->name;
				$selectedNomination = !empty($answers[$category->id])?$this->nomination_model->find($answers[$category->id]) : null;
                $problems[] = [
					'id' => $category->id,
					'name' => $categoryName,
					'selected_nomination_id' => $selectedNomination->id??null,
					'selected_nomination_name' => $selectedNomination->name??null,
                    'nominations' => $this->category_model->nominations($category->id)
                ];
            }
        }

		$data['ballot'] = $ballot??null;
		$howManys = [];
		for ($i = 1; $i <= 12; $i++) {
			$howManys[] = [
				'id' => $i,
				'name' => $i
			];
		}
		$data['how_manys'] = $howManys;
		$data['most_oscar_movies'] = $this->movie_model->mostOscarMovies();
		$oscarSetting = OscarSetting::getInstance();
        $lockBallotPage = $oscarSetting->get('lock_ballot_page');
		$data['lock_ballot_page'] = $lockBallotPage??0;
        $data['categories'] = $problems;

		$dataResult = array(
            'status' => true,
            'message' => 'Fetch ballot page successfully',
            'data' => $data
        );
 
        return $this->response($dataResult, 200);
	}

	public function store()
	{
		$mostOscar = $this->request->data('most_oscar_movie_id');
        $howMany = $this->request->data('how_many');
		$answers = $this->request->data('answers');

		$user = OscarAuth::getInstance()->user();
		$ballot =  $this->ballot_model->findBallot($user['id'], date('Y'));
		if ( !empty($ballot)) {
			$data = array(
				'answer' => json_encode($answers),
				'most_oscar_movie_id' => $mostOscar,
				'how_many' => $howMany,
				'updated' => date('Y-m-d H:i:s')
			);
			$this->ballot_model->update($ballot->id, $data);
		} else {
			$data = array(
				'answer' => json_encode($answers),
				'user_id' => $user['id'],
				'most_oscar_movie_id' => $mostOscar,
				'how_many' => $howMany,
				'year' => date('Y'),
				'created' => date('Y-m-d H:i:s'),
				'updated' => date('Y-m-d H:i:s')
			);
			$ballot = $this->ballot_model->add($data);
		}


		
		$dataResult = array(
            'status' => true,
            'message' => 'Add ballot successfully',
            'data' => $ballot
        );
 
        return $this->response($dataResult, 200);
	}

	public function update()
	{
		$id = $this->request->data('id');
		$categoryIds = $this->request->data('category_ids');
        $nominationIds = $this->request->data('nomination_ids');
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
		$data['most_oscar_movie_id'] = $this->request->data('most_oscar_movie_id');
		$data['how_many'] = $this->request->data('how_many');
		$this->ballot_model->update($id, $data);

		$dataResult = array(
            'status' => true,
            'message' => 'Update ballot successfully',
            'data' => []
        );
 
        return $this->response($dataResult, 200);
	}
	
}