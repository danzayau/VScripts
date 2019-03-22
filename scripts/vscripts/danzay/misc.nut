/*
	Miscellaneous scripts and functions.
	
	Needs to be ran (ScriptRunFile) by the player when they join.
*/


// Functions
/*
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

/*
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

/*
	Teleports the player to an entity's origin.
	
	Parameters:
	destEntity - The entity handle to teleport the player to.
*/
function TeleportPlayerTo(destEntity)
{
	self.SetOrigin(destEntity.GetOrigin());
}


/*
	Sets the targeted entity's velocity to 0.
	
	Parameters:
	entity - The handle of the entity to set the velocity of.
*/
function SetVelocityToZero(entity)
{
	entity.SetVelocity(Vector(0, 0, 0));
}

/*
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

/*
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

/*
	Plays a sound to the player.
	
	Parameters:
	soundPath - Path of the sound file (csgo/sound/soundPath).
*/
function PlaySound(soundPath)
{
	ExecuteCommand("play */" + soundPath);
}

/*
	Prints a message to the center info panel via env_hudhint.

	Parameters:
	message - String of the message to display.
*/
function PrintHintText(message) 
{
	local env_hudhint = Entities.CreateByClassname("env_hudhint");
	env_hudhint.__KeyValueFromString("Message", message);
	EntFireByHandle(env_hudhint, "ShowHudHint", "", 0, self, self);
	env_hudhint.Destroy();
}

/*
	Prints a message to the center info panel via game_text.

	Parameters:
	message - String of the message to display.
*/
function PrintGameText(message)
{
	local game_text = Entities.CreateByClassname("game_text");
	game_text.__KeyValueFromString("Message", message);
	game_text.__KeyValueFromString("color", "255 255 255");
	game_text.__KeyValueFromString("effect", "0");
	game_text.__KeyValueFromString("fadein", "0.0");
	game_text.__KeyValueFromString("fadeout", "0.0");
	game_text.__KeyValueFromString("holdtime", "3.0");
	game_text.__KeyValueFromString("x", "-1");
	game_text.__KeyValueFromString("y", "0.35");
	EntFireByHandle(game_text, "Display", "", 0, self, self);
	game_text.Destroy();
}