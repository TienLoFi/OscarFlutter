<?php

Class Awardresult_model extends BaseModel {
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
        $query = $this->db->from('tb_award_results');
        $totalQuery = clone $query;
        if (!empty($parameters['search'])) {
            $query->where('name LIKE', '%'.$parameters['search'].'%');
            $totalQuery->where('name LIKE', '%'.$parameters['search'].'%');
        }

        if (!empty($parameters['status'])) {
            $query->where('status', $parameters['status']);
            $totalQuery->where('status', $parameters['status']);
        }

        if (!empty($parameters['year'])) {
            $query->where('year', $parameters['year']);
            $totalQuery->where('year', $parameters['year']);
        }

        $query = $query->order_by('id', 'DESC')->limit($limit, $start)->get();

		$result = [];
		if ($query->num_rows() > 0) {
		
			foreach ($query->result() as $row) {
                if (!empty($row->name)) {
                    $result[] = array(
						'id' => $row->id,
						'name' => $row->name,
                        'year' => $row->year,
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
        return $this->db->from('tb_award_results')->get()->result();
    }

    /**
     * Find a caetgory by Id
     * @param int $id
     * @return array
     */
    public function find($id)
    {
        $sql = sprintf("SELECT * FROM tb_award_results WHERE id = %d", $id);
        $query = $this->db->query($sql);
        $result = $query->result();
        return $result[0]?? array();
    }

    /**
     * Add a new award result
     * @param array $data
     * @return array
     */
    public function add($data = array())
    {
        $this->db->insert('tb_award_results', $data);

        $id = $this->db->insert_id();

        return $this->find($id);
    }

    /**
     * Update a award result
     * @param int $id
     * @param array $data
     * @return bool
     */
    public function update($id, $data)
    {
        $this->db->where('id', $id);
        $this->db->update('tb_award_results', $data);
    }

    /**
     * Delete a award result
     * @param int $id
     * @return bool
     */
    public function delete($id)
    {
        $this->db->delete('tb_award_results', array('id' => $id));
    }

    /**
     * Save Result Items
     * @param int $awardResultId
     * @param array $categoryIds
     * @param array $nominationIds
     */
    public function SaveResultItems($awardResultId, $categoryIds, $nominationIds)
    {
        $this->db->delete('tb_award_items', array('award_result_id' => $awardResultId));
        for($i = 0; $i < count($categoryIds); $i++) {
            $data = [
                'award_result_id' => $awardResultId,
                'category_id' => $categoryIds[$i],
                'nomination_id' => $nominationIds[$i]
            ];
            $this->db->insert('tb_award_items', $data);
        }
    }


    public function selectedNomination($awardResultId, $categoryId)
    {
        $sql = sprintf("SELECT * FROM tb_award_items WHERE award_result_id = %d AND category_id = %d LIMIT 1", $awardResultId, $categoryId);
        $query = $this->db->query($sql);
        $result = $query->result();
        return $result[0]?? null;
    }

    public function getAwardResult($year)
    {
        $sql = sprintf("SELECT * FROM tb_award_results WHERE year = %d ORDER BY id LIMIT 1", $year);
        $query = $this->db->query($sql);
        $result = $query->result();
        $awardResult = $result[0]??null;
        if (!empty($awardResult)) {
            $aiSql = sprintf("SELECT * FROM tb_award_items WHERE award_result_id = %d ", $awardResult->id);
            $aiQuery = $this->db->query($aiSql);
            $awardResult->award_items = $aiQuery->result();
        }

        return $awardResult;
    }
}