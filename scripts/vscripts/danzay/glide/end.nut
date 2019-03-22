function OnStartTouch() {
	local playerScope = activator.GetScriptScope();
	playerScope.OnEndZoneTouch(self);
}

self.ConnectOutput("OnStartTouch", "OnStartTouch");