class CfgFunctions {
    class kat_chemical_gui_updateInjury_overrite
	{
		tag="ace_medical_gui";
		class ace_medical_gui
		{
			class updateInjuryList
			{
                file = QPATHTOF(functions\fnc_updateInjuryList.sqf);
			};
		};
	};

    class kat_chemical_gui_updatebody_overrite
    {
        tag="ace_medical_gui";
        class ace_medical_gui
        {
            class updateBodyImage
            {
                file = QPATHTOF(functions\fnc_updateBodyImage.sqf);
            };
        };
    };

    class overwrite_medicalTreatment {
        tag = "ace_medical_treatment";
        class ace_medical_treatment {
            class fullHealLocal {
                file = QPATHTOF(functions\fnc_fullHealLocal.sqf);
            };
        };
    };
};