#include "script_component.hpp"

class CfgPatches {
    class ADDON    {
        name = COMPONENT_NAME;
        requiredVersion = REQUIRED_VERSION;
        units[] = {
            QGVAR(computer),
            QGVAR(patientSpot)
        };
        weapons[] = {};
        magazines[] = { };
        requiredAddons[] = {
            "kat_main",
            "kat_airway",
            "kat_breathing",
            "kat_circulation",
            "kat_surgery",
            "ace_interact_menu",
            "ace_dragging",
            "A3_Props_F_Enoch_Military_Equipment",
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
        author = "kolmipilot";
        authors[] = {"kolmipilot", "MiszczuZPolski"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
#include "RscDisplayMain.hpp"
#include "RscTitles.hpp"
