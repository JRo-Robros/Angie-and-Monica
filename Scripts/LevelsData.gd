extends Node

const LEVELS:Array = [
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,0,0,0,0,5,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,2,3,2,300,5,"Move Angie and Monica to their goals", "Welcome"],
	[0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,1,0,0,0,1,1,1,1,1,0,1,1,0,0,1,6,0,1,1,1,1,1,1,1,1,1,0,1,1,5,0,0,0,1,1,1,1,1,1,0,0,0,1,1,0,0,1,1,0,0,0,0,1,1,0,0,1,1,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,1,7,0,3,150,8,"Watch Your Step","The Long and Winding Road"],
	[6,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,1,1,1,0,0,0,0,0,0,1,5,1,1,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,4,3,3,300,5,"Use Blocks to Change Positions", "Against the Wall"],
	[3,5,3,2,0,3,2,1,3,2,2,3,2,3,3,2,4,3,2,5,3,2,6,3,2,7,3,2,8,3,2,9,3,7,0,3,7,1,3,7,2,3,7,3,3,7,4,3,7,5,3,7,6,3,7,9,3,7,7,3,7,8,3,6,8,3,6,7,3,6,0,3,6,1,3,6,2,3,6,3,3,6,4,3,6,5,3,6,6,3,6,9,3,3,9,3,3,8,3,3,7,3,3,6,3,3,3,3,3,2,3,3,1,3,3,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,6,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,4,1,300,12,"Me first!","Park n Pass"],
	[4,6,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,1,5,6,1,1,1,0,0,0,0,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,4,3,3,300,12,"Do a 180","Trading Places"],
	[4,7,3,4,2,3,2,2,3,2,7,3,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,0,0,1,1,1,5,6,1,1,1,0,0,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,4,5,4,4,300,14,"You got this!", "Rocks and Hard Places"],
	[5,7,3,4,7,3,5,6,3,4,6,3,5,5,3,4,5,3,5,3,3,4,3,3,5,2,3,4,2,3,5,1,3,4,1,3,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,0,0,0,1,1,6,1,5,1,1,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,7,5,7,3,300,13,"Single File, Please","Narrow Passage"],
	[2,6,3,2,7,3,3,7,3,4,7,3,4,6,3,3,5,2,5,6,3,5,7,3,6,7,3,7,7,3,7,6,3,6,5,2,3,3,2,6,3,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,6,0,0,0,0,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,5,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,6,3,6,300,6,"Push boxes into empty spaces", "Push it"],
	[4,4,2,4,5,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,1,1,1,1,1,0,0,0,0,1,5,1,1,1,1,0,0,0,0,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,3,2,2,300,12,"Since boxes can only move into empty spaces, Two boxes together can help you reposition.","Boxes blocks us"],
	[2,5,1,1,6,3,1,7,3,1,8,3,2,8,3,3,8,3,3,7,3,3,6,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,5,6,0,0,0,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,4,7,2,7,300,12,"Only Monica can push Horn blocks", "Heavy Metal"],
	[5,2,3,6,2,3,7,2,3,7,3,3,5,3,3,6,5,0,5,4,3,7,4,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,0,0,0,0,1,1,6,5,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,4,4,4,300,15,"Only Angie can push Halo Blocks", "It belongs in a museum!"],
	[2,3,3,2,5,3,8,3,1,8,6,0,0,0,0,1,5,0,1,6,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,1,0,0,1,0,0,0,0,1,0,1,1,1,1,0,1,0,0,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,1,1,0,0,0,0,0,4,0,5,300,16,"Kick those blocks off the edges if necessary", "Is This Sparta?!"],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,5,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,1,3,1,1,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,1,1,3,1,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,5,1,4,300,7,"Spiderwebs hold a character in place for one move.","Walking into Spiderwebs"],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,1,1,1,1,1,1,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,6,0,0,0,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,4,5,3,300,18,"Stop Following Me!","Stay Put"],
	[9,2,3,2,3,3,0,0,5,1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,0,0,0,0,6,1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,1,1,1,0,300,18,"Think Ahead","Rocks and Harder Places"],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,5,0,0,0,0,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,0,0,0,0,1,1,4,1,1,1,0,0,0,0,1,1,1,1,1,1,0,0,0,0,1,1,1,1,1,1,0,0,0,0,6,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,3,5,3,4,300,6,"Reverse Tiles will switch a Character's Directions","Switcharoo!"],
	[4,4,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,0,6,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,4,1,1,4,1,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,6,2,2,300,9,"Walking ove a reverse tile when already revesed will switch back to normal","Do-si-do"],
	[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,0,0,0,1,1,1,1,6,1,1,0,0,0,4,1,1,1,1,1,1,0,0,0,1,1,5,1,1,1,1,0,0,0,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,8,2,2,300,7,"Careful!  Angie and Monica don't get along well enough to share a tile.","Personal Space"],
	[2,4,3,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,6,1,1,1,1,1,0,0,0,0,0,1,0,1,0,0,1,0,0,0,0,0,1,4,5,1,1,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,1,1,1,1,4,0,0,0,0,0,1,1,0,1,1,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,1,0,0,0,1,0,0,0,0,7,0,3,300,11,"These reverses can get pretty tricky.","Double Back"],
	[9,0,3,9,1,3,9,2,3,9,3,3,9,4,3,9,5,3,9,6,3,9,7,3,9,8,3,9,9,3,8,9,3,7,9,3,6,9,3,5,9,3,4,9,3,3,9,3,2,9,3,1,9,3,0,9,3,0,8,3,0,6,3,0,7,3,0,5,3,0,4,3,0,3,3,0,2,3,0,1,3,0,0,3,1,0,3,2,0,3,3,0,3,4,0,3,5,0,3,6,0,3,7,0,3,8,0,3,6,2,3,5,2,3,7,3,3,7,4,3,7,2,3,7,5,3,4,2,3,3,2,3,2,2,3,4,4,3,5,4,3,7,6,3,7,7,3,6,7,3,5,7,3,4,7,3,3,7,3,2,7,3,3,5,3,2,5,3,1,5,3,2,3,3,5,5,3,6,6,3,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,6,5,1,1,1,1,1,1,1,5,1,1,1,1,1,1,1,1,1,6,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,8,2,7,1,300,26,"I didn't know this was multiple-choice!","Two Paths"],
	[8,3,3,7,4,3,0,0,0,1,1,1,1,0,0,0,0,5,4,4,4,4,1,6,5,0,0,4,4,4,4,1,6,6,6,0,6,4,4,4,0,0,6,6,6,6,6,4,5,0,0,0,0,5,6,6,6,6,5,0,0,0,0,5,6,6,6,6,6,5,0,0,5,6,6,6,0,6,6,6,5,5,6,6,6,0,0,6,6,6,6,6,6,6,6,0,0,0,0,6,6,6,6,0,0,0,9,5,9,4,300,9,"Tasty but twisty","MMMMMMMM, Donut"],
	[2,8,3,2,2,3,3,2,0,3,8,0,4,7,0,4,6,0,4,5,0,4,4,0,4,3,0,3,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,6,1,1,1,5,1,0,0,0,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,0,0,0,1,3,3,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,5,5,5,300,24,"How'd she even get in there?","A Fiend in Need"],
	[1,4,3,1,5,3,2,5,3,2,4,3,3,4,3,3,5,3,3,1,1,1,2,1,1,3,1,3,3,1,3,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,6,1,1,1,1,5,1,0,0,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,1,1,1,0,0,1,1,1,1,1,4,1,3,0,0,1,1,1,1,1,1,1,3,0,0,0,0,0,0,0,0,0,0,0,2,8,2,2,300,37,"Sometimes Monica has to help Angie","Uneasy Partnership"],
	[6,4,3,6,5,3,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,1,1,1,1,1,1,1,0,0,1,1,1,1,4,1,1,6,1,1,5,1,1,1,1,0,0,0,1,1,0,0,0,1,1,0,0,1,1,1,1,0,0,1,1,4,1,1,4,1,1,4,1,4,1,1,1,1,1,4,1,1,4,1,0,1,1,0,0,0,0,1,1,0,0,0,1,0,0,0,0,1,0,0,0,7,0,2,300,17,"Na Na Na Na Na Na Na Na", "Does that look like someone?"],
	[0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,1,0,0,0,0,1,1,1,1,1,3,0,0,0,0,1,3,3,3,3,1,0,0,0,0,1,3,6,5,3,1,0,0,0,0,1,3,4,4,3,1,0,0,0,0,1,3,3,3,3,1,0,0,0,0,3,1,1,1,1,1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,8,2,1,7,300,23,"The Final Challenge?","Sticky Situation"]
]

