#include "script_component.hpp"

class CfgPatches {
    class ADDON    {
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        units[] = {};
        weapons[] = {};
        magazines[] = {};
        requiredAddons[] = {
            "ace_medical",
            "ace_medical_ai",
            "ace_medical_blood",
            "ace_medical_damage",
            "ace_medical_engine",
            "ace_medical_feedback",
            "ace_medical_gui",
            "ace_medical_statemachine",
            "ace_medical_status",
            "ace_medical_treatment",
            "ace_medical_vitals",
            "ace_dogtags",
            "cba_settings"
        };
        author = "Mazinski";
        authors[] = {"Mazinski"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"
#include "CfgWeapons.hpp"
<<<<<<< HEAD
#include "CfgVehicles.hpp"
#include "ACE_Medical_Treatment_Actions.hpp"
=======
#include "ACE_Medical_Treatment_Actions.hpp"
>>>>>>> parent of aaaa00b4 (Merge branch 'dev-Tomcat' of https://github.com/Cplhardcore/KAM into dev-Tomcat)
