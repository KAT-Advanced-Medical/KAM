class CfgFunctions {
    class overwrite_ace_medical_damage {
        tag = "ace_medical_damage";
        class ace_medical_damage {
            class determineIfFatal {
                file = QPATHTOF(functions\fnc_determineIfFatal.sqf);
            };
            class handleIncapacitation {
                file = QPATHTOF(functions\fnc_handleIncapacitation.sqf);
            };
            class woundsHandlerBase {
                file = QPATHTOF(functions\fnc_woundsHandlerBase.sqf);
            };
            class woundsHandlerVehiclehit {
                file = QPATHTOF(functions\fnc_woundsHandlerVehiclehit.sqf);
            };
            class woundsHandlerBurning {
                file = QPATHTOF(functions\fnc_woundsHandlerBurning.sqf);
            };
        };
    };
    class overwrite_ace_medical_engine {
        tag = "ace_medical_engine";
        class ace_medical_engine {
            class handleDamage {
                file = QPATHTOF(functions\fnc_handleDamage.sqf);
            };
            class updateBodyPartVisuals {
                file = QPATHTOF(functions\fnc_updateBodyPartVisuals.sqf);
            };
        };
    };
    class overwrite_ace_medical_gui {
        tag = "ace_medical_gui";
        class ace_medical_gui {
            class addTreatmentActions {
                file = QPATHTOF(functions\fnc_addTreatmentActions.sqf);
            };
            class onKeyDown {
                file = QPATHTOF(functions\fnc_onKeyDown.sqf);
            };
        };
    };
    class overwrite_ace_medical {
        tag = "ace_medical";
        class ace_medical {
            class addDamageToUnit {
                file = QPATHTOF(functions\fnc_addDamageToUnit.sqf);
            };
        };
    };
    class overwrite_ace_medical_status {
        tag = "ace_medical_status";
        class ace_medical_status {
            class initUnit {
                file = QPATHTOF(functions\fnc_initUnit.sqf);
            };
        };
    };
    class overwrite_ace_medical_treatment {
        tag = "ace_medical_treatment";
        class ace_medical_treatment {
            class tourniquetLocal {
                file = QPATHTOF(functions\fnc_tourniquetLocal.sqf);
            };
            class tourniquet {
                file = QPATHTOF(functions\fnc_tourniquet.sqf);
            };
            class hasTourniquetAppliedTo {
                file = QPATHTOF(functions\fnc_hasTourniquetAppliedTo.sqf);
            };
            class canSplint {
                file = QPATHTOF(functions\fnc_canSplint.sqf);
            };
            class splintLocal {
                file = QPATHTOF(functions\fnc_splintLocal.sqf);
            };
            class fullHealLocal {
                file = QPATHTOF(functions\fnc_fullHealLocal.sqf);
            };
            class canBandage {
                file = QPATHTOF(functions\fnc_canBandage.sqf);
            };
            class ivBagLocal {
                file = QPATHTOF(functions\fnc_ivBagLocal.sqf);
            };
         };
    };
};
