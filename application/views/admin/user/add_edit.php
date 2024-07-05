<?php if ($edit):?>
    <form method="post" accept-charset="utf-8" action="<?php echo base_url()?>admin/user/update">
    <input type="hidden" name="id" value="<?php echo $user->id;?>">
<?php else: ?>
    <form method="post" accept-charset="utf-8" action="<?php echo base_url()?>admin/user/store">
<?php endif;?>

    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <?php if ($edit):?>
            <h3 class="modal-title">Edit User</h3>
        <?php else: ?>
            <h3 class="modal-title">Add User</h3>
        <?php endif;?>
    </div>
    <div class="modal-body">
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label for="name" class="control-label">Name</label>
                    <input type="text" name="name" class="form-control" placeholder="Enter user name" value="<?php echo $edit?$user->name : ''; ?>" required>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label for="email" class="control-label">Email</label>
                    <input type="text" name="email" class="form-control" placeholder="Enter user email" value="<?php echo $edit?$user->email : ''; ?>" required>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label for="password" class="control-label">Password</label>
                    <input type="text" name="password" class="form-control" placeholder="Enter user password" value="" <?php echo $edit?'':'required'?>>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label for="name" class="control-label">Role</label>
                    <select name="role_id" class="form-control" required>
                        <option value="">Select Role</option>
                        <?php foreach($roles as $role):?>
                            <option value="<?php echo $role->id?>" <?php echo !empty($user) && $role->id == $user->role_id?'selected':''?>><?php echo $role->name?></option>
                        <?php endforeach;?>
					</select>
                </div>
            </div>            
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label for="name" class="control-label">Verified</label>
                    <select name="verify" class="form-control" required>
                        <option value="">Select Verified</option>
                        <option value="1" <?php echo !empty($user) && $user->verify == 1?'selected': ''?>>Yes</option>
                        <option value="0" <?php echo !empty($user) && $user->verify == 0?'selected': ''?>>No</option>
					</select>
                </div>
            </div>            
        </div>		
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label for="name" class="control-label">Status</label>
                    <select name="status" class="form-control" required>
                        <option>Select Status</option>
                        <option value="1" <?php echo !empty($user) && $user->status == 1?'selected': ''?>>Active</option>
                        <option value="0" <?php echo !empty($user) && $user->status == 0?'selected': ''?>>Inactive</option>
					</select>
                </div>
            </div>            
        </div>		
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default waves-effect" data-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-info waves-effect waves-light">Save</button>
    </div>
</form>