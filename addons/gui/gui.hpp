#include "script_component.hpp"
class RscText;
class RscButton;
class RscPicture;
class RscListBox;
class RscActivePicture;
class RscButtonMenu;
class RscControlsGroupNoScrollbars;

class ace_medical_gui_TriageToggle: RscButton {
    x = QUOTE(POS_X(14.33));
    w = QUOTE(POS_W(10.3));
};

class ace_medical_gui_TriageSelect: RscControlsGroupNoScrollbars {
    x = QUOTE(POS_X(14.33));
    w = QUOTE(POS_W(10.3));
    class controls {
        class None: RscButton {
            w = QUOTE(POS_W(10.3));
        };
    };
};

class ACEGVAR(medical_gui,BodyImage): RscControlsGroupNoScrollbars {
    class controls {
        class Background;
        class Torso_Infected: Background {
            idc = IDC_BODY_TORSO_I;
            text = QPATHTOF(data\body_image\torso_i.paa);
            colorText[] = {1, 1, 1, 1};
            show = 0;
        };
        class Torso_AED_Pads: Background {
            idc = IDC_BODY_TORSO_AED_PADS;
            text = QPATHTOF(data\body_image\torso_aed_pads.paa);
            colorText[] = {0.18, 0.6, 0.96, 1};
            show = 0;
        };
        class Torso_AED_VitalsMonitor: Torso_AED_Pads {
            idc = IDC_BODY_TORSO_AED_VITALS;
            text = QPATHTOF(data\body_image\torso_aed_vitals_monitor.paa);
        };
    };
};

class ACE_Medical_Menu {
    class controls {
        class Triage: RscActivePicture {};
        class Surgury: Triage {
            idc = IDC_SURGERY;
            onButtonClick = QUOTE(ace_medical_gui_selectedCategory = 'surgery');
            text = QPATHTOF(data\categories\plate.paa);
            tooltip = "Surgery";
            x = QUOTE(POS_X(13.5));
        };
        class Action1: RscButtonMenu {};
        class Action10: Action1 {
            idc = IDC_ACTION_10;
            y = QUOTE(POS_Y(14.4));
        };
        class Action11: Action1 {
            idc = IDC_ACTION_11;
            y = QUOTE(POS_Y(15.5));
        };
        class TriageStatus: RscText {
            x = QUOTE(POS_X(14.33));
            w = QUOTE(POS_W(10.33));
        };
    };
};
