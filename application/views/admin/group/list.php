
<?php require_once APPPATH.'/views/_header.php';?>

<!-- admin_header -->
<?php require_once APPPATH.'/views/admin/inc/admin_header.php'; ?>
<input type="hidden" id="group-page-admin" value="1">
<!-- content -->
<div class="ballot-content" style="padding-top:25px; padding-bottom:20px">
	<div style="width:100%;text-align:center;background: #fafafa;margin-top: 5px;padding-top: 5px;padding-bottom: 5px;">
		<a data-toggle="modal" data-target="#add-edit-group-modal" id="add-group-btn" class="btn btn-success waves-effect w-md waves-light m-b-5">ADD GROUP</a>
		<a id="delete-groups-btn" class="btn btn-danger waves-effect w-md waves-light m-b-5">Delete</a>
	</div>
	<div class="panel"><div class="panel-body">
	<div class="table-rep-plugin">
	<div class="table-responsive b-0">
		<form method="get" accept-charset="utf-8" action="<?php echo base_url()?>admin/group/index">
			<div class="row">
				<div class="col-sm-3">
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
				<div class="col-sm-9">
					<div class="dataTables_filter">
						<label> 
							<select id="leader_id" name="leader_id" class="form-control input-sm">
								<option value="">Select Leader</option>
								<?php foreach($users as $user):?>
									<option value="<?php echo $user->id ?>" <?php echo $user->id == $this->input->get('leader_id')?'selected':''?>><?php echo $user->name?>(<?php echo $user->email;?>)</option>
								<?php endforeach;?>
							</select>
						</label>
						<label>
							<select name="status" class="form-control input-sm" >
								<option value="">Select Status</option>
								<option value="1" <?php echo $this->input->get('status') == 1?'selected': ''?>>Active</option>
								<option value="2" <?php echo $this->input->get('status') == 2?'selected': ''?>>Inactive</option>
							</select>						
						</label>
						<label><input type="search" name="search" class="form-control input-sm" value="<?php echo $this->input->get('search');?>" placeholder="Search..." aria-controls="datatable-editable"></label>
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
					<th data-priority="6">Leader</th>
					<th data-priority="6">Member</th>
					<th data-priority="6">Group Number</th>
					<th data-priority="6">Status</th>
					<th data-priority="6">Created</th>
					<th data-priority="6">Update</th>
					<th data-priority="3">Actions</th>
				</tr>
			</thead>
			<tbody>
            <?php if (!empty($list)):?>
                <?php foreach ($list as $item):?>
                    <?php if (!empty($item['name'])):?>
                    <tr class="gradeX">
						<td><input type="checkbox" class="checkbox" value="<?php echo $item['id'];?>"></td>
                        <td><?php echo $item['name']; ?></td>
						<td><?php echo $item['leader_name'].'('.$item['leader_email'].')'?></td>
                        <td><?php echo $item['members']; ?></td>
						<td><?php echo $item['group_number']; ?></td>
						<td><?php echo $item['status'] == 1?'Active' : 'Inactive'; ?></td>
						<td><?php echo date('Y-m-d H:i:s', strtotime($item['created'])); ?></td>
                        <td><?php echo date('Y-m-d H:i:s', strtotime($item['updated'])); ?></td>
                        <td class="actions">
							<a href="#" class="hidden on-editing cancel-row"><i class="fa fa-times"></i></a>
                            <a href="#" class="on-default remove-row" style="color: red;" onclick="onDeleteGroup('<?php echo $item['id']; ?>')"><i class="fa fa-trash-o"></i></a>
							<a href="#" class="on-default edit-row" style="color: white;" data-toggle="modal" data-target="#add-edit-group-modal" onclick="onEditGroup('<?php echo $item['id']; ?>')"><i class="fa fa-edit"></i></a>
                        </td>
                    </tr>	
                    <?php endif;?>
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
<div id="add-edit-group-modal" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
	<div class="modal-dialog">
		<div class="modal-content" id="add-edit-group-content">
		</div>
	</div>
</div>
<div id="add-member-modal" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
	<div class="modal-dialog">
		<div class="modal-content" id="add-member-content">
		</div>
	</div>
</div>
<!-- footer -->

<?php require_once APPPATH.'/views/_footer.php';?>