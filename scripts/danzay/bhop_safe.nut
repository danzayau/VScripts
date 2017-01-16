/*	bhop_safe

	Written by DanZay.
	
	B-hop checkpoint/safe area trigger.
	
	!!!IMPORTANT!!!
	The place the player gets teleported is the ORIGIN of the last touched safe trigger.
*/


// Functions

/* 	StartTouch()

	OnStartTouch output.
*/
function StartTouch()
{
	local playerScope = activator.GetScriptScope();
	playerScope.BhopSafeStartTouch(self);
}


// Output Connections

self.ConnectOutput("OnStartTouch", "StartTouch");