class CfgFunctions {
    class overwrite_ace_medical_gui {
        tag = "ace_medical_gui";
        class ace_medical_gui {
            class updateInjuryList {
                file = QPATHTOF(functions\fnc_updateInjuryList.sqf);
            };
        };
    };
	class overwrite_medical_treatment {
		tag = "ace_medical_treatment";
		class ace_medical_treatment {
            class cprLocal {
                file = QPATHTOF(functions\fnc_cprLocal.sqf);
            };
			class treatment {
                file = QPATHTOF(functions\fnc_treatment.sqf);
            };
            class fullHealLocal {
                file = QPATHTOF(functions\fnc_fullHealLocal.sqf);
            };
        };
	};
    class overwrite_ace_medical_status {
        tag = "ace_medical_status";
        class ace_medical_status {
            class getBloodVolumeChange {
                file = QPATHTOF(functions\fnc_getBloodVolumeChange.sqf);
            };
        };
    };
};
