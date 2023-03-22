class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
        disableModuload = "true";
    };
};

class Extended_Init_EventHandlers {
    class CAManBase {
        class ADDON {
            init = QUOTE(_this call COMPILE_FILE(XEH_init));
        };
    };
};

class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_postInit));
    };
};
