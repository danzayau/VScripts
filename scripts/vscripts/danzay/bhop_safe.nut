/*
	B-hop checkpoint/safe area trigger.
	
	!!!IMPORTANT!!!
	The place the player gets teleported is the ORIGIN of the last touched safe trigger.
*/


// Functions

/*
	OnStartTouch output.
*/
function OnStartTouch()
{
	local playerScope = activator.GetScriptScope();
	playerScope.OnBhopSafeStartTouch(self);
}


// Output Connections

self.ConnectOutput("OnStartTouch", "OnStartTouch");