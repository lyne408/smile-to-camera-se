scriptName SmileToCamera_MCM extends SKI_ConfigBase

;-- Properties --------------------------------------
SmileToCamera property theQuest auto

;-- Variables ---------------------------------------
int id_On
int id_ToggleKey
int id_delaySlider
int id_ExpressionMood
int id_ExpressionStrength
int id_DoExpreesion
int id_PositionAdjustX
int id_PositionAdjustY
int id_PositionAdjustZ

; SCRIPT VERSION ----------------------------------------------------------------------------------

int function GetVersion()
	return 2
endFunction

; INITIALIZATION ----------------------------------------------------------------------------------

; @implements SKI_ConfigBase
event OnConfigInit()
	ModName = "Smile To Camera"
endEvent

; @implements SKI_QuestBase
;this event called from PlayerAlias!!! so we must attach SKI_PlayerLoadGameAlias to quest
event OnVersionUpdate(int newVersion)
	Debug.Trace(self + ": Updating Version [" + CurrentVersion + "] -> [" + newVersion + "]")
	OnConfigInit()
	theQuest.Update()
endEvent

Function VersionCheck()
	;Mcm not call OnVersionUpdate() !! so force call OnVersionUpdate()
	debug.trace(self+" : VersionCheck()")
	Parent.CheckVersion()
EndFunction

;this event called from PlayerAlias!!! so we must attach SKI_PlayerLoadGameAlias to quest
Event OnGameReload()
	Parent.OnGameReload()
	
	Debug.Trace(self + " OnGameReload() : Check Version [" + CurrentVersion + "] / [" + GetVersion() + "]")
	VersionCheck()
	
EndEvent

;-- Events ---------------------------------------

event OnPageReset(string pagename)
	SetCursorFillMode(TOP_TO_BOTTOM)

	self.AddHeaderOption("ON/OFF", 0)
	id_ToggleKey = self.AddKeyMapOption("Toggle Key", theQuest.toggleKey, 0)
	id_On = self.AddToggleOption("ON/OFF", theQuest.HeadTrack_ON, 0)
	
	self.AddHeaderOption("Delay", 0)
	id_delaySlider = self.AddSliderOption("Loop Run Interval (s)", theQuest.HeadTrack_Loop_Delay, "{2}", 0)
	
	self.AddHeaderOption("Position Adjust", 0)
	id_PositionAdjustX = self.AddSliderOption("X", theQuest.PositionAdjustX, "{0}", 0)
	id_PositionAdjustY = self.AddSliderOption("Y", theQuest.PositionAdjustY, "{0}", 0)
	id_PositionAdjustZ = self.AddSliderOption("Z", theQuest.PositionAdjustZ, "{0}", 0)
	
	SetCursorPosition(1)
	
	self.AddHeaderOption("Facial Expression", 0)
	id_ExpressionMood = self.AddSliderOption("Mood", theQuest.ExpressionMood, "{0}", 0)
	id_ExpressionStrength = self.AddSliderOption("Strength", theQuest.ExpressionStrength, "{0}", 0)
	AddTextOption("", "", 0)
	id_DoExpreesion = self.AddTextOption("Force Expression", "Do", 0)
	
endEvent

function OnOptionDefault(Int option)

	if option == id_On
		theQuest.HeadTrack_ON()
		self.SetToggleOptionValue(option, theQuest.HeadTrack_ON, false)
	elseif option == id_ToggleKey
		theQuest.toggleKey = 47
		self.SetKeyMapOptionValue(option, theQuest.toggleKey, false)
	elseif option == id_delaySlider
		theQuest.HeadTrack_Loop_Delay = 0.05
		self.SetSliderOptionValue(option, theQuest.HeadTrack_Loop_Delay, "{2}", false)
	elseif option == id_ExpressionMood
		theQuest.ExpressionMood = 10
		self.SetSliderOptionValue(option, theQuest.ExpressionMood, "{0}", false)
	elseif option == id_ExpressionStrength
		theQuest.ExpressionStrength = 30
		self.SetSliderOptionValue(option, theQuest.ExpressionStrength, "{0}", false)
	endIf
