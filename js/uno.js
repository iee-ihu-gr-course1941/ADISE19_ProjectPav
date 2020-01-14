var me={token:null,player_name:null};
var me1={token:null,player_name:null};
var me2={token:null,player_name:null};
var game_status={};
var last_update=new Date().getTime();
var timer=null;
var count = 0;
var count1 = 0;
var color = null;
var colordb = null;


$(function () {

    check_if_players();
    $('#uno_login').click(login_to_game);
    $('#game_reset').click(reset_board);
    $('#deckcard').click (draw_func);
    $('#pass_btn').click(pass);
    game_status_update(); 

});


function check_if_players(){

    $.ajax({url: "uno.php/status/", success: fill_board2});
}


function fill_board2(data){

    var obj = data;

        if(obj[0].p_turn != null){
            $.ajax({type:"GET", url: "uno.php/board/", dataType:"json", success: fill_game });
        }else{
            $('#player1-container').html("");
            $('#player2-container').html("");
            $('#tableCard-container').html("");
        }

}

function fill_game(data){
   
    for(var i=0; i<2; i++){
		for(var j=0; j<data[i].length; j++){
            var obj = data[i][j];

            if(obj.card_color == 'R'){
                cardcolor = "#DF0001";
            }else if (obj.card_color == 'Y'){
                cardcolor = "#FFD302";
            }else if (obj.card_color == 'B'){
                cardcolor = "#0093E1";
            }else if (obj.card_color == 'G'){
                cardcolor = "#019B4A";
            }else{
                cardcolor = "black";
            }

            if(i==0){
				if(obj.player_name=='p1'){

                    $('#player1-container').append('<div class="p1cardclass" id="p1card'+counter1+'" style="background-color: ' + cardcolor +'">' + obj.card_text +'</div>');
                     counter1 = counter1 + 1;

                }if(obj.player_name=='p2'){

                    $('#player2-container').append('<div class="p2cardclass" id="p2card'+counter2+'" style="background-color: ' + cardcolor +'">' + obj.card_text +'</div>');
                    counter2 = counter2 + 1;
                   
                }
            }else{
               
                    $('#tableCard-container').append('<div id=tableCard style="background-color: ' + cardcolor +'">' + obj.card_text +'</div>');
                
            }
        }

    }

    $.ajax({url: "uno.php/status/", success: give_status});
   
}

function give_status(data){

    var obj = data[0];

    game_status.p_turn = obj.p_turn;

    update_info();
    check_turn();

}

function reset_board() {

    $('#player1-container').html("");
    $('#player2-container').html("");
    $('#tableCard-container').html("");
    $('#game_info2').html("");

    count = 0;
    count1 = 0;
    me={token:null,player_name:null};
    me1={token:null,player_name:null};
    me2={token:null,player_name:null};
    last_update=new Date().getTime();
    timer=null;

    game_status_update();
    update_info();

	$.ajax({url: "uno.php/reset/", 
    method: 'POST',
    dataType: "json",
    contentType: 'application/json',
    success: fill_game_by_data});

    game_status_update();
    update_info();

	$('#game_initializer').show(1100);
}


function update_hand(color,card){

    console.log("card = " + card + " card color = " + color);

    $.ajax({url: "uno.php/do_move/"+color+'/'+card+'/'+game_status.p_turn, 
    method: 'PUT',
    dataType: "json",
    contentType: 'application/json',
    success: success_move});

    if(card != 'W' && card != '+4W' && card != '+2' && card != 'R' && card != 'S'){
        pass();
    }

}


function winner(){


    if($("#player1-container").find(".p1cardclass").length == 0) {
        $('#game_info2').html('Player 1 is winner!!! <br> Player 2 is a noob!!!');


    } else if($("#player2-container").find(".p2cardclass").length == 0) {
        $('#game_info').html('Player 2 is winner!!! <br> Player 1 is a noob!!!');

    }

}

function success_move(){

    console.log("Move has been succesfully updated in database");

}


