<?php

function show_status() {
	
	global $mysqli;
	
	check_abort();
	
	$sql = 'select * from game_status';
	$st = $mysqli->prepare($sql);
	$st->execute();
	$res = $st->get_result();
	header('Content-type: application/json');
	print json_encode($res->fetch_all(MYSQLI_ASSOC), JSON_PRETTY_PRINT);

}

function del_players(){

	global $mysqli;

	$status = read_status();
	if($status['status']=='aborded') {
		$sql2 = "delete from players where username is not null";
		$st2 = $mysqli->prepare($sql2);
		$st2->execute();

	}else{
		return;
	}
}

function check_abort() {
	global $mysqli;
	
	$sql = "update game_status set status='aborded', result=if(p_turn='p1','p2','D'),p_turn=null where p_turn is not null and last_change<(now()-INTERVAL 5 MINUTE) and status='started'";
	$st = $mysqli->prepare($sql);
	$r = $st->execute();
	del_players();
}

function read_status() {
	global $mysqli;
	
	$sql = 'select * from game_status';
	$st = $mysqli->prepare($sql);
	$st->execute();
	$res = $st->get_result();
	$status = $res->fetch_assoc();
	return($status);
}

function update_game_status() {
	global $mysqli;
	$status = read_status();
	$new_status=null;
	$new_turn=null;
	
	$st3=$mysqli->prepare('select count(*) as aborted from players WHERE last_action< (NOW() - INTERVAL 5 MINUTE)');
	$st3->execute();
	$res3 = $st3->get_result();
	$aborted = $res3->fetch_assoc()['aborted'];
	if($aborted>0) {
		$sql = "UPDATE players SET username=NULL, token=NULL WHERE last_action< (NOW() - INTERVAL 5 MINUTE)";
		$st2 = $mysqli->prepare($sql);
		$st2->execute();
		if($status['status']=='started') {
			$new_status='aborted';
		}
	}
	
	$sql = 'select count(*) as c from players where username is not null';
	$st = $mysqli->prepare($sql);
	$st->execute();
	$res = $st->get_result();
	$active_players = $res->fetch_assoc()['c'];
	
	
	switch($active_players) {
		case 0: $new_status='not active'; break;
		case 1: $new_status='initialized'; break;
		case 2: $new_status='started'; 
				if($status['p_turn']==null) {
					$new_turn='p1'; // It was not started before...
				}
				break;
	}
	$sql = 'update game_status set status=?, p_turn=?';
	$st = $mysqli->prepare($sql);
	$st->bind_param('ss',$new_status,$new_turn);
	$st->execute();
	
	
	
}

function handle_player_turn($method, $b){
	if($method=='PUT') {
        update_turn($b);
}
}

function update_turn($b){
	global $mysqli;

	$sql = 'update game_status set p_turn=?, last_change= NOW()';
	$st = $mysqli->prepare($sql);
	$st->bind_param('s',$b);
	$st->execute();

	$sql2 = 'select * from game_status';
	$st2 = $mysqli->prepare($sql2);
	$st2->execute();
	$res2 = $st2->get_result();
	header('Content-type: application/json');
	print json_encode($res2->fetch_all(MYSQLI_ASSOC), JSON_PRETTY_PRINT);
}

function update_move($b,$c,$d){

	global $mysqli;

	
	$status = read_status();

	$sql = 'select card_id from hand where card_id = (select h.card_id from hand h inner join deck_reset d on h.card_id = d.card_id where d.card_color=? and d.card_text = ? and h.player_name = ? order by d.card_text desc limit 1)';
	$st = $mysqli->prepare($sql);
	$st->bind_param('sss',$b,$c,$d);
	$st->execute();
	$res = $st->get_result();
	$r = $res->fetch_all(MYSQLI_ASSOC);
	$card_id = $r[0]['card_id'];

	$sql2 = 'UPDATE play_card SET card_id=?, card_text=? where play_card_id=1';
	$st2 = $mysqli->prepare($sql2);
    $st2->bind_param('is',$card_id,$c);
	$st2->execute();
	
	sleep(0.2);

	$sql3 = 'delete from hand where card_id=? desc limit 1';
	$st3 = $mysqli->prepare($sql3);
	$st3->bind_param('i',$card_id);
	$st3->execute();

	sleep(0.5);

	if($status['p_turn']=='p1') {
		$sql4 = 'select count(*) as c from hand where player_name="p1"'; 
		$st4 = $mysqli->prepare($sql4);
		$st4->execute();
		$res4 = $st4->get_result();
		$r4 = $res4->fetch_all(MYSQLI_ASSOC);
		if($r4[0]['c'] == 0){
			$sql5 = "update game_status set status='ended', p_turn=null, result='p1', last_change= NOW()";
			$st5 = $mysqli->prepare($sql5);
			$st5->execute();
		}
	}else if($status['p_turn']=='p2'){
		$sql4 = 'select count(*) as c from hand where player_name="p2"'; 
		$st4 = $mysqli->prepare($sql4);
		$st4->execute();
		$res4 = $st4->get_result();
		$r4 = $res4->fetch_all(MYSQLI_ASSOC);
		if($r4[0]['c'] == 0){
			$sql5 = "update game_status set status='ended', p_turn=null, result='p2', last_change= NOW()";
			$st5 = $mysqli->prepare($sql5);
			$st5->execute();
		}
	}else{
		header("HTTP/1.1 400 Bad Request");
		print json_encode(['errormesg'=>"something went wrong, player_name = $d"]);
		exit;
	}

	header('Content-type: application/json');
	print json_encode($r4[0]['c'], JSON_PRETTY_PRINT);
	header('Content-type: application/json');
	print json_encode($status['p_turn'], JSON_PRETTY_PRINT);
}





?>