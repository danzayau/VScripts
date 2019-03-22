function OnStartTouch() {
	local playerScope = activator.GetScriptScope();
	playerScope.OnStartZoneTouch(self);
}

self.ConnectOutput("OnStartTouch", "OnStartTouch");