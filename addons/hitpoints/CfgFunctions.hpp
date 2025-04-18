class CfgFunctions {
    class overwrite_ace_medical_damage {
        tag = "ace_medical_damage";
        class ace_medical_damage {
            class handleIncapacitation {
                file = QPATHTOF(functions\fnc_handleIncapacitation.sqf);
            };
            class woundsHandlerBase {
                file = QPATHTOF(functions\fnc_woundsHandlerBase.sqf);
            };
            class woundsHandlerExplosion {
                file = QPATHTOF(functions\fnc_woundsHandlerExplosion.sqf);
            };
            class woundsHandlerVehiclehit {
                file = QPATHTOF(functions\fnc_woundsHandlerVehiclehit.sqf);
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
            class updateDamageEffects {
                file = QPATHTOF(functions\fnc_updateDamageEffects.sqf);
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
            class updateBodyImage {
                file = QPATHTOF(functions\fnc_updateBodyImage.sqf);
            };
            class updateInjuryList {
                file = QPATHTOF(functions\fnc_updateInjuryList.sqf);
            };
        };
    };
    class overwrite_ace_medical_status {
        tag = "ace_medical_status";
        class ace_medical_status {
            class updateWoundBloodLoss {
                file = QPATHTOF(functions\fnc_updateWoundBloodLoss.sqf);
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
};
