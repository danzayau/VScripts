/*	bhop_block

	Written by DanZay.
	
	B-hop block trigger.
	
	!!!IMPORTANT!!!
	Name the entity as the number of jumps on other b-hop blocks you want to require.
	Use -1 to efficiently specify a strictly single touch b-hop.
	E.g. 	use 0 if you don't need the player to touch any other b-hop blocks,
			use 1 if you want the player to touch 1 other b-hop block etc.
*/


// Functions

/* 	StartTouch()

	OnStartTouch output.
*/
function StartTouch()
{
	local playerScope = activator.GetScriptScope();
	playerScope.BhopBlockStartTouch(self);
}

/* 	EndTouch()

	OnEndTouch output.
*/
function EndTouch()
{
	local playerScope = activator.GetScriptScope();
	playerScope.BhopBlockEndTouch();
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