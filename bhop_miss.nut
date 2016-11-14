/*	bhop_block

	Written by DanZay.
	
	The teleport trigger below the b-hops that the player hits when they fall.
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