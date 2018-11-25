/*
	B-hop trigger.
	
	!!!IMPORTANT!!!
	Name the entity as the number of jumps on other b-hop triggers you want to require.
	E.g. 	use name "0" if you don't need the player to touch any other b-hop triggers,
			use name "1" if you want the player to touch 1 other b-hop trigger etc.
	Use name "-1" to efficiently specify a strictly single touch b-hop.
*/


// Functions

/*
	OnStartTouch output.
*/
function OnStartTouch()
{
	local playerScope = activator.GetScriptScope();
	playerScope.OnBhopTriggerStartTouch(self);
}

/*
	OnEndTouch output.
*/
function OnEndTouch()
{
	local playerScope = activator.GetScriptScope();
	playerScope.OnBhopTriggerEndTouch();
}

/*
	Ran after a short delay after touching the trigger.
*/
function CheckIfHopped()
{
	local playerScope = activator.GetScriptScope();
	playerScope.BhopCheckIfHopped(self);
}


// Output Connections

self.ConnectOutput("OnStartTouch", "OnStartTouch");
self.ConnectOutput("OnEndTouch", "OnEndTouch");