function  playCard(e){

    var card = $(this).text();
    var tablecard = $('#tableCard').text();
    var cardcolor = $(this).css("background-color");
    var tablecardcolor = $('#tableCard').css("background-color");
    var o=e.target;
    var divid=o.id;

    console.log(game_status.p_turn + " " + count + " " + cardcolor + " " + tablecardcolor + " " + card + " " + tablecard);

    if (cardcolor == "rgb(0, 0, 0)" && count == 0) {

        putBlackCard(card,cardcolor,divid);
        count1 = 0;
        count = 0;
        update_info();
        winner();

    }else if ((cardcolor == tablecardcolor || card == tablecard) && (card != 'W') && (card != '+4W') && count == 0) {

        putCard(card,cardcolor,divid);
        update_info();
        winner();    
    }

    
}

function putCard(card,color,id){

    var color = changecardcolor(color);
    var colordb = changecardcolor2(color);

    if (card == "R" || card == "S") {

        $('#tableCard-container').html('<div id=tableCard style="background-color: ' + color  +'">' + card +'</div>');
        $('#'+id).remove(); 

        update_hand(colordb,card);
        count1 = 0;
        count = 0;

    }else if (card == '+2'){

        $('#tableCard-container').html('<div id=tableCard style="background-color: ' + color  +'">' + card +'</div>');
        $('#'+id).remove();

        draw_enemy_two();
        count1 = 0;
        count = 0;
        update_hand(colordb,card);

    }else if (card != 'R' || card != 'S' || card !='+2' || card != 'W' || card != '+4W') {

        $('#tableCard-container').html('<div id=tableCard style="background-color: ' + color  +'">' + card +'</div>');
        $('#'+id).remove();

        count1 = count1 + 1;
        count = count + 1;
        update_hand(colordb,card);

    }
}

function draw_enemy_two(){

    count1 = -1;

    if (game_status.p_turn == 'p1'){
        draw_card_p2();
        draw_card_p2();
    }else if (game_status.p_turn == 'p2'){
        draw_card_p1();
        draw_card_p1();
    }

}

function draw_enemy_four(){

    count1 = -3;

    if (game_status.p_turn == 'p1'){
        draw_card_p2();
        draw_card_p2();
        draw_card_p2();
        draw_card_p2();
    }else if (game_status.p_turn == 'p2'){
        draw_card_p1();
        draw_card_p1();
        draw_card_p1();
        draw_card_p1();
    }

}

function putBlackCard(card,color,id){

    var color = changecardcolor(color);
    var colordb = changecardcolor2(color);

    var red = '#DF0001';
    var green = '#019B4A';
    var yellow = '#FFD302';
    var blue = '#0093E1';

    if(card == 'W'){
        var userInput = prompt("What color do you want your Wild card to be?", "R, Y, G or B?") ;
        switch (userInput.toUpperCase()) {
            case "Y":
                $('#tableCard-container').html('<div id=tableCard style="background-color: ' + yellow  +'">' + card +'</div>');
                $('#'+id).remove();  
                update_hand(colordb,card);    
            break;
            case "B":
                $('#tableCard-container').html('<div id=tableCard style="background-color: ' + blue  +'">' + card +'</div>');
                $('#'+id).remove(); 
                update_hand(colordb,card);            
            break;
            case "R":
                $('#tableCard-container').html('<div id=tableCard style="background-color: ' + red  +'">' + card +'</div>');
                $('#'+id).remove();    
                update_hand(colordb,card);       
            break;
            case "G":
                $('#tableCard-container').html('<div id=tableCard style="background-color: ' + green  +'">' + card +'</div>');
                $('#'+id).remove();   
                update_hand(colordb,card);       
            break;
        }

    }else if(card == '+4W'){
        var userInput = prompt("What color do you want your Wild card to be?", "R, Y, G or B?") ;
        switch (userInput.toUpperCase()) {
            case "Y":
                $('#tableCard-container').html('<div id=tableCard style="background-color: ' + yellow  +'">' + card +'</div>');
                $('#'+id).remove();   
                update_hand(colordb,card);
                draw_enemy_four();       
            break;
            case "B":
                $('#tableCard-container').html('<div id=tableCard style="background-color: ' + blue  +'">' + card +'</div>');
                $('#'+id).remove();
                update_hand(colordb,card);
                draw_enemy_four();  
            break;
            case "R":
                $('#tableCard-container').html('<div id=tableCard style="background-color: ' + red  +'">' + card +'</div>');
                $('#'+id).remove();
                update_hand(colordb,card);
                draw_enemy_four();  
            break;
            case "G":
                $('#tableCard-container').html('<div id=tableCard style="background-color: ' + green  +'">' + card +'</div>');
                $('#'+id).remove();
                update_hand(colordb,card);
                draw_enemy_four();  
            break;
        }


    }
}


