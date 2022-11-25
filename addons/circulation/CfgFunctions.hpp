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
    class overwrite_medical_treatment {
        tag = "ace_medical_treatment";
        class ace_medical_treatment {
              class cprLocal {
                file = QPATHTOF(functions\fnc_cprLocal.sqf);
              };
              class cprSuccess {
                file = QPATHTOF(functions\fnc_cprSuccess.sqf);
              };
            class treatment {
                file = QPATHTOF(functions\fnc_treatment.sqf);
              };
          };
    };
};
