class CfgVehicles
{
    class Item_base_F;
    class kat_EACAItem: Item_base_F
    {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(EACA_Display);
        author = "fijik,Archer,J3FF";
        vehicleClass = "Items";
        model = QPATHTOF(models\vial\vial_01.p3d);
        hiddenSelections[]=
        {
            "camo1",
            "camo2",
            "label_amiodarone",
			"label_atropine",
			//"label_EACA",
			"label_etomidate",
			"label_fentanyl",
			"label_flumazenil",
			"label_ketamine",
			"label_lidocaine",
			"label_lorazepam",
			"label_nalbuphine",
			"label_nitroglycerin",
			"label_Norepinephrine",
			"label_phenylephrine",
			"label_TXA"
        };
        class TransportItems 
        {
            class _xx_kat_EACA
            {
                name = "kat_EACA";
                count = 1;
            };
        };
    };
    class kat_TXAItem: Item_base_F
    {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(TXA_Display);
        author = "fijik,Archer,J3FF";
        vehicleClass = "Items";
        model = QPATHTOF(models\vial\vial_01.p3d);
        hiddenSelections[]=
        {
            "camo1",
            "camo2",
            "label_amiodarone",
			"label_atropine",
			"label_EACA",
			"label_etomidate",
			"label_fentanyl",
			"label_flumazenil",
			"label_ketamine",
			"label_lidocaine",
			"label_lorazepam",
			"label_nalbuphine",
			"label_nitroglycerin",
			"label_Norepinephrine",
			"label_phenylephrine",
			//"label_TXA"
        };
        class TransportItems 
        {
            class _xx_kat_TXA
            {
                name = "kat_TXA";
                count = 1;
            };
        };
    };
    class kat_norepinephrineItem: Item_base_F
    {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(Norepinephrine_Display);
        author = "fijik,Archer,J3FF";
        vehicleClass = "Items";
        model = QPATHTOF(models\vial\vial_01.p3d);
        hiddenSelections[]=
        {
            "camo1",
            "camo2",
            "label_amiodarone",
			"label_atropine",
			"label_EACA",
			"label_etomidate",
			"label_fentanyl",
			"label_flumazenil",
			"label_ketamine",
			"label_lidocaine",
			"label_lorazepam",
			"label_nalbuphine",
			"label_nitroglycerin",
			//"label_Norepinephrine",
			"label_phenylephrine",
			"label_TXA"
        };
        class TransportItems 
        {
            class _xx_kat_norepinephrine
            {
                name = "kat_norepinephrine";
                count = 1;
            };
        };
    };
    class kat_phenylephrineItem: Item_base_F
    {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(Phenylephrine_Display);
        author = "fijik,Archer,J3FF";
        vehicleClass = "Items";
        model = QPATHTOF(models\vial\vial_01.p3d);
        hiddenSelections[]=
        {
            "camo1",
            "camo2",
            "label_amiodarone",
			"label_atropine",
			"label_EACA",
			"label_etomidate",
			"label_fentanyl",
			"label_flumazenil",
			"label_ketamine",
			"label_lidocaine",
			"label_lorazepam",
			"label_nalbuphine",
			"label_nitroglycerin",
			"label_Norepinephrine",
			//"label_phenylephrine",
			"label_TXA"
        };
        class TransportItems 
        {
            class _xx_kat_phenylephrine
            {
                name = "kat_phenylephrine";
                count = 1;
            };
        };
    };
    class kat_nitroglycerinItem: Item_base_F
    {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(Nitroglycerin_Display);
        author = "fijik,Archer,J3FF";
        vehicleClass = "Items";
        model = QPATHTOF(models\vial\vial_01.p3d);
        hiddenSelections[]=
        {
            "camo1",
            "camo2",
            "label_amiodarone",
			"label_atropine",
			"label_EACA",
			"label_etomidate",
			"label_fentanyl",
			"label_flumazenil",
			"label_ketamine",
			"label_lidocaine",
			"label_lorazepam",
			"label_nalbuphine",
			//"label_nitroglycerin",
			"label_Norepinephrine",
			"label_phenylephrine",
			"label_TXA"
        };
        class TransportItems 
        {
            class _xx_kat_nitroglycerin
            {
                name = "kat_nitroglycerin";
                count = 1;
            };
        };
    };
    class kat_amiodaroneItem: Item_base_F
    {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(Amiodarone_Display);
        author = "fijik,Archer,J3FF";
        vehicleClass = "Items";
        model = QPATHTOF(models\vial\vial_01.p3d);
        hiddenSelections[]=
        {
            "camo1",
            "camo2",
            //"label_amiodarone",
			"label_atropine",
			"label_EACA",
			"label_etomidate",
			"label_fentanyl",
			"label_flumazenil",
			"label_ketamine",
			"label_lidocaine",
			"label_lorazepam",
			"label_nalbuphine",
			"label_nitroglycerin",
			"label_Norepinephrine",
			"label_phenylephrine",
			"label_TXA"
        };
        class TransportItems 
        {
            class _xx_kat_amiodarone
            {
                name = "kat_amiodarone";
                count = 1;
            };
        };
    };
    class kat_lidocaineItem: Item_base_F
    {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(Lidocaine_Display);
        author = "fijik,Archer,J3FF";
        vehicleClass = "Items";
        model = QPATHTOF(models\vial\vial_01.p3d);
        hiddenSelections[]=
        {
            "camo1",
            "camo2",
            "label_amiodarone",
			"label_atropine",
			"label_EACA",
			"label_etomidate",
			"label_fentanyl",
			"label_flumazenil",
			"label_ketamine",
			//"label_lidocaine",
			"label_lorazepam",
			"label_nalbuphine",
			"label_nitroglycerin",
			"label_Norepinephrine",
			"label_phenylephrine",
			"label_TXA"
        };
        class TransportItems 
        {
            class _xx_kat_lidocaine
            {
                name = "kat_lidocaine";
                count = 1;
            };
        };
    };
    class kat_atropineItem: Item_base_F
    {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(Atropine_Display);
        author = "fijik,Archer,J3FF";
        vehicleClass = "Items";
        model = QPATHTOF(models\vial\vial_01.p3d);
        hiddenSelections[]=
        {
            "camo1",
            "camo2",
            "label_amiodarone",
			//"label_atropine",
			"label_EACA",
			"label_etomidate",
			"label_fentanyl",
			"label_flumazenil",
			"label_ketamine",
			"label_lidocaine",
			"label_lorazepam",
			"label_nalbuphine",
			"label_nitroglycerin",
			"label_Norepinephrine",
			"label_phenylephrine",
			"label_TXA"
        };
        class TransportItems 
        {
            class _xx_kat_atropine
            {
                name = "kat_atropine";
                count = 1;
            };
        };
    };
    class kat_ketamineItem: Item_base_F
    {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(Ketamine_Display);
        author = "fijik,Archer,J3FF";
        vehicleClass = "Items";
        model = QPATHTOF(models\vial\vial_01.p3d);
        hiddenSelections[]=
        {
            "camo1",
            "camo2",
            "label_amiodarone",
			"label_atropine",
			"label_EACA",
			"label_etomidate",
			"label_fentanyl",
			"label_flumazenil",
			//"label_ketamine",
			"label_lidocaine",
			"label_lorazepam",
			"label_nalbuphine",
			"label_nitroglycerin",
			"label_Norepinephrine",
			"label_phenylephrine",
			"label_TXA"
        };
        class TransportItems 
        {
            class _xx_kat_ketamine
            {
                name = "kat_ketamine";
                count = 1;
            };
        };
    };
    class kat_fentanylItem: Item_base_F
    {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(Fentanyl_Display);
        author = "fijik,Archer,J3FF";
        vehicleClass = "Items";
        model = QPATHTOF(models\vial\vial_01.p3d);
        hiddenSelections[]=
        {
            "camo1",
            "camo2",
            "label_amiodarone",
			"label_atropine",
			"label_EACA",
			"label_etomidate",
			//"label_fentanyl",
			"label_flumazenil",
			"label_ketamine",
			"label_lidocaine",
			"label_lorazepam",
			"label_nalbuphine",
			"label_nitroglycerin",
			"label_Norepinephrine",
			"label_phenylephrine",
			"label_TXA"
        };
        class TransportItems 
        {
            class _xx_kat_fentanyl
            {
                name = "kat_fentanyl";
                count = 1;
            };
        };
    };
    class kat_nalbuphineItem: Item_base_F
    {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(Nalbuphine_Display);
        author = "fijik,Archer,J3FF";
        vehicleClass = "Items";
        model = QPATHTOF(models\vial\vial_01.p3d);
        hiddenSelections[]=
        {
            "camo1",
            "camo2",
            "label_amiodarone",
			"label_atropine",
			"label_EACA",
			"label_etomidate",
			"label_fentanyl",
			"label_flumazenil",
			"label_ketamine",
			"label_lidocaine",
			"label_lorazepam",
			//"label_nalbuphine",
			"label_nitroglycerin",
			"label_Norepinephrine",
			"label_phenylephrine",
			"label_TXA"
        };
        class TransportItems 
        {
            class _xx_kat_nalbuphine
            {
                name = "kat_nalbuphine";
                count = 1;
            };
        };
    };
    class kat_lorazepamItem: Item_base_F
    {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(Lorazepam_Display);
        author = "fijik,Archer,J3FF";
        vehicleClass = "Items";
        model = QPATHTOF(models\vial\vial_01.p3d);
        hiddenSelections[]=
        {
            "camo1",
            "camo2",
            "label_amiodarone",
			"label_atropine",
			"label_EACA",
			"label_etomidate",
			"label_fentanyl",
			"label_flumazenil",
			"label_ketamine",
			"label_lidocaine",
			//"label_lorazepam",
			"label_nalbuphine",
			"label_nitroglycerin",
			"label_Norepinephrine",
			"label_phenylephrine",
			"label_TXA"
        };
        class TransportItems 
        {
            class _xx_kat_lorazepam
            {
                name = "kat_lorazepam";
                count = 1;
            };
        };
    };
    class kat_flumazenilItem: Item_base_F
    {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(Flumazenil_Display);
        author = "fijik,Archer,J3FF";
        vehicleClass = "Items";
        model = QPATHTOF(models\vial\vial_01.p3d);
        hiddenSelections[]=
        {
            "camo1",
            "camo2",
            "label_amiodarone",
			"label_atropine",
			"label_EACA",
			"label_etomidate",
			"label_fentanyl",
			//"label_flumazenil",
			"label_ketamine",
			"label_lidocaine",
			"label_lorazepam",
			"label_nalbuphine",
			"label_nitroglycerin",
			"label_Norepinephrine",
			"label_phenylephrine",
			"label_TXA"
        };
        class TransportItems 
        {
            class _xx_kat_flumazenil
            {
                name = "kat_flumazenil";
                count = 1;
            };
        };
    };
    class kat_etomidateItem: Item_base_F
    {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(Etomidate_Display);
        author = "fijik,Archer,J3FF";
        vehicleClass = "Items";
        model = QPATHTOF(models\vial\vial_01.p3d);
        hiddenSelections[]=
        {
            "camo1",
            "camo2",
            "label_amiodarone",
			"label_atropine",
			"label_EACA",
			//"label_etomidate",
			"label_fentanyl",
			"label_flumazenil",
			"label_ketamine",
			"label_lidocaine",
			"label_lorazepam",
			"label_nalbuphine",
			"label_nitroglycerin",
			"label_Norepinephrine",
			"label_phenylephrine",
			"label_TXA"
        };
        class TransportItems 
        {
            class _xx_kat_etomidate
            {
                name = "kat_etomidate";
                count = 1;
            };
        };
    };
};