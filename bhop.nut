/*	bhop

	Written by DanZay.
	
	Implementation of a b-hop block system with controllable number
	of other b-hop block touches required so that you can customise
	the b-hop gameplay e.g. single touch or multi-touch b-hop.
	
	!!!IMPORTANT!!!
	Needs to be ran (ScriptRunFile) by the player when they join.
	Requires misc.nut to be ran by the player.
*/

// Global Variables

const checkIfHoppedDelay = 0.1; // Time before checking if the player is still touching the block.

previousBlocks <- []; // Previously touched b-hop blocks.
touching <- null; // B-hop block they are current touching.
safeArea <- null; // Last touched safe area.


// Functions

/*	BhopBlockStartTouch(bhopTrigger)
	Called when player touches a b-hop block trigger.
	Checks if the player should be teleported, and if not, adds the block to the
	previously touched blocks array, and sends an order to check if the player
	is still touching after a short delay (in which case it will teleport them).
	
	Parameters:
	bhopTrigger - The handle of the touched b-hop block trigger. 
*/
function BhopBlockStartTouch(bhopTrigger)
{
	if (BhopValidateTouch(bhopTrigger))
	{
		touching = bhopTrigger;
		previousBlocks.append(bhopTrigger);
		EntFireByHandle(bhopTrigger, "RunScriptCode", "CheckIfHopped();", checkIfHoppedDelay, self, self);
	}
	else
	{
		BhopTeleportBack();
	}
}

/*	BhopBlockEndTouch()

	Called when player stops touching a b-hop block trigger.
	Clears the touching variable, indicating the player has left the b-hop block.
*/	
function BhopBlockEndTouch()
{
	touching = null;
}

/*	BhopValidateTouch(bhopTrigger)
	
	Checks whether or not the player should be teleported having touched a b-hop block.

	Parameters:
	bhopTrigger - The handle of the touched b-hop block trigger. 
*/
function BhopValidateTouch(bhopTrigger)
{
	// Number of jumps on other b-hop blocks the player needs before touching the same one again.
	local numOtherBlocksRequired = bhopTrigger.GetName().tointeger();
	
	if ((numOtherBlocksRequired == -1) && IsInArray(bhopTrigger, previousBlocks))
	{	// Strictly single-touch b-hop
		return false;
	}
	else if (numOtherBlocksRequired >= 0)
	{
		for(local i = Max(previousBlocks.len() - numOtherBlocksRequired, 0); i < previousBlocks.len(); i++)
		{
			if (previousBlocks[i] == bhopTrigger)
			{
				return false;
			}
		}
	}
	return true;
}

/*	BhopCheckIfHopped(bhopTrigger)
	
	Called after a short delay after touching a b-hop block.
	Teleports the player if they are still touching the b-hop block.

	Parameters:
	bhopTrigger - The handle of the touched b-hop block trigger. 
*/
function BhopCheckIfHopped(bhopTrigger)
{
	if (touching == bhopTrigger)
	{
		BhopTeleportBack();
	}
}

/*	BhopTeleportBack()

	Teleports the player to the last touched safe area's origin.
*/
function BhopTeleportBack()
{
	TeleportPlayerTo(safeArea);
}

/*	BhopSafeStartTouch(safeTrigger)

	Called when the player touches a safe area trigger.
	Sets the new safe area trigger, and clears the previously touched block array.
	
	Parameters:
	safeTrigger - The handle of the touched safe area trigger.
*/	
function BhopSafeStartTouch(safeTrigger)
{
	safeArea = safeTrigger;
	previousBlocks.clear();
}