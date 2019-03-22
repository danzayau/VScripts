enum Course {
    Main,
    Bonus1
}

sounds <- {
	CornerTouch = "UI/armsrace_level_up",
    NotFinished = "UI/armsrace_demoted"
}

goalReached <- {
    a = false,
    b = false,
    c = false,
    d = false,
    e = false
}

currentCourse <- null;

function TeleportToBonus1Start() {
    start <- Entities.FindByName(null, "bonus1_start");
    TeleportPlayerTo(start);
}

function Reset(course) {
    goalReached.a = false;
    goalReached.b = false;
    goalReached.c = false;
    goalReached.d = false;
    goalReached.e = false;

    currentCourse = course;

    if (course == "1") {
        goalReached.e = true;
    }
}

function CheckFinished(course) {
    if (course != currentCourse) {
        return;
    }

    if (course == "0") {
        return goalReached.a
            && goalReached.b
            && goalReached.c
            && goalReached.d
            && goalReached.e;
    } else if (course == "1") {
        return goalReached.a
            && goalReached.b
            && goalReached.c
            && goalReached.d;
    }
}

function OnStartZoneTouch(zone) {
    course <- zone.GetName();
    Reset(course);
}

function OnEndZoneTouch(zone) {
    course <- zone.GetName();
    if (CheckFinished(course)) {
        end <- Entities.FindByName(null, "end");
        TeleportPlayerTo(end);
    }
}

function OnGoalTouch(goal) {
    id <- goal.GetName();
    if (!goalReached[id]) {
        goalReached[id] = true;
        PlaySound(sounds.CornerTouch);
    }
}