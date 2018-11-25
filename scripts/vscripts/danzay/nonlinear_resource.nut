/*
	Resource file for the objective system.
*/


// Message String Table
messagesNonlinear <-
{
	ObjectiveGet = "★%d",
	AlreadyCollectedObjective = "You already got this ★",
	ObjectiveGateFail = "You need ★%d to pass\n\nYou only have ★%d",
	ObjectiveReset = "You have reset your ★ count"
}

// Sound Path String Table (sound/...)
soundsNonlinear <-
{
	ObjectiveGet = "UI/armsrace_level_up",
	ObjectiveFail = "UI/armsrace_demoted"
}


// Message Generators

function GetMessageObjectiveGet()
{
	local message = format(messagesNonlinear.ObjectiveGet, GetNumberOfObjectivesCollected());
	return message;
}

function GetMessageAlreadyCollectedObjective()
{
	local message = messagesNonlinear.AlreadyCollectedObjective;
	return message;
}

function GetMessageObjectiveGateFail(objectivesRequired)
{
	local message = format(messagesNonlinear.ObjectiveGateFail, objectivesRequired, GetNumberOfObjectivesCollected());
	return message;
}

function GetMessageObjectiveReset()
{
	local message = messagesNonlinear.ObjectiveReset;
	return message;
}


// Sound Path Grabbers

function GetSoundObjectiveGet()
{
	return soundsNonlinear.ObjectiveGet;
}

function GetSoundObjectiveFail()
{
	return soundsNonlinear.ObjectiveFail;
}