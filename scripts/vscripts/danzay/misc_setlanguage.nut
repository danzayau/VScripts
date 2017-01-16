/*	misc_setlanguage

	Written by DanZay.
	
	Sets the selected language of the player.
	
	!!!IMPORTANT!!!
	Name the entity as the language you want to set to.
*/


// Functions

/* 	StartTouch()

	OnStartTouch output.
*/
function StartTouch()
{
	local playerScope = activator.GetScriptScope();
	playerScope.langauge = self.GetName();
}


// Output Connections

self.ConnectOutput("OnStartTouch", "StartTouch");