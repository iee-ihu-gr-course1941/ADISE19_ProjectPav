
<?php

function show_board(){

	global $mysqli;
	
	$sql = 'select h.player_name, d.card_text, d.card_color from hand h inner join deck_reset d on h.card_id=d.card_id order by card_text';
	$sql1 = 'select * from play_card t inner join deck_reset d on t.card_id=d.card_id order by play_card_id desc limit 1';
	$st = $mysqli->query($sql);
	$st1 = $mysqli->query($sql1);
	$res1 = $st->fetch_all(MYSQLI_ASSOC);
	$res2 = $st1->fetch_all(MYSQLI_ASSOC);
	header('Content-type: application/json');
    print json_encode(array($res1,$res2), JSON_PRETTY_PRINT);
    
}

function reset_board() {

	global $mysqli;

	$sql = 'CALL clean_board()';
	$mysqli->query($sql);
}

function draw_card_p1() {

	global $mysqli;

	$sql = 'SELECT * FROM remaining_deck ORDER BY RAND() LIMIT 1';
	$st = $mysqli->prepare($sql);
	$st->execute();
	$res = $st->get_result();
	$r = $res->fetch_all(MYSQLI_ASSOC);
	$card = $r[0]['card_id'];

	$sql2 = "INSERT INTO hand (player_name, card_id) VALUES ('p1', ?)";
	$st2 = $mysqli->prepare($sql2);
    $st2->bind_param('i',$card);
	$st2->execute();

	$sql3 = "DELETE FROM remaining_deck where card_id=?";
	$st3 = $mysqli->prepare($sql3);
    $st3->bind_param('i',$card);
	$st3->execute();

	header('Content-type: application/json');
	print json_encode($r, JSON_PRETTY_PRINT);

}

function draw_card_p2() {

	global $mysqli;

	$sql = 'SELECT * FROM remaining_deck ORDER BY RAND() LIMIT 1';
	$st = $mysqli->prepare($sql);
	$st->execute();
	$res = $st->get_result();
	$r = $res->fetch_all(MYSQLI_ASSOC);
	$card = $r[0]['card_id'];

	$sql2 = "INSERT INTO hand (player_name, card_id) VALUES ('p2', ?)";
	$st2 = $mysqli->prepare($sql2);
    $st2->bind_param('i',$card);
	$st2->execute();

	$sql3 = "DELETE FROM remaining_deck where card_id=?";
	$st3 = $mysqli->prepare($sql3);
    $st3->bind_param('i',$card);
	$st3->execute();

	header('Content-type: application/json');
	print json_encode($r, JSON_PRETTY_PRINT);

}


function reset_game(){

	global $mysqli;

	$x=0;
	$y=0;

	reset_board();

	for ($x = 0; $x < 7; $x++) {
		$sql2 = 'SELECT * FROM deck ORDER BY RAND() LIMIT 1';
		$st2 = $mysqli->prepare($sql2);
		$st2->execute();
		$res2 = $st2->get_result();
		$r2 = $res2->fetch_all(MYSQLI_ASSOC);
		$card = $r2[0]['card_id'];

		$sql3 = "INSERT INTO hand (player_name, card_id) VALUES ('p1', ?)";
		$st3 = $mysqli->prepare($sql3);
    	$st3->bind_param('i',$card);
		$st3->execute();

		$sql = "DELETE FROM deck where card_id=?";
		$st = $mysqli->prepare($sql);
    	$st->bind_param('i',$card);
		$st->execute();

		$sql4 = "DELETE FROM remaining_deck where card_id=?";
		$st4 = $mysqli->prepare($sql4);
    	$st4->bind_param('i',$card);
		$st4->execute();
	}

	for ($y = 0; $y < 7; $y++) {
		$sql2 = 'SELECT * FROM deck ORDER BY RAND() LIMIT 1';
		$st2 = $mysqli->prepare($sql2);
		$st2->execute();
		$res2 = $st2->get_result();
		$r2 = $res2->fetch_all(MYSQLI_ASSOC);
		$card = $r2[0]['card_id'];
	
		$sql3 = "INSERT INTO hand (player_name, card_id) VALUES ('p2', ?)";
		$st3 = $mysqli->prepare($sql3);
		$st3->bind_param('i',$card);
		$st3->execute();
	
		$sql = "DELETE FROM deck where card_id=?";
		$st = $mysqli->prepare($sql);
		$st->bind_param('i',$card);
		$st->execute();
	
		$sql4 = "DELETE FROM remaining_deck where card_id=?";
		$st4 = $mysqli->prepare($sql4);
		$st4->bind_param('i',$card);
		$st4->execute();
	}

	$sql7 = 'SELECT * FROM deck ORDER BY RAND() LIMIT 1';
	$st7 = $mysqli->prepare($sql7);
	$st7->execute();
	$res7 = $st7->get_result();
	$r7 = $res7->fetch_all(MYSQLI_ASSOC);
	$card = $r7[0]['card_id'];
	$card_text = $r7[0]['card_text'];

	$sql8 = 'UPDATE play_card SET card_id=?, card_text=? where play_card_id=1';
	$st8 = $mysqli->prepare($sql8);
    $st8->bind_param('is',$card,$card_text);
	$st8->execute();

	$sql9 = "DELETE FROM remaining_deck where card_id=?";
	$st9 = $mysqli->prepare($sql9);
    $st9->bind_param('i',$card);
	$st9->execute();

}


?>