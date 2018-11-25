/*
	Implementation of a b-hop trigger system with controllable number
	of other b-hop trigger touches required so that you can customise
	the b-hop gameplay e.g. single touch or multi-touch b-hop.
	
	!!!IMPORTANT!!!
	Needs to be ran (ScriptRunFile) by the player when they join.
	Requires misc.nut to be ran by the player.
*/

// Global Variables

const bh_checkIfHoppedDelay = 0.1; // Time before checking if the player is still touching the trigger.

bh_previousTriggers <- []; // Previously touched b-hop triggers.
bh_touching <- null; // B-hop trigger the player is currently touching.
bh_safeArea <- null; // Last touched safe area.


// Functions

/*
	Called when player touches a b-hop trigger.
	Checks if the player should be teleported, and if not, adds the trigger to the
	previously touched triggers array, and sends an order to check if the player
	is still touching after a short delay (in which case it will teleport them).
	
	Parameters:
	bhopTrigger - The handle of the touched b-hop trigger. 
*/
function OnBhopTriggerStartTouch(bhopTrigger)
{
	if (BhopValidateTouch(bhopTrigger))
	{
		bh_touching = bhopTrigger;
		bh_previousTriggers.append(bhopTrigger);
		EntFireByHandle(bhopTrigger, "RunScriptCode", "CheckIfHopped();", bh_checkIfHoppedDelay, self, self);
	}
	else
	{
		BhopTeleportBack();
	}
}

/*
	Called when player stops touching a b-hop trigger.
	Clears the touching variable, indicating the player has left the b-hop trigger.
*/	
function OnBhopTriggerEndTouch()
{
	bh_touching = null;
}

/*
	Checks whether or not the player should be teleported having touched a b-hop trigger.

	Parameters:
	bhopTrigger - The handle of the touched b-hop trigger. 
*/
function BhopValidateTouch(bhopTrigger)
{
	// Number of jumps on other b-hop triggers the player needs before touching the same one again.
	local numOtherTriggersRequired = bhopTrigger.GetName().tointeger();
	
	if ((numOtherTriggersRequired == -1) && IsInArray(bhopTrigger, bh_previousTriggers))
	{	// Strictly single-touch b-hop
		return false;
	}
	else if (numOtherTriggersRequired >= 0)
	{
		for(local i = Max(bh_previousTriggers.len() - numOtherTriggersRequired, 0); i < bh_previousTriggers.len(); i++)
		{
			if (bh_previousTriggers[i] == bhopTrigger)
			{
				return false;
			}
		}
	}
	return true;
}

/*
	Called after a short delay after touching a b-hop trigger.
	Teleports the player if they are still touching the b-hop trigger.

	Parameters:
	bhopTrigger - The handle of the touched b-hop trigger. 
*/
function BhopCheckIfHopped(bhopTrigger)
{
	if (bh_touching == bhopTrigger)
	{
		BhopTeleportBack();
	}
}

/*
	Teleports the player to the last touched safe area's origin.
*/
function BhopTeleportBack()
{
	TeleportPlayerTo(bh_safeArea);
	SetVelocityToZero(self);
}

/*
	Called when the player touches a safe area trigger.
	Sets the new safe area trigger, and clears the previously touched trigger array.
	
	Parameters:
	safeTrigger - The handle of the touched safe area trigger.
*/	
function OnBhopSafeStartTouch(safeTrigger)
{
	bh_safeArea = safeTrigger;
	bh_previousTriggers.clear();
}