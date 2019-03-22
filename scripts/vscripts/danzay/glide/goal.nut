function OnStartTouch() {
	local playerScope = activator.GetScriptScope();
	playerScope.OnGoalTouch(self);
}

self.ConnectOutput("OnStartTouch", "OnStartTouch");