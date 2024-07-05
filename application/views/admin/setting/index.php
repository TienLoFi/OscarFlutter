<?php require_once APPPATH.'/views/_header.php';?>

<!-- admin_header -->
<?php require_once APPPATH.'/views/admin/inc/admin_header.php'; ?>

<!-- content -->
<div class="ballot-content" style="padding-top:25px; padding-bottom:20px">
    <form method="post" accept-charset="utf-8" action="<?php echo base_url()?>admin/setting/store">
        <div class="panel">
            <div class="panel-body">
                <div class="row">
                    <div class="col-xs-2"></div>
                    <div class="col-xs-8">
                        <div class="modal-header">
                            <h3 class="modal-title">SETTING</h3>
                        </div>
                        <table class="table">
                        <tbody>
                        <?php if (!empty($settings)):?>
                            <?php foreach ($settings as $item):?>
                                <?php if (!empty($item->key)):?>
                                <tr class="gradeX">
                                    <td><?php echo $item->label; ?></td>
                                    <td>
                                            <?php if ($item->type == 1):?>
                                                <input type="text" name="<?php echo $item->key;?>" class="form-control" value="<?php echo $item->value;?>">
                                            <?php elseif ($item->type == 2):?>
                                                <?php
                                                    $value = json_decode($item->value, true);
                                                    $options = $value['options'];
                                                    $selectedValue = $value['selected_value'];
                                                ?>
                                                <select name="<?php echo $item->key;?>" class="form-control input-sm" >
                                                    <?php foreach($options as $option):?>
                                                        <option value="<?php echo $option['key'];?>" <?php echo $option['key'] == $selectedValue?'selected': ''?>><?php echo $option['value'] ?></option>
                                                    <?php endforeach;?>
                                                </select>
                                            <?php elseif ($item->type == 3):?>
                                                <input type="checkbox" name="<?php echo $item->key;?>" <?php echo $item->value == 1?'checked' : ''?>>
                                            <?php endif;?>
                                    </td>
                                </tr>	
                                <?php endif;?>
                            <?php endforeach ?>		
                        <?php endif;?>	
                        </tbody>
                        </table>
                    </div>
                    <div class="col-xs-2"></div>
                </div>      
            </div>
        </div>
        <div style="width:100%;text-align:center;background: #fafafa;margin-top: 15px;padding-top: 15px;padding-bottom: 10px;">
            <a type="button" href="/admin/setting/index" class="btn btn-danger waves-effect w-md waves-light m-b-5">Reset</a>
            <button type="submit" class="btn btn-success waves-effect w-md waves-light m-b-5">Save</button>
        </div>
    </form>
</div>
<!-- footer -->
<?php require_once APPPATH.'/views/_footer.php';?>