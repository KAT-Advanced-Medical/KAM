class RscText;
class RscButton;
class RscPicture;
class RscListBox;
class RscActivePicture;
class RscButtonMenu;
class RscControlsGroup;
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
        class Torso_ChestSeal: Background {
            idc = IDC_BODY_TORSO_CHESTSEAL;
            text = QPATHTOF(data\body_image\torso_chestseal.paa);
            colorText[] = {1, 0.95, 0, 1};
            show = 0;
        };
        class Head_GuedelTube: Torso_ChestSeal {
            idc = IDC_BODY_HEAD_GUEDELTUBE;
            text = QPATHTOF(data\body_image\head_guedeltube.paa);
            colorText[] = {0.1, 1, 1, 1};
        };
        class Head_KingLT: Head_GuedelTube {
            idc = IDC_BODY_HEAD_KINGLT;
            text = QPATHTOF(data\body_image\head_kinglt.paa);
        };
        class Head_NasalCannula: Torso_ChestSeal {
            idc = IDC_BODY_HEAD_NASAL;
            text = QPATHTOF(data\body_image\head_nasalcannula.paa);
            colorText[] = {0.18, 0.6, 0.96, 1};
        };
        class RightArm_PulseOximeter: Background {
            idc = IDC_BODY_RIGHTARM_PULSEOX;
            text = QPATHTOF(data\body_image\rightarm_pulseoximeter.paa);
            colorText[] = {0.3, 0.8, 0.8, 1};
            show = 0;
        };
        class LeftArm_PulseOximeter: RightArm_PulseOximeter {
            idc = IDC_BODY_LEFTARM_PULSEOX;
            text = QPATHTOF(data\body_image\leftarm_pulseoximeter.paa);
        };
        class Torso_AED_Pads: Background {
            idc = IDC_BODY_TORSO_AED_PADS;
            text = QPATHTOF(data\body_image\torso_aed_pads.paa);
            colorText[] = {0.18, 0.6, 0.96, 1};
            show = 0;
        };
        class RightArm_AED_VitalsMonitor: Torso_AED_Pads {
            idc = IDC_BODY_RIGHTARM_AED_VITALS;
            text = QPATHTOF(data\body_image\rightarm_aed_vitals_monitor.paa);
        };
        class LeftArm_AED_VitalsMonitor: RightArm_AED_VitalsMonitor {
            idc = IDC_BODY_LEFTARM_AED_VITALS;
            text = QPATHTOF(data\body_image\leftarm_aed_vitals_monitor.paa);
        };
        class Torso_IO: Torso_ChestSeal {
            idc = IDC_BODY_TORSO_IO;
            text = QPATHTOF(data\body_image\torso_io.paa);
            colorText[] = {0.3, 0.6, 0.3, 1};
        };
        class Torso_Pneumothorax: Torso_ChestSeal {
            idc = IDC_BODY_TORSO_PNEUMOTHORAX;
            text = QPATHTOF(data\body_image\torso_pneumothorax.paa);
            colorText[] = {1, 1, 1, 1};
        };
        class RightArm_IV: Torso_IO {
            idc = IDC_BODY_RIGHTARM_IV;
            text = QPATHTOF(data\body_image\rightarm_iv.paa);
        };
        class LeftArm_IV: RightArm_IV {
            idc = IDC_BODY_LEFTARM_IV;
            text = QPATHTOF(data\body_image\leftarm_iv.paa);
        };
        class RightLeg_IV: RightArm_IV {
            idc = IDC_BODY_RIGHTLEG_IV;
            text = QPATHTOF(data\body_image\rightleg_iv.paa);
        };
        class LeftLeg_IV: RightArm_IV {
            idc = IDC_BODY_LEFTLEG_IV;
            text = QPATHTOF(data\body_image\leftleg_iv.paa);
        };
    };
};