const dialogues = [
	["[color=#8fd3ff]If you get stuck, I’ll help you out![/color]",
	"[color=#c32454][right]No thanks, you’ll just make it worse![/right][/color]"],
	["[color=#c32454][right]Quit pushing me around, Angie![/right][/color]",
	"[color=#8fd3ff]I’m sorry, I didn’t mean to.[/color]"],
	["[color=#c32454][right]I wonder what’s in those boxes..[/right][/color]",
	"[color=#8fd3ff]Something fluffy maybe?[/color]",
	"[color=#c32454][right]..something delicious..[/right][/color]"],
	["[color=#8fd3ff]How many angels would it take to move two boxes?[/color]",
	"[color=#c32454][right]..does it matter? We only have one...[/right][/color]"],
	["[color=#c32454][right]You know, if I keep having to help you out, I might just leave you behind..[/right][/color]"],
	["[color=#c32454][right]Why can’t you push your own crates, Angie?[/right][/color]",
	"[color=#8fd3ff]No I don’t want to! I can’t touch those terrible cursed things![/color]"],
	["[color=#8fd3ff]You know, sometimes an angel just needs her space.[/color]",
	"[color=#c32454][right]Good riddance![/right][/color]"],
	["[color=#c32454][right]That last place kind of looked like a penguin..[/right][/color]",
	"[color=#8fd3ff]What?[/color]",
	"[color=#c32454][right]..I wonder if I could eat it...[/right][/color]",
	"[color=#8fd3ff]What?[/color]",
	"[color=#c32454][right]..what?[/right][/color]",
	"[color=#c32454][right]...[/right][/color]"],
	["[color=#8fd3ff]So contrary![/color]",
	"[color=#c32454][right]But backwards is better, you know.[/right][/color]"],
	["[color=#c32454][right]Watch out![/right][/color]"],
	["[color=#8fd3ff]We did it![/color]"],
	["[color=#c32454][right]It’s like a cross between a jungle and a fried chicken..[/right][/color]",
	"[color=#8fd3ff]The last puzzle?[/color]",
	"[color=#c32454][right]..your hair right now..[/right][/color]",
	"[color=#8fd3ff]EEEK![/color]"],
	["[color=#8fd3ff]Okay I admit it- I got a little confused on that one![/color]",
	"[color=#c32454][right]Ha! A little?[/right][/color]"],
	["[color=#c32454][right]..ugh.. It’s slightly claustrophobic in there.[/right][/color]",
	"[color=#8fd3ff]Clauster-what now?[/color]",
	"[color=#c32454][right]Fear of spiders. I think..[/right][/color]"],
	["[color=#8fd3ff]Slippery![/color]"],
	["[color=#c32454][right]You got a little mixed up there, didn’t you?[/right][/color]"],
	["[color=#c32454][right]A little help?[/right][/color]",
	"[color=#8fd3ff]Ahh... What about this?[/color]",
	"[color=#c32454][right]Nope.[/right][/color]",
	"[color=#8fd3ff]...Did that work?[/color]",
	"[color=#c32454][right]Nope.[/right][/color]",
	"[color=#8fd3ff]I give up![/color]",
	"[color=#c32454][right]...[/right][/color]"],
	["[color=#c32454][right]Ugh, so claustrophobic![/right][/color]",
	"[color=#8fd3ff]Just eat them![/color]",
	"[color=#c32454][right]What, the spiders, or the webs?[/right][/color]",
	"[color=#8fd3ff]No! Wait, what?[/color]"],
	["[color=#8fd3ff]Hey, next time let me out faster, Monica![/color]",
	"[color=#c32454][right]Muahahaha![/right][/color]",
	"[color=#8fd3ff]Wait, did you leave me in there on purpose?[/color]",
	"[color=#c32454][right]...[/right][/color]"],
	["[color=#c32454][right]What’d you have for lunch?[/right][/color]",
	"[color=#8fd3ff]Don’t ask an angel what she eats, Monica![/color]",
	"[color=#c32454][right]Hehee, I’ll bet you’re starving![/right][/color]",
	"[color=#c32454][right]I found a rat.[/right][/color]"],
	["[color=#8fd3ff]Amazing! That was quite a sticky situation![/color]"],
	["[color=#c32454][right]Did you see that?[/right][/color]",
	"[color=#8fd3ff]You mean the rainbow?[/color]",
	"[color=#c32454][right]No.. There was a frog.[/right][/color]",
	"[color=#c32454][right]It got away.[/right][/color]"],
	["[color=#8fd3ff]That was easy![/color]",
	"[color=#c32454][right]You think?[/right][/color]"],
	["[color=#c32454][right]Wait... That was the whole thing?[/right][/color]"],
	["[color=#8fd3ff]Great job, Monica![/color]",
	"[color=#c32454][right]Well, someone had to figure it out.[/right][/color]"],
	["[color=#c32454][right]That went... well?[/right][/color]",
	"[color=#8fd3ff]Yeah, it was great![/color]",
	"[color=#c32454][right]Ugh.. I was being sarcastic.[/right][/color]"],
	["[color=#8fd3ff]Wow, that was confusing! I’m glad we made it alright![/color]",
	"[color=#c32454][right]No thanks to you..[/right][/color]"],
	["[color=#8fd3ff]So, how did I do?[/color]",
	"[color=#c32454][right]..heehee..[/right][/color]",
	"[color=#8fd3ff]What’s that supposed to mean?[/color]"],
	["[color=#c32454][right]I found a beetle...[/right][/color]",
	"[color=#c32454][right]...it was delicious.[/right][/color]",
	"[color=#8fd3ff]I think I saw a cute rabbit![/color]",
	"[color=#c32454][right]...it was delicious.[/right][/color]"],
	["[color=#8fd3ff]That was nice![/color]"],
	["[color=#c32454][right]You tripped.[/right][/color]"],
#	3star
	["[rainbow freq=0.2 sat=10 val=20]We're a great team when we work together![/rainbow]","[color=#c32454][right][shake rate=5 level=10]Whatever.[/shake][/right][/color]"],
	["[color=#c32454][right]I guess that was [shake rate=5 level=10]pretty good.[/shake][/right][/color]","[rainbow freq=0.2 sat=10 val=20]That was fantastic![/rainbow]"],
#	2star
	["[color=#8fd3ff]That was a great effort![/color]","[color=#c32454][right]Could've been better.[/right][/color]"],
	["[color=#8fd3ff]I'm glad to spend so much time together.[/color]","[color=#c32454][right]Could you be any more annoying?![/right][/color]"],
#	1star
	["[color=#c32454][right]Try not to slow me down next time.[/right][/color]","[color=#8fd3ff]That was tough, but hard work got us through.[/color]"],
	["[color=#8fd3ff]Sometimes it's good to take your time.[/color]","[color=#c32454][right]Speak for yourself... I got places to be![/right][/color]"],
#	Story
	["[color=#c32454][right]I suppose you want me to thank you.[/right][/color]","[color=#8fd3ff]The look on your face is gratitude enough.[/color]"],
	["[color=#c32454][right]Lucky for you I'm awesome![/right][/color]","[color=#8fd3ff]You are.  Thank you so much![/color]"],
	["[color=#8fd3ff]We all need a helping hand sometimes.[/color]","[color=#c32454][right]I had it under control.[/right][/color]"],
#	4star -- 40
	["[color=#c32454][right]Hoooo-leeeeee. . . . . .[/right][/color]","[color=#8fd3ff][shake rate=5 level=10]Don't you dare![/shake][/color]"],
#	Story
	["[color=#c32454][right]I'm suprised you squeezed through with those thighs.[/right][/color]","[color=#8fd3ff][shake rate=5 level=10]How dare you![/shake][/color]"],
	
]

