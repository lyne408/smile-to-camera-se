scriptName SmileToCamera extends Quest

;-- Properties --------------------------------------
actor property PlayerRef auto
static property HeadTrackDummyTarget auto
float property HeadTrack_Loop_Delay = 0.05 auto hidden
bool property HeadTrack_ON = true auto hidden
int property ExpressionMood = 10 auto hidden
int property ExpressionStrength = 30 auto hidden
int property toggleKey = 47 auto hidden
float property PositionAdjustX = 0.0 auto hidden
float property PositionAdjustY = 0.0 auto hidden
float property PositionAdjustZ = 0.0 auto hidden

;-- Variables ---------------------------------------
Bool thirdCam = true
bool bHeadtrackLast = true
ObjectReference Target
ObjectReference TempObj
Bool reg3 = false
bool bRightAngle = true

;-- Functions ---------------------------------------

function OnInit()
	self.RegisterforCameraState()
	reg3 = true
	Target = none
	TempObj = none
	PlayerRef.SetAnimationVariableBool("IsNPC", true)
	PlayerRef.SetHeadTracking(true)
	self.RegisterForSingleUpdate(HeadTrack_Loop_Delay)
endFunction

function Update()
	self.RegisterForKey(toggleKey)
endFunction

function OnUpdate()
	if HeadTrack_ON == true ;&& skse.GetPluginVersion("BeinzCameraPlugin") > 0
		;if skse.GetVersionRelease() <= 0 && skse.GetPluginVersion("BeinzCameraPlugin") <= 0
		;	debug.Notification("Error- could not find SKSE version or Head Track plugin.  Terminating loop.")
		;	return 
		;endIf
		if Target == none
			;debug.Notification("SmileToCamera Loading...")
			Utility.wait(3)	;for save loading
			;debug.Notification("SmileToCamera Started")
			TrackingObject_ON()
		elseif Target.GetParentCell() != PlayerRef.GetParentCell()
			TrackingObject_OFF()
			Utility.wait(3)	;for cell loading
			TrackingObject_ON()
		endIf
		if reg3 == false
			self.RegisterforCameraState()
			reg3 = true
		endIf
		;self.RegisterForKey(toggleKey)
		
		if thirdCam && !PlayerRef.IsInCombat() && !PlayerRef.IsWeaponDrawn()
			float px = PlayerRef.GetPositionX()
			float py = PlayerRef.GetPositionY()
			float pz = PlayerRef.GetPositionZ()
			float x1 = BeinzCameraPlugin.CamPosX()
			float y1 = BeinzCameraPlugin.CamPosY()
			float z1 = BeinzCameraPlugin.CamPosZ()
			TempObj.SetPosition(x1,y1,z1)
			float dist = TempObj.GetDistance(PlayerRef)
			;float zNew = z1 - (dist/100 * 12)
			float xNew = x1 - PositionAdjustX
			float yNew = y1 - PositionAdjustY
			float zNew = z1 - PositionAdjustZ
			TempObj.SetPosition(x1,y1,pz)
			float fAngle = PlayerRef.GetHeadingAngle(TempObj)
			;Debug.Trace("Beinz SmileToCamera Player [" + px + "," + py + "," + pz + "] / CamPlugin [" + x1 + "," + y1 + "," + z1 + "] / distance : " + dist + " / zNew : " + zNew + " / fAngle : " + fAngle)
			if (Math.Abs(fAngle) < 90)
				Target.SetPosition(xNew,yNew,zNew)
				
				PlayerRef.SetAnimationVariableBool("IsNPC", true)
				PlayerRef.SetHeadTracking(true)
				PlayerRef.SetLookAt(Target, false)
				PlayerRef.SetExpressionOverride(ExpressionMood, ExpressionStrength)
				bRightAngle = true
			elseif bRightAngle
				float offsetX = 100 * Math.Cos(0)
				float offsetY = 100 * Math.Sin(0)
				Target.MoveTo(PlayerRef,offsetX,offsetY,PlayerRef.GetHeight())
				
				PlayerRef.SetAnimationVariableBool("IsNPC", false)
				PlayerRef.SetHeadTracking(false)
				PlayerRef.SetLookAt(Target, false)
				;PlayerRef.ClearLookAt()
				PlayerRef.ClearExpressionOverride()
				bRightAngle = false
			endIf
			bHeadtrackLast = true
		elseif bHeadtrackLast
			PlayerRef.SetAnimationVariableBool("IsNPC", false)
			PlayerRef.SetHeadTracking(false)
			;PlayerRef.SetLookAt(PlayerRef as ObjectReference, false)
			PlayerRef.ClearLookAt()
			PlayerRef.ClearExpressionOverride()
			bHeadtrackLast = false
		endIf
		
		self.RegisterForSingleUpdate(HeadTrack_Loop_Delay)
	else
		;HeadTrack_OFF()
		;TrackingObject_OFF()
	endIf
endFunction

Function TrackingObject_ON()
	Target = PlayerRef.PlaceAtMe(HeadTrackDummyTarget as form, 1, false, false)
	TempObj = PlayerRef.PlaceAtMe(HeadTrackDummyTarget as form, 1, false, false)
EndFunction

Function TrackingObject_OFF()
	TempObj.DisableNoWait(false)
	TempObj.Delete()
	TempObj = none
	Target.DisableNoWait(false)
	Target.Delete()
	Target = none
EndFunction

function HeadTrack_OFF()
	HeadTrack_ON = false
	PlayerRef.SetAnimationVariableBool("IsNPC", false)
	PlayerRef.SetHeadTracking(false)
	PlayerRef.ClearLookAt()
	;PlayerRef.SetLookAt(PlayerRef as ObjectReference, false)
	PlayerRef.ClearExpressionOverride()
endFunction

function HeadTrack_ON()
	HeadTrack_ON = true
	PlayerRef.SetAnimationVariableBool("IsNPC", true)
	PlayerRef.SetHeadTracking(true)
	if Target == none
		TrackingObject_OFF()
		TrackingObject_ON()
	elseif Target.GetParentCell() != PlayerRef.GetParentCell()
		TrackingObject_OFF()
		TrackingObject_ON()
	endIf
	;self.RegisterForSingleUpdate(HeadTrack_Loop_Delay)
	OnUpdate()
endFunction

function ToggleOnOff()
	if HeadTrack_ON == true
		Debug.Trace("Beinz SmileToCamera ToggleOnOff() : HeadTrack_ON = True -> False")
		HeadTrack_OFF()
	else
		Debug.Trace("Beinz SmileToCamera ToggleOnOff() : HeadTrack_ON = False -> True")
		HeadTrack_ON()
	endIf
endFunction

function OnKeyUp(Int KeyCode, Float holdTime)
	if KeyCode == toggleKey && !Utility.IsInMenuMode() && KeyCode != 1	;1=ESC
		ToggleOnOff()
	endIf
endFunction

;valid States for Camera:
;0 - first person	= 1st
;1 - auto vanity
;2 - VATS
;3 - free			= TFC
;4 - iron sights
;5 - furniture
;6 - transition
;7 - tweenmenu
;8 - third person 1
;9 - third person 2	= 3rd
;10 - horse
;11 - bleedout
;12 - dragon
function OnPlayerCameraState(Int oldState, Int newState)

	if newState == 9 || newState == 3
		thirdCam = true
	else
		thirdCam = false
		;Debug.Trace("Beinz SmileToCamera CameraState : " + newState)
		;Debug.Notification("SmileToCamera CameraState : " + newState)
	endIf
endFunction