class ACE_Medical_Menu {
    class controlsBackground {
        class IVFlowBackground: RscText {
            idc = IDC_IV_FLOW_BACKGROUND; // LOOK HERE
            x = QUOTE(POS_X(-8.5));
            y = QUOTE(POS_Y(1.1));
            w = QUOTE(POS_W(9));
            h = QUOTE(POS_H(16.3));
            colorBackground[] = {0, 0, 0, 0.7};
        };
        class IVFlowTitle: RscText {
            idc = IDC_IV_FLOW_TITLE; // LOOK HERE
            text = CSTRING(IVFlowTitle);
            x = QUOTE(POS_X(-8.5));
            y = QUOTE(POS_Y(0));
            w = QUOTE(POS_W(9));
            h = QUOTE(POS_H(1));
            colorBackground[] = GUI_BCG_COLOR; // LOOK HERE
            show = 1;
            class Attributes {
                color = "#E5E5E5";
                font = "RobotoCondensed";
                shadow = "true";
            };
        };
        class ABGBackground: IVFlowBackground {
            idc = IDC_ABG_BACKGROUND; // LOOK HERE
            x = QUOTE(POS_X(39.6));
            y = QUOTE(POS_Y(1.1));
            w = QUOTE(POS_W(9));
            h = QUOTE(POS_H(3.3));
        };
        class ABGTitle: IVFlowTitle {
            idc = IDC_ABG_TITLE; // LOOK HERE
            text = CSTRING(ABGTitle);
            x = QUOTE(POS_X(39.6));
            y = QUOTE(POS_Y(0));
            w = QUOTE(POS_W(9));
            h = QUOTE(POS_H(1));
            show = 1;
            class Attributes {
                color = "#E5E5E5";
                font = "RobotoCondensed";
                shadow = "true";
            };
        };
    };
    class controls {
        class HeadCover: RscText {
            idc = IDC_IV_FLOW_HEADCOVER; // LOOK HERE
            text = CSTRING(Cover);
            x = QUOTE(POS_X(-8));
            y = QUOTE(POS_Y(2.3));
            w = QUOTE(POS_W(8));
            h = QUOTE(POS_H(1.5));
            colorBackground[] = {0, 0, 0, 1};
            show = 1;
            class Attributes {
                align = "center";
                color = "#E5E5E5";
                font = "RobotoCondensed";
                shadow = "false";
            };
        };
        class HeadTitle: RscText {
            idc = IDC_IV_FLOW_HEADTITLE; // LOOK HERE
            text = CSTRING(HeadTitle);
            x = QUOTE(POS_X(-6.2));
            y = QUOTE(POS_Y(1.5));
            w = QUOTE(POS_W(2));
            h = QUOTE(POS_H(0.5));
            colorBackground[] = {0, 0, 0, 0};
            show = 1;
            class Attributes {
                align = "center";
                color = "#E5E5E5";
                font = "RobotoCondensed";
                shadow = "false";
            };
        };
        class HeadType: RscText {
            idc = IDC_IV_FLOW_HEADTYPE; // LOOK HERE
            x = QUOTE(POS_X(-3.7));
            y = QUOTE(POS_Y(1.5));
            w = QUOTE(POS_W(2));
            h = QUOTE(POS_H(0.5));
            colorBackground[] = {0, 0, 0, 0};
            show = 1;
            class Attributes {
                align = "center";
                color = "#E5E5E5";
                font = "RobotoCondensed";
                shadow = "false";
            };
        };
        class HeadSubtractFull: RscButton {
            idc = IDC_IV_FLOW_HEADSUBTRACTFULL; // LOOK HERE
            text = "<<";
            x = QUOTE(POS_X(-7.5));
            y = QUOTE(POS_Y(2.5));
            w = QUOTE(POS_W(1));
            h = QUOTE(POS_H(1));
            colorBackground[] = {0, 0, 0, 0.7};
            show = 0;
            class Attributes {
                align = "right";
                color = "#E5E5E5";
                font = "RobotoCondensed";
                shadow = "false";
            };
        };
        class HeadSubtract: RscButton {
            idc = IDC_IV_FLOW_HEADSUBTRACT; // LOOK HERE
            text = "<";
            x = QUOTE(POS_X(-6.5));
            y = QUOTE(POS_Y(2.5));
            w = QUOTE(POS_W(1));
            h = QUOTE(POS_H(1));
            colorBackground[] = {0, 0, 0, 0.7};
            show = 0;
            class Attributes {
                align = "right";
                color = "#E5E5E5";
                font = "RobotoCondensed";
                shadow = "false";
            };
        };
        class HeadValue: RscText {
            idc = IDC_IV_FLOW_HEADVALUE; // LOOK HERE
            x = QUOTE(POS_X(-5));
            y = QUOTE(POS_Y(2.5));
            w = QUOTE(POS_W(2));
            h = QUOTE(POS_H(1));
            colorBackground[] = {0, 0, 0, 0.7};
            show = 0;
            class Attributes {
                align = "center";
                color = "#E5E5E5";
                font = "RobotoCondensed";
                shadow = "false";
            };
        };
        class HeadAdd: RscButton {
            idc = IDC_IV_FLOW_HEADADD; // LOOK HERE
            text = ">";
            x = QUOTE(POS_X(-3.5));
            y = QUOTE(POS_Y(2.5));
            w = QUOTE(POS_W(1));
            h = QUOTE(POS_H(1));
            colorBackground[] = {0, 0, 0, 0.7};
            show = 0;
            class Attributes {
                align = "left";
                color = "#E5E5E5";
                font = "RobotoCondensed";
                shadow = "false";
            };
        };
        class HeadAddFull: RscButton {
            idc = IDC_IV_FLOW_HEADADDFULL; // LOOK HERE
            text = ">>";
            x = QUOTE(POS_X(-2.5));
            y = QUOTE(POS_Y(2.5));
            w = QUOTE(POS_W(1));
            h = QUOTE(POS_H(1));
            colorBackground[] = {0, 0, 0, 0.7};
            show = 0;
            class Attributes {
                align = "left";
                color = "#E5E5E5";
                font = "RobotoCondensed";
                shadow = "false";
            };
        };
    
