class CfgFunctions {
    class overwrite_dotags {
        tag = "ace_dogtags";
        class ace_dogtags {
            class getDogtagData {
                file = QPATHTOF(functions\fnc_getDogtagData.sqf);
            };
            class canCheckDogtag {
                file = QPATHTOF(functions\fnc_canCheckDogtag.sqf);
            };
        };
    };
	class overwrite_cprLocal {
		tag = "ace_medical_treatment";
		class ace_medical_treatment {
            class cprLocal {
                file = QPATHTOF(functions\fnc_cprLocal.sqf);
            };
        };
	};
};
