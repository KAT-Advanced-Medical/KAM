class CfgWeapons {
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;

    class kat_PainkillerItem: ACE_ItemCore {
        scope = 2; //This item is not actually used and it is replaced by ace_common_fnc_registerItemReplacement 
        author = "Katalam";
        displayName = CSTRING(Painkillers_Box_Display);
        picture = QPATHTOF(ui\icon_painkillers.paa);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_CarbonateItem: ACE_ItemCore {
        scope = 2; //This item is not actually used and it is replaced by ace_common_fnc_registerItemReplacement 
        author = "Mazinski.H";
        displayName = CSTRING(Carbonate_Box_Display);
        picture = QPATHTOF(ui\icon_Carbonate.paa);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_PervitinItem: ACE_ItemCore {
        scope = 2; //This item is not actually used and it is replaced by ace_common_fnc_registerItemReplacement 
        author = "Miss Heda";
        displayName = CSTRING(Pervitin_Capsule_Display);
        picture = QPATHTOF(ui\icon_Pervitin.paa);
        descriptionShort = CSTRING(Pervitin_Capsule_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.1;
        }; 
    };
    class kat_CaffeineItem: ACE_ItemCore {
        scope = 2; //This item is not actually used and it is replaced by ace_common_fnc_registerItemReplacement 
        author = "Miss Heda";
        displayName = CSTRING(Caffeine_Bottle_Display);
        picture = QPATHTOF(ui\icon_Caffeine.paa);
        descriptionShort = CSTRING(Caffeine_Bottle_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.1;
        }; 
    };
    class kat_PenthroxItem: ACE_ItemCore {
        scope = 2; //This item is not actually used and it is replaced by ace_common_fnc_registerItemReplacement 
        author = "Blue";
        displayName = CSTRING(Penthrox_Display);
        picture = QPATHTOF(ui\icon_penthrox.paa);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_IV_16: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(IV_16_Display);
        picture = QPATHTOF(ui\icon_IV_16.paa);
        model = QPATHTOF(models\iv\kat_iv.p3d);
        descriptionShort = CSTRING(IV_DescShort);
        hiddenSelections[]={"0"};
        hiddenSelectionsMaterials[] = {QPATHTOF(models\iv\kat_iv.rvmat)};
        hiddenSelectionsTextures[] = {QPATHTOF(models\iv\kat_iv_co.paa)};
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        }; 
    };
    class kat_IO_FAST: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(IO_45_Display);
        picture = QPATHTOF(ui\icon_fast_io.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(IO_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        }; 
    };
    class kat_naloxone: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Naloxone_Box_Display);
        picture = QPATHTOF(ui\icon_Naloxone.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Naloxone_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        }; 
    };
    class kat_EACA: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(EACA_Display);
        picture = QPATHTOF(ui\icon_TXA.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(EACA_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.2;
        };
    };
    class kat_TXA: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(TXA_Box_Display);
        picture = QPATHTOF(ui\icon_TXA.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(TXA_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        }; 
    };
    class kat_norepinephrine: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Norep_Box_Display);
        picture = QPATHTOF(ui\norep.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Norep_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        }; 
    };
    class kat_phenylephrine: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Phenyl_Box_Display);
        picture = QPATHTOF(ui\phen.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Phenyl_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        }; 
    };
    class kat_nitroglycerin: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Nitro_Box_Display);
        picture = QPATHTOF(ui\nitro.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Nitro_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        }; 
    };
    class kat_amiodarone: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Amiodarone_Box_Display);
        picture = QPATHTOF(ui\icon_Amiodarone.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Amiodarone_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        }; 
    };
    class kat_lidocaine: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Lidocaine_Box_Display);
        picture = QPATHTOF(ui\icon_Lidocaine.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Lidocaine_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        }; 
    };
    class kat_atropine: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Atropine_Box_Display);
        picture = QPATHTOF(ui\icon_Atropine.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Atropine_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        }; 
    };
    class kat_ketamine: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Ketamine_Box_Display);
        picture = QPATHTOF(ui\icon_Ketamine.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Ketamine_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        }; 
    };
    class kat_fentanyl: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Fentanyl_Box_Display);
        picture = QPATHTOF(ui\icon_Fentanyl.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Fentanyl_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        }; 
    };
    class kat_nalbuphine: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Nalbuphine_Box_Display);
        picture = QPATHTOF(ui\icon_Nalbuphine.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Nalbuphine_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        }; 
    };
        class kat_lorazepam: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Lorazepam_displayName);
        picture = QPATHTOF(ui\icon_lorazepam.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Lorazepam_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.2;
        }; 
    };
    class kat_flumazenil: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Flumazenil_displayName);
        picture = QPATHTOF(ui\icon_flumazenil.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Flumazenil_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.2;
        }; 
    };
    class kat_etomidate: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Etomidate_displayName);
        picture = QPATHTOF(ui\icon_etomidate.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Etomidate_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.2;
        }; 
    };
    class kat_coag_sense: ACE_ItemCore {
        scope = 2;
        author = "Miss Heda";
        displayName = CSTRING(Coag_Sense_Display);
        picture = QPATHTOF(ui\icon_Coag_Sense.paa);
        descriptionShort = CSTRING(Coag_Sense_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        }; 
    };
};
