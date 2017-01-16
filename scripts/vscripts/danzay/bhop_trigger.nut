/*	bhop_trigger

	Written by DanZay.
	
	B-hop trigger.
	
	!!!IMPORTANT!!!
	Name the entity as the number of jumps on other b-hop triggers you want to require.
	Use -1 to efficiently specify a strictly single touch b-hop.
	E.g. 	use 0 if you don't need the player to touch any other b-hop triggers,
			use 1 if you want the player to touch 1 other b-hop trigger etc.
*/


// Functions

/* 	StartTouch()

	OnStartTouch output.
*/
function StartTouch()
{
	local playerScope = activator.GetScriptScope();
	playerScope.BhopTriggerStartTouch(self);
}

/* 	EndTouch()

	OnEndTouch output.
*/
function EndTouch()
{
	local playerScope = activator.GetScriptScope();
	playerScope.BhopTriggerEndTouch();
}

/*	CheckIfHopped()
	
	Ran after a short delay after touching the trigger.
*/
function CheckIfHopped()
{
	local playerScope = activator.GetScriptScope();
	playerScope.BhopCheckIfHopped(self);
}


// Output Connections

self.ConnectOutput("OnStartTouch", "StartTouch");
self.ConnectOutput("OnEndTouch", "EndTouch");