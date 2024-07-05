<?php

Class Ballot_model extends BaseModel {
    /**
     * Constructor
     */
	function __construct() {
		parent::__construct();
        $this->load->model('awardresult_model');
        $this->load->model('category_model');
        $this->load->model('movie_model');
	}

    /**
     * Find a ballot by Id
     * @param int $id
     * @return array
     */
    public function find($id)
    {
        $sql = sprintf("SELECT * FROM tb_ballots WHERE id = %d", $id);
        $query = $this->db->query($sql);
        $result = $query->result();
        return $result[0]?? null;
    }

    /**
     * Find ballot
     * @param int $userId
     * @param string $year
     * @return object
     */
    public function findBallot($userId, $year)
    {
        $sql = sprintf("SELECT * FROM tb_ballots WHERE user_id = %d AND year = '%s' LIMIT 1", $userId, $year);
        $query = $this->db->query($sql);
        $result = $query->result();
        return $result[0]?? null;
    }

    /**
     * Add a new ballot
     * @param array $data
     * @return array
     */
    public function add($data = array())
    {
        $this->db->insert('tb_ballots', $data);

        $id = $this->db->insert_id();

        return $this->find($id);
    }

    /**
     * Update a ballot
     * @param int $id
     * @param array $data
     * @return bool
     */
    public function update($id, $data)
    {
        $this->db->where('id', $id);
        $this->db->update('tb_ballots', $data);
    }

    /**
     * Calculate ballot info
     * @return array
     */
    public function calculateBallotInfo($userId)
    {
        $year = date('Y');
        $ballotInfo = array();
        $ballot = $this->findBallot($userId, $year);
        if (empty($ballot)) return null;
        $awardResult = $this->awardresult_model->getAwardResult($year);
        if (empty($awardResult)) return null;
        $ballotInfo['most_oscar_movie_id'] = $ballot->most_oscar_movie_id;
        $ballotInfo['how_many'] = $ballot->how_many;
        $totalCorrect = 0;
        $score = 0;
        $answers = json_decode($ballot->answer, true);
        $categoryScores = $this->category_model->categoryScores();
        if (!empty($awardResult->award_items)) {
            foreach($awardResult->award_items as $awardItem) {
                foreach($answers as $answer) {
                    if ($awardItem->category_id == $answer['category_id'] && $awardItem->nomination_id == $answer['nomination_id']) {
                        $score += (int)$categoryScores[$awardItem->category_id];
                        $totalCorrect++;
                    }
                }
            }
        }
        $ballotInfo['total_correct'] = $totalCorrect;
        $ballotInfo['score'] = $score;
        $oscarSetting = OscarSetting::getInstance();
        $lockBallotPage = $oscarSetting->get('lock_ballot_page');
        if ($lockBallotPage != 1) {
            $ballotInfo['total_correct'] = 0;
            $ballotInfo['score'] = 0;
        }

        return $ballotInfo;
    }
}