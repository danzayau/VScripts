/*	antibhop

	Written by DanZay.
	
	Implementation of anti b-hop trigger system.
	
	!!!IMPORTANT!!!
	Needs to be ran (ScriptRunFile) by the player when they join.
	Requires misc.nut to be ran by the player.
*/

// Global Variables

const abh_checkIfHoppedDelay = 0.1; // Time before checking if the player is still touching the trigger.

abh_touching <- null; // Anti b-hop trigger the player is currently touching.


// Functions

/*	AntibhopTriggerStartTouch(antibhopTrigger)
	Called when player touches an anti b-hop trigger.
	
	Parameters:
	antibhopTrigger - The handle of the touched anti b-hop trigger. 
*/
function AntibhopTriggerStartTouch(antibhopTrigger)
{
	abh_touching = antibhopTrigger;
	EntFireByHandle(antibhopTrigger, "RunScriptCode", "AntibhopCheckIfHopped();", abh_checkIfHoppedDelay, self, self);
}

/*	AntibhopTriggerEndTouch(antibhopTrigger)
	Called when player stops touching an anti b-hop trigger.
*/
function AntibhopTriggerEndTouch()
{
	abh_touching = null;
}

/*	AntibhopCheckIfHopped(antibhopTrigger)
	
	Called after a short delay after touching a anti b-hop trigger.
	Sets the player's velocity to 0 if they b-hopped.

	Parameters:
	antibhopTrigger - The handle of the touched anti b-hop trigger. 
*/
function AntibhopCheckIfHopped(antibhopTrigger)
{
	if (abh_touching != antibhopTrigger)
	{
		SetVelocityToZero(self);
	}
}