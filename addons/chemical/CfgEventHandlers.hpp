class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
        disableModuload = "true";
    };
};

class Extended_Init_EventHandlers {
    class CAManBase {
        class ADDON {
            init = QUOTE([ARR_2((_this select 0),false)] call FUNC(init));
        };
    };
    class kat_radSource {
        class ADDON {
            init = QUOTE([_this select 0] call FUNC(initRadSourceObject));
        };
    };
};

class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_postInit));
    };
};

