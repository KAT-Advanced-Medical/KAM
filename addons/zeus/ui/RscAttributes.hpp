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
    onLoad = QUOTE([ARR_3('onLoad', _this, QQGVAR(RscChangeBloodType))] call FUNC(zeusAttributes));
    onUnload = QUOTE([ARR_3('onUnload', _this, QQGVAR(RscChangeBloodType))] call FUNC(zeusAttributes));
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
                    w = "W_PART(26)";
                    h = "H_PART(2.2)";
                    class controls {
                        class Title1: RscText {
                            idc = -1;
                            text = CSTRING(ModuleManageAirway_bloodGroup);
                            toolTip = "";
                            x = 0;
                            y = 0;
                            w = "W_PART(10)";
                            h = "H_PART(1)";
                            colorBackground[] = {0,0,0,0.5};
                        };
                        class BloodType: RscCombo {
                            idc = 16107;
                            x = "W_PART(10.1)";
                            y = 0;
                            w = "W_PART(15.9)";
                            h = "H_PART(1)";
                            colorBackground[] = {0, 0, 0, 0.7};
                            class Items {
                                class BloodType_0 {
                                    text = "O+";
                                    default = 1;
                                };
                                class BloodType_0_N {
                                    text = "O-";
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
                            y = "H_PART(1.1)";
                        };
                        class BloodValue: RscXSliderH {
                            idc = 26423;
                            x =" W_PART(10.1)";
                            y = "H_PART(1.1)";
                            w = "W_PART(15.9)";
                            h = "H_PART(1)";
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
    onLoad = QUOTE([ARR_3('onLoad', _this, QQGVAR(RscManageAirway))] call FUNC(zeusAttributes));
    onUnload = QUOTE([ARR_3('onUnload', _this, QQGVAR(RscManageAirway))] call FUNC(zeusAttributes));
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
                    w = "W_PART(26)";
                    h = "H_PART(6.5)";
                    class controls {
                        class Title1: RscText {
                            idc = -1;
                            text = CSTRING(ModuleManageAirway_Obstruction);
                            toolTip = "";
                            x = 0;
                            y = 0;
                            w = "W_PART(10)";
                            h = "H_PART(1)";
                            colorBackground[] = {0,0,0,0.5};
                        };
                        class Obstruction: RscCheckBox {
                            idc = 16101;
                            x = "W_PART(10.1)";
                            y = 0;
                            w = "W_PART(1)";
                            h = "H_PART(1)";
                        };
                        class Title2: Title1 {
                            idc = -1;
                            text = CSTRING(ModuleManageAirway_Occlusion);
                            toolTip = "";
                            y = "H_PART(1.1)";
                        };
                        class Occlusion: Obstruction {
                            idc = 16102;
                            y = "H_PART(1.1)";
                        };
                        class Title3: Title1 {
                            idc = -1;
                            text = CSTRING(ModuleManageAirway_Pneumothorax);
                            toolTip = "";
                            y = "H_PART(2.2)";
                        };
                        class Pneumothorax: Obstruction {
                            idc = 16103;
                            y = "H_PART(2.2)";
                        };
                        class Title4: Title1 {
                            idc = -1;
                            text = CSTRING(ModuleManageAirway_Hemopneumothorax);
                            toolTip = "";
                            y = "H_PART(3.3)";
                        };
                        class Hemopneumothorax: Obstruction {
                            idc = 16104;
                            y = "H_PART(3.3)";
                        };
                        class Title5: Title1 {
                            idc = -1;
                            text = CSTRING(ModuleManageAirway_Tensionpneumothorax);
                            toolTip = "";
                            y = "H_PART(4.4)";
                        };
                        class Tensionpneumothorax: Obstruction {
                            idc = 16105;
                            y = "H_PART(4.4)";
                        };
                        class Title6: Title1 {
                            idc = -1;
                            text = CSTRING(ModuleManageAirway_SpO2Value);
                            toolTip = "";
                            y = "H_PART(5.5)";
                        };
                        class SpO2Value: RscXSliderH {
                            idc = 16106;
                            x = "W_PART(10.1)";
                            y = "H_PART(5.5)";
                            w = "W_PART(15.9)";
                            h = "H_PART(1)";
                        };
                    };
                };
            };
        };
        class ButtonOK: ButtonOK {};
        class ButtonCancel: ButtonCancel {};
    };
};


class GVAR(RscAsystoleModule): RscDisplayAttributes {
    onLoad = QUOTE([ARR_3('onLoad', _this, QQGVAR(RscAsystoleModule))] call FUNC(zeusAttributes));
    onUnload = QUOTE([ARR_3('onUnload', _this, QQGVAR(RscAsystoleModule))] call FUNC(zeusAttributes));
    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class changeShockableState: RscControlsGroupNoScrollbars {
                    onSetFocus = QUOTE(_this call FUNC(ui_changeAsystole));
                    idc = 26424;
                    x = 0;
                    y = 0;
                    w = "W_PART(26)";
                    h = "H_PART(1.1)";
                    class controls {
                        class Title1: RscText {
                            idc = -1;
                            text = CSTRING(shockablestate_Module_state);
                            toolTip = "";
                            x = 0;
                            y = 0;
                            w = "W_PART(10)";
                            h = "H_PART(1)";
                            colorBackground[] = {0,0,0,0.5};
                        };
                        class ShockableState: RscCombo {
                            idc = 16112;
                            x = "W_PART(10.1)";
                            y = 0;
                            w = "W_PART(15.9)";
                            h = "H_PART(1)";
                            colorBackground[] = {0, 0, 0, 0.7};
                            class Items {
                                class none {
                                    text = "";
                                    default = 1;
                                };
                                class shockable {
                                    text = CSTRING(shockablestate_Module_shockable);
                                };
                                class non_shockable {
                                    text = CSTRING(shockablestate_Module_non_shockable);
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
