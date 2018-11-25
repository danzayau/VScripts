/*
	Objective gate trigger - teleport type.
	Teleports players to the closest trigger called "dzy-reject" if they don't have enough objectives.
	Number of objectives required is set by it's "Name".
*/

	
// Functions

/*
	OnStartTouch output.
*/
function OnStartTouch()
{
	local playerScope = activator.GetScriptScope();
	playerScope.OnObjectiveGateTeleportTouch(self);
}


// Output Connections

self.ConnectOutput("OnStartTouch", "OnStartTouch");