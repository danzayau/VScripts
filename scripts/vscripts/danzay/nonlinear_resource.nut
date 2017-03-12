/*	nonlinear_resource

	Written by DanZay, November 2016.
	
	Resource file for the objective system.
*/


// Message String Table
messagesNonlinear <-
{
	english =
	{
		ObjectiveGet = "<font color='#FFFF00' size='56'>★</font><font size='48'> %d</font>",
		AlreadyCollectedObjective = "You already got this <font color='#FFFF00'>★</font>.",
		ObjectiveGateFail = "You need <font color='#FFFF00'>★</font>%d to pass.<br /><br />You have <font color='#FFFF00'>★</font>%d.",
		ObjectiveReset = "You have reset your <font color='#FFFF00'>★</font> count."
	}
}

// Sound Path String Table (sound/...)
soundsNonlinear <-
{
	ObjectiveGet = "UI/armsrace_level_up"
}


// Message Generators

function MessageObjectiveGet()
{
	local message = format(messagesNonlinear[misc_language].ObjectiveGet, GetNumberOfObjectivesCollected());
	return message;
}

function MessageAlreadyCollectedObjective()
{
	local message = messagesNonlinear[misc_language].AlreadyCollectedObjective;
	return message;
}

function MessageObjectiveGateFail(objectivesRequired)
{
	local message = format(messagesNonlinear[misc_language].ObjectiveGateFail, objectivesRequired, GetNumberOfObjectivesCollected());
	return message;
}

function MessageObjectiveReset()
{
	local message = messagesNonlinear[misc_language].ObjectiveReset;
	return message;
}


// Sound Path Grabbers

function SoundObjectiveGet()
{
	return soundsNonlinear.ObjectiveGet;
}