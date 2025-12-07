class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
    };
};

// class Extended_PostInit_EventHandlers {
//     class ADDON {
//         init = QUOTE(call COMPILE_FILE(XEH_postInit));
//     };
// };

class Extended_Respawn_EventHandlers {
    class CAManBase {
        class ADDON {
            respawn = QUOTE(call ACEFUNC(medical_statemachine,resetStateDefault));
            exclude[] = {IGNORE_BASE_UAVPILOTS};
        };
    };
};

class Extended_Local_EventHandlers {
    class CAManBase {
        class ADDON {
            local = QUOTE(call ACEFUNC(medical_statemachine,localityChangedEH)); // TODO replace with kam function
            exclude[] = {IGNORE_BASE_UAVPILOTS};
        };
    };
};