const specificDialogues = {
	"1": [35,36,25],
	"2": [33,34,25],
	"3": [31,32],
	"4": [40],
	"Welcome": [22,23,29],
	"The Long and Winding Road": [7,24,15,12,10,21],
	"Against the Wall": [30,29,23,22,19],
	"Trading Places": [1,15,21,26,30],
	"Rocks and Hard Places": [15,19,24,26,27],
	"Push it": [1,2,3,10,23,28],
	"Boxes blocks us": [1,2,3,12],
	"Heavy Metal": [0,4,5,19,24,28],
	"It belongs in a museum!": [10,13,16,21,30],
	"Is This Sparta?!": [7,7,19,27,10],
	"Walking into Spiderwebs": [0,9,20,28],
	"Stay Put": [6,1,0,29],
	"Rocks and Harder Places": [9,10,11,21,27],
	"Switcharoo!": [8,10,28,29],
	"Do-si-do": [6,9,12,14,15],
	"Personal Space": [6,8,9,29,30],
	"Double Back": [7,11,15,21,26],
	"Two Paths": [6,10,13,13],
	"MMMMMMMM, Donut": [8,12,14,15,26],
	"A Fiend in Need": [1,2,3,12,16,17,27,37,39],
	"Uneasy Partnership": [18,18,20,4,38],
	"Does that look like someone?": [6,7,27,19],
	"Sticky Situation": [0,9,16,17,20]
}

