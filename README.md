# DanZay's KZ VScripts (CS:GO)

These VScripts provide mappers with reliable, more customisable implementations of frequently used KZ mechanics (e.g. b-hop blocks) . This is hopefully done whilst also reducing the complexity of putting the mechanics into a map.

---

### Brief Explanation of VScripts

Entities can be given an "Entity Script" in their properties. This makes them run a script when it spawns. A script can connect entity outputs, such as a trigger_multiple's OnStartTouch, to execute code. That code can be written to have the entity do [almost anything](https://developer.valvesoftware.com/wiki/List_of_Counter-Strike:_Global_Offensive_Script_Functions). In my case, they run functions from the player's scope. Used VScript files are placed into /csgo/scripts/vscripts/ and need to be packed into the map. Recommended resources: [VScript](https://developer.valvesoftware.com/wiki/VScript), [Vscript Fundamentals](https://developer.valvesoftware.com/wiki/Vscript_Fundamentals).

---

### Usage

Example VMFs of how to use the VScripts are provided [here](example_vmfs).

Don't forget to place all .nut files into /csgo/scripts/vscripts/danzay/.

Certain scripts need to be run by the player (RunScriptFile) when they spawn into the map ([example of how to do this using a trigger_multiple that covers the spawn points](http://i.imgur.com/lCfW3PF.png)). This puts the required functions and variables into the player's scope.

Further documentation of usage can be found below, and in the comments of the .nut files.

---

#### *misc.nut*

All functions that weren't directly related to a certain mechanic. Is generally required to be in the player's scope. Includes teleport, printing to the center info panel, execute client commands.

One of the challenges was to disable the speed panel temporarily before sending a message to the center info panel. This is only done if a flag is set to true, so you should provide a way for the player to choose if they want to use the speed panel by using *misc_setspeedflag.nut* (specify what you want to set the flag to by naming the entity "true" or "false").

You must have the player run misc.nut when they join.

Use *misc_setlanguage.nut* to set the player's language as specified by the entity's name (this is mostly there for fun, but you could theoretically provide message localisation).

---

#### *bhop.nut*

Implementation of b-hop block mechanic.

You must have the player run *bhop.nut* and *misc.nut* when they join.

Use *bhop_block.nut* for bhop block triggers. You can specify how many jumps on other blocks you want to require by setting the name of the bhop_block entity e.g. 0 means it doesn't matter (multi-touch), 1 means you have to jump on different blocks 1 time before going back etc. You can use -1 to specify a strictly single-touch b-hop.

Use *bhop_safe.nut* for safe area triggers. Failing a b-hop will teleport you to the origin of the last touched safe area trigger. This is notably useful for non-linear maps where you would usually not know where you want to teleport the player to.

Use *bhop_miss.nut* for other triggers that should teleport the player back to the last touched safe area.

---

#### *nonlinear.nut*

Implements, for lack of a better name, a non-linear system.

This has the players touch objectives to increase their objective count. You can then create a 'gate' that will block the player if they don't have a certain number of objectives (specified by setting the name of the gate entity).

You must have the player run *nonlinear.nut* and *misc.nut* when they join.

Use *nonlinear_objective.nut* for objective triggers.

Use *nonlinear_gate_rebound.nut* and/or nonlinear_gate_teleport.nut for objective gate triggers.

Use *nonlinear_reset.nut* for objective count reset triggers.

Look at editing *nonlinear_resource.nut* if you would like to change the messages displayed and the sound played.