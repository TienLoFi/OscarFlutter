<?php

Class Nomination_model extends BaseModel {
    
    const STATUS_ACTIVE = 1;
    const STATUS_INACTIVE = 2;

	function __construct() {
		parent::__construct();
	}

    /**
     * Get nomination list
     * @param array $parameters
     * @return array
     */
    public function list($parameters = array())
    {
        $limit = $parameters['limit']??10;
        $page = $parameters['page']??1;
        $start = ($page - 1) * $page;
        $query = $this->db->from('tb_nominations');
        $totalQuery = clone $query;
        if (!empty($parameters['search'])) {
            $query->where('name LIKE', '%'.$parameters['search'].'%');
            $totalQuery->where('name LIKE', '%'.$parameters['search'].'%');
        }
        if (!empty($parameters['year'])) {
            $query->where('year', $parameters['year']);
            $totalQuery->where('year', $parameters['year']);
        }

        if (!empty($parameters['status'])) {
            $query->where('status', $parameters['status']);
            $totalQuery->where('status', $parameters['status']);
        }

        $query = $query->order_by('id', 'DESC')->limit($limit, $start)->get();
		$result = array();
		if ($query->num_rows() > 0) {
		
			foreach ($query->result() as $row) {
				$result[] = array(
						'id' => $row->id,
						'name' => $row->name,
                        'year' => $row->year,
                        'desc' => $row->desc,
						'created' => $row->created,
                        'updated' => $row->updated
				);
			}
		}

        $totalResult = $totalQuery->select('count(id) AS total')->get()->result();
        $total = !empty($totalResult[0]->total)?$totalResult[0]->total : 0;
		
		return array(
            'total' => $total,
            'page' => $page,
            'limit' => $limit,
            'result' => $result
        );
    }

    /**
     * Find a nomination by Id
     * @param int $id
     * @return array
     */
    public function find($id)
    {
        $sql = sprintf("SELECT * FROM tb_nominations WHERE id = %d and status = %d", $id, self::STATUS_ACTIVE);
        $query = $this->db->query($sql);
        $result = $query->result();

        return $result[0]?? null;
    }

    /**
     * Add a new nomination
     * @param array $data
     * @return array
     */
    public function add($data = array())
    {
        $this->db->insert('tb_nominations', $data);

        $id = $this->db->insert_id();
        return $this->find($id);
    }

    /**
     * Update a nomination
     * @param int $id
     * @param array $data
     * @return bool
     */
    public function update($id, $data)
    {
        $this->db->where('id', $id);
        $this->db->update('tb_nominations', $data);
    }

    /**
     * Delete a nomination
     * @param int $id
     * @return bool
     */
    public function delete($id)
    {
        $this->db->delete('tb_nominations', array('id' => $id));
    }

    /**
     * Get category ids
     * @param int $nominationId
     * @return array
     */
    public function getCategoryIds($nominationId)
    {
        $result = [];
        $query = $this->db->from('tb_nominations_categories')->where('nomination_id', $nominationId)->get();
        if ($query->num_rows() > 0) {
		
			foreach ($query->result() as $row) {
				$result[] = $row->category_id;
			}
		}
        return $result;
    }

    /**
     * Remove Category Ids
     * @param int $nominationId
     */
    public function removeCategoryIds($nominationId)
    {
        $this->db->delete('tb_nominations_categories', array('nomination_id' => $nominationId));
    }

    /**
     * Insert Category Ids
     * @param int $id
     * @param int $nominationId
     */
    public function insertCategoryIds($nominationId, $categoryIds)
    {
        foreach($categoryIds as $categoryId) {
            $data = array(
                'category_id' => $categoryId,
                'nomination_id' => $nominationId
            );
            $this->db->insert('tb_nominations_categories', $data);
        }
    }

    /**
     * Get all nominations
     * @return array
     */
    public function allNominations()
    {
        return $this->db->from('tb_nominations')->get()->result();
    }
}