function changecardcolor(color){

    if(color == 'rgb(0, 0, 0)'){
        color = 'black';
    }else if(color == 'rgb(1, 155, 74)'){
        color = '#019B4A';
    }else if(color == 'rgb(255, 211, 2)'){
        color = '#FFD302';
    }else if(color == 'rgb(223, 0, 1)'){
        color = '#DF0001';
    }else if(color == 'rgb(0, 147, 225)'){
        color = '#0093E1';
    }
    return color;
}

function changecardcolor2(color){

    if(color == 'black'){
        colordb = 'W';
    }else if(color == '#019B4A'){
        colordb = 'G';
    }else if(color == '#FFD302'){
        colordb = 'Y';
    }else if(color == '#DF0001'){
        colordb = 'R';
    }else if(color == '#0093E1'){
        colordb = 'B';
    }
    return colordb;
}


function fill_board(){	

	$.ajax({type:"GET", url: "uno.php/board/", dataType:"json", success: fill_game_by_data });

}

function fill_game_by_data(data){

    game_status_update();

    var cardcolor = null;
    var counter1 = 0;
    var counter2 = 0;

    for(var i=0; i<2; i++){
		for(var j=0; j<data[i].length; j++){
            var obj = data[i][j];

           if(obj.card_color == 'R'){
            cardcolor = "#DF0001";
        }else if (obj.card_color == 'Y'){
            cardcolor = "#FFD302";
        }else if (obj.card_color == 'B'){
            cardcolor = "#0093E1";
        }else if (obj.card_color == 'G'){
            cardcolor = "#019B4A";
        }else{
            cardcolor = "black";
        }

            if(i==0){
				if(obj.player_name=='p1' && obj.player_name==me.player_name){

                    $('#player1-container').append('<div class="p1cardclass" id="p1card'+counter1+'" style="background-color: ' + cardcolor +'">' + obj.card_text +'</div>');
                     counter1 = counter1 + 1;

                }else if(obj.player_name=='p2' && obj.player_name==me.player_name){

                    $('#player2-container').append('<div class="p2cardclass" id="p2card'+counter2+'" style="background-color: ' + cardcolor +'">' + obj.card_text +'</div>');
                    counter2 = counter2 + 1;
                }}else if(obj.player_name=='p1'){
					$('#player1-container').append("");
				}else if(obj.player_name=='p2'){
					$('#player2-container').append("");
            }else{
            
				if(game_status.status=='started' || (me1.player_name!= null && me2.player_name!=null)){
                    $('#tableCard-container').html('<div id=tableCard style="background-color: ' + cardcolor +'">' + obj.card_text +'</div>');
                    
                    if(obj.card_text == '+2'){
                        count1 = -1;
                        draw_card_p2();
                        draw_card_p2();
                    }
                    
                    if(obj.card_text == 'W'){
                        var userInput = prompt("Lucky!!! Table Card is Wildcard, Player 1 choose What color do you want your Wild card to be?", "R, Y, G or B?") ;
                        switch (userInput.toUpperCase()) {
                            case "Y":
                                $('#tableCard-container').html('<div id=tableCard style="background-color: ' + '#FFD302'  +'">' + obj.card_text +'</div>');   
                            break;
                            case "B":
                                $('#tableCard-container').html('<div id=tableCard style="background-color: ' + '#0093E1'  +'">' + obj.card_text +'</div>');           
                            break;
                            case "R":
                                $('#tableCard-container').html('<div id=tableCard style="background-color: ' + '#DF0001'  +'">' + obj.card_text +'</div>');      
                            break;
                            case "G":
                                $('#tableCard-container').html('<div id=tableCard style="background-color: ' + '#019B4A'  +'">' + obj.card_text +'</div>');
                            break;
                        }
                
                    }if(obj.card_text == '+4W'){
                        var userInput = prompt("Super Lucky!!! Table Card is Wildcard +4, Player 1 choose What color do you want your Wild card to be?", "R, Y, G or B?") ;
                        switch (userInput.toUpperCase()) {
                            case "Y":
                                $('#tableCard-container').html('<div id=tableCard style="background-color: ' + '#FFD302'  +'">' + obj.card_text +'</div>');
                                count1 = -3;
                                draw_card_p2();
                                draw_card_p2();  
                                draw_card_p2(); 
                                draw_card_p2();      
                            break;
                            case "B":
                                $('#tableCard-container').html('<div id=tableCard style="background-color: ' + '#0093E1'  +'">' + obj.card_text +'</div>');
                                count1 = -3;
                                draw_card_p2();
                                draw_card_p2();  
                                draw_card_p2(); 
                                draw_card_p2();  
                            break;
                            case "R":
                                $('#tableCard-container').html('<div id=tableCard style="background-color: ' + '#DF0001'  +'">' + obj.card_text +'</div>');
                                count1 = -3;
                                draw_card_p2();
                                draw_card_p2();  
                                draw_card_p2(); 
                                draw_card_p2();  
                            break;
                            case "G":
                                $('#tableCard-container').html('<div id=tableCard style="background-color: ' + '#019B4A'  +'">' + obj.card_text +'</div>');
                                count1 = -3;
                                draw_card_p2();
                                draw_card_p2();  
                                draw_card_p2(); 
                                draw_card_p2();  
                            break;
                        }
                        
                    }
                
				}else{
                    $('#table_card').html("[]");               
                }
			}
        
            
        }

    }

    check_turn();
    
}


