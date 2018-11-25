/*
	Teleport trigger that teleports players to the last safe area
	e.g. place below the b-hops so they are teleported when fall.
*/


// Functions

/*
	OnStartTouch output.
*/
function OnStartTouch()
{
	local playerScope = activator.GetScriptScope();
	playerScope.BhopTeleportBack();
}


// Output Connections

self.ConnectOutput("OnStartTouch", "OnStartTouch");