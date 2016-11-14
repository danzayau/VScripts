/*	nonlinear

	Written by DanZay.
	
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

const objectiveEntName = "dzy-nonlinear_objective"; // Name of objective entities.
const rejectDestEntName = "dzy-nonlinear_rejectdest"; // Name of objective gate teleport destinations.
const reboundVelocity = 500; // Velocity at which the objective gates rebound the player.

collectedObjectives <- []; // An array of the handles of the objectives the player has collected.
objectivesRequired <- null; // The number of objectives required by a touched objective gate.

	
// Functions

/* 	GetObjectiveHandles()

	Returns an array of all objective entity handles found in the map.
*/	
function GetObjectiveHandles()
{	
	local objectiveHandles = [];
	local ent = null;
	while ((ent = Entities.FindByName(ent, objectiveEntName)) != null)
	{
		objectiveHandles.append(ent);
	}
	return objectiveHandles;
}

/* 	GetNumberOfObjectives()

	Returns the number of objectives found in the map.
*/	
function GetNumberOfObjectives()
{
	local objectiveHandles = GetObjectiveHandles();
	return objectiveHandles.len();
}

/* 	GetNumberOfObjectivesCollected()

	Returns the number of objectives that have been collected.
*/
function GetNumberOfObjectivesCollected()
{
	return collectedObjectives.len();
}
	
/* 	ResetObjectivesCollected()

	Called when player touches objective reset trigger.
	Resets the player's collected objectives by clearing the related array.
*/
function ResetObjectivesCollected()
{
	if (collectedObjectives.len() > 0)
	{
		collectedObjectives.clear();
		CenterPanelMessage(MessageObjectiveReset());
	}
}

/* 	ObjectiveTouch(objectiveTrigger)

	Called when player touches an objective trigger.
	Adds the objective to the collected objectives list if the player hasn't collected it already.
	
	Parameters:
	touchedObjective - The handle of the touched objective trigger. 
*/
function ObjectiveTouch(touchedObjective)
{
	if (IsInArray(touchedObjective, collectedObjectives))
	{
		CenterPanelMessage(MessageAlreadyCollectedObjective());
	}
	else
	{
		collectedObjectives.append(touchedObjective);
		PlaySound(SoundObjectiveGet());
		CenterPanelMessage(MessageObjectiveGet());
	}
}

/*	ObjectiveGateReboundTouch(touchedGate)

	Called when player touches an objective gate (rebound type).
	Checks if the player has enough objectives to pass, and rebounds them if they don't.
	
	Parameters:
	touchedGate - The handle of the touched objective gate trigger.
*/
function ObjectiveGateReboundTouch(touchedGate)
{
	local objectivesRequired = touchedGate.GetName().tointeger();
	
	if (GetNumberOfObjectivesCollected() < objectivesRequired)
	{
		CenterPanelMessage(MessageObjectiveGateFail(objectivesRequired));
		Rebound(touchedGate);
	}
}

/*	Rebound(touchedTrigger)

	Rebounds the player (set's their velocity) to bounce them away from the face of the trigger they touched.
	Intended for rectangular triggers, and works fine when the player can't hit the corners.
	
	Parameters:
	touchedTrigger - The handle of the touched objective gate trigger.
*/
function Rebound(touchedTrigger)
{
	local triggerBounds = touchedTrigger.GetBoundingMaxs();
	local triggerCenter = touchedTrigger.GetCenter();
	local playerCenter = self.GetCenter();
	local playerNewVelocity = self.GetVelocity();
	
	if (playerCenter.x < (triggerCenter.x - triggerBounds.x))
	{	// Player coming from -x
		playerNewVelocity.x = -1 * reboundVelocity;
	}
	else if (playerCenter.x > (triggerCenter.x + triggerBounds.x)) 
	{	// Player coming from +x
		playerNewVelocity.x = reboundVelocity;
	}
	else if (playerCenter.y < (triggerCenter.y - triggerBounds.y))
	{	// Player coming from -y
		playerNewVelocity.y = -1 * reboundVelocity;
	}
	else if (playerCenter.y > (triggerCenter.y + triggerBounds.y))
	{	// Player coming from +y
		playerNewVelocity.y = reboundVelocity;
	}
	else if (playerCenter.z < (triggerCenter.z - triggerBounds.z))
	{	// Player comnig from -z
		playerNewVelocity.z = -1 * reboundVelocity;
	}
	else
	{	// Player coming from +z
		playerNewVelocity.z = reboundVelocity;
	}

	self.SetVelocity(playerNewVelocity);
}

/*	ObjectiveGateTeleportTouch(touchedGate)

	Called when player touches a objective gate (teleport type).
	Checks if the player has enough objectives to pass, and teleports them if they don't.
	
	Parameters:
	touchedGate - The handle of the touched objective gate trigger.
*/
function ObjectiveGateTeleportTouch(touchedGate)
{
	local objectivesRequired = touchedGate.GetName().tointeger();
	
	if (GetNumberOfObjectivesCollected() < objectivesRequired)
	{	
		CenterPanelMessage(MessageObjectiveGateFail(objectivesRequired));
		local teleportDest = Entities.FindByNameNearest(rejectDestEntName, self.GetOrigin(), 256);
		TeleportPlayerTo(teleportDest);
	}
}