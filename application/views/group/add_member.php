<form method="post" accept-charset="utf-8" action="<?php echo base_url()?>group/storeMember">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 class="modal-title">Add Member</h3>
    </div>
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
            <button class="btn btn-sm btn-primary" id="send-invite-btn">Send</button>
        </div>
    </div>	
</form>