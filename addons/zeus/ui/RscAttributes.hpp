class RscControlsGroup;
class RscControlsGroupNoScrollbars;
class RscText;
class RscListbox;
class RscCombo;
class RscEdit;
class RscXSliderH;
class RscCheckBox;
class RscActivePicture;
class RscMapControl;
class RscPicture;
class ctrlToolbox;
class RscButton;

class RscDisplayAttributes {
    class Controls {
        class Background;
        class Title;
        class Content: RscControlsGroup {
            class controls;
        };
        class ButtonOK;
        class ButtonCancel;
    };
};


class GVAR(RscChangeBloodType): RscDisplayAttributes {
    onLoad = QUOTE([ARR_3('onLoad',_this,QQGVAR(RscChangeBloodType))] call FUNC(zeusAttributes));
    onUnload = QUOTE([ARR_3('onUnload',_this,QQGVAR(RscChangeBloodType))] call FUNC(zeusAttributes));
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class changeBloodType: RscControlsGroupNoScrollbars {
                    onSetFocus = QUOTE(_this call FUNC(ui_changeBloodType));
                    idc = 26422;
                    x = 0;
                    y = 0;
                    w = QUOTE(W_PART(26));
                    h = QUOTE(H_PART(2.2));
                    class controls {
                        class Title1: RscText {
                            idc = -1;
                            text = CSTRING(ModuleManageAirway_bloodGroup);
                            toolTip = "";
                            x = 0;
                            y = 0;
                            w = QUOTE(W_PART(10));
                            h = QUOTE(H_PART(1));
                            colorBackground[] = {0,0,0,0.5};
                        };
                        class BloodType: RscCombo {
                            idc = 16107;
                            x = QUOTE(W_PART(10.1));
                            y = 0;
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
                            colorBackground[] = {0, 0, 0, 0.7};
                            class Items {
                                class BloodType_0 {
                                    text = "0+";
                                    default = 1;
                                };
                                class BloodType_0_N {
                                    text = "0-";
                                };
                                class BloodType_A {
                                    text = "A+";
                                };
                                class BloodType_A_N {
                                    text = "A-";
                                };
                                class BloodType_B {
                                    text = "B+";
                                };
                                class BloodType_B_N {
                                    text = "B-";
                                };
                                class BloodType_AB {
                                    text = "AB+";
                                };
                                class BloodType_AB_N {
                                    text = "AB-";
                                };
                            };
                        };
                        class Title6: Title1 {
                            idc = -1;
                            text = CSTRING(ModuleManageAirway_bloodVolume);
                            toolTip = "";
                            y = QUOTE(H_PART(1.1));
                        };
                        class BloodValue: RscXSliderH {
                            idc = 26423;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(1.1));
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
                        };
                    };
                };

            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};


