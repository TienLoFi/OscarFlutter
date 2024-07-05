

<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 class="modal-title">Group Detail</h3>
</div>
<div class="modal-body">
    <div class="row">
        <div class="col-xs-12">
            <div class="form-group">
                <label for="name" class="control-label">Name</label>
                <input type="text" name="name" class="form-control" placeholder="Enter Group name" value="<?php echo $group->name ?>" disabled>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-6">
            <div class="form-group">
                <label for="name" class="control-label">Status</label>
                <select name="status" class="form-control" disabled>
                    <option value="1" <?php echo !empty($group) && $group->status == 1?'selected': ''?>>Active</option>
                    <option value="0" <?php echo !empty($group) && $group->status == 0?'selected': ''?>>Inactive</option>
                </select>
            </div>
        </div>
        <div class="col-xs-6">
            <div class="form-group">
                <label for="name" class="control-label">Group Number</label>
                <input type="text" name="group_number" class="form-control" value="<?php echo $group->group_number; ?>" disabled>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <div class="form-group">
                <label for="name" class="control-label">Description</label>
                <textarea type="text" name="desc" class="form-control" rows="3"  disabled><?php echo !empty($group->desc)?$group->desc : ''; ?></textarea>
            </div>
        </div>
    </div>
    
</div>


<div class="modal-header">
    <h3 class="modal-title">Members</h3>
    <form>
        <label><input type="search" name="search" id="front-view-search-member" class="form-control input-sm" value="<?php echo $this->input->get('search');?>" placeholder="Search..." aria-controls="datatable-editable"></label>
        <a class="btn btn-sm btn-primary" id="front-view-search-btn">Search</a>
    </form>
</div>
<div class="table-rep-plugin">
	<div class="table-responsive b-0" id="front-view-member-list-box">
        
    </div>
</div>
