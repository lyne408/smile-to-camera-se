#include "skse64/GameData.h"
#include "skse64/PapyrusArgs.h"
#include "skse64/PapyrusVM.h"
#include "skse64/PapyrusNativeFunctions.h"

namespace CameraPluginNamespace{

	bool RegisterFuncs(VMClassRegistry* registry);
	UInt32 CalculatePosition(StaticFunctionTag* base);
	float CamPosX(StaticFunctionTag* base);
	float CamPosY(StaticFunctionTag* base);
	float CamPosZ(StaticFunctionTag* base);
}

