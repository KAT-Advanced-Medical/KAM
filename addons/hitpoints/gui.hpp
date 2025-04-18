class RscText;
class RscButton;
class RscPicture;
class RscListBox;
class RscActivePicture;
class RscButtonMenu;
class RscControlsGroup;
class RscControlsGroupNoScrollbars;

class ACEGVAR(medical_gui,BodyImage): RscControlsGroupNoScrollbars {
    class controls {
        class Background: RscPicture {
            idc = -1;
            text = QPATHTOF(data\body_image\background.paa);
            x = 0;
            y = 0;
            w = QUOTE(POS_W(12.33));
            h = QUOTE(POS_H(12.33));
        };
        class Head: Background {
            idc = IDC_BODY_HEAD;
            text = QPATHTOF(data\body_image\head.paa);
        };
        class Neck: Background {
            idc = IDC_BODY_NECK;
            text = QPATHTOF(data\body_image\neck.paa);
        };
        class Chest: Background {
            idc = IDC_BODY_CHEST;
            text = QPATHTOF(data\body_image\chest.paa);
        };
        class Torso: Background {
            idc = IDC_BODY_TORSO;
            text = QPATHTOF(data\body_image\torso.paa);
        };
        class ArmLeft: Background {
            idc = IDC_BODY_ARMLEFT;
            text = QPATHTOF(data\body_image\arm_left.paa);
        };
        class ArmUpperLeft: Background {
            idc = IDC_BODY_ARMUPPERLEFT;
            text = QPATHTOF(data\body_image\arm_upper_left.paa);
        };
        class ArmRight: Background {
            idc = IDC_BODY_ARMRIGHT;
            text = QPATHTOF(data\body_image\arm_right.paa);
        };
        class ArmUpperRight: Background {
            idc = IDC_BODY_ARMUPPERRIGHT;
            text = QPATHTOF(data\body_image\arm_upper_right.paa);
        };
        class LegLeft: Background {
            idc = IDC_BODY_LEGLEFT;
            text = QPATHTOF(data\body_image\leg_left.paa);
        };
        class LegUpperLeft: Background {
            idc = IDC_BODY_LEGUPPERLEFT;
            text = QPATHTOF(data\body_image\leg_upper_left.paa);
        };
        class LegRight: Background {
            idc = IDC_BODY_LEGRIGHT;
            text = QPATHTOF(data\body_image\leg_right.paa);
        };
        class LegUpperRight: Background {
            idc = IDC_BODY_LEGUPPERRIGHT;
            text = QPATHTOF(data\body_image\leg_upper_right.paa);
        };
        class ArmLeftB: Background {
            idc = IDC_BODY_ARMLEFT_B;
            text = QPATHTOF(data\body_image\arm_left_b.paa);
            colorText[] = {0, 0, 0.8, 1};
            show = 0;
        };
        class ArmUpperLeftB: ArmLeftB {
            idc = IDC_BODY_ARMUPPERLEFT_B;
            text = QPATHTOF(data\body_image\arm_upper_left_b.paa);
        };
        class ArmRightB: ArmLeftB {
            idc = IDC_BODY_ARMRIGHT_B;
            text = QPATHTOF(data\body_image\arm_right_b.paa);
        };
        class ArmUpperRightB: ArmLeftB {
            idc = IDC_BODY_ARMUPPERRIGHT_B;
            text = QPATHTOF(data\body_image\arm_upper_right_b.paa);
        };
        class LegLeftB: ArmLeftB {
            idc = IDC_BODY_LEGLEFT_B;
            text = QPATHTOF(data\body_image\leg_left_b.paa);
        };
        class LegUpperLeftB: ArmLeftB {
            idc = IDC_BODY_LEGUPPERLEFT_B;
            text = QPATHTOF(data\body_image\leg_upper_left_b.paa);
        };
        class LegRightB: ArmLeftB {
            idc = IDC_BODY_LEGRIGHT_B;
            text = QPATHTOF(data\body_image\leg_right_b.paa);
        };
        class LegUpperRightB: ArmLeftB {
            idc = IDC_BODY_LEGUPPERRIGHT_B;
            text = QPATHTOF(data\body_image\leg_upper_right_b.paa);
        };
        class ArmLeftT: Background {
            idc = IDC_BODY_ARMLEFT_T;
            text = QPATHTOF(data\body_image\arm_lower_left_t.paa);
            colorText[] = {0, 0, 0.8, 1};
            show = 0;
        };
        class ArmRightT: ArmLeftT {
            idc = IDC_BODY_ARMRIGHT_T;
            text = QPATHTOF(data\body_image\arm_lower_right_t.paa);
        };
        class LegLeftT: ArmLeftT {
            idc = IDC_BODY_LEGLEFT_T;
            text = QPATHTOF(data\body_image\leg_lower_left_t.paa);
        };
        class LegRightT: ArmLeftT {
            idc = IDC_BODY_LEGRIGHT_T;
            text = QPATHTOF(data\body_image\leg_lower_right_t.paa);
        };
        class ArmUpperLeftT: ArmLeftT {
            idc = IDC_BODY_ARMUPPERLEFT_T;
            text = QPATHTOF(data\body_image\arm_left_t.paa);
        };
        class ArmUpperRightT: ArmLeftT {
            idc = IDC_BODY_ARMUPPERRIGHT_T;
            text = QPATHTOF(data\body_image\arm_right_t.paa);
        };
        class LegUpperLeftT: ArmLeftT {
            idc = IDC_BODY_LEGUPPERLEFT_T;
            text = QPATHTOF(data\body_image\leg_left_t.paa);
        };
        class LegUpperRightT: ArmLeftT {
            idc = IDC_BODY_LEGUPPERRIGHT_T;
            text = QPATHTOF(data\body_image\leg_right_t.paa);
        };
        class HeadS: Background {
            idc = IDC_BODY_HEAD_S;
            text = QPATHTOF(data\body_image\head_s.paa);
            colorText[] = {1.0, 1.0, 1.0, 1.0};
            show = 0;
        };
        class NeckS: Background {
            idc = IDC_BODY_NECK_S;
            text = QPATHTOF(data\body_image\neck_s.paa);
            colorText[] = {1.0, 1.0, 1.0, 1.0};
            show = 0;
        };
        class ChestS: HeadS {
            idc = IDC_BODY_CHEST_S;
            text = QPATHTOF(data\body_image\chest_s.paa);
        };
        class TorsoS: HeadS {
            idc = IDC_BODY_TORSO_S;
            text = QPATHTOF(data\body_image\torso_s.paa);
        };
        class ArmLeftS: HeadS {
            idc = IDC_BODY_ARMLEFT_S;
            text = QPATHTOF(data\body_image\arm_left_s.paa);
        };
        class ArmRightS: HeadS {
            idc = IDC_BODY_ARMRIGHT_S;
            text = QPATHTOF(data\body_image\arm_right_s.paa);
        };
        class LegLeftS: HeadS {
            idc = IDC_BODY_LEGLEFT_S;
            text = QPATHTOF(data\body_image\leg_left_s.paa);
        };
        class LegRightS: HeadS {
            idc = IDC_BODY_LEGRIGHT_S;
            text = QPATHTOF(data\body_image\leg_right_s.paa);
        };
        class ArmUpperLeftS: HeadS {
            idc = IDC_BODY_ARMUPPERLEFT_S;
            text = QPATHTOF(data\body_image\arm_upper_left_s.paa);
        };
        class ArmUpperRightS: HeadS {
            idc = IDC_BODY_ARMUPPERRIGHT_S;
            text = QPATHTOF(data\body_image\arm_upper_right_s.paa);
        };
        class LegUpperLeftS: HeadS {
            idc = IDC_BODY_LEGUPPERLEFT_S;
            text = QPATHTOF(data\body_image\leg_upper_left_s.paa);
        };
        class LegUpperRightS: HeadS {
            idc = IDC_BODY_LEGUPPERRIGHT_S;
            text = QPATHTOF(data\body_image\leg_upper_right_s.paa);
        };
    };
};

