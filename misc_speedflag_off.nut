/*	misc_speedflag_off

	Written by DanZay.
	
	Sets flags to indicate that the player does not want to use KZTimer speed panel.
*/


// Functions

/* 	StartTouch()

	OnStartTouch output.
*/
function StartTouch()
{
	local playerScope = activator.GetScriptScope();
	playerScope.usingSpeedPanel = false;
	playerScope.showingSpeedPanel = false;
}


// Output Connections

self.ConnectOutput("OnStartTouch", "StartTouch");