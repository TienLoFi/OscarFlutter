<?php if ($edit):?>
    <form method="post" accept-charset="utf-8" action="<?php echo base_url()?>admin/category/update">
    <input type="hidden" name="id" value="<?php echo $category->id;?>">
<?php else: ?>
    <form method="post" accept-charset="utf-8" action="<?php echo base_url()?>admin/category/store">
<?php endif;?>

    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <?php if ($edit):?>
            <h3 class="modal-title">Edit Category</h3>
        <?php else: ?>
            <h3 class="modal-title">Add Category</h3>
        <?php endif;?>
    </div>
    <div class="modal-body">
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label for="name" class="control-label">Name</label>
                    <input type="text" name="name" class="form-control" placeholder="Enter category name" value="<?php echo $edit?$category->name : ''; ?>" required>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label for="score" class="control-label">Score</label>
                    <input type="text" name="score" class="form-control" placeholder="Enter category score" value="<?php echo $edit?$category->score : ''; ?>" required>
                </div>
            </div>
        </div>        
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label for="name" class="control-label">Description</label>
                    <textarea type="text" name="desc" class="form-control" rows="3" placeholder="Enter category description"><?php echo !empty($category->desc)?$category->desc : ''; ?></textarea>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label for="name" class="control-label">Status</label>
                    <select name="status" class="form-control" >
                        <option value="1" <?php echo !empty($category) && $category->status == 1?'selected': ''?>>Active</option>
                        <option value="0" <?php echo !empty($category) && $category->status == 0?'selected': ''?>>Inactive</option>
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