        class ChestCover: HeadCover {
            idc = IDC_IV_FLOW_CHESTCOVER; // LOOK HERE
            x = QUOTE(POS_X(-8));
            y = QUOTE(POS_Y(4.8));
        };
        class ChestTitle: HeadTitle {
            idc = IDC_IV_FLOW_CHESTTITLE; // LOOK HERE
            text = CSTRING(ChestTitle);
            y = QUOTE(POS_Y(4.1));
        };
        class ChestType: HeadType {
            idc = IDC_IV_FLOW_CHESTTYPE; // LOOK HERE
            y = QUOTE(POS_Y(4.1));
        };
        class ChestSubtractFull: HeadSubtractFull {
            idc = IDC_IV_FLOW_CHESTSUBTRACTFULL; // LOOK HERE
            y = QUOTE(POS_Y(5));
        };
        class ChestSubtract: HeadSubtract {
            idc = IDC_IV_FLOW_CHESTSUBTRACT; // LOOK HERE
            y = QUOTE(POS_Y(5));
        };
        class ChestValue: HeadValue {
            idc = IDC_IV_FLOW_CHESTVALUE; // LOOK HERE
            y = QUOTE(POS_Y(5));
        };
        class ChestAdd: HeadAdd {
            idc = IDC_IV_FLOW_CHESTADD; // LOOK HERE
            y = QUOTE(POS_Y(5));
        };
        class ChestAddFull: HeadAddFull {
            idc = IDC_IV_FLOW_CHESTADDFULL; // LOOK HERE
            y = QUOTE(POS_Y(5));
        };

        class LArmCover: HeadCover {
            idc = IDC_IV_FLOW_LARMCOVER; // LOOK HERE
            y = QUOTE(POS_Y(7.4));
        };
        class LArmTitle: HeadTitle {
            idc = IDC_IV_FLOW_LARMTITLE; // LOOK HERE
            text = CSTRING(LArmTitle);
            y = QUOTE(POS_Y(6.6));
        };
        class LArmType: HeadType {
            idc = IDC_IV_FLOW_LARMTYPE; // LOOK HERE
            y = QUOTE(POS_Y(6.6));
        };
        class LArmSubtractFull: HeadSubtractFull {
            idc = IDC_IV_FLOW_LARMSUBTRACTFULL; // LOOK HERE
            y = QUOTE(POS_Y(7.6));
        };
        class LArmSubtract: HeadSubtract {
            idc = IDC_IV_FLOW_LARMSUBTRACT; // LOOK HERE
            y = QUOTE(POS_Y(7.6));
        };
        class LArmValue: HeadValue {
            idc = IDC_IV_FLOW_LARMVALUE; // LOOK HERE
            y = QUOTE(POS_Y(7.6));
        };
        class LArmAdd: HeadAdd {
            idc = IDC_IV_FLOW_LARMADD; // LOOK HERE
            y = QUOTE(POS_Y(7.6));
        };
        class LArmAddFull: HeadAddFull {
            idc = IDC_IV_FLOW_LARMADDFULL; // LOOK HERE
            y = QUOTE(POS_Y(7.6));
        };

        class RArmCover: HeadCover {
            idc = IDC_IV_FLOW_RARMCOVER; // LOOK HERE
            y = QUOTE(POS_Y(10.1));
        };
        class RArmTitle: HeadTitle {
            idc = IDC_IV_FLOW_RARMTITLE; // LOOK HERE
            text = CSTRING(RArmTitle);
            y = QUOTE(POS_Y(9.3));
        };
        class RArmType: HeadType {
            idc = IDC_IV_FLOW_RARMTYPE; // LOOK HERE
            y = QUOTE(POS_Y(9.3));
        };
        class RArmSubtractFull: HeadSubtractFull {
            idc = IDC_IV_FLOW_RARMSUBTRACTFULL; // LOOK HERE
            y = QUOTE(POS_Y(10.3));
        };
        class RArmSubtract: HeadSubtract {
            idc = IDC_IV_FLOW_RARMSUBTRACT; // LOOK HERE
            y = QUOTE(POS_Y(10.3));
        };
        class RArmValue: HeadValue {
            idc = IDC_IV_FLOW_RARMVALUE; // LOOK HERE
            y = QUOTE(POS_Y(10.3));
        };
        class RArmAdd: HeadAdd {
            idc = IDC_IV_FLOW_RARMADD; // LOOK HERE
            y = QUOTE(POS_Y(10.3));
        };
        class RArmAddFull: HeadAddFull {
            idc = IDC_IV_FLOW_RARMADDFULL; // LOOK HERE
            y = QUOTE(POS_Y(10.3));
        };

