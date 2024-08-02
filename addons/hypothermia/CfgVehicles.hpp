class CBA_Extended_EventHandlers_base;
class CfgVehicles {
    class Man;
    
    class CAManBase: Man {
        class ACE_Actions {
            class ACE_MainActions {
                class KAT_CheckHandWarmers {
                    displayName = CSTRING(CheckHandWarmers);
                    condition = "true";
                    statement = QUOTE([ARR_2(_player,_target)] call FUNC(checkHandWarmers));
                    icon = QACEPATHTOF(medical_gui,ui\cross.paa);
                };
            };
        };
    };
};