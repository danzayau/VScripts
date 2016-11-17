/*	antibhop_trigger

	Written by DanZay.
	
	Anti b-hop trigger.
*/


// Functions

/* 	StartTouch()

	OnStartTouch output.
*/
function StartTouch()
{
	local playerScope = activator.GetScriptScope();
	playerScope.AntibhopTriggerStartTouch(self);
}

/* 	EndTouch()

	OnEndTouch output.
*/
function EndTouch()
{
	local playerScope = activator.GetScriptScope();
	playerScope.AntibhopTriggerEndTouch();
}

/*	CheckIfHopped()
	
	Ran after a short delay after touching the trigger.
*/
function CheckIfHopped()
{
	local playerScope = activator.GetScriptScope();
	playerScope.AntibhopCheckIfHopped(self);
}


// Output Connections

self.ConnectOutput("OnStartTouch", "StartTouch");
self.ConnectOutput("OnEndTouch", "EndTouch");