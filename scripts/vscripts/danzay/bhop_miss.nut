/*	bhop_block

	Written by DanZay.
	
	Teleport trigger that teleports players to the last safe area
	e.g. place below the b-hops so they are teleported when fall.
*/


// Functions

/* 	StartTouch()

	OnStartTouch output.
*/
function StartTouch()
{
	local playerScope = activator.GetScriptScope();
	playerScope.BhopTeleportBack();
}


// Output Connections

self.ConnectOutput("OnStartTouch", "StartTouch");