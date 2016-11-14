/*	nonlinear_reset

	Written by DanZay.
	
	Reset trigger.
*/


// Functions

/* 	StartTouch()

	OnStartTouch output.
*/
function StartTouch()
{
	local playerScope = activator.GetScriptScope();
	playerScope.ResetObjectivesCollected();
}


// Output Connections

self.ConnectOutput("OnStartTouch", "StartTouch");