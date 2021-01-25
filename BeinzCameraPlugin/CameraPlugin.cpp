#include "skse64/GameCamera.h"
#include "skse64/NiObjects.h"
#include "skse64/NiNodes.h"

#include "CameraPlugin.h"

#define getPlayerCamera\
	PlayerCamera* cam = PlayerCamera::GetSingleton();\
	if (!cam) {\
		_MESSAGE("[ERROR] Can not get GameCamera!");\
		return 0;\
	}

namespace CameraPluginNamespace {

	bool RegisterFuncs(VMClassRegistry* registry) {
		_MESSAGE("--- BeinzCameraPlugin ---> Call RegisterFuncs()");

		const char* className = "BeinzCameraPlugin";
	
		registry->RegisterFunction(
			new NativeFunction0 <StaticFunctionTag, UInt32>("CalculatePosition", className, CameraPluginNamespace::CalculatePosition, registry));
		registry->RegisterFunction(
			new NativeFunction0 <StaticFunctionTag, float>("CamPosX", className, CameraPluginNamespace::CamPosX, registry));
		registry->RegisterFunction(
			new NativeFunction0 <StaticFunctionTag, float>("CamPosY", className, CameraPluginNamespace::CamPosY, registry));
		registry->RegisterFunction(
			new NativeFunction0 <StaticFunctionTag, float>("CamPosZ", className, CameraPluginNamespace::CamPosZ, registry));
		

		return true;
	}


	UInt32 CalculatePosition(StaticFunctionTag* base) {
		// _MESSAGE("--- BeinzCameraPlugin ---> Call CalculatePosition()");

		getPlayerCamera;

		_MESSAGE("[BeinzCameraPlugin] cam->pos[%f,%f,%f]", cam->pos.x, cam->pos.y, cam->pos.z);
		NiNode* cameraNode = cam->cameraNode;
		_MESSAGE("[BeinzCameraPlugin] cameraNode->m_worldTransform[%f,%f,%f]", cameraNode->m_worldTransform.pos.x, cameraNode->m_worldTransform.pos.y, cameraNode->m_worldTransform.pos.z);
		if (cam->pos.x == 0 && cam->pos.y == 0 && cam->pos.z == 0)	return 1;

		return 2;
	}


	float CamPosX(StaticFunctionTag* base) {
		// _MESSAGE("\tX ---> CameraPluginNamespace::CamPosX");

		getPlayerCamera;

		return cam->cameraNode->m_worldTransform.pos.x;
	}

	float CamPosY(StaticFunctionTag* base) {
		// _MESSAGE("\t\tY ---> CameraPluginNamespace::CamPosY");

		getPlayerCamera;

		return cam->cameraNode->m_worldTransform.pos.y;
	}

	float CamPosZ(StaticFunctionTag* base) {
		// _MESSAGE("\t\t\tZ ---> CameraPluginNamespace::CamPosZ");

		getPlayerCamera;

		return cam->cameraNode->m_worldTransform.pos.z;
	}

}