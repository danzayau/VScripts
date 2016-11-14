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
	
	if (self.GetName() == "true")
	{
		playerScope.usingSpeedPanel = true;
		playerScope.showingSpeedPanel = true;
	}
	else
	{
		playerScope.usingSpeedPanel = false;
		playerScope.showingSpeedPanel = false;
	}
}


// Output Connections

self.ConnectOutput("OnStartTouch", "StartTouch");