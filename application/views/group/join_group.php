<form method="post" accept-charset="utf-8" action="<?php echo base_url()?>group/storeJoinGroup">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 class="modal-title">Join Group</h3>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <div class="form-group">
                <label for="name" class="control-label">Group Number</label>
                <input type="text" name="group_number" class="form-control" placeholder="Enter Group Number" required>
            </div>
        </div>
        <div class="col-xs-12">
            <div class="form-group">
                <label for="name" class="control-label">Group Password</label>
                <input type="text" name="group_password" class="form-control" placeholder="Enter Group Password" required>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <button class="btn btn-sm btn-primary">Join</button>
        </div>
    </div>	
</form>