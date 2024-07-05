<option value="">--Select movie--</option>
<?php foreach($movies as $movie):?>
    <option value="<?php echo $movie->id ?>"><?php echo $movie->name ?></option>
<?php endforeach;?>