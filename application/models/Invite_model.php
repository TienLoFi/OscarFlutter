<?php

Class Invite_model extends BaseModel {
    
    const STATUS_ACCEPT = 1;
    const STATUS_PENDING = 2;
    const STATUS_REJECT = 3;

    /**
     * Find an Invite
     * @param int $id
     * @return object
     */
    public function find($id)
    {
        $sql = sprintf("SELECT * FROM tb_invites WHERE id = %d", $id);
        $query = $this->db->query($sql);
        $result = $query->result();

        return $result[0]?? null;
    }
    
    /**
     * Add a new Invite
     * @param array $data
     * @return object
     */
    public function add($data = array())
    {
        $this->db->insert('tb_invites', $data);

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
        $this->db->update('tb_invites', $data);
    }

    /**
     * Find last invite
     * @param int $userId
     * @return object
     */
    public function findLastInviteBy($userId)
    {
        $sql = sprintf("SELECT * FROM tb_invites WHERE user_id = %d AND status = %d ORDER BY id DESC LIMIT 1", $userId, Invite_model::STATUS_PENDING);
        $query = $this->db->query($sql);
        $result = $query->result();

        return $result[0]?? null;
    }
}