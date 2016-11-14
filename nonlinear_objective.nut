/*	nonlinear_objective

	Written by DanZay.
	
	Objective trigger.
*/


// Functions

/* 	StartTouch()

	OnStartTouch output.
*/
function StartTouch()
{
	local playerScope = activator.GetScriptScope();
	playerScope.ObjectiveTouch(self);
}


// Output Connections

self.ConnectOutput("OnStartTouch", "StartTouch");