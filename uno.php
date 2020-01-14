<?php

require_once "lib/dbconnect.php";
require_once "lib/board.php";
require_once "lib/users.php";
require_once "lib/game.php";

$method = $_SERVER['REQUEST_METHOD'];
$request = explode('/', trim($_SERVER['PATH_INFO'],'/'));
$input = json_decode(file_get_contents('php://input'),true);


switch ($r=array_shift($request)) {
    case 'board' : 
            switch ($b=array_shift($request)) {
                case '':
                case null: handle_board($method,$input);
                        break;
                default: header("HTTP/1.1 404 Not Found");
                        break;
			}
                break;
    case 'reset': 
            if(sizeof($request)==0) {handle_reset($method,$input);}
    case 'status': 
			if(sizeof($request)==0) {show_status();}
			else {header("HTTP/1.1 404 Not Found");}
			break;
	case 'players': handle_player($method, $request,$input);
            break;
    case 'turn_change': if(sizeof($request)==0) {draw_card();}
                        else if (sizeof($request)==1){handle_turn($method, $request);}
                        else {header("HTTP/1.1 404 Not Found");}
                        break;
    case 'draw_p1': if(sizeof($request)==0){draw_card_p1();}
                        break;
    case 'draw_p2': if(sizeof($request)==0){draw_card_p2();}
                    break;
    case 'do_move': handle_move($method,$request[0],$request[1],$request[2]);
                break;

    default:  header("HTTP/1.1 404 Not Found");
                        exit;
}

function handle_reset($method){
    if($method=='POST') {
        reset_game();
        show_board();
}
}

function handle_board($method) {
 
    if($method=='GET') {
            show_board();
    } else if ($method=='POST') {
            reset_board();
    }
    
}

function handle_move($method,$x,$y,$z) {
	if($method=='PUT') {
        update_move($x,$y,$z);
    }   
}

function handle_turn($method, $request){
    switch ($b=array_shift($request)) {
        case 'p1': 
        case 'p2': handle_player_turn($method, $b);
            break;
        default: header("HTTP/1.1 404 Not Found");
            break;
                }
}

function handle_player($method, $request,$input) {
	switch ($b=array_shift($request)) {
		case '':
		case null: if($method=='GET') {show_users();}
				   else {header("HTTP/1.1 400 Bad Request"); 
						 print json_encode(['errormesg'=>"Method $method not allowed here."]);}
                    break;
        case 'p1': 
		case 'p2': handle_user($method, $b,$input);
					break;		
		default: header("HTTP/1.1 404 Not Found");
				 print json_encode(['errormesg'=>"Player $b not found."]);
                 break;
	}
}


?>