        class LLegCover: HeadCover {
            idc = IDC_IV_FLOW_LLEGCOVER; // LOOK HERE
            y = QUOTE(POS_Y(12.8));
        };
        class LLegTitle: HeadTitle {
            idc = IDC_IV_FLOW_LLEGTITLE; // LOOK HERE
            text = CSTRING(LLegTitle);
            y = QUOTE(POS_Y(12));
        };
        class LLegType: HeadType {
            idc = IDC_IV_FLOW_LLEGTYPE; // LOOK HERE
            y = QUOTE(POS_Y(12));
        };
        class LLegSubtractFull: HeadSubtractFull {
            idc = IDC_IV_FLOW_LLEGSUBTRACTFULL; // LOOK HERE
            y = QUOTE(POS_Y(12.9));
        };
        class LLegSubtract: HeadSubtract {
            idc = IDC_IV_FLOW_LLEGSUBTRACT; // LOOK HERE
            y = QUOTE(POS_Y(12.9));
        };
        class LLegValue: HeadValue {
            idc = IDC_IV_FLOW_LLEGVALUE; // LOOK HERE
            y = QUOTE(POS_Y(12.9));
        };
        class LLegAdd: HeadAdd {
            idc = IDC_IV_FLOW_LLEGADD; // LOOK HERE
            y = QUOTE(POS_Y(12.9));
        };
        class LLegAddFull: HeadAddFull {
            idc = IDC_IV_FLOW_LLEGADDFULL; // LOOK HERE
            y = QUOTE(POS_Y(12.9));
        };

        class RLegCover: HeadCover {
            idc = IDC_IV_FLOW_RLEGCOVER; // LOOK HERE
            y = QUOTE(POS_Y(15.4));
        };
        class RLegTitle: HeadTitle {
            idc = IDC_IV_FLOW_RLEGTITLE; // LOOK HERE
            text = CSTRING(RLegTitle);
            y = QUOTE(POS_Y(14.6));
        };
        class RLegType: HeadType {
            idc = IDC_IV_FLOW_RLEGTYPE; // LOOK HERE
            y = QUOTE(POS_Y(14.6));
        };
        class RLegSubtractFull: HeadSubtractFull {
            idc = IDC_IV_FLOW_RLEGSUBTRACTFULL; // LOOK HERE
            y = QUOTE(POS_Y(15.5));
        };
        class RLegSubtract: HeadSubtract {
            idc = IDC_IV_FLOW_RLEGSUBTRACT; // LOOK HERE
            y = QUOTE(POS_Y(15.5));
        };
        class RLegValue: HeadValue {
            idc = IDC_IV_FLOW_RLEGVALUE; // LOOK HERE
            y = QUOTE(POS_Y(15.5));
        };
        class RLegAdd: HeadAdd {
            idc = IDC_IV_FLOW_RLEGADD; // LOOK HERE
            y = QUOTE(POS_Y(15.5));
        };
        class RLegAddFull: HeadAddFull {
            idc = IDC_IV_FLOW_RLEGADDFULL; // LOOK HERE
            y = QUOTE(POS_Y(15.5));
        };

        class Triage: RscActivePicture {};
        class Surgery: Triage {
            idc = IDC_SURGERY;
            onButtonClick = QUOTE(ace_medical_gui_selectedCategory = 'surgery');
            text = QPATHTOF(data\categories\plate.paa);
            tooltip = "Surgery";
            x = QUOTE(POS_X(13.5));
        };
        class TriageCard: RscListBox {
            h = QUOTE(POS_H(12.2));
        };
        class ActionButtonGroup: RscControlsGroup {
            h = QUOTE(POS_H(12.2));
        };
        class Injuries: TriageCard {
            y = QUOTE(POS_Y(3.3));
            h = QUOTE(POS_Y(13.3));
        };
        class BodyLabelLeft: RscText {
            idc = IDC_SIDE_LABEL_LEFT;
            show = 0;
        };
        class BodyLabelRight: BodyLabelLeft {
            idc = IDC_SIDE_LABEL_RIGHT;
        };
    };
};
