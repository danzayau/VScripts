/*	misc_speedflag_on

	Written by DanZay.
	
	Sets flags to indicate that the player does want to use KZTimer speed panel.
*/


// Functions

/* 	StartTouch()

	OnStartTouch output.
*/
function StartTouch()
{
	local playerScope = activator.GetScriptScope();
	playerScope.usingSpeedPanel = true;
	playerScope.showingSpeedPanel = true;
}


// Output Connections

self.ConnectOutput("OnStartTouch", "StartTouch");