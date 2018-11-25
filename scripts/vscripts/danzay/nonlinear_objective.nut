/*
	Objective trigger.
*/


// Functions

/*
	OnStartTouch output.
*/
function OnStartTouch()
{
	local playerScope = activator.GetScriptScope();
	playerScope.OnObjectiveTouch(self);
}


// Output Connections

self.ConnectOutput("OnStartTouch", "OnStartTouch");