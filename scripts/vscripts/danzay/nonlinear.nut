/*
	Implementation of a non-linear, objective-based system.
	The player must gather objectives to increase their objective count.
	Their objective count can be used to control the actions of entities.
	For example, an 'objective gate' has been implemented, which requires
	a certain number of objectives for the player to pass through it.
	
	!!!IMPORTANT!!!
	Needs to be ran (ScriptRunFile) by the player when they join.
	Requires misc.nut to be ran by the player.
*/

// Includes

DoIncludeScript("danzay/nonlinear_resource.nut", self.GetScriptScope());
	
	
// Global Variables

const nl_reboundVelocity = 500; // Velocity at which the objective gates rebound the player.

nl_collectedObjectives <- []; // An array of the handles of the objectives the player has collected.
nl_objectivesRequired <- null; // The number of objectives required by a touched objective gate.

	
// Functions

/* 	GetNumberOfObjectivesCollected()

	Returns the number of objectives that have been collected.
*/
function GetNumberOfObjectivesCollected()
{
	return nl_collectedObjectives.len();
}
	
/* 	ResetObjectivesCollected()

	Called when player touches objective reset trigger.
	Resets the player's collected objectives by clearing the related array.
*/
function ResetObjectivesCollected()
{
	if (nl_collectedObjectives.len() > 0)
	{
		nl_collectedObjectives.clear();
		PrintGameText(GetMessageObjectiveReset());
	}
}

/*
	Called when player touches an objective trigger.
	Adds the objective to the collected objectives list if the player hasn't collected it already.
	
	Parameters:
	touchedObjective - The handle of the touched objective trigger. 
*/
function OnObjectiveTouch(touchedObjective)
{
	if (IsInArray(touchedObjective, nl_collectedObjectives))
	{
		PrintGameText(GetMessageAlreadyCollectedObjective());
	}
	else
	{
		nl_collectedObjectives.append(touchedObjective);
		PlaySound(GetSoundObjectiveGet());
		PrintGameText(GetMessageObjectiveGet());
	}
}

/*
	Called when player touches an objective gate (rebound type).
	Checks if the player has enough objectives to pass, and rebounds them if they don't.
	
	Parameters:
	touchedGate - The handle of the touched objective gate trigger.
*/
function OnObjectiveGateReboundTouch(touchedGate)
{
	local nl_objectivesRequired = touchedGate.GetName().tointeger();
	
	if (GetNumberOfObjectivesCollected() < nl_objectivesRequired)
	{
		PrintGameText(GetMessageObjectiveGateFail(nl_objectivesRequired));
		PlaySound(GetSoundObjectiveFail());
		Rebound(touchedGate);
	}
}

/*
	Called when player touches a objective gate (teleport type).
	Checks if the player has enough objectives to pass, and teleports them if they don't.
	
	Parameters:
	touchedGate - The handle of the touched objective gate trigger.
*/
function OnObjectiveGateTeleportTouch(touchedGate)
{
	local nl_objectivesRequired = touchedGate.GetName().tointeger();
	
	if (GetNumberOfObjectivesCollected() < nl_objectivesRequired)
	{	
		PrintGameText(GetMessageObjectiveGateFail(nl_objectivesRequired));
		PlaySound(GetSoundObjectiveFail());
		TeleportPlayerTo(touchedGate);
		SetVelocityToZero(self);
	}
}