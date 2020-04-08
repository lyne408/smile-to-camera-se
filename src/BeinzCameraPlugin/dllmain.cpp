#include <ShlObj.h>
//#include "stdafx.h"
#include "common/IDebugLog.h"
#include "skse64/PluginAPI.h"		// super
#include "skse64_common/skse_version.h"	// What version of SKSE is running?
#include "CameraPlugin.h"

static PluginHandle					g_pluginHandle = kPluginHandle_Invalid;

extern "C" {

	// Called by SKSE to learn about this plugin and check that it's safe to load it
	bool SKSEPlugin_Query(const SKSEInterface* skse, PluginInfo* info) {

		gLog.OpenRelative(CSIDL_MYDOCUMENTS, "\\My Games\\Skyrim Special Edition\\SKSE\\BeinzCameraPlugin.log");
		gLog.SetPrintLevel(IDebugLog::kLevel_Error);
		gLog.SetLogLevel(IDebugLog::kLevel_DebugMessage);

		_MESSAGE("--- BeinzCameraPlugin ---> Call SKSEPlugin_Query()");

		// populate info structure
		info->infoVersion = PluginInfo::kInfoVersion;
		info->name = "BeinzCameraPlugin";
		info->version = 1;

		// store plugin handle so we can identify ourselves later
		g_pluginHandle = skse->GetPluginHandle();

		if (skse->isEditor)
		{
			_MESSAGE("loaded in editor, marking as incompatible");
			return false;
		}

		// Now CURRENT_RELEASE_RUNTIME is RUNTIME_VERSION_1_5_97.
		else if (skse->runtimeVersion != CURRENT_RELEASE_RUNTIME)
		{
			_MESSAGE("Unsupported runtime version %08X", skse->runtimeVersion);
			return false;
		}

		// ### do not do anything else in this callback
		// ### only fill out PluginInfo and return true/false

		// supported runtime version
		return true;
	}
	// Called by SKSE to load this plugin
	bool SKSEPlugin_Load(const SKSEInterface* skse) {

		_MESSAGE("--- BeinzCameraPlugin ---> Call SKSEPlugin_Load()");

		auto ipapyrus = reinterpret_cast<SKSEPapyrusInterface*>(skse->QueryInterface(kInterface_Papyrus));

		//Check if the function registration was a success...
		bool btest = ipapyrus->Register(CameraPluginNamespace::RegisterFuncs);

		if (btest) {
			_MESSAGE("--- BeinzCameraPlugin ---> Register Papyrus native funtions succeeded!");
		}
		return true;
	}
}