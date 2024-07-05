
<?php require_once '_header.php';?>
<!-- header -->
<?php if (!empty($ballot)):?>
	<form id="form_admin_problem" action="<?php echo base_url();?>home/update" method="post">
	<input type="hidden" name="id" value="<?php echo $ballot->id;?>">
<?php else: ?>
	<form id="form_admin_problem" action="<?php echo base_url();?>home/store" method="post">
<?php endif;?>
<div class="ballot-header">
	<?php require_once APPPATH.'/views/inc/header.php'; ?>
	<div style="background-color: #f6f6f6;padding-top:13px;padding-bottom:13px;margin-top:-6px;margin-right:0;margin-left:0;" class="row">
		<div class="col-md-6" style="background-color: #f6f6f6;margin-top: -10px;">    
			<h4 style="padding-top: 10px;"><strong>Name : <?php echo $user['name']??''; ?></strong></h4>
			<h4 style="padding-top: 10px;"><strong>Score : <?php echo ($ballotInfo['score']??0).'/100'; ?></strong></h4>	
		    
        </div>
		<div class="col-md-6" style="background-color: #f6f6f6;margin-top: -10px;">	
            <h4><strong>TIEBREAKER QUESTIONS</strong></h4>
            <h4 style="padding-top: 10px;padding-bottom:12px;">Total number of correct answers : <?php echo $ballotInfo['total_correct']??0;?></h4>
			<h4>Film with the Most Oscars : 
            
            <select id="most_oscar_movie_id" name="most_oscar_movie_id" style="height: 30px; border: 0; border-bottom: solid 1px;background-color: #f6f6f6;margin-left:10px;">
                <?php foreach($mostOscarMovies as $movie): ?>
					<option value="<?php echo $movie->id;?>" <?php echo !empty( $ballot) && $ballot->most_oscar_movie_id == $movie->id? 'selected':''?>><?php echo $movie->name;?></option>
                <?php endforeach;?>
            </select>
            </h4>
			<h4>How many?
            <select id="how_many" name="how_many" style="height: 30px; width: 160px; border: 0; border-bottom: solid 1px;background-color: #f6f6f6;margin-left:10px;">
                <?php
                    for($i = 1; $i <= 12; $i++) {
                        if ($i == $ballot->how_many)
                            echo '<option value="'.$i.'" selected>'.$i.'</option>';
                        else
                            echo '<option value="'.$i.'">'.$i.'</option>';
                    }
                ?>
            </select>
            </h4>	
		</div>
	</div>
</div>

<!-- content -->
<div class="ballot-content">

	<div id="ballots">
		<?php foreach ($problems as $key => $value):?>
		<div class="ballot-box ballots-col3">
			<div class="ballot-sell-header"><h5><?php echo $key.' ('. count($value['nominations']).')'; ?></h5></div>
			<input type="hidden" name="category_ids[]" value="<?php echo $value['category_id'];?>">
			<?php foreach ($value['nominations'] as $nomination): ?>
					
					<div class="ballot-sell radio radio-primary">
						<input  type="radio" name="nomination_ids[<?php echo $value['category_id'];?>]" value="<?php echo $nomination->id?>" <?php echo !empty($value['selected_nomination_id']) && $nomination->id == $value['selected_nomination_id']?'checked':''?>>
						<label><?php echo $nomination->name;?></label>
					</div>
			<?php endforeach;?>		 
		</div>
		<?php endforeach; ?>		
	</div>
    <?php 
        $oscarSetting = OscarSetting::getInstance();
        $lockBallotPage = $oscarSetting->get('lock_ballot_page');
    ?>
	<?php if (!empty($user) && $lockBallotPage != 1):?>
	<div style="width:100%;text-align:center;background: #fafafa;margin-top: 15px;padding-top: 15px;padding-bottom: 10px;">
		<a type="button" href="/" class="btn btn-danger waves-effect w-md waves-light m-b-5">Reset</a>
		<button type="submit" class="btn btn-success waves-effect w-md waves-light m-b-5">Save</button>
	</div>
	<?php endif;?>
</div>
</form>

<!-- footer -->

<style>
.ballot-sell {
    padding-top: 10px;
    padding-bottom: 10px;
    border-bottom: solid 1px #ddd;
    cursor: pointer;
}

.ballot-sell:hover{
    background: #efefef;
    opacity: 0.5;
}

.ballot-progress{
    position: absolute; 
    top: -2px; 
    left: 0; 
    width: 0%; 
    height: calc(100% - 1px);
    background: #aaa;
    opacity:0.2;
}

.ballot-progress-sapn{
    float: right;
    display: none;
}
</style>

<?php require_once '_footer.php';?>