var _exit_scene_path = "res://MainMenu.tscn"

func get_exit_scene_path() -> String:
	return _exit_scene_path
	
func set_exit_scene(sceneName:String) -> void:
	_exit_scene_path = "res://" + sceneName + ".tscn"

func getDialogue(levelName:String, stars:String):
	var _combined_dialogs = []
	if specificDialogues.has(levelName):
		_combined_dialogs.append_array(specificDialogues[levelName])
	if specificDialogues.has(stars):
		_combined_dialogs.append_array(specificDialogues[stars])
	return _combined_dialogs[randi() % _combined_dialogs.size()]

var custom_level:Array = []

func _ready():
	pass # Replace with function body.

func get_level_data(level) -> Array:
	return LEVELS[level-1]

func level_exists(level) -> bool:
	if level < 1:
		return false
	if level > LEVELS.size():
		return false
	return true

func set_custom_level(_inputString:String) -> void:
	if _inputString == "":
		return
		
	push_warning(_inputString)
	var data = JSON.parse(_inputString)
	
	if typeof(data.result) == TYPE_ARRAY:
		if data.result.size() < 1: 
			push_warning("Data Format Error: 1")
			return
		if not (data.result[0] is Array):
			if data.result.size() < 100:
				push_warning("Data Format Error: 2")
				return
			print("One Custom Level")
			custom_level.push_back(data.result)
			return 
		if data.result[0].size() < 100:
			push_warning("Data Format Error: 3")
			return
	else:
		push_warning("Data Format Error: 0")
		return
		
	print("Multiple Custom Levels")
	custom_level = data.result
	return
