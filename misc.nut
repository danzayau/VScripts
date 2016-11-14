/*	misc

	Written by DanZay, November 2016.
	
	Miscellaneous scripts and functions.
	
	Needs to be ran (ScriptRunFile) by the player when they join.
*/


// Global Variables

const minMessageTime = 5; // Amount of time in seconds the speed panel is disabled for messages to be seen.
const speedPanelHideLagg = 0.5 // Amount of time to delay showing messages to allow the speed panel to go away.

language <- "english"; // The language of which to display messages (default is English).
usingSpeedPanel <- true; // Whether or not the player is using !speed.
showingSpeedPanel <- true; // Whether or not the player is currently showing the speed panel.
latestMessageTime <- null; // Timestamp of when the latest message was printed to the centre panel.


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

	Teleports the player to an entity's origin, and set's their velocity to 0.
	
	Parameters:
	destEntity - The entity handle to teleport the player to.
*/
function TeleportPlayerTo(destEntity)
{
	self.SetOrigin(destEntity.GetOrigin());
	self.SetVelocity(Vector(0, 0, 0));
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
	if (usingSpeedPanel)
	{
		local messageTime = Time();
		latestMessageTime = messageTime;
		UpdateSpeedPanelVisibility(false, messageTime);
		EntFireByHandle(self, "RunScriptCode", "UpdateSpeedPanelVisibility(true, " + messageTime + ");", minMessageTime, self, self);
		// Delay showing the hint message to give time for the speed panel to go away (especially with high ping).
		EntFireByHandle(self, "RunScriptCode", "ShowHudHintMessage(\"" + message + "\");", speedPanelHideLagg, self, self);
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
	/* The following is not done (latestMessageTime != messageTime) because
	messageTime is rounded value when it is called via EntFireByHandle */
	if ((latestMessageTime - messageTime) > 0.1)
	{
		return;
	}
	else if (wantToShowSpeedPanel && !showingSpeedPanel)
	{	// Turn speed panel on.
		ExecuteCommand("sm_speed");
		showingSpeedPanel = true;
	}
	else if (!wantToShowSpeedPanel && showingSpeedPanel) 
	{	// Turn the speed panel off.
		ExecuteCommand("sm_speed");
		showingSpeedPanel = false;
	}
}