endFunction

function OnOptionSelect(Int option)

	if option == id_On
		theQuest.ToggleOnOff()
		self.SetToggleOptionValue(id_On, theQuest.HeadTrack_ON, false)
	elseif option == id_DoExpreesion
		Game.GetPlayer().SetExpressionOverride(theQuest.ExpressionMood, theQuest.ExpressionStrength)
	endIf
endFunction

function OnOptionSliderOpen(Int option)

	if option == id_delaySlider
		self.SetSliderDialogRange(0.000000, 1.00000)
		self.SetSliderDialogInterval(0.0100000)
		self.SetSliderDialogStartValue(theQuest.HeadTrack_Loop_Delay)
	elseif option == id_ExpressionMood
		self.SetSliderDialogRange(0.0, 16.0)
		self.SetSliderDialogInterval(1)
		self.SetSliderDialogStartValue(theQuest.ExpressionMood)
	elseif option == id_ExpressionStrength
		self.SetSliderDialogRange(0.0, 100.0)
		self.SetSliderDialogInterval(1)
		self.SetSliderDialogStartValue(theQuest.ExpressionStrength)
	elseif option == id_PositionAdjustX
		self.SetSliderDialogRange(-100.0, 100.0)
		self.SetSliderDialogInterval(1)
		self.SetSliderDialogStartValue(theQuest.PositionAdjustX)
	elseif option == id_PositionAdjustY
		self.SetSliderDialogRange(-100.0, 100.0)
		self.SetSliderDialogInterval(1)
		self.SetSliderDialogStartValue(theQuest.PositionAdjustY)
	elseif option == id_PositionAdjustZ
		self.SetSliderDialogRange(-100.0, 100.0)
		self.SetSliderDialogInterval(1)
		self.SetSliderDialogStartValue(theQuest.PositionAdjustZ)
	endIf
endFunction

function OnOptionSliderAccept(Int option, Float value)

	if option == id_delaySlider
		self.SetSliderOptionValue(option, value, "{2}", false)
		theQuest.HeadTrack_Loop_Delay = value
	elseif option == id_ExpressionMood
		self.SetSliderOptionValue(option, value, "{0}", false)
		theQuest.ExpressionMood = value as int
	elseif option == id_ExpressionStrength
		self.SetSliderOptionValue(option, value, "{0}", false)
		theQuest.ExpressionStrength = value as int
	elseif option == id_PositionAdjustX
		self.SetSliderOptionValue(option, value, "{0}", false)
		theQuest.PositionAdjustX = value as int
	elseif option == id_PositionAdjustY
		self.SetSliderOptionValue(option, value, "{0}", false)
		theQuest.PositionAdjustY = value as int
	elseif option == id_PositionAdjustZ
		self.SetSliderOptionValue(option, value, "{0}", false)
		theQuest.PositionAdjustZ = value as int
	endIf
endFunction

function OnOptionKeyMapChange(Int option, Int keyCode, String conflictControl, String conflictName)

	Bool continue = true
	if conflictControl != ""
		String msg
		if conflictName != ""
			msg = "This key is already mapped to:\n\"" + conflictControl + "\"\n(" + conflictName + ")\n\nAre you sure you want to continue?"
		else
			msg = "This key is already mapped to:\n\"" + conflictControl + "\"\n\nAre you sure you want to continue?"
		endIf
		continue = self.ShowMessage(msg, true, "$Yes", "$No")
	endIf
	if continue == false
		return 
	endIf
	if option == id_ToggleKey
		theQuest.toggleKey = keyCode
		self.SetKeyMapOptionValue(option, keyCode, false)
	endIf
endFunction

;-- Functions ---------------------------------------

;-- State -------------------------------------------
