/*	nonlinear_gate_teleport

	Written by DanZay.
	
	Objective gate trigger - teleport type.
	Teleports players to the closest trigger called "dzy-reject" if they don't have enough objectives.
	Number of objectives required is set by it's "Name".
*/

	
// Functions

/* 	StartTouch()

	OnStartTouch output.
*/
function StartTouch()
{
	local playerScope = activator.GetScriptScope();
	playerScope.ObjectiveGateTeleportTouch(self);
}


// Output Connections

self.ConnectOutput("OnStartTouch", "StartTouch");