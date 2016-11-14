/*	nonlinear_gate

	Written by DanZay.
	
	Objective gate trigger - rebound type.
	Bounces players back if they don't have enough objectives.
	
	!!!IMPORTANT!!!
	Name the entity as the number of objectives required to pass the gate.
	Recommended to use in combination with a teleporter type gate behind it
	so that players get teleported if they manage to bug the rebound.
*/

	
// Functions

/* 	StartTouch()

	OnStartTouch output.
*/
function StartTouch()
{
	local playerScope = activator.GetScriptScope();
	playerScope.ObjectiveGateReboundTouch(self);
}


// Output Connections

self.ConnectOutput("OnStartTouch", "StartTouch");