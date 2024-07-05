<?php

Class Group_model extends BaseModel {
    
    const STATUS_ACTIVE = 1;
    const STATUS_INACTIVE = 2;

    const STATUS_GROUP_ACTIVE = 1;
    const STATUS_GROUP_PENDING = 2;

	function __construct() {
		parent::__construct();
        $this->load->model('user_model');
	}

    /**
     * Get group list
     * @param array $parameters
     * @return array
     */
    public function list($parameters = array())
    {
        $limit = $parameters['limit']??20;
        $page = $parameters['page']??1;
        $start = ($page - 1) * $page;
        $query = $this->db
            ->from('tb_groups')
            ->join('tb_users', 'tb_groups.leader_id = tb_users.id', 'left');
        $totalQuery = clone $query;
        if (!empty($parameters['search'])) {
            $query->where('tb_groups.name LIKE', '%'.$parameters['search'].'%');
            $totalQuery->where('tb_groups.name LIKE', '%'.$parameters['search'].'%');
        }

        if (!empty($parameters['status'])) {
            $query->where('tb_groups.status', $parameters['status']);
            $totalQuery->where('tb_groups.status', $parameters['status']);
        }

        if (!empty($parameters['leader_id'])) {
            $query->where('tb_groups.leader_id', $parameters['leader_id']);
            $totalQuery->where('tb_groups.leader_id', $parameters['leader_id']);
        }

        $query = $query->select('tb_groups.id AS id,tb_groups.name AS name,tb_groups.desc AS desc,tb_users.name as leader_name, tb_users.email as leader_email,tb_groups.leader_id AS leader_id,tb_groups.group_number AS group_number,tb_groups.status AS status,tb_groups.created AS created,tb_groups.updated AS updated')->order_by('tb_groups.id', 'DESC')->limit($limit, $start)->get();
		$result[] = array();
		if ($query->num_rows() > 0) {
			foreach ($query->result() as $row) {
                $result[] = array(
                        'id' => $row->id,
                        'name' => $row->name,
                        'desc' => $row->desc,
                        'leader_id' => $row->leader_id,
                        'leader_name' => $row->leader_name,
                        'leader_email' => $row->leader_email,
                        'group_number' => $row->group_number,
                        'status' => $row->status,
                        'members' => $this->getTotalMember($row->id),
                        'created' => $row->created,
                        'updated' => $row->updated
                );
			}
		}
       
        $totalResult = $totalQuery->select('count(tb_groups.id) AS total')->get()->result();
        $total = !empty($totalResult[0]->total)?$totalResult[0]->total : 0;
		
		return array(
            'total' => $total,
            'page' => $page,
            'limit' => $limit,
            'result' => $result
        );
    }

    /**
     * Get my groups
     * @return array
     */
    public function myGroups($parameters = array())
    {
        $user = OscarAuth::getInstance()->user();
        $limit = $parameters['limit']??20;
        $page = $parameters['page']??1;
        $start = ($page - 1) * $page;
        $groupIds = $this->user_model->groupIds($user['id']);
        $query = $this->db
            ->from('tb_groups')
            ->join('tb_users', 'tb_groups.leader_id = tb_users.id', 'left')->group_start()->where('tb_groups.leader_id', $user['id'])->or_where('tb_groups.user_id', $user['id']);
        if (!empty($groupIds)) {
            $query->or_where_in('tb_groups.id', $groupIds);
        }
        $query->group_end();
        
        $totalQuery = clone $query;
        if (!empty($parameters['search'])) {
            $query->where('tb_groups.name LIKE', '%'.$parameters['search'].'%');
            $totalQuery->where('tb_groups.name LIKE', '%'.$parameters['search'].'%');
        }

        if (!empty($parameters['status'])) {
            $query->where('tb_groups.status', $parameters['status']);
            $totalQuery->where('tb_groups.status', $parameters['status']);
        }

        $query = $query->select('tb_groups.id AS id,tb_groups.name AS name,tb_groups.desc AS desc, tb_groups.user_id AS user_id,tb_users.name as leader_name, tb_users.email as leader_email,tb_groups.leader_id AS leader_id,tb_groups.group_number AS group_number,tb_groups.status AS status,tb_groups.created AS created,tb_groups.updated AS updated')->order_by('tb_groups.id', 'DESC')->limit($limit, $start)->get();
		$result = array();
		if ($query->num_rows() > 0) {
			foreach ($query->result() as $row) {
                $result[] = array(
                        'id' => $row->id,
                        'name' => $row->name,
                        'desc' => $row->desc,
                        'user_id' => $row->user_id,
                        'leader_id' => $row->leader_id,
                        'leader_name' => $row->leader_name,
                        'leader_email' => $row->leader_email,
                        'group_number' => $row->group_number,
                        'status' => $row->status,
                        'members' => $this->getTotalMember($row->id),
                        'created' => $row->created,
                        'updated' => $row->updated
                );
			}
		}
       
        $totalResult = $totalQuery->select('count(tb_groups.id) AS total')->get()->result();
        $total = !empty($totalResult[0]->total)?$totalResult[0]->total : 0;
		
		return array(
            'total' => $total,
            'page' => $page,
            'limit' => $limit,
            'result' => $result
        );
    }

    /**
     * Find a group
     * @param int $id
     * @return object
     */
    public function find($id)
    {
        $sql = sprintf("SELECT * FROM tb_groups WHERE id = %d", $id);
        $query = $this->db->query($sql);
        $result = $query->result();

        return $result[0]?? null;
    }

    /**
     * Add a new group
     * @param array $data
     * @return array
     */
    public function add($data = array())
    {
        $this->db->insert('tb_groups', $data);

        $id = $this->db->insert_id();

        return $this->find($id);
    }


    /**
     * Update a group
     * @param int $id
     * @param array $data
     * @return bool
     */
    public function update($id, $data)
    {
        $this->db->where('id', $id);
        $this->db->update('tb_groups', $data);
    }

    /**
     * Delete a group
     * @param int $id
     * @return bool
     */
    public function delete($id)
    {
        $this->db->delete('tb_groups', array('id' => $id));
    }

    /**
     * Get total memner
     * @param int $groupId
     * @return int
     */
    protected function getTotalMember($groupId)
    {
        $totalSql = sprintf("select count(id) AS total from tb_group_members where group_id = %d", $groupId);
        $totalQuery = $this->db->query($totalSql);
        $totalResult = $totalQuery->result();
        return !empty($totalResult[0]->total)?$totalResult[0]->total : 0;;
    }

    /**
     * Get members
     * @param int $groupId
     * @param array $parameters
     * @return array
     */
    public function members($groupId, $parameters = array())
    {
        $limit = $parameters['limit']??9999;
        $page = $parameters['page']??1;
        $start = ($page - 1) * $page;
        $query = $this->db
                ->select('tb_group_members.id AS id, tb_users.name AS name, tb_users.email AS email, tb_users.score AS score, tb_group_members.status AS status')
                ->from('tb_group_members')
                ->join('tb_users', 'tb_group_members.user_id = tb_users.id', 'left')
                ->where('tb_group_members.group_id', $groupId);
        $totalQuery = clone $query;
        if (!empty($parameters['search'])) {
            $query->group_start()->where('tb_users.name LIKE', '%'.$parameters['search'].'%')->or_where('tb_users.email LIKE', '%'.$parameters['search'].'%')->group_end();
            $totalQuery->group_start()->where('tb_users.name LIKE', '%'.$parameters['search'].'%')->or_where('tb_users.email LIKE', '%'.$parameters['search'].'%')->group_end();
        }

        if (!empty($parameters['status'])) {
            $query->where('tb_group_members.status', $parameters['status']);
            $totalQuery->where('tb_group_members.status', $parameters['status']);
        }

        $query = $query->order_by('tb_group_members.id', 'DESC')->limit($limit, $start)->get();
		$result = array();
		if ($query->num_rows() > 0) {
			foreach ($query->result() as $row) {
                $result[] = (object)array(
                    'id' => $row->id,
                    'name' => $row->name,
                    'email' => $row->email,
                    'score' => $row->score,
                    'status' => $row->status
                );
			}
		}
       
        $totalResult = $totalQuery->select('count(tb_group_members.id) AS total')->get()->result();
        $total = !empty($totalResult[0]->total)?$totalResult[0]->total : 0;
		return array(
            'total' => $total,
            'page' => $page,
            'limit' => $limit,
            'result' => $result
        );
    }

    /**
     * Get member
     * @param int $memberId
     * @return object
     */
    public function findMember($memberId)
    {
        $sql = sprintf("SELECT tb_group_members.id AS `id`, tb_users.name AS `name`, tb_users.email AS `email`, tb_group_members.status AS `status` FROM tb_group_members LEFT JOIN tb_users ON tb_group_members.user_id = tb_users.id WHERE tb_group_members.id = %d", $memberId);
        $query = $this->db->query($sql);
        $result = $query->result();

        return $result[0]?? (object)array();
    }

    /**
     * Add member
     * @param int $groupId
     * @param int $memberId
     * @param int $status
     */
    public function addMember($groupId, $memberId, $status)
    {
        $data = array(
            'group_id' => $groupId,
            'user_id' => $memberId,
            'status' => $status
        );
        $this->db->insert('tb_group_members', $data);

        $id = $this->db->insert_id();

        return $this->findMember($id);
    }

    /**
     * Delete members
     */
    public function deleteMember($id)
    {
        $this->db->delete('tb_group_members', array('id' => $id));
    }

    /**
     * Remove members from group
     * @param array $ids
     */
    public function removeMembers($ids = array())
    {
        foreach($ids as $id) {
            $this->db->delete('tb_group_members', array(
                'id' => $id
            ));
        }
    }

    /**
     * Get all groups
     * @return array
     */
    public function allGroups()
    {
        return $this->db->from('tb_groups')->get()->result();
    }

    /**
     * Get group member ids
     * @return array
     */
    public function getGroupMemberIds($groupId)
    {
        $query = $this->getQuery();
        $query = $query->select('user_id')->from('tb_group_members')->where('group_id', $groupId)->get();
        $result = array();
		if ($query->num_rows() > 0) {
			foreach ($query->result() as $row) {
                $result[] = $row->user_id;
			}
		}

        $group = $this->find($groupId);
        if (!empty($group)) {
            $result[] = $group->leader_id;
        }

        return $result;
    }
    /**
     * Find group
     * @param int $groupNumber
     * @return object
     */
    public function findGroupBy($groupNumber)
    {
        $sql = sprintf("SELECT * FROM tb_groups WHERE group_number = '%s'", $groupNumber);
        $query = $this->db->query($sql);
        $result = $query->result();
        return $result[0]?? null;
    }

    /**
     * Join user to group
     * @param int $userId
     * @param int $groupNumber
     * @param string $groupPassword
     */
    public function joinGroup($userId, $groupNumber, $groupPassword)
    {
        $group = $this->findGroupBy($groupNumber);
        if ($group->group_password != $groupPassword) return false;
        $this->addMember($group->id, $userId, Group_model::STATUS_GROUP_ACTIVE);
    }

    /**
     * Get group members
     * @param int $groupId
     * @return array
     */
    public function getGroupMembers($groupId)
    {
        $query = $this->db
                ->select('tb_group_members.id AS id, tb_group_members.group_id as group_id, tb_users.id AS user_id, tb_users.name AS name, tb_users.email AS email, tb_users.score AS score, tb_group_members.status AS status')
                ->from('tb_group_members')
                ->join('tb_users', 'tb_group_members.user_id = tb_users.id', 'left')
                ->where('tb_group_members.group_id', $groupId);
        return $query->get()->result();
    }

    public function getGroupLeaders()
    {
        $sql = sprintf("SELECT `id`, `name` FROM tb_users WHERE `id` IN (SELECT leader_id from tb_groups)");
        return $this->db->query($sql)->result();
    }

    public function searchMembers($search)
    {
        if (empty($search)) return [];
		$user = OscarAuth::getInstance()->user();
		$userId = $user['id'];
        $sql = "SELECT `id`, `name`, `email` FROM tb_users WHERE (`name` LIKE '%$search%' OR `email` LIKE '%$search%') AND  status = 1 AND verify = 1 AND id != $userId";
        return $this->db->query($sql)->result();
    }

    public function removeMember($groupId, $memberId)
    {
        $this->db->delete('tb_group_members', array(
            'group_id' => $groupId,
            'user_id' => $memberId
        ));
    }

    public function updateStatusGroupMember($memberId, $groupId, $status)
    {
        $this->db->where('group_id', $groupId)->where('user_id', $memberId)->update('tb_group_members', array(
            'status' => $status
        ));
    }

    public function inviteList($userId)
    {
        $query = $this->db
        ->select('tb_invites.id AS invite_id, tb_invites.user_id AS user_id, tb_users.name AS inviter_name, tb_users.email AS inviter_email, tb_invites.group_id AS group_id, tb_groups.name as group_name, tb_groups.status as status')
        ->from('tb_invites')
        ->join('tb_users', 'tb_invites.user_id = tb_users.id', 'left')
        ->join('tb_groups', 'tb_invites.group_id = tb_groups.id', 'left')
        ->where('tb_invites.creator_id', $userId)
        ->where('tb_invites.status', Invite_model::STATUS_PENDING);

        return $query->get()->result();
    }

    public function inviteListCount($userId)
    {

        $totalQuery = $this->db
        ->from('tb_invites')
        ->where('creator_id', $userId)
        ->where('status', Invite_model::STATUS_PENDING);

        $totalResult = $totalQuery->select('count(id) AS total')->get()->result();
        return !empty($totalResult[0]->total)?$totalResult[0]->total : 0;
    }

}