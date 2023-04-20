class RscText;
class RscButton;
class RscPicture;
class RscListBox;
class RscActivePicture;
class RscButtonMenu;
class RscControlsGroupNoScrollbars;

class ace_medical_gui_TriageToggle: RscButton {
    x = QUOTE(POS_X(14.33));
    w = "POS_W(10.3)";
};

class ace_medical_gui_TriageSelect: RscControlsGroupNoScrollbars {
    x = QUOTE(POS_X(14.33));
    w = QUOTE(POS_W(10.3));
    class controls {
        class None: RscButton {
            w = "POS_W(10.3)";
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
