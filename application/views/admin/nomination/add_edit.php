
<?php if ($edit):?>
    <form method="post" accept-charset="utf-8" action="<?php echo base_url()?>admin/nomination/update">
    <input type="hidden" name="id" value="<?php echo $nomination->id;?>">
<?php else: ?>
    <form method="post" accept-charset="utf-8" action="<?php echo base_url()?>admin/nomination/store">
<?php endif;?>
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <?php if ($edit):?>
            <h3 class="modal-title">Edit Nomination</h3>
        <?php else: ?>
            <h3 class="modal-title">Add Nomination</h3>
        <?php endif;?>
    </div>
    <div class="modal-body">
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label for="name" class="control-label">Name</label>
                    <input type="text" name="name" class="form-control" placeholder="Enter movie title" value="<?php echo $edit?$nomination->name : ''; ?>" required>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label for="name" class="control-label">Year</label>
                    <select name="year" id="nomination_year" class="form-control" required>
                        <option>Select year</option>
                        <?php $currentYear = date('Y');?>
                        <?php for($i = (int)$currentYear; $i >= 1928; $i--):?>
                            <?php if ($i == $nomination->year):?>
                                <option value="<?php echo $i?>" selected><?php echo $i;?></option>
                            <?php else: ?>
                                <option value="<?php echo $i?>" <?php echo $i == $currentYear?'selected':''?>><?php echo $i;?></option>
                            <?php endif;?>
                        <?php endfor;?>
					</select>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label for="name" class="control-label">Movie</label>
                    <select id="movie_id" name="movie_id" class="selectized" required>
                        <option value="">--Select movie--</option>
                        <?php foreach($movies as $movie):?>
                            <?php if ($edit):?>
                                <option value="<?php echo $movie->id ?>" <?php echo $movie->id == $nomination->movie_id?'selected':''?>><?php echo $movie->name?></option>
                            <?php else: ?>
                                <option value="<?php echo $movie->id ?>"><?php echo $movie->name ?></option>
                            <?php endif;?>
                        <?php endforeach;?>
                    </select>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label for="name" class="control-label">Category</label>
                    <select id="category_id" name="category_id[]" class="selectized" multiple required>
                        <option value="">--Select category--</option>
                        <?php foreach($categories as $category):?>
                            <?php if ($edit):?>
                                <option value="<?php echo $category->id ?>" <?php echo in_array($category->id, $selectedIds)?'selected':''?>><?php echo $category->name?></option>
                            <?php else: ?>
                                <option value="<?php echo $category->id ?>"><?php echo $category->name ?></option>
                            <?php endif;?>
                        <?php endforeach;?>
                    </select>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label for="name" class="control-label">Description</label>
                    <textarea type="text" name="desc" class="form-control" rows="3" placeholder="Enter video description"><?php echo !empty($nomination->desc)?$nomination->desc : ''; ?></textarea>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label for="name" class="control-label">Status</label>
                    <select name="status" class="form-control" >
                        <option value="1" <?php echo !empty($nomination) && $nomination->status == 1?'selected': ''?>>Active</option>
                        <option value="0" <?php echo !empty($nomination) && $nomination->status == 0?'selected': ''?>>Inactive</option>
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