function login_to_game() {

	if($('#username').val()=='') {
		alert('You have to set a username');
		return;		
    }
    
	var p_name = $('#pname').val();
	
	$.ajax({url: "uno.php/players/"+p_name, 
			method: 'PUT',
			dataType: "json",
			contentType: 'application/json',
			data: JSON.stringify( {player_name: p_name, username: $('#username').val()}),
			success: login_result,
            error: login_error});
            
}

function login_result(data) {

    if (data[0].player_name == 'p1'){

        me = data[0];
        me1 = data[0];
        fill_board();

    }else if (data[0].player_name == 'p2'){

        me = data[0];
        me2 = data[0];
        fill_board();

    }

    if (me1.player_name == 'p1' && me2.player_name == 'p2'){

        $('#game_initializer').hide(200);
        game_status.p_turn = 'p1';
        $('#pass_btn').show(200);
        count = 0;
        coun1 = 0;

    }

    game_status_update();
    $('#username').val("");

    update_info();
}



function login_error(data,y,z,c) {

	var x = data.responseJSON;
    alert(x.errormesg);
    
}

function update_info(){

    if(game_status.p_turn == 'p1'){
        player = 'Player 1';
        $('#game_info').html("I am Player: <strong>"+game_status.p_turn+"</strong>, my name is <strong>"+me1.username +"<br><br></strong>Game state: <strong>"+game_status.status+"</strong>,<strong>"+ player+"</strong> must play now.");
    }else if(game_status.p_turn == 'p2'){
        player = 'Player 2';
        $('#game_info').html("I am Player: <strong>"+game_status.p_turn+"</strong>, my name is <strong>"+me2.username +"</strong><br><br>Game state: <strong>"+game_status.status+"</strong>,<strong>"+ player+"</strong> must play now.");
    }else if(game_status.p_turn == null){
        $('#game_info').html("I am Player: <strong>Not Entered</strong>, my name is <strong>Not Entered</strong><br><br> Game state: <strong>"+game_status.status+"</strong>, Null must play now.");
    }
	
}

function game_status_update() {
	
    clearTimeout(timer);
    $.ajax({url: "uno.php/status/", success: update_status});

}

