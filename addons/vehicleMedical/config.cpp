class CfgPatches {
	class ADDON
	{
		name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;;
		author = "M3ales & Cplhardcore";
		url = "https://github.com/M3ales/MIRA_Vehicle_Medical";
		requiredAddons[] = {"ace_interact_menu", "ace_medical", "ace_medical_treatment", "cba_settings", "kat_main"};
		units[] = {};
		weapons[] = {};
		VERSION_CONFIG;
	};
};

class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
    };
};

class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_postInit));
    };
};
