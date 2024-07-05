<?php

Class Category_model extends BaseModel {
    const STATUS_ACTIVE = 1;
    const STATUS_INACTIVE = 2;
    /**
     * Constructor
     */
	function __construct() {
		parent::__construct();
	}

    /**
     * Get list
     * @param array $parameters
     * @return array
     */
    public function list($parameters = array())
    {
        $limit = $parameters['limit']??10;
        $page = $parameters['page']??1;
        $start = ($page - 1) * $limit;
        $query = $this->db->from('tb_categories');
        $totalQuery = clone $query;
        if (!empty($parameters['search'])) {
            $query->where('name LIKE', '%'.$parameters['search'].'%');
            $totalQuery->where('name LIKE', '%'.$parameters['search'].'%');
        }

        if (!empty($parameters['status'])) {
            $query->where('status', $parameters['status']);
            $totalQuery->where('status', $parameters['status']);
        }

        $query = $query->order_by('id', 'DESC')->limit($limit, $start)->get();

		$result = [];
		if ($query->num_rows() > 0) {
		
			foreach ($query->result() as $row) {
                if (!empty($row->name)) {
                    $result[] = array(
						'id' => $row->id,
						'name' => $row->name,
                        'score' => $row->score,
                        'desc' => $row->desc,
                        'status' => $row->status,
						'created' => $row->created,
                        'updated' => $row->updated
				    );
                }

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
     * Get all categories
     * @return array
     */
    public function all()
    {
        return $this->db->from('tb_categories')->get()->result();
    }

    /**
     * Find a caetgory by Id
     * @param int $id
     * @return array
     */
    public function find($id)
    {
        $sql = sprintf("SELECT * FROM tb_categories WHERE id = %d", $id);
        $query = $this->db->query($sql);
        $result = $query->result();
        return $result[0]?? array();
    }

    /**
     * Add a new category
     * @param array $data
     * @return array
     */
    public function add($data = array())
    {
        $this->db->insert('tb_categories', $data);

        $id = $this->db->insert_id();

        return $this->find($id);
    }

    /**
     * Update a category
     * @param int $id
     * @param array $data
     * @return bool
     */
    public function update($id, $data)
    {
        $this->db->where('id', $id);
        $this->db->update('tb_categories', $data);
    }

    /**
     * Delete a category
     * @param int $id
     * @return bool
     */
    public function delete($id)
    {
        $this->db->delete('tb_categories', array('id' => $id));
    }

    /**
     * Get nominations
     * @param int $categoryId
     * @return array
     */
    public function nominations($categoryId)
    {
        $sql = sprintf("SELECT * FROM tb_nominations WHERE id IN (SELECT nomination_id FROM tb_nominations_categories where category_id = %d)", $categoryId);
        return $this->db->query($sql)->result();
    }

    public function categoryScores()
    {
        $categories = $this->db->from('tb_categories')->get()->result();
        $catScores = array();
        foreach($categories as $category) {
            $catScores[$category->id] = $category->score;
        }

        return $catScores;
    }
}