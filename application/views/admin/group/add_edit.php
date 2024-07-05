<?php if ($edit):?>
    <form method="post" accept-charset="utf-8" action="<?php echo base_url()?>admin/group/update">
    <input type="hidden" name="id" id="group_id" value="<?php echo $group->id;?>">
<?php else: ?>
    <form method="post" accept-charset="utf-8" action="<?php echo base_url()?>admin/group/store">
<?php endif;?>

    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <?php if ($edit):?>
            <h3 class="modal-title">Edit Group</h3>
        <?php else: ?>
            <h3 class="modal-title">Add Group</h3>
        <?php endif;?>
    </div>
    <div class="modal-body">
        <div class="row">
            <div class="col-xs-6">
                <div class="form-group">
                    <label for="name" class="control-label">Name</label>
                    <input type="text" name="name" class="form-control" placeholder="Enter Group name" value="<?php echo $edit?$group->name : ''; ?>" required>
                </div>
            </div>
            <div class="col-xs-6">
                <div class="form-group">
                    <label for="name" class="control-label">Status</label>
                    <select name="status" class="form-control" >
                        <option value="1" <?php echo !empty($group) && $group->status == 1?'selected': ''?>>Active</option>
                        <option value="0" <?php echo !empty($group) && $group->status == 0?'selected': ''?>>Inactive</option>
					</select>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-6">
                <div class="form-group">
                    <label for="name" class="control-label">Group Number</label>
                    <input type="text" name="group_number" class="form-control" placeholder="Enter Group Number" value="<?php echo $edit?$group->group_number : ''; ?>" required>
                </div>
            </div>
            <div class="col-xs-6">
                <div class="form-group">
                    <label for="name" class="control-label">Group Password</label>
                    <input type="text" name="group_password" class="form-control" placeholder="Enter Group Password" value="<?php echo $edit?$group->group_password : ''; ?>" required>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label for="name" class="control-label">Description</label>
                    <textarea type="text" name="desc" class="form-control" rows="3" placeholder="Enter Group description"><?php echo !empty($group->desc)?$group->desc : ''; ?></textarea>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label for="name" class="control-label">Leader</label>
                    <select id="leader_id" name="leader_id" class="form-control input-sm" required>
                        <option>Select Leader</option>
                        <?php foreach($users as $user):?>
                            <?php if ($edit):?>
                                <option value="<?php echo $user->id ?>" <?php echo $user->id == $group->leader_id?'selected':''?>><?php echo $user->name?>(<?php echo $user->email?>)</option>
                            <?php else: ?>
                                <option value="<?php echo $user->id ?>"><?php echo $user->name ?></option>
                            <?php endif;?>
                        <?php endforeach;?>
                    </select>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <button type="submit" class="btn btn-info waves-effect waves-light">Save</button>
            </div>
        </div>		
    </div>
</form>
<?php if ($edit):?>
<div class="modal-header">
    <h3 class="modal-title">Members</h3>
    <form>
        <label><input type="search" name="search" id="search_member" class="form-control input-sm" value="<?php echo $this->input->get('search');?>" placeholder="Search..." aria-controls="datatable-editable"></label>
        <label>
            <select name="status" id="status_member" class="form-control input-sm" >
                <option value="">Select Status</option>
                <option value="1" <?php echo $this->input->get('status') == 1?'selected': ''?>>Active</option>
                <option value="2" <?php echo $this->input->get('status') == 2?'selected': ''?>>Pending</option>
            </select>						
        </label>
        <a class="btn btn-sm btn-primary" id="search-btn">Search</a>
        <a id="add-member-btn" style="margin-left: 60px;" class="btn btn-sm btn-success">Add</a>
		<a id="delete-member-btn" class="btn btn-sm btn-danger">Delete</a>
    </form>
</div>
<div style="display: none;" id="add-member-box">
    <form method="post" accept-charset="utf-8">
        <div class="modal-header">
            <h4 class="modal-title">Add Member</h4>
        </div>
        <div class="modal-content">
            <div class="row">
                <div class="col-xs-12">
                    <div class="form-group">
                        <select id="member_id" name="member_id" class="form-control input-sm" required>
                            <option>Select Member</option>
                            <?php foreach($users as $user):?>
                                <option value="<?php echo $user->id ?>"><?php echo $user->name?>(<?php echo $user->email;?>)</option>
                            <?php endforeach;?>
                        </select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12">
                    <label><input type="checkbox" checked> Send Invitation Email</label>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12">
                    <a class="btn btn-sm btn-primary" id="send-invite-btn">Send</a>
                    <a class="btn btn-sm btn-danger" id="close-send-invite-btn">Close</a>
                </div>
            </div>
        </div>	
    </form>
</div>
<div class="table-rep-plugin">
	<div class="table-responsive b-0" id="member_list_box">
        
    </div>
</div>
<?php endif;?>