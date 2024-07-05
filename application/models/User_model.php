<?php

Class User_model extends BaseModel {
	const STATUS_ACTIVE = 1;
    const STATUS_INACTIVE = 2;

	function __construct() {
		parent::__construct();
		$this->load->model('ballot_model');
	}

    /**
     * Get user list
     * @param array $parameters
     * @return array
     */
    public function list($parameters = array())
    {
        $limit = $parameters['limit']??10;
        $page = $parameters['page']??1;
        $start = ($page - 1) * $limit;
        $query = $this->db
				->from('tb_users')
				->join('tb_roles', 'tb_roles.id = tb_users.role_id', 'left');
        $totalQuery = clone $query;
        if (!empty($parameters['search'])) {
            $query->group_start()->where('tb_users.name LIKE', '%'.$parameters['search'].'%')->or_where('tb_users.email LIKE', '%'.$parameters['search'].'%')->group_end();
            $totalQuery->group_start()->where('tb_users.name LIKE', '%'.$parameters['search'].'%')->or_where('tb_users.email LIKE', '%'.$parameters['search'].'%')->group_end();
        }

        if (!empty($parameters['status'])) {
            $query->where('tb_users.status', $parameters['status']);
            $totalQuery->where('tb_users.status', $parameters['status']);
        }

		if (!empty($parameters['role_id'])) {
            $query->where('tb_users.role_id', $parameters['role_id']);
            $totalQuery->where('tb_users.role_id', $parameters['role_id']);
        }

		if (!empty($parameters['group_id'])) {
			$memberIds = $this->group_model->getGroupMemberIds($parameters['group_id']);
			$query->where_in('tb_users.id', $memberIds);
            $totalQuery->where_in('tb_users.id', $memberIds);
		}

        $query = $query->select('tb_users.id AS id, tb_users.name AS name, tb_users.email AS email, tb_roles.name AS role_name, tb_users.role_id AS role_id, tb_users.level AS level, tb_users.score AS score, tb_users.correct_categories AS correct_categories, tb_users.most_oscar AS most_oscar, tb_users.how_many AS how_many, tb_users.verify AS verify, tb_users.status AS status,tb_users.created AS created, tb_users.updated AS updated')->order_by('tb_users.id', 'DESC')->limit($limit, $start)->get();

		if ($query->num_rows() > 0) {

			foreach ($query->result() as $row) {
				$groups = $this->groups($row->id);
				$ballotInfo = $this->ballot_model->calculateBallotInfo($row->id);
				$mostOscarMovie = !empty($ballotInfo['most_oscar_movie_id'])?$this->movie_model->find($ballotInfo['most_oscar_movie_id']) : null;
				$result[] = array(
						'id' => $row->id,
						'name' => $row->name,
                        'email' => $row->email,
						'role_name' => $row->role_name,
                        'level' => $row->level,
						'groups' => $groups,
                        'score' => $ballotInfo['score']??0,
                        'correct_categories' => $ballotInfo['total_correct']??0,
                        'most_oscar' => $mostOscarMovie->name??'',
                        'how_many' => $ballotInfo['how_many']??0,
                        'verify' => $row->verify,
						'status' => $row->status,
						'created' => gmdate("Y-m-d", strtotime($row->created)),
                        'updated' => gmdate("Y-m-d", strtotime($row->updated))
				);
			}
		}

        $totalResult = $totalQuery->select('count(tb_users.id) AS total')->get()->result();
        $total = !empty($totalResult[0]->total)?$totalResult[0]->total : 0;

		return array(
            'total' => $total,
            'page' => $page,
            'limit' => $limit,
            'result' => $result
        );
    }

    /**
     * Find a user
     * @param int $id
     * @return object
     */
    public function find($id)
    {
        $sql = sprintf("SELECT * FROM tb_users WHERE id = %d", $id);
        $query = $this->db->query($sql);
        $result = $query->result();

        return $result[0]?? null;
    }


	/**
     * Find a user
     * @param string $email
     * @return array
     */
    public function findByEmail($email)
    {
        $sql = sprintf("SELECT * FROM tb_users WHERE email = '%s'", $email);
        $query = $this->db->query($sql);
        $result = $query->result();

        return $result[0]?? null;
    }

    /**
     * Add a new user
     * @param array $data
     * @return array
     */
    public function add($data = array())
    {
        $this->db->insert('tb_users', $data);

        $id = $this->db->insert_id();

        return $this->find($id);
    }


    /**
     * Update a user
     * @param int $id
     * @param array $data
     * @return bool
     */
    public function update($id, $data)
    {
        $this->db->where('id', $id)->update('tb_users', $data);
    }

    /**
     * Delete a user
     * @param int $id
     * @return bool
     */
    public function delete($id)
    {
        $this->db->delete('tb_users', array('id' => $id));
    }

	/**
	 * Get user list
	 */
	public function getAllUsers()
	{
		return $this->db->from('tb_users')->get()->result();
	}


    public function signIn($email='', $pwd='') {
		if ($this->isExistUser($email, $pwd))
			return $this->getUserInfo($email, $pwd);

		return null;
	}

	public function signUp($name='', $email='', $pwd='') {
		$this->db->set('pwd', md5($pwd));
		$this->db->set('email', $email);
		$this->db->set('name', $name);
		$this->db->set('last_update', time());
		$this->db->insert('tb_users');

		return true;
	}

	public function changeverify($email=''){
		$this->db->set('verify', 1);
		$this->db->where('email', $email);
		$this->db->update('tb_users');
		return true;
	}
	public function changePassword($email='', $pwd='') {
		$this->db->set('pwd', md5($pwd));
		$this->db->where('email', $email);
		$this->db->update('tb_users');

		return true;
	}

	public function changePasswordById($id='', $pwd='') {
		$this->db->set('pwd', md5($pwd));
		$this->db->where('id', $id);
		$this->db->update('tb_users');

		return true;
	}

	public function isExistEmail($email = '') {
		if ($email == '')
			return false;

		$query = "SELECT id FROM tb_users WHERE email='$email'";
		$query = $this->db->query($query);

		return $query->num_rows()>0 ? true : false;
	}

	public function isExistUserById($id, $password) {
		$query = "SELECT id FROM tb_users WHERE id='$id' AND pwd=MD5('$password')";

		$query = $this->db->query($query);

		return $query->num_rows()>0 ? true : false;
	}

	public function isExistUser($email='', $pwd='') {
		if ($email == '' || $pwd == '')
			return false;

		$query = "SELECT id FROM tb_users WHERE email='$email' AND pwd=MD5('$pwd')";
		$query = $this->db->query($query);

		return $query->num_rows()>0 ? true : false;
	}

	public function getUserInfo($email='', $pwd='') {
		$result = array();

		if ($email == '' || $pwd == '')
			return $result;

		$query = "SELECT * FROM tb_users WHERE email='$email' AND pwd=MD5('$pwd') LIMIT 1";
		$query = $this->db->query($query);

		if ($query->num_rows() > 0) {
			$row = $query->row();
			$result = array(
				'id'=>$row->id,
				'name'=>$row->name,
				'email'=>$row->email,
				'role_id' => $row->role_id,
				'password'=>$row->pwd,
				'level'=>$row->level,
				'score'=>$row->score,
				'how_many'=>$row->how_many,
				'oscar_title' => $row->most_oscar ,
				'verify'=> $row->verify
			);
		}

		return $result;
	}

	public function getUserCurInfo() {
		$info = $this->session->userdata['sign'];
		$this->db->where('id', $info['id']);
		$query = $this->db->get('tb_users');
		$result = $query->result_array();
		if (count($result) > 0)
		{
			return $result[0];
		}
		return null;
	}

	public function getUserList() {
		$result = array();

		$query = "SELECT * FROM tb_users WHERE level<>100";
		$query = $this->db->query($query);

		if ($query->num_rows() > 0) {

			foreach ($query->result() as $row) {
				$result[] = array(
						'id' => $row->id,
						'name' => $row->name,
						'email' => $row->email,
						'role_id' => $row->role_id,
						'most_oscar' => $row->most_oscar,
						'how_many' => $row->how_many,
						'lastUpdate' => gmdate("Y-m-d", $row->last_update),
						'score' => $row->score,
						'correct_categories' => $row->correct_categories,
						'level' => $row->level
				);
			}
		}

		return $result;
	}

    public function getUserData() {
		$result = array();

		$query = "SELECT * FROM tb_users WHERE level<>100";
		$query = $this->db->query($query);

		if ($query->num_rows() > 0) {

			foreach ($query->result() as $row) {
				$result[] = array(
						'uid' => $row->id,
						'name' => $row->name,
						'score' => $row->score,
						'correct_categories' => $row->correct_categories,
						'how_many' => $row->how_many,
                    	'most_oscars' => $row->most_oscar,
				);
			}
		}

		return $result;
	}

	public function setAnswer($id, $answer) {
		$query = "SELECT * FROM tb_ballots WHERE id=$id";
		$query = $this->db->query($query);

		if ($query->num_rows() > 0) {
			$this->db->set('answer', $answer);
			$this->db->where('id', $id);
			$this->db->update('tb_ballots');
		} else {
			$this->db->set('answer', $answer);
			$this->db->set('id', $id);
			$this->db->insert('tb_ballots');
		}

		$this->setScore($id);
	}

	public function getAnswer($id='') {
		$result = '';

		if ($id == '')
			return $result;

		$query = "SELECT * FROM tb_ballots WHERE id='$id' LIMIT 1";
		$query = $this->db->query($query);

		if ($query->num_rows() > 0) {
			$row = $query->row();

			$temp = json_decode($row->answer);
			if ($temp != "") {
				foreach ($temp as $item) {
					$result .= $item->value.',';
				}
			}


		}

		return $result;
	}

	public function getAdminAnswer() {
		$result = '';
		$adminID = $this->getAdminID();
		$query = "SELECT * FROM tb_ballots WHERE id=$adminID LIMIT 1";
		//echo $this->db->last_query();exit;
                $query = $this->db->query($query);
                if ($query->num_rows() > 0) {
                    	$row = $query->row();

			$temp = json_decode($row->answer);
			if ($temp != "") {
				foreach ($temp as $item) {
					$result .= $item->value.',';
				}
			}


		}
        //echo "<pre>";print_r($result);exit;
		return substr_replace($result, "", -1);
	}

	public function setReset($id) {
		$query = "DELETE FROM tb_ballots WHERE id=$id";
		$query = $this->db->query($query);

		$this->setResetScore();
	}

	public function setScore($id) {
		$dic = $this->config->item('problems');
		$answer = $this->getAnswer($id);

		$query = "SELECT * FROM tb_ballots WHERE id<>$id";
		$query = $this->db->query($query);

		foreach ($query->result() as $row) {
			$score = 0;
			$data = json_decode($row->answer, true);

			foreach ($data as $item) {
				$aaa = $item['value'];
				if(strpos($answer, $item['value'])!==false) {
					$score += $dic[$item['name']]['score'];
				}
			}

			$this->db->set('score', $score);
			$this->db->where('id', $row->id);
			$this->db->update('tb_users');
		}
	}

	public function getCountOfCorrectAnswers($id) {
		$dic = $this->config->item('problems');
		$answer = $this->getAdminAnswer();

		if($answer == "") {
			return 0;
		}

		$query = "SELECT * FROM tb_ballots WHERE id=$id";
		$query = $this->db->query($query);
		$count = 0;

		foreach ($query->result() as $row) {
			$score = 0;
			// var_dump($row);
			$data = json_decode($row->answer, true);

			foreach ($data as $item) {
				$aaa = $item['value'];
				if(strpos($answer, $item['value'])!==false) {
					// $score += $dic[$item['name']]['score'];
					$count ++;
				}
			}
		}

        $this->db->where('id', $id);
        $this->db->update("tb_users", array('correct_categories' => $count));
		return $count;
	}

	public function setResetScore() {
		$query = "UPDATE tb_users SET score=0";
		$query = $this->db->query($query);
	}

	public function deleteUser($id) {
            	$this->db->where('id', $id);
		$this->db->delete('tb_users');

		$this->db->where('id', $id);
		$this->db->delete('tb_ballot');
	}

    public function delete_User($uid) {
        if($uid != ''){
            $this->deleteUser($uid);
            return true;
        }else{
            return false;
        }
	}

    public function getAdminID() {
		$this->db->where('level', 100);
		$query = $this->db->get('tb_users');
		$result = $query->result_array();
                if (count($result) == 0) {
			return false;
		}
		else {
			return $result[0]['id'];
		}
	}

    public function setUserData($userId, $data) {
                $this->db->where('id', $userId);
                $this->db->update('tb_users', $data);
    }

    public function getUserInfoById($id) {
		$result = array();

		if ($id == "")
			return $result;

		$query = "SELECT * FROM tb_users WHERE id=".$id." LIMIT 1";
		$query = $this->db->query($query);

		if ($query->num_rows() > 0) {
			$row = $query->row();

			$result = array('id'=>$row->id, 'name'=>$row->name, 'email'=>$row->email, 'password'=>$row->pwd, 'level'=>$row->level, 'score'=>$row->score);
		}

		return $result;
	}

	/**
     * Get all roles
     * @return array
     */
	public function roles()
	{
		return $this->db->from('tb_roles')->get()->result();
	}

	/**
	 * Get group ids
	 * @param int $userId
	 * @return array
	 */
	public function groupIds($userId)
	{
		$groupMembers = $this->getQuery()->from('tb_group_members')->where('user_id', $userId)->get()->result();
		$result = array();
		foreach($groupMembers as $gMember) {
			$result[] = $gMember->group_id;
		}
		$groups = $this->getQuery()->from('tb_groups')->where('user_id', $userId)->or_where('user_id', $userId)->get()->result();
		foreach($groups as $group) {
			$result[] = $group->id;
		}
		return $result;
	}

	/**
	 * Get groups
	 * @param int $userId
	 * @return array
	 */
	public function groups($userId)
	{
		$groupIds = $this->groupIds($userId);
		if (empty($groupIds)) return null;
		$groups = $this->db->from('tb_groups')->where_in('id', $groupIds)->get()->result();
		return $groups;
	}

	/**
	 * Get user password
	 * @param int $userId
	 */
	public function getPassword($userId) {
		$user = $this->find($userId);

		return $user->pwd?? null;
	}
}