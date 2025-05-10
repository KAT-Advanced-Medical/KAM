class CfgVehicles {
    class Man;

    class CAManBase: Man {
        class ACE_Actions {
            class ACE_MainActions {
                class KAT_CheckHandWarmers {
                    displayName = CSTRING(Check_Hand_Warmers);
                    condition = QUOTE(GVAR(hypothermiaActive));
                    statement = QUOTE([ARR_2(_player,_target)] call FUNC(checkHandWarmers));
                    icon = QACEPATHTOF(medical_gui,ui\cross.paa);
                };
            };
        };

        class ACE_SelfActions {
            class KAT_Equipment {
                class KAT_CheckHandWarmersSelf {
                    displayName = CSTRING(Check_Hand_Warmers);
                    condition = QUOTE(GVAR(hypothermiaActive));
                    statement = QUOTE([ARR_2(_player,_player)] call FUNC(checkHandWarmers));
                    icon = QACEPATHTOF(medical_gui,ui\cross.paa);
                };
            };
        };
    };
};
