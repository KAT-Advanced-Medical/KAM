class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class ACE_Medical {
                #define ACTION_CONDITION condition = "true";
                #include "InteractionBodyParts.hpp"
                #undef ACTION_CONDITION
            };
        };
        class ACE_Actions {
            #define ACTION_CONDITION condition = QUOTE(ACEGVAR(medical_gui,enableActions) == 0);
            #include "InteractionBodyParts.hpp"
            #undef ACTION_CONDITION
            class ACE_MainActions {
                class ACE_Medical_Radial {
                    #define ACTION_CONDITION condition = "true";
                    #include "InteractionBodyParts.hpp"
                    #undef ACTION_CONDITION
                };
            };
        };
    };
};