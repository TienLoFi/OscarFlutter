<?php if ($edit):?>
    <form method="post" accept-charset="utf-8" action="<?php echo base_url()?>admin/movie/update">
    <input type="hidden" name="id" value="<?php echo $movie->id;?>">
<?php else: ?>
    <form method="post" accept-charset="utf-8" action="<?php echo base_url()?>admin/movie/store">
<?php endif;?>

    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <?php if ($edit):?>
            <h3 class="modal-title">Edit Movie</h3>
        <?php else: ?>
            <h3 class="modal-title">Add Movie</h3>
        <?php endif;?>
    </div>
    <div class="modal-body">
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label for="name" class="control-label">Name</label>
                    <input type="text" name="name" class="form-control" placeholder="Enter movie name" value="<?php echo $edit?$movie->name : ''; ?>" required>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label for="name" class="control-label">Year</label>
                    <select name="year" id="movie_year" class="form-control" required>
                        <option>Select year</option>
                        <?php $currentYear = date('Y');?>
                        <?php for($i = (int)$currentYear; $i >= 1928; $i--):?>
                            <?php if ($i == $movie->year):?>
                                <option value="<?php echo $i?>" selected><?php echo $i;?></option>
                            <?php else: ?>
                                <option value="<?php echo $i?>"><?php echo $i;?></option>
                            <?php endif;?>
                        <?php endfor;?>
					</select>
                </div>
            </div>
        </div>      
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label for="name" class="control-label">Description</label>
                    <textarea type="text" name="desc" class="form-control" rows="3" placeholder="Enter movie description"><?php echo !empty($movie->desc)?$movie->desc : ''; ?></textarea>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label for="name" class="control-label">Most Oscar Nomination?</label>
                    <select name="most_oscar" class="form-control" >
                        <option value="">Select Most Oscar</option>
                        <option value="1" <?php echo !empty($movie) && $movie->most_oscar == 1?'selected': ''?>>Yes</option>
                        <option value="0" <?php echo !empty($movie) && $movie->most_oscar == 0?'selected': ''?>>No</option>
					</select>
                </div>
            </div>            
        </div>	
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label for="name" class="control-label">Status</label>
                    <select name="status" class="form-control" >
                        <option value="">Select Status</option>
                        <option value="1" <?php echo !empty($movie) && $movie->status == 1?'selected': ''?>>Active</option>
                        <option value="0" <?php echo !empty($movie) && $movie->status == 0?'selected': ''?>>Inactive</option>
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