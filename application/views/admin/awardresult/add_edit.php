<?php if ($edit):?>
    <form method="post" accept-charset="utf-8" action="<?php echo base_url()?>admin/awardresult/update">
    <input type="hidden" name="id" value="<?php echo $awardResult->id;?>">
<?php else: ?>
    <form method="post" accept-charset="utf-8" action="<?php echo base_url()?>admin/awardresult/store">
<?php endif;?>

    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <?php if ($edit):?>
            <h3 class="modal-title">Edit Award Result</h3>
        <?php else: ?>
            <h3 class="modal-title">Add Award Result</h3>
        <?php endif;?>
    </div>
    <div class="modal-body">
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label for="name" class="control-label">Name</label>
                    <input type="text" name="name" class="form-control" placeholder="Enter award result name" value="<?php echo $edit?$awardResult->name : ''; ?>" required>
                </div>
            </div>
            <div class="col-xs-6">
                <div class="form-group">
                    <label for="name" class="control-label">Year</label>
                    <select name="year" class="form-control input-sm">
                        <option value="">Select Year</option>
                        <?php $currentYear = date('Y');?>
                        <?php for($i = (int)$currentYear; $i >= 1928; $i--):?>
                            <?php if ($i == $awardResult->year):?>
                                <option value="<?php echo $i?>" selected><?php echo $i;?></option>
                            <?php else: ?>
                                <option value="<?php echo $i?>"><?php echo $i;?></option>
                            <?php endif;?>
                        <?php endfor;?>
                    </select>
                </div>
            </div>
            <div class="col-xs-6">
                <div class="form-group">
                    <label for="name" class="control-label">Status</label>
                    <select name="status" class="form-control" >
                        <option value="">Select Status</option>
                        <option value="1" <?php echo !empty($awardResult) && $awardResult->status == 1?'selected': ''?>>Active</option>
                        <option value="0" <?php echo !empty($awardResult) && $awardResult->status == 0?'selected': ''?>>Inactive</option>
					</select>
                </div>
            </div>            
        </div>	
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label for="name" class="control-label">Description</label>
                    <textarea type="text" name="desc" class="form-control" rows="3" placeholder="Enter award result description"><?php echo !empty($awardResult->desc)?$awardResult->desc : ''; ?></textarea>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-xs-12">
                <h3 class="modal-title">Results</h3>
                <table class="table">
                    <tbody>
                    <?php if (!empty($problems)):?>
                        <?php foreach ($problems as $key => $value):?>
                            <tr class="gradeX">
                                <td>
                                    <?php echo $key?><input type="hidden" name="category_ids[]" value="<?php echo $value['category_id'];?>">
                                </td>
                                <td>
                                    <select name="nomination_ids[]" class="form-control input-sm" >
                                        <option>Select nomination</option>
                                        <?php foreach($value['nominations'] as $nomination):?>
                                            <option value="<?php echo $nomination->id;?>" <?php echo !empty($value['selected_nomination_id']) && $nomination->id == $value['selected_nomination_id']?'selected' : ''?>><?php echo $nomination->name;?></option>
                                        <?php endforeach;?>
                                    </select>
                                </td>
                            </tr>	
                        <?php endforeach ?>		
                    <?php endif;?>	
                    </tbody>
                </table>
            </div>
        </div>
	
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-default waves-effect" data-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-info waves-effect waves-light">Save</button>
    </div>
</form>