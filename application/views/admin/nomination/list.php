
<?php require_once APPPATH.'/views/_header.php';?>

<!-- admin_header -->
<?php require_once APPPATH.'/views/admin/inc/admin_header.php'; ?>
<input type="hidden" id="nomination-page-admin" value="1">
<!-- content -->
<div class="ballot-content" style="padding-top:25px; padding-bottom:20px">
	<div style="width:100%;text-align:center;background: #fafafa;margin-top: 5px;padding-top: 5px;padding-bottom: 5px;">
		<a data-toggle="modal" data-target="#add-edit-nomination-modal" id="add-nomination-btn" class="btn btn-success waves-effect w-md waves-light m-b-5">ADD NOMINATION</a>
		<a id="delete-nominations-btn" class="btn btn-danger waves-effect w-md waves-light m-b-5">Delete</a>
	</div>
	<div class="panel"><div class="panel-body">
	<div class="table-rep-plugin">
	<div class="table-responsive b-0">
		<form method="get" accept-charset="utf-8" action="<?php echo base_url()?>admin/nomination/index">
			<div class="row">
				<div class="col-sm-6">
					<div class="dataTables_length">
						<label>
							Show 
							<select name="limit" class="form-control input-sm">
								<?php foreach($page_sizes as $key => $value):?>
									<?php if ($key == $this->input->get('limit')):?>
										<option value="<?php echo $key?>" selected><?php echo $value;?></option>
									<?php else: ?>
										<option value="<?php echo $key?>"><?php echo $value;?></option>
									<?php endif;?>
								<?php endforeach;?>
							</select>
							entries
						</label>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="dataTables_filter">
						<label> 
							<select name="year" class="form-control input-sm">
								<option value="">Select Year</option>
								<?php $currentYear = date('Y');?>
								<?php for($i = (int)$currentYear; $i >= 1928; $i--):?>
									<?php if ($i == $this->input->get('year')):?>
										<option value="<?php echo $i?>" selected><?php echo $i;?></option>
									<?php else: ?>
										<option value="<?php echo $i?>"><?php echo $i;?></option>
									<?php endif;?>
								<?php endfor;?>
							</select>
						</label>
						<label>
						<select name="status" class="form-control input-sm" >
							<option value="">Select Status</option>
							<option value="1" <?php echo $this->input->get('status') == 1?'selected': ''?>>Active</option>
							<option value="2" <?php echo $this->input->get('status') == 2?'selected': ''?>>Inactive</option>
						</select>						
						</label>
						<label><input type="search" name="search" class="form-control input-sm" value="<?php echo $this->input->get('search');?>" aria-controls="datatable-editable" placeholder="Search..."></label>
						<button style="margin-left: 20px;" class="btn btn-success ">Search</button>
					</div>
				</div>

			</div>
		</form>
		<table class="table table-striped">
			<thead>
				<tr>
                    <th></th>
					<th>Name</th>
					<th data-priority="6">Year</th>
					<th data-priority="6">Created</th>
					<th data-priority="6">Updated</th>
					<th data-priority="3">Actions</th>
				</tr>
			</thead>
			<tbody>
            <?php if (!empty($list)):?>
                <?php foreach ($list as $item):?>
                    <tr class="gradeX">
                        <td><input type="checkbox" class="checkbox" value="<?php echo $item['id'];?>"></td>
                        <td><?php echo $item['name']; ?></td>
                        <td><?php echo $item['year']; ?></td>
						<td><?php echo date('Y-m-d H:i:s', strtotime($item['created'])); ?></td>
                        <td><?php echo date('Y-m-d H:i:s', strtotime($item['updated'])); ?></td>
                        <td class="actions">
                            <a href="#" class="hidden on-editing cancel-row"><i class="fa fa-times"></i></a>
                            <a href="#" class="on-default remove-row" style="color: red;" onclick="onDeleteNomination('<?php echo $item['id']; ?>')"><i class="fa fa-trash-o"></i></a>
							<a href="#" class="on-default edit-row" style="color: white;" data-toggle="modal" data-target="#add-edit-nomination-modal" onclick="onEditNomination('<?php echo $item['id']; ?>')"><i class="fa fa-edit"></i></a>
                        </td>
                    </tr>	
                <?php endforeach ?>		
            <?php endif;?>	
			</tbody>
		</table>
		<div class="row mt-2">
			<div class="col-sm-6">
				<div class="dataTables_info" role="status" aria-live="polite"><?php echo $pagination_string;?></div>
			</div>
			<div class="col-sm-6">
				<div class="dataTables_paginate paging_simple_numbers" id="datatable-editable_paginate">
					<?php echo $pagination;?>
				</div>
			</div>
		</div>
	</div>
	</div>
	</div></div>
</div>
<div id="add-edit-nomination-modal" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
	<div class="modal-dialog">
		<div class="modal-content" id="add-edit-nomination-content">
		</div>
	</div>
</div>
<!-- footer -->
<?php require_once APPPATH.'/views/_footer.php';?>