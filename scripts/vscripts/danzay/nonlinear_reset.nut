/*	nonlinear_reset

	Written by DanZay.
	
	Reset trigger.
*/


// Functions

/*
	OnStartTouch output.
*/
function OnStartTouch()
{
	local playerScope = activator.GetScriptScope();
	playerScope.ResetObjectivesCollected();
}


// Output Connections

self.ConnectOutput("OnStartTouch", "OnStartTouch");