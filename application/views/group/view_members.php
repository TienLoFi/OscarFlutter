<?php if (!empty($members)):?>
<table class="table table-striped">
    <thead>
        <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Score</th>
            <th>Status</th>

        </tr>
    </thead>
    <tbody>
    <?php foreach($members as $member):?>
        <tr class="gradeX">
            <td><?php echo $member->name;?></td>
            <td><?php echo $member->email;?></td>
            <td><?php echo $member->score;?></td>
            <td><?php echo $member->status == 1?'Active' : 'Pending';?></td>
        </tr>
    <?php endforeach;?>
    </tbody>
</table>
<div class="row mt-2">
    <div class="col-sm-6">
        <div class="dataTables_info" role="status" aria-live="polite"><?php echo $pagination_string;?></div>
    </div>
    <div class="col-sm-6">
        <div class="dataTables_paginate paging_simple_numbers" id="datatable-editable_paginate">
            <?php echo $pagination;?>
        </div>
    </div>
</div>
<?php else: ?>
    <table class="table table-striped">
    <thead>
        <tr>
            <th></th>
            <th>Name</th>
            <th>Email</th>
            <th>Score</th>
            <th>Status</th>
            <th data-priority="3"></th>
        </tr>
    </thead>
    <tbody>
        <tr class="gradeX">
            <td colspan="6">There are no members</td>
        </tr>
    </tbody>
</table>
<?php endif;?>