class ACE_Medical_Menu {
    class controls {
        class SelectHead: RscButton {
            idc = -1;
            onButtonClick = QUOTE(ACEGVAR(medical_gui,selectedBodyPart) = 0);
            tooltip = CSTRING(SelectHead);
            x = QUOTE(POS_X(19.3));
            y = QUOTE(POS_Y(3.2));
            w = QUOTE(POS_W(1.4));
            h = QUOTE(POS_H(1.2));
            colorFocused[] = {0, 0, 0, 0};
            colorBackground[] = {0, 0, 0, 0};
            colorBackgroundActive[] = {0, 0, 0, 0};
        };
        class SelectNeck: RscButton {
            idc = -1;
            onButtonClick = QUOTE(ACEGVAR(medical_gui,selectedBodyPart) = 1);
            tooltip = CSTRING(SelectNeck);
            x = QUOTE(POS_X(19.3));
            y = QUOTE(POS_Y(4.4));
            w = QUOTE(POS_W(1.4));
            h = QUOTE(POS_H(0.6));
            colorFocused[] = {0, 0, 0, 0};
            colorBackground[] = {0, 0, 0, 0};
            colorBackgroundActive[] = {0, 0, 0, 0};
        };
        class SelectChest: SelectHead {
            onButtonClick = QUOTE(ACEGVAR(medical_gui,selectedBodyPart) = 2);
            tooltip = CSTRING(SelectChest);
            x = QUOTE(POS_X(18.9));
            y = QUOTE(POS_Y(5));
            w = QUOTE(POS_W(2.2));
            h = QUOTE(POS_H(1.9));
        };
        class SelectTorso: SelectHead {
            onButtonClick = QUOTE(ACEGVAR(medical_gui,selectedBodyPart) = 3);
            tooltip = CSTRING(SelectTorso);
            x = QUOTE(POS_X(18.9));
            y = QUOTE(POS_Y(6.9));
            w = QUOTE(POS_W(2.2));
            h = QUOTE(POS_H(1.9));
        };
        class SelectUpperArmLeft: SelectHead {
            onButtonClick = QUOTE(ACEGVAR(medical_gui,selectedBodyPart) = 4);
            tooltip = CSTRING(SelectLeftArm);
            x = QUOTE(POS_X(21.1));
            y = QUOTE(POS_Y(7.4));
            w = QUOTE(POS_W(1.1));
            h = QUOTE(POS_H(2.3));
        };
        class SelectArmLeft: SelectUpperArmLeft {
            onButtonClick = QUOTE(ACEGVAR(medical_gui,selectedBodyPart) = 5);
            tooltip = CSTRING(SelectUpperLeftArm);
            x = QUOTE(POS_X(21.1));
            y = QUOTE(POS_Y(5.1));
            w = QUOTE(POS_W(1.1));
            h = QUOTE(POS_H(2.3));
        };
        class SelectUpperArmRight: SelectUpperArmLeft {
            onButtonClick = QUOTE(ACEGVAR(medical_gui,selectedBodyPart) = 6);
            tooltip = CSTRING(SelectRightArm);
            x = QUOTE(POS_X(17.8));
            y = QUOTE(POS_Y(7.4));
            w = QUOTE(POS_W(1.1));
            h = QUOTE(POS_H(2.3));
        };
        class SelectArmRight: SelectUpperArmRight {
            onButtonClick = QUOTE(ACEGVAR(medical_gui,selectedBodyPart) = 7);
            tooltip = CSTRING(SelectRightUpperArm);
            x = QUOTE(POS_X(17.8));
            y = QUOTE(POS_Y(5.1));
            w = QUOTE(POS_W(1.1));
            h = QUOTE(POS_H(2.3));
        };
        class SelectUpperLegLeft: SelectHead {
            onButtonClick = QUOTE(ACEGVAR(medical_gui,selectedBodyPart) = 8);
            tooltip = CSTRING(SelectLeftLeg);
            x = QUOTE(POS_X(20.0));
            y = QUOTE(POS_Y(11.7));
            w = QUOTE(POS_W(1.1));
            h = QUOTE(POS_H(2.4));
        };
        class SelectLegLeft: SelectUpperLegLeft {
            onButtonClick = QUOTE(ACEGVAR(medical_gui,selectedBodyPart) = 9);
            tooltip = CSTRING(SelectLeftUpperLeg);
            x = QUOTE(POS_X(20.0));
            y = QUOTE(POS_Y(8.4));
            w = QUOTE(POS_W(1.1));
            h = QUOTE(POS_H(3.3));
        };
        class SelectUpperLegRight: SelectHead {
            onButtonClick = QUOTE(ACEGVAR(medical_gui,selectedBodyPart) = 10);
            tooltip = CSTRING(SelectRightLeg);
            x = QUOTE(POS_X(18.9));
            y = QUOTE(POS_Y(11.7));
            w = QUOTE(POS_W(1.1));
            h = QUOTE(POS_H(2.4));
        };
        class SelectLegRight: SelectUpperLegRight {
            onButtonClick = QUOTE(ACEGVAR(medical_gui,selectedBodyPart) = 11);
            tooltip = CSTRING(SelectRightUpperLeg);
            x = QUOTE(POS_X(18.9));
            y = QUOTE(POS_Y(8.8));
            w = QUOTE(POS_W(1.1));
            h = QUOTE(POS_H(3.3));
        };
    };
};

