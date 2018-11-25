/*
	Objective gate trigger - rebound type.
	Bounces players back if they don't have enough objectives.
	
	!!!IMPORTANT!!!
	Name the entity as the number of objectives required to pass the gate.
	Recommended to use in combination with a teleporter type gate behind it
	so that players get teleported if they manage to bug the rebound.
*/

	
// Functions

/*
	OnStartTouch output.
*/
function OnStartTouch()
{
	local playerScope = activator.GetScriptScope();
	playerScope.OnObjectiveGateReboundTouch(self);
}


// Output Connections

self.ConnectOutput("OnStartTouch", "OnStartTouch");