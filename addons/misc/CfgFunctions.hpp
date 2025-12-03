class CfgFunctions {
    class overwrite_ace_dragging {
        tag = "ace_dragging";
        class ace_dragging {
            class carryObject {
                file = QPATHTOF(functions\fnc_carryObject.sqf);
            };
            class handleUnconscious {
                file = QPATHTOF(functions\fnc_handleUnconscious.sqf);
            };
        };
    };
    class overwrite_ace_medical_engine {
        tag = "ace_medical_engine";
        class ace_medical_engine {
            class updateDamageEffects {
                file = QPATHTOF(functions\fnc_updateDamageEffects.sqf);
            };
        };
    };
    class overwrite_medical_treatment {
        tag = "ace_medical_treatment";
        class ace_medical_treatment {
            class treatment {
                file = QPATHTOF(functions\fnc_treatment.sqf);
            };
            class treatmentSuccess {
                file = QPATHTOF(functions\fnc_treatmentSuccess.sqf);
            };
            class useItem {
                file = QPATHTOF(functions\fnc_useItem.sqf);
            };
            class bandageLocal {
                file = QPATHTOF(functions\fnc_bandageLocal.sqf);
            };
            class getBandageTime {
                file = QPATHTOF(functions\fnc_getBandageTime.sqf);
            };
            class findMostEffectiveWounds {
                file = QPATHTOF(functions\fnc_findMostEffectiveWounds.sqf);
            };
            class handleBandageOpening {
                file = QPATHTOF(functions\fnc_handleBandageOpening.sqf);
            };
            class canStitch {
                file = QPATHTOF(functions\fnc_canStitch.sqf);
            };
            class stitchWound {
                file = QPATHTOF(functions\fnc_stitchWound.sqf);
            };
            class getStitchTime {
                file = QPATHTOF(functions\fnc_getStitchTime.sqf);
            };
            class surgicalKitProgress {
                file = QPATHTOF(functions\fnc_surgicalKitProgress.sqf);
            };
        };
    };
    class ace_medical {
        tag = "ace_medical";
        class ace_medical {
            class setUnconscious {
                file = QPATHTOF(functions\fnc_setUnconscious.sqf);
            };
            class serializeState {
                file = QPATHTOF(functions\fnc_serializeState.sqf);
            };
            class deserializeState {
                file = QPATHTOF(functions\fnc_deserializeState.sqf);
            };
        };
    };
    class overwrite_dogtags {
        tag = "ace_dogtags";
        class ace_dogtags {
            class getDogtagData {
                file = QPATHTOF(functions\fnc_getDogtagData.sqf);
            };
            class canCheckDogtag {
                file = QPATHTOF(functions\fnc_canCheckDogtag.sqf);
            };
            class showDogtagData {
                file = QPATHTOF(functions\fnc_showDogtagData.sqf);
            };
        };
    };
    class overwrite_medical_feedback {
        tag = "ace_medical_feedback";
        class ace_medical_feedback {
            class handleEffects {
                file = QPATHTOF(functions\fnc_handleEffects.sqf);
            };
        };
    };
};