class GVAR(RscManageAirway): RscDisplayAttributes {
    onLoad = QUOTE([ARR_3('onLoad',_this,QQGVAR(RscManageAirway))] call FUNC(zeusAttributes));
    onUnload = QUOTE([ARR_3('onUnload',_this,QQGVAR(RscManageAirway))] call FUNC(zeusAttributes));
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class manageAirway: RscControlsGroupNoScrollbars {
                    onSetFocus = QUOTE(_this call FUNC(ui_manageAirway));
                    idc = 26422;
                    x = 0;
                    y = 0;
                    w = QUOTE(W_PART(26));
                    h = QUOTE(H_PART(7.5));
                    class controls {
                        class Title1: RscText {
                            idc = -1;
                            text = CSTRING(ModuleManageAirway_Obstruction);
                            toolTip = "";
                            x = 0;
                            y = 0;
                            w = QUOTE(W_PART(10));
                            h = QUOTE(H_PART(1));
                            colorBackground[] = {0,0,0,0.5};
                        };
                        class Obstruction: RscCheckBox {
                            idc = 16101;
                            x = QUOTE(W_PART(10.1));
                            y = 0;
                            w = QUOTE(W_PART(1));
                            h = QUOTE(H_PART(1));
                        };
                        class Title2: Title1 {
                            text = CSTRING(ModuleManageAirway_Occlusion);
                            y = QUOTE(H_PART(1.1));
                        };
                        class Occlusion: Obstruction {
                            idc = 16102;
                            y = QUOTE(H_PART(1.1));
                        };
                        class Title3: Title1 {
                            text = CSTRING(ModuleManageAirway_Pneumothorax);
                            y = QUOTE(H_PART(2.2));
                        };
                        class PneumothoraxValue: RscXSliderH {
                            idc = 16105;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(2.2));
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
                        };
                        class Title4: Title1 {
                            text = CSTRING(ModuleManageAirway_PneumothoraxDeteriorate);
                            y = QUOTE(H_PART(3.3));
                        };
                        class PneumothoraxDeteriorate: Obstruction {
                            idc = 16107;
                            y = QUOTE(H_PART(3.3));
                        };
                        class Title5: Title1 {
                            text = CSTRING(ModuleManageAirway_Hemopneumothorax);
                            toolTip = "";
                            y = QUOTE(H_PART(4.4));
                        };
                        class Hemopneumothorax: Obstruction {
                            idc = 16103;
                            y = QUOTE(H_PART(4.4));
                        };
                        class Title6: Title1 {
                            text = CSTRING(ModuleManageAirway_Tensionpneumothorax);
                            y = QUOTE(H_PART(5.5));
                        };
                        class Tensionpneumothorax: Obstruction {
                            idc = 16104;
                            y = QUOTE(H_PART(5.5));
                        };
                        class Title7: Title1 {
                            text = CSTRING(ModuleManageAirway_SpO2Value);
                            y = QUOTE(H_PART(6.6));
                        };
                        class SpO2Value: RscXSliderH {
                            idc = 16106;
                            x = QUOTE(W_PART(10.1));
                            y = QUOTE(H_PART(6.6));
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
                        };
                    };
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};


class GVAR(RscCardiacStateModule): RscDisplayAttributes {
    onLoad = QUOTE([ARR_3('onLoad',_this,QQGVAR(RscCardiacStateModule))] call FUNC(zeusAttributes));
    onUnload = QUOTE([ARR_3('onUnload',_this,QQGVAR(RscCardiacStateModule))] call FUNC(zeusAttributes));
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class changeCardiacState: RscControlsGroupNoScrollbars {
                    onSetFocus = QUOTE(_this call FUNC(ui_changeCardiacState));
                    idc = 26424;
                    x = 0;
                    y = 0;
                    w = QUOTE(W_PART(26));
                    h = QUOTE(H_PART(1.1));
                    class controls {
                        class Title1: RscText {
                            idc = -1;
                            text = CSTRING(CardiacState_Module_State);
                            toolTip = "";
                            x = 0;
                            y = 0;
                            w = QUOTE(W_PART(10));
                            h = QUOTE(H_PART(1));
                            colorBackground[] = {0,0,0,0.5};
                        };
                        class CardiacState: RscCombo {
                            idc = 16112;
                            x = QUOTE(W_PART(10.1));
                            y = 0;
                            w = QUOTE(W_PART(15.9));
                            h = QUOTE(H_PART(1));
                            colorBackground[] = {0, 0, 0, 0.7};
                            class Items {
                                class None {
                                    text = "";
                                    default = 1;
                                };
                                class Asystole {
                                    text = CSTRING(CardiacState_Module_Asystole);
                                };
                                class PEA {
                                    text = CSTRING(CardiacState_Module_PEA);
                                };
                                class VF {
                                    text = CSTRING(CardiacState_Module_VF);
                                };
                                class VT {
                                    text = CSTRING(CardiacState_Module_VT);
                                };
                            };
                        };
                    };
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};
