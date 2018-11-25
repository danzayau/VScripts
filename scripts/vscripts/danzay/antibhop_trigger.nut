/*
	Anti b-hop trigger.
*/


// Functions

/*
	OnStartTouch output.
*/
function OnStartTouch()
{
	local playerScope = activator.GetScriptScope();
	playerScope.OnAntibhopTriggerStartTouch(self);
}

/*
	OnEndTouch output.
*/
function OnEndTouch()
{
	local playerScope = activator.GetScriptScope();
	playerScope.OnAntibhopTriggerEndTouch();
}

/*
	Ran after a short delay after touching the trigger.
*/
function CheckIfHopped()
{
	local playerScope = activator.GetScriptScope();
	playerScope.AntibhopCheckIfHopped(self);
}


// Output Connections

self.ConnectOutput("OnStartTouch", "OnStartTouch");
self.ConnectOutput("OnEndTouch", "OnEndTouch");