class RscTitles {
    class ACEGVAR(medical_gui,RscPatientInfo) {
        class controls {
            class PatientInfoContainer: RscControlsGroupNoScrollbars {
                class controls {
                    class BodyImage: ACEGVAR(medical_gui,BodyImage) {
                        x = QUOTE(POS_W(2.25));
                        y = QUOTE(POS_H(1.5));
                        w = QUOTE(POS_W(8.5));
                        h = QUOTE(POS_H(8.5));
                        class controls: controls {
                            class Background: Background {
                                w = QUOTE(POS_W(8.5));
                                h = QUOTE(POS_H(8.5));
                            };
                            class Head: Head {
                                w = QUOTE(POS_W(8.5));
                                h = QUOTE(POS_H(8.5));
                            };
                            class Torso: Torso {
                                w = QUOTE(POS_W(8.5));
                                h = QUOTE(POS_H(8.5));
                            };
                            class ArmLeft: ArmLeft {
                                w = QUOTE(POS_W(8.5));
                                h = QUOTE(POS_H(8.5));
                            };
                            class ArmRight: ArmRight {
                                w = QUOTE(POS_W(8.5));
                                h = QUOTE(POS_H(8.5));
                            };
                            class LegLeft: LegLeft {
                                w = QUOTE(POS_W(8.5));
                                h = QUOTE(POS_H(8.5));
                            };
                            class LegRight: LegRight {
                                w = QUOTE(POS_W(8.5));
                                h = QUOTE(POS_H(8.5));
                            };
                            class ArmLeftB: ArmLeftB {
                                w = QUOTE(POS_W(8.5));
                                h = QUOTE(POS_H(8.5));
                            };
                            class ArmRightB: ArmRightB {
                                w = QUOTE(POS_W(8.5));
                                h = QUOTE(POS_H(8.5));
                            };
                            class LegLeftB: LegLeftB {
                                w = QUOTE(POS_W(8.5));
                                h = QUOTE(POS_H(8.5));
                            };
                            class LegRightB: LegRightB {
                                w = QUOTE(POS_W(8.5));
                                h = QUOTE(POS_H(8.5));
                            };
                            class ArmLeftT: ArmLeftT {
                                w = QUOTE(POS_W(8.5));
                                h = QUOTE(POS_H(8.5));
                            };
                            class ArmRightT: ArmRightT {
                                w = QUOTE(POS_W(8.5));
                                h = QUOTE(POS_H(8.5));
                            };
                            class LegLeftT: LegLeftT {
                                w = QUOTE(POS_W(8.5));
                                h = QUOTE(POS_H(8.5));
                            };
                            class LegRightT: LegRightT {
                                w = QUOTE(POS_W(8.5));
                                h = QUOTE(POS_H(8.5));
                            };
                            class HeadS: HeadS {
                                w = QUOTE(POS_W(8.5));
                                h = QUOTE(POS_H(8.5));
                            };
                            class TorsoS: TorsoS {
                                w = QUOTE(POS_W(8.5));
                                h = QUOTE(POS_H(8.5));
                            };
                            class ArmLeftS: ArmLeftS {
                                w = QUOTE(POS_W(8.5));
                                h = QUOTE(POS_H(8.5));
                            };
                            class ArmRightS: ArmRightS {
                                w = QUOTE(POS_W(8.5));
                                h = QUOTE(POS_H(8.5));
                            };
                            class LegLeftS: LegLeftS {
                                w = QUOTE(POS_W(8.5));
                                h = QUOTE(POS_H(8.5));
                            };
                            class LegRightS: LegRightS {
                                w = QUOTE(POS_W(8.5));
                                h = QUOTE(POS_H(8.5));
                            };
                        };
                    };
                };
            };
        };
    };
};
