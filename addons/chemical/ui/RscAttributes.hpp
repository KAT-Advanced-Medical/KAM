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

class GVAR(kat_RscAtributeRadius): RscControlsGroupNoScrollbars {
    onSetFocus = QUOTE(_this call FUNC(AttributeRadius));
    idc = 26422;
    x = 0;
    y = 0;
    w = "W_PART(26)";
    h = "H_PART(6.5)";
    class controls {
        class Title1: RscText {
            idc = 16109;
            text = CSTRING(UI_max_range);
            toolTip = CSTRING(GasModule_max_radius_dcs);
            x = 0;
            y = 0;
            w = "W_PART(10)";
            h = "H_PART(1)";
            colorBackground[] = {0,0,0,0.5};
        };
        class radius_max: RscEdit {
            idc = 1611;
            x = "W_PART(10.1)";
            y = 0;
            w = "W_PART(15.9)";
            h = "H_PART(1)";
        };
        class Title2: Title1 {
            idc = 16108;
            text = CSTRING(UI_min_range);
            toolTip = CSTRING(GasModule_min_radius_dcs);
            y = "H_PART(1.1)";
        };
        class radius_min: radius_max {
            idc = 1612;
            y = "H_PART(1.1)";
        };
        class Title3: Title1 {
            idc = 1614;
            text = CSTRING(UI_sealable);
            toolTip = "";
            y = "H_PART(2.2)";
        };
        class canSealed: RscCheckBox {
            idc = 1613;
            x = "W_PART(10.1)";
            y = "H_PART(2.2)";
            w = "W_PART(1)";
            h = "H_PART(1)";
        };
        class Title4: Title1 {
            idc = -1;
            text = CSTRING(UI_selectGas);
            toolTip = "";
            y = "H_PART(3.3)";
        };
        class gasType: RscCombo {
            idc = 1615;
            x = "W_PART(10.1)";
            y = "H_PART(3.3)";
            w = "W_PART(10)";
            h = "H_PART(1)";
            colorBackground[] = {0, 0, 0, 0.7};
            class Items {
                class type1 {
                    text = CSTRING(LvL1_Gas);
                    pricture = "";
                    default = 1;
                };
            };
        };
        class Title6: Title1 {
            idc = 1616;
            text = CSTRING(GasModule_createContaminatedZone);
            toolTip = "";
            y = "H_PART(4.4)";
            w = "W_PART(25)";
        };
        class Title5: Title1 {
            idc = -1;
            text = CSTRING(GasModule_placeModuleOnObject);
            toolTip = "";
            y = "H_PART(5.5)";
            w = "W_PART(25)";
        };
    };
};


class GVAR(kat_RscGasModul): RscDisplayAttributes {
    onLoad = QUOTE([ARR_3('onLoad', _this, QQGVAR(kat_RscGasModul))] call FUNC(zeusAttributes));
    onUnload = QUOTE([ARR_3('onUnload', _this, QQGVAR(kat_RscGasModul))] call FUNC(zeusAttributes));

    class Controls: Controls {
        class Background: Background {};
        class Title: Title {};
        class Content: Content {
            class Controls {
                class radius: GVAR(kat_RscAtributeRadius) {};
            };
        };
        class ButtonOK: ButtonOK {
            onSetFocus = QUOTE(_this call FUNC(ui_gasModul));
        };
        class ButtonCancel: ButtonCancel {};
    };
};
