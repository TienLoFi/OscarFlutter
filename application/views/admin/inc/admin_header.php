<div class="ballot-header" style="padding-bottom:0">
	<div id="title" style="box-shadow: 0 3px 4px rgba(0,0,0,0.2);">
		<div class="ballot-header-login">
		<?php if (!$isLogin) { ?>
    		<div><a href="#" data-toggle="modal" data-target="#signin-modal">Sign In</a></div>
			<div style="margin-top:6px"><a href="#" data-toggle="modal" data-target="#signup-modal">Sign Up</a></div>
		<?php } else { ?>
			<div><a href="#" style="margin-left:20px" id="signOut">Sign Out</a></div>
			<div style="margin-top:6px"><a href="#" data-toggle="modal" data-target="#change-modal">My Profile</a></div>
            <div><a href="/" style="margin-left:20px">Visit site</a></div>
		<?php }?>
		</div>
		<h2><?php $year = date('Y'); 
            $ends = array('th','st','nd','rd','th','th','th','th','th','th');
            if (($year % 100) >= 11 && ($year%100) <= 13)
               $abbreviation = 'th';
            else
               $abbreviation = $ends[($year-1928) % 10];
            echo ($year-1928).$abbreviation; ?> Academy Awards</h2>
		<h1 class="header-title m-t-0 m-b-30"><?=date('Y')?> - OSCARS BALLOT</h1>
		<p>Fill out your annual ballot with your predictions on who will take home the awards. Good luck.</p>
	</div>
	
	<div class="ballot-menu">
		<div class="navbar">						
			<ul class="nav">
                <?php if (!empty($isActiveSettingPage)):?>
                    <li style="float:right;"  class="active"><a href="<?php echo base_url()?>admin/setting/index">Setting</a></li>
                <?php else: ?>
                    <li style="float:right;"><a href="<?php echo base_url()?>admin/setting/index">Setting</a></li>
                <?php endif?>
                <?php if (!empty($isActiveUserPage)):?>
                    <li style="float:right;"  class="active"><a href="<?php echo base_url()?>admin/user/index">Users</a></li>
                <?php else: ?>
                    <li style="float:right;"><a href="<?php echo base_url()?>admin/user/index">Users</a></li>
                <?php endif?>
                <?php if (!empty($isActiveAwardResultPage)):?>
                    <li style="float:right;" class="active"><a href="<?php echo base_url()?>admin/awardresult/index">Award Result</a></li>
                <?php else: ?>
                    <li style="float:right;"><a href="<?php echo base_url()?>admin/awardresult/index">Award Result</a></li>
                <?php endif?>
                <?php if (!empty($isActiveCategoryPage)):?>
                    <li style="float:right;"  class="active"><a href="<?php echo base_url()?>admin/category/index">Categories</a></li>
                <?php else: ?>
                    <li style="float:right;"><a href="<?php echo base_url()?>admin/category/index">Categories</a></li>
                <?php endif?>
                <?php if (!empty($isActiveMoviePage)):?>
                    <li style="float:right;"  class="active"><a href="<?php echo base_url()?>admin/movie/index">Movies</a></li>
                <?php else: ?>
                    <li style="float:right;"><a href="<?php echo base_url()?>admin/movie/index">Movies</a></li>
                <?php endif?>
                <?php if (!empty($isActiveNominationPage)):?>
                    <li style="float:right;"  class="active"><a href="<?php echo base_url()?>admin/nomination/index">Nomination</a></li>
                <?php else: ?>
                    <li style="float:right;"><a href="<?php echo base_url()?>admin/nomination/index">Nomination</a></li>
                <?php endif?>
                <?php if (!empty($isActiveGroupPage)):?>
                    <li style="float:right;" class="active"><a href="<?php echo base_url()?>admin/group/index">Group</a></li>
                <?php else: ?>
                    <li style="float:right;"><a href="<?php echo base_url()?>admin/group/index">Group</a></li>
                <?php endif?>
																
			</ul>
		</div>
	</div>
</div>