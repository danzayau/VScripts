/*	misc

	Written by DanZay, November 2016.
	
	Miscellaneous scripts and functions.
	
	Needs to be ran (ScriptRunFile) by the player when they join.
*/


// Global Variables

const misc_minMessageTime = 5; // Amount of time in seconds the speed panel is disabled for messages to be seen.
const misc_speedPanelHideLagg = 0.5 // Amount of time to delay showing messages to allow the speed panel to go away.

misc_language <- "english"; // The misc_language of which to display messages (default is English).
misc_usingSpeedPanel <- true; // Whether or not the player is using !speed.
misc_showingSpeedPanel <- true; // Whether or not the player is currently showing the speed panel.
misc_latestMessageTime <- null; // Timestamp of when the latest message was printed to the centre panel.


// Functions
/*	IsInArray(key, array)

	Checks if the variable is in the array.
	
	Parameters:
	key - Variable to find in the array.
	array - Array to be searched.
*/
function IsInArray(key, array)
{
    foreach(variable in array)
	{
		if (variable == key)
		{
			return true;
		}
	}
    return false;
}

/*	Max(value1, value2)

	Returns the greater value.
	
	Parameters:
	value1 - First value.
	value2 - Second value.
*/
function Max(value1, value2)
{
	if (value1 >= value2)
	{
		return value1;
	}
	return value2;
}

/*	TeleportPlayerTo(destEntity)

	Teleports the player to an entity's origin.
	
	Parameters:
	destEntity - The entity handle to teleport the player to.
*/
function TeleportPlayerTo(destEntity)
{
	self.SetOrigin(destEntity.GetOrigin());
}


/*	SetVelocityToZero(entity)

	Sets the targeted entity's velocity to 0.
	
	Parameters:
	entity - The handle of the entity to set the velocity of.
*/
function SetVelocityToZero(entity)
{
	entity.SetVelocity(Vector(0, 0, 0));
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
		playerNewVelocity.x = -1 * nl_reboundVelocity;
	}
	else if (playerCenter.x > (triggerCenter.x + triggerBounds.x)) 
	{	// Player coming from +x
		playerNewVelocity.x = nl_reboundVelocity;
	}
	else if (playerCenter.y < (triggerCenter.y - triggerBounds.y))
	{	// Player coming from -y
		playerNewVelocity.y = -1 * nl_reboundVelocity;
	}
	else if (playerCenter.y > (triggerCenter.y + triggerBounds.y))
	{	// Player coming from +y
		playerNewVelocity.y = nl_reboundVelocity;
	}
	else if (playerCenter.z < (triggerCenter.z - triggerBounds.z))
	{	// Player comnig from -z
		playerNewVelocity.z = -1 * nl_reboundVelocity;
	}
	else
	{	// Player coming from +z
		playerNewVelocity.z = nl_reboundVelocity;
	}

	self.SetVelocity(playerNewVelocity);
}

/*	ExecuteCommand(command)
	Executes a command in the player's console.

	Parameters:
	command - String of the command to execute.
*/
function ExecuteCommand(command)
{
	local point_clientcommand = Entities.CreateByClassname("point_clientcommand");
	EntFireByHandle(point_clientcommand, "Command", command, 0, self, self);
	point_clientcommand.Destroy();
}

/*	ShowHudHintMessage(message)

	Sends a message to the player's centre panel.
	
	Parameters:
	message - String of the message to send.
*/
function ShowHudHintMessage(message)
{
	local env_hudhint = Entities.CreateByClassname("env_hudhint");
	env_hudhint.__KeyValueFromString("Message", message);
	EntFireByHandle(env_hudhint, "ShowHudHint", "", 0, self, self);
	env_hudhint.Destroy();
}

/*	PlaySound(soundPath, volume)

	Plays a sound to the player.
	
	Parameters:
	soundPath - Path of the sound file (sound/...).
*/
function PlaySound(soundPath)
{
	ExecuteCommand("play */" + soundPath);
}

/*	CenterPanelMessage(message)

	Prints a message to the center info panel via an env_hudhint.
	Hides the speed panel temporarily if the player's speed panel flag is true.
	This flag can be set by having the player touch misc_speedflag_on or misc_speedflag_off.
	
	Parameters:
	message - String of the message to display.
*/
function CenterPanelMessage(message) 
{
	if (misc_usingSpeedPanel)
	{
		local messageTime = Time();
		misc_latestMessageTime = messageTime;
		UpdateSpeedPanelVisibility(false, messageTime);
		EntFireByHandle(self, "RunScriptCode", "UpdateSpeedPanelVisibility(true, " + messageTime + ");", misc_minMessageTime, self, self);
		// Delay showing the hint message to give time for the speed panel to go away (especially with high ping).
		EntFireByHandle(self, "RunScriptCode", "ShowHudHintMessage(\"" + message + "\");", misc_speedPanelHideLagg, self, self);
	}
	else
	{
		ShowHudHintMessage(message);
	}	
}

/*	UpdateSpeedPanelVisibility(wantToShowSpeedPanel, messageTime)

	Updates the speed panel visbility for the player (sm_speed in console).
	Does not do anything if there has been a more recent message.
	
	Parameters:
	wantToShowSpeedPanel - Bool of whether or not to show the speed panel.
	messageTime - Timestamp of when the related message was printed.
*/
function UpdateSpeedPanelVisibility(wantToShowSpeedPanel, messageTime)
{
	/* The following is not done (misc_latestMessageTime != messageTime) because
	messageTime is rounded value when it is called via EntFireByHandle */
	if ((misc_latestMessageTime - messageTime) > 0.1)
	{
		return;
	}
	else if (wantToShowSpeedPanel && !misc_showingSpeedPanel)
	{	// Turn speed panel on.
		ExecuteCommand("sm_speed");
		misc_showingSpeedPanel = true;
	}
	else if (!wantToShowSpeedPanel && misc_showingSpeedPanel) 
	{	// Turn the speed panel off.
		ExecuteCommand("sm_speed");
		misc_showingSpeedPanel = false;
	}
}