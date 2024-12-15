class RscText;
class RscStructuredText;
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
                show = 0;
            };
            class ABGTitle: IVFlowTitle {
                idc = IDC_ABG_TITLE; // LOOK HERE
                text = CSTRING(ABGTitle);
                x = QUOTE(POS_X(39.6));
                y = QUOTE(POS_Y(0));
                w = QUOTE(POS_W(9));
                h = QUOTE(POS_H(1));
                show = 0;
                class Attributes {
                    color = "#E5E5E5";
                    font = "RobotoCondensed";
                    shadow = "true";
                };
            };
            class AdditionalTitle: IVFlowTitle {
                idc = IDC_ADD_MENUS; // LOOK HERE
                text = "Additional Menus";
                x = QUOTE(POS_X(30.6));
                y = QUOTE(POS_Y(-1));
                w = QUOTE(POS_W(5.5));
                h = QUOTE(POS_H(1));
                colorBackground[] = GUI_BCG_COLOR; // LOOK HERE
                show = 1;
                class Attributes {
                    color = "#E5E5E5";
                    font = "RobotoCondensed";
                    shadow = "true";
                };
            };
    };
    class controls {
            class IVbutton: RscButton {
                idc = IDC_IV_FLOW_SHOWBUTTON; // LOOK HERE
                onButtonClick = QUOTE([ARR_2(ACEGVAR(medical_gui,target),1)] call FUNC(handleIVShow));
                text = "IV Flow Control";
                x = QUOTE(POS_X(28.7));
                y = QUOTE(POS_Y(0));
                w = QUOTE(POS_W(4.4));
                h = QUOTE(POS_H(1));
                show = 0;
                colorBackground[] = {0, 0, 0, 0};
                colorBackgroundActive[] = {1, 1, 1, 0.4};
                colorBackgroundDisabled[] = {0, 0, 0, 0};
                colorBorder[] = {0,0,0,0};
                class Attributes {
                    color = "#E5E5E5";
                    font = "RobotoCondensed";
                    shadow = "true";
                };
            };
            class HeadCover: RscStructuredText  {
                idc = IDC_IV_FLOW_HEADCOVER; // LOOK HERE
                text = CSTRING(HeadCover);
                x = QUOTE(POS_X(-8));
                y = QUOTE(POS_Y(2.3));
                w = QUOTE(POS_W(8));
                h = QUOTE(POS_H(1.3));
                colorBackground[] = {0, 0, 0, 0.5};
                show = 0;
                class Attributes {
                    align = "center";
                    valign = "bottom";
                    color = "#E5E5E5";
                    font = "RobotoCondensed";
                    shadow = "false";
                };
            };
            class HeadTitle: RscStructuredText  {
                idc = IDC_IV_FLOW_HEADTITLE; // LOOK HERE
                text = CSTRING(HeadTitle);
                x = QUOTE(POS_X(-6.6));
                y = QUOTE(POS_Y(1.5));
                w = QUOTE(POS_W(2.2));
                h = QUOTE(POS_H(0.8));
                colorBackground[] = {0, 0, 0, 0};
                show = 0;
                class Attributes {
                    align = "center";
                    color = "#E5E5E5";
                    font = "RobotoCondensed";
                    shadow = "false";
                    size = 0.9;
                };
            };
            class HeadType: RscStructuredText  {
                idc = IDC_IV_FLOW_HEADTYPE; // LOOK HERE
                x = QUOTE(POS_X(-3.6));
                y = QUOTE(POS_Y(1.5));
                w = QUOTE(POS_W(2));
                h = QUOTE(POS_H(0.8));
                colorBackground[] = {0, 0, 0, 0};
                show = 0;
                class Attributes {
                    align = "center";
                    color = "#E5E5E5";
                    font = "RobotoCondensed";
                    shadow = "false";
                    size = 0.9;
                };
            };
            class HeadSubtractFull: RscButton {
                idc = IDC_IV_FLOW_HEADSUBTRACTFULL; // LOOK HERE
                onButtonClick = QUOTE([ARR_3(ACEGVAR(medical_gui,target),0,-0.5)] call FUNC(handleIVAdjust));
                text = "<<";
                x = QUOTE(POS_X(-7.5));
                y = QUOTE(POS_Y(2.5));
                w = QUOTE(POS_W(1));
                h = QUOTE(POS_H(1));
                show = 0;
                colorBackground[] = {0, 0, 0, 0.7};
                colorBackgroundActive[] = {1, 1, 1, 1};
                colorBackgroundDisabled[] = {0, 0, 0, 0.7};
                colorBorder[] = {0,0,0,0};
                class Attributes {
                    color = "#E5E5E5";
                    font = "RobotoCondensed";
                    shadow = "false";
                };
            };
            class HeadSubtract: RscButton {
                idc = IDC_IV_FLOW_HEADSUBTRACT; // LOOK HERE
                onButtonClick = QUOTE([ARR_3(ACEGVAR(medical_gui,target),0,-0.1)] call FUNC(handleIVAdjust));
                text = "<";
                x = QUOTE(POS_X(-6));
                y = QUOTE(POS_Y(2.5));
                w = QUOTE(POS_W(1));
                h = QUOTE(POS_H(1));
                show = 0;
                colorBackground[] = {0, 0, 0, 0.7};
                colorBackgroundActive[] = {1, 1, 1, 1};
                colorBackgroundDisabled[] = {0, 0, 0, 0.7};
                colorBorder[] = {0,0,0,0};
                class Attributes {
                    color = "#E5E5E5";
                    font = "RobotoCondensed";
                    shadow = "false";
                };
            };
            class HeadIVValue: RscStructuredText {
                idc = IDC_IV_FLOW_HEADIV_VALUE; // LOOK HERE
                text = CSTRING(IVValue);
                x = QUOTE(POS_X(-5));
                y = QUOTE(POS_Y(2.5));
                w = QUOTE(POS_W(2));
                h = QUOTE(POS_H(1));
                colorBackground[] = {0, 0, 0, 0.2};
                show = 0;
                class Attributes {
                    align = "center";
                    color = "#E5E5E5";
                    font = "RobotoCondensed";
                    shadow = "false";
                    size = 1;
                };
            };
            class HeadAdd: RscButton {
                idc = IDC_IV_FLOW_HEADADD; // LOOK HERE
                onButtonClick = QUOTE([ARR_3(ACEGVAR(medical_gui,target),0,0.1)] call FUNC(handleIVAdjust));
                text = ">";
                x = QUOTE(POS_X(-3));
                y = QUOTE(POS_Y(2.5));
                w = QUOTE(POS_W(1));
                h = QUOTE(POS_H(1));
                show = 0;
                colorBackground[] = {0, 0, 0, 0.7};
                colorBackgroundActive[] = {1, 1, 1, 1};
                colorBackgroundDisabled[] = {0, 0, 0, 0.7};
                colorBorder[] = {0,0,0,0};
                class Attributes {
                    color = "#E5E5E5";
                    font = "RobotoCondensed";
                    shadow = "false";
                };
            };
            class HeadAddFull: RscButton {
                idc = IDC_IV_FLOW_HEADADDFULL; // LOOK HERE
                onButtonClick = QUOTE([ARR_3(ACEGVAR(medical_gui,target),0,0.5)] call FUNC(handleIVAdjust));
                text = ">>";
                x = QUOTE(POS_X(-1.5));
                y = QUOTE(POS_Y(2.5));
                w = QUOTE(POS_W(1));
                h = QUOTE(POS_H(1));
                show = 0;
                colorBackground[] = {0, 0, 0, 0.7};
                colorBackgroundActive[] = {1, 1, 1, 1};
                colorBackgroundDisabled[] = {0, 0, 0, 0.7};
                colorBorder[] = {0,0,0,0};
                class Attributes {
                    color = "#E5E5E5";
                    font = "RobotoCondensed";
                    shadow = "false";
                };
            };
        
            class ChestCover: HeadCover {
                idc = IDC_IV_FLOW_CHESTCOVER;
                text = CSTRING(ChestCover); // LOOK HERE
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
                onButtonClick = QUOTE([ARR_3(ACEGVAR(medical_gui,target),1,-0.5)] call FUNC(handleIVAdjust));
                y = QUOTE(POS_Y(5));
            };
            class ChestSubtract: HeadSubtract {
                idc = IDC_IV_FLOW_CHESTSUBTRACT; // LOOK HERE
                onButtonClick = QUOTE([ARR_3(ACEGVAR(medical_gui,target),1,-0.1)] call FUNC(handleIVAdjust));
                y = QUOTE(POS_Y(5));
            };
            class ChestIVValue: HeadIVValue {
                idc = IDC_IV_FLOW_CHESTTEST; // LOOK HERE
                y = QUOTE(POS_Y(5));
            };
            class ChestAdd: HeadAdd {
                idc = IDC_IV_FLOW_CHESTADD; // LOOK HERE
                onButtonClick = QUOTE([ARR_3(ACEGVAR(medical_gui,target),1,0.1)] call FUNC(handleIVAdjust));
                y = QUOTE(POS_Y(5));
            };
            class ChestAddFull: HeadAddFull {
                idc = IDC_IV_FLOW_CHESTADDFULL; // LOOK HERE
                onButtonClick = QUOTE([ARR_3(ACEGVAR(medical_gui,target),1,0.5)] call FUNC(handleIVAdjust));
                y = QUOTE(POS_Y(5));
            };

            class LArmCover: HeadCover {
                idc = IDC_IV_FLOW_LARMCOVER; // LOOK HERE
                text = CSTRING(LArmCover);
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
                onButtonClick = QUOTE([ARR_3(ACEGVAR(medical_gui,target),2,-0.5)] call FUNC(handleIVAdjust));
                y = QUOTE(POS_Y(7.6));
            };
            class LArmSubtract: HeadSubtract {
                idc = IDC_IV_FLOW_LARMSUBTRACT; // LOOK HERE
                onButtonClick = QUOTE([ARR_3(ACEGVAR(medical_gui,target),2,-0.1)] call FUNC(handleIVAdjust));
                y = QUOTE(POS_Y(7.6));
            };
            class LArmIVValue: HeadIVValue {
                idc = IDC_IV_FLOW_LARMIVVALUE; // LOOK HERE
                y = QUOTE(POS_Y(7.6));
            };
            class LArmAdd: HeadAdd {
                idc = IDC_IV_FLOW_LARMADD; // LOOK HERE
                onButtonClick = QUOTE([ARR_3(ACEGVAR(medical_gui,target),2,0.1)] call FUNC(handleIVAdjust));
                y = QUOTE(POS_Y(7.6));
            };
            class LArmAddFull: HeadAddFull {
                idc = IDC_IV_FLOW_LARMADDFULL; // LOOK HERE
                onButtonClick = QUOTE([ARR_3(ACEGVAR(medical_gui,target),2,0.5)] call FUNC(handleIVAdjust));
                y = QUOTE(POS_Y(7.6));
            };

            class RArmCover: HeadCover {
                idc = IDC_IV_FLOW_RARMCOVER; // LOOK HERE
                text = CSTRING(RArmCover);
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
                onButtonClick = QUOTE([ARR_3(ACEGVAR(medical_gui,target),3,-0.5)] call FUNC(handleIVAdjust));
                y = QUOTE(POS_Y(10.3));
            };
            class RArmSubtract: HeadSubtract {
                idc = IDC_IV_FLOW_RARMSUBTRACT; // LOOK HERE
                onButtonClick = QUOTE([ARR_3(ACEGVAR(medical_gui,target),3,-0.1)] call FUNC(handleIVAdjust));
                y = QUOTE(POS_Y(10.3));
            };
            class RArmIVValue: HeadIVValue {
                idc = IDC_IV_FLOW_RARMIVVALUE; // LOOK HERE
                y = QUOTE(POS_Y(10.3));
            };
            class RArmAdd: HeadAdd {
                idc = IDC_IV_FLOW_RARMADD; // LOOK HERE
                onButtonClick = QUOTE([ARR_3(ACEGVAR(medical_gui,target),3,0.1)] call FUNC(handleIVAdjust));
                y = QUOTE(POS_Y(10.3));
            };
            class RArmAddFull: HeadAddFull {
                idc = IDC_IV_FLOW_RARMADDFULL; // LOOK HERE
                onButtonClick = QUOTE([ARR_3(ACEGVAR(medical_gui,target),3,0.5)] call FUNC(handleIVAdjust));
                y = QUOTE(POS_Y(10.3));
            };

            class LLegCover: HeadCover {
                idc = IDC_IV_FLOW_LLEGCOVER; // LOOK HERE
                text = CSTRING(LLegCover);
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
                onButtonClick = QUOTE([ARR_3(ACEGVAR(medical_gui,target),4,-0.5)] call FUNC(handleIVAdjust));
                y = QUOTE(POS_Y(12.9));
            };
            class LLegSubtract: HeadSubtract {
                idc = IDC_IV_FLOW_LLEGSUBTRACT; // LOOK HERE
                onButtonClick = QUOTE([ARR_3(ACEGVAR(medical_gui,target),4,-0.1)] call FUNC(handleIVAdjust));
                y = QUOTE(POS_Y(12.9));
            };
            class LLegIVValue: HeadIVValue {
                idc = IDC_IV_FLOW_LLEGIVVALUE; // LOOK HERE
                y = QUOTE(POS_Y(12.9));
            };
            class LLegAdd: HeadAdd {
                idc = IDC_IV_FLOW_LLEGADD; // LOOK HERE
                onButtonClick = QUOTE([ARR_3(ACEGVAR(medical_gui,target),4,0.1)] call FUNC(handleIVAdjust));
                y = QUOTE(POS_Y(12.9));
            };
            class LLegAddFull: HeadAddFull {
                idc = IDC_IV_FLOW_LLEGADDFULL; // LOOK HERE
                onButtonClick = QUOTE([ARR_3(ACEGVAR(medical_gui,target),4,0.5)] call FUNC(handleIVAdjust));
                y = QUOTE(POS_Y(12.9));
            };

            class RLegCover: HeadCover {
                idc = IDC_IV_FLOW_RLEGCOVER; // LOOK HERE
                text = CSTRING(RLegCover);
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
                onButtonClick = QUOTE([ARR_3(ACEGVAR(medical_gui,target),5,-0.5)] call FUNC(handleIVAdjust));
                y = QUOTE(POS_Y(15.5));
            };
            class RLegSubtract: HeadSubtract {
                idc = IDC_IV_FLOW_RLEGSUBTRACT; // LOOK HERE
                onButtonClick = QUOTE([ARR_3(ACEGVAR(medical_gui,target),5,-0.1)] call FUNC(handleIVAdjust));
                y = QUOTE(POS_Y(15.5));
            };
            class RLegIVValue: HeadIVValue {
                idc = IDC_IV_FLOW_RLEGIVVALUE; // LOOK HERE
                y = QUOTE(POS_Y(15.5));
            };
            class RLegAdd: HeadAdd {
                idc = IDC_IV_FLOW_RLEGADD; // LOOK HERE
                onButtonClick = QUOTE([ARR_3(ACEGVAR(medical_gui,target),5,0.1)] call FUNC(handleIVAdjust));
                y = QUOTE(POS_Y(15.5));
            };
            class RLegAddFull: HeadAddFull {
                idc = IDC_IV_FLOW_RLEGADDFULL; // LOOK HERE
                onButtonClick = QUOTE([ARR_3(ACEGVAR(medical_gui,target),5,0.5)] call FUNC(handleIVAdjust));
                y = QUOTE(POS_Y(15.5));
            };

            class ABGbutton: RscButton
            {
                idc = IDC_TEST_SHOWBUTTON;
                onButtonClick = QUOTE([ARR_2(ACEGVAR(medical_gui,target),1)] call FUNC(handleABGShow));
                text = "ABG Results";
                x = QUOTE(POS_X(33.8));
                y = QUOTE(POS_Y(0));
                w = QUOTE(POS_W(4.2));
                h = QUOTE(POS_H(1));
                show = 0;
                colorBackground[] = {0, 0, 0, 0};
                colorBackgroundActive[] = {1, 1, 1, 0.4};
                colorBackgroundDisabled[] = {0, 0, 0, 0};
                colorBorder[] = {0,0,0,0};
                class Attributes {
                    color = "#E5E5E5";
                    font = "RobotoCondensed";
                    shadow = "true";
                };
            };
            class PaCO2_Output: RscStructuredText {
                idc = IDC_TEST_PACO2; // LOOK HERE
                text = CSTRING(BGBlank);
                x = QUOTE(POS_X(40));
                y = QUOTE(POS_Y(1.5));
                w = QUOTE(POS_W(2.2));
                h = QUOTE(POS_H(1));
                colorBackground[] = {0, 0, 0, 0.5};
                show = 0;
                class Attributes {
                    align = "center";
                    color = "#E5E5E5";
                    font = "RobotoCondensed";
                    shadow = "false";
                    size = 1;
                };
            };
            class PaO2_Output: PaCO2_Output {
                idc = IDC_TEST_PAO2; // LOOK HERE
                x = QUOTE(POS_X(43));
            };
            class SpO2_Output: PaCO2_Output {
                idc = IDC_TEST_SPO2; // LOOK HERE
                x = QUOTE(POS_X(46));
            };
            class HCO3_Output: RscStructuredText {
                idc = IDC_TEST_HCO3; // LOOK HERE
                text = CSTRING(BGBlank);
                x = QUOTE(POS_X(40));
                y = QUOTE(POS_Y(3));
                w = QUOTE(POS_W(2.2));
                h = QUOTE(POS_H(1));
                colorBackground[] = {0, 0, 0, 0.5};
                show = 0;
                class Attributes {
                    align = "center";
                    color = "#E5E5E5";
                    font = "RobotoCondensed";
                    shadow = "false";
                    size = 1;
                };
            };
            class PH_Output: HCO3_Output {
                idc = IDC_TEST_PH; // LOOK HERE
                x = QUOTE(POS_X(43));
            };
            class Test_Reset: RscButton {
                idc = IDC_TEST_RESET; // LOOK HERE
                onButtonClick = QUOTE([ACEGVAR(medical_gui,target)] call FUNC(dumpBloodGas));
                text = CSTRING(TestReset);
                x = QUOTE(POS_X(46));
                y = QUOTE(POS_Y(3));
                w = QUOTE(POS_W(2.1));
                h = QUOTE(POS_H(1));
                colorText[] = {1, 1, 1, 0.9};
                colorActive[] = {0, 0, 0, 0.7};
                colorBackground[] = {0, 0, 0, 0.7};
                colorBackgroundActive[] = {1, 1, 1, 1};
                colorBorder[] = {0,0,0,0};
                show = 0;
                class Attributes {
                    align = "center";
                    font = "RobotoCondensed";
                    shadow = "false";
                };
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
