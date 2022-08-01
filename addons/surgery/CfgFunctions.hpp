class CfgFunctions {
	class overwrite_medical_treatment {
		tag = "ace_medical_treatment";
		class ace_medical_treatment {
			class treatment {
                file = QPATHTOF(functions\fnc_treatment.sqf);
            };
        };
	};
    class overwrite_ace_medical_status {
        tag = "ace_medical_status";
        class ace_medical_status {
            class hasStableVitals {
                file = QPATHTOF(functions\fnc_hasStableVitals.sqf);
            };
        };
    };
};
