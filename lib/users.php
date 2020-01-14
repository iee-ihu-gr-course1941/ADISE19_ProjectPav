<?php

function handle_user($method, $b,$input) {

	if($method=='PUT') {
        set_user($b,$input);
    }
}

function show_users() {

	global $mysqli;

	$sql = 'select player_name, username from players';
	$st = $mysqli->prepare($sql);
	$st->execute();
	$res = $st->get_result();

	header('Content-type: application/json');
	print json_encode($res->fetch_all(MYSQLI_ASSOC), JSON_PRETTY_PRINT);
}

function set_user($b,$input) {
	
	if(!isset($input['username'])) {
		header("HTTP/1.1 400 Bad Request");
		print json_encode(['errormesg'=>"No username given."]);
		exit;
	}

	$username = $input['username'];
	global $mysqli;

	$sql = 'select count(*) as c from players where player_name=?';
	$st = $mysqli->prepare($sql);
	$st->bind_param('s',$b);
	$st->execute();
	$res = $st->get_result();
	$r = $res->fetch_all(MYSQLI_ASSOC);
	if($r[0]['c']>0) {
		header("HTTP/1.1 400 Bad Request");
		print json_encode(['errormesg'=>"Player $b is already set. Please select another player."]);
		exit;
	}
	
    $sql = "INSERT INTO players (player_name, username, token) VALUES (?, ?, md5(CONCAT( ?, NOW())))";
    $st2 = $mysqli->prepare($sql);
    $st2->bind_param('sss',$b,$username,$username);
    $st2->execute();
    
	update_game_status();
	
	$sql = 'select * from players where player_name=?';
	$st = $mysqli->prepare($sql);
	$st->bind_param('s',$b);
	$st->execute();
	$res = $st->get_result(); 
	header('Content-type: application/json');
	print json_encode($res->fetch_all(MYSQLI_ASSOC), JSON_PRETTY_PRINT);

}


?>