function update_status(data) {
 
	last_update=new Date().getTime();
    game_status = data[0];
    game_status.p_turn=data[0].p_turn;

    if (game_status.status == 'aborded' || game_status.status == 'not active' || game_status.status == 'ended'){

        $(".p1cardclass").remove();
        $(".p2cardclass").remove();
        $("#tableCard").remove();

         player = null;
         me={token:null,player_name:null};
         me1={token:null,player_name:null};
         me2={token:null,player_name:null};
      //   $('#pass_btn').hide();

    }else if(game_status.status == 'started'){

        $('#game_initializer').hide();
    }
	update_info();
    clearTimeout(timer);

    timer=setTimeout(function() { game_status_update();}, 4500);
 	
}


var counter1 = 7;
var counter2 = 7;
function draw_func(){

    if(game_status.p_turn == 'p1'){
        draw_card_p1();
    }else if(game_status.p_turn == 'p2'){
        draw_card_p2();
    }

}

function draw_card_p1(){
  
    if(count1 == 0 || count1 == -1 || count1 == -2 || count1 == -3){

        count1 = count1 + 1;
        $.ajax({type:"PUT",url:"uno.php/draw_p1", dataType:"json", success: draw_card_success_p1});  

    }else{
        $('#game_info2').html("You can only draw one card!");
    }
    
}

function draw_card_success_p1(data){

    var obj = data;
    var card_draw = obj[0].card_text;
  
    if(obj[0].card_color == 'R'){
        cardcolor = "#DF0001";
    }else if (obj[0].card_color == 'Y'){
        cardcolor = "#FFD302";
    }else if (obj[0].card_color == 'B'){
        cardcolor = "#0093E1";
    }else if (obj[0].card_color == 'G'){
        cardcolor = "#019B4A";
    }else{
        cardcolor = "black";
    }

        $('#player1-container').append('<div class="p1cardclass" id="p1card'+counter1+'" style="background-color: ' + cardcolor +'">' + card_draw +'</div>');
        counter1 = counter1 + 1;
    
}

function draw_card_p2(){
 
    if(count1 == 0 || count1 == -1 || count1 == -2 || count1 == -3){

        count1 = count1 + 1;
        $.ajax({type:"PUT",url:"uno.php/draw_p2", dataType:"json", success: draw_card_success_p2}); 

    }else{
        $('#game_info2').html("You can only draw one card!");
    }
    
}

function draw_card_success_p2(data){

    var obj = data;
    var card_draw = obj[0].card_text;

    if(obj[0].card_color == 'R'){
        cardcolor = "#DF0001";
    }else if (obj[0].card_color == 'Y'){
        cardcolor = "#FFD302";
    }else if (obj[0].card_color == 'B'){
        cardcolor = "#0093E1";
    }else if (obj[0].card_color == 'G'){
        cardcolor = "#019B4A";
    }else{
        cardcolor = "black";
    }

        $('#player2-container').append('<div class="p2cardclass" id="p2card'+counter2+'" style="background-color: ' + cardcolor +'">' + card_draw +'</div>');
         counter2 = counter2 + 1;
    
}

function pass(){

    count = 0;
    count1 = 0;

    update_turn();
    check_turn();
}

function update_turn(){

    $('#game_info2').html('');
 
        if (game_status.p_turn == 'p1'){
            game_status.p_turn = 'p2';
        }else if(game_status.p_turn == 'p2'){
            game_status.p_turn = 'p1';
        }
      
    $.ajax({url: "uno.php/draw/"+game_status.p_turn, 
			method: 'PUT',
			dataType: "json",
			contentType: 'application/json',
            success: newturn_success});
            
}

function newturn_success(data){

    var obj = data;
    game_status.p_turn = obj[0].p_turn;

    game_status_update();
    update_info();
}

function check_turn(){
 
    if (game_status.p_turn == 'p1'){

       $('#player2-container').off('click', '.p2cardclass');
       $('#player1-container').on('click', '.p1cardclass', playCard);
    
    }else if(game_status.p_turn == 'p2'){

        $('#player1-container').off('click', '.p1cardclass');
        $('#player2-container').on('click', '.p2cardclass', playCard);

    }
}

