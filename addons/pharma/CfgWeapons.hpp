class CfgWeapons {
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;

    class kat_IV_16: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(IV_16_Display);
        picture = QPATHTOF(ui\icon_IV_16.paa);
        model = QPATHTOF(models\iv\kat_iv.p3d);
        descriptionShort = CSTRING(IV_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_IV_14: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(IV_14_Display);
        picture = QPATHTOF(ui\icon_IV_16.paa);
        model = QPATHTOF(models\iv\kat_iv.p3d);
        descriptionShort = CSTRING(IV_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_IV_20: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(IV_20_Display);
        picture = QPATHTOF(ui\icon_IV_16.paa);
        model = QPATHTOF(models\iv\kat_iv.p3d);
        descriptionShort = CSTRING(IV_DescShort);
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
    class kat_10ml_syringe: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_10_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_10_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_5ml_syringe: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_5_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_5_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
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
        author = "fijik,Archer,J3FF";
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
    class kat_phenylephrineAuto: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(PhenylAuto_Box_Display);
        picture = QPATHTOF(ui\icon_PhenylephrineAuto.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(PhenylAuto_DescShort);
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
    class kat_epinephrineIV: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(EpinephrineIV_displayName);
        picture = QPATHTOF(ui\icon_EpinephrineIV.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(EpinephrineIV_DescShort);
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
    class kat_syringe_kat_txa_10ml_1: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_txa_10_1_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_txa_10_1_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_txa_10ml_2: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_txa_10_2_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_txa_10_2_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_lidocaine_10ml_1: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_lidocaine_10_1_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_lidocaine_10_1_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_ketamine_10ml_1: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_ketamine_10_1_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_ketamine_10_1_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_ketamine_10ml_2: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_ketamine_10_2_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_ketamine_10_2_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_fentanyl_10ml_1: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_fentanyl_10_1_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_fentanyl_10_1_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_fentanyl_10ml_2: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_fentanyl_10_2_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_fentanyl_10_2_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_nalbuphine_10ml_1: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_nalbuphine_10_1_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_nalbuphine_10_1_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_nalbuphine_10ml_2: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_nalbuphine_10_2_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_nalbuphine_10_2_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_txa_5ml_1: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_txa_5_1_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_txa_5_1_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_txa_5ml_2: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_txa_5_2_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_txa_5_2_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_eaca_5ml_1: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_eaca_5_1_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_eaca_5_1_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_eaca_5ml_2: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_eaca_5_2_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_eaca_5_2_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_norepinephrine_5ml_1: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_norepinephrine_5_1_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_norepinephrine_5_1_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_norepinephrine_5ml_2: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_norepinephrine_5_2_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_norepinephrine_5_2_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_phenylephrine_5ml_1: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_phenylephrine_5_1_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_phenylephrine_5_1_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_phenylephrine_5ml_2: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_phenylephrine_5_2_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_phenylephrine_5_2_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_nitroglycerin_5ml_1: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_nitroglycerin_5_1_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_phenylephrine_5_1_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_nitroglycerin_5ml_2: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_nitroglycerin_5_2_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_nitroglycerin_5_2_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_amiodarone_5ml_1: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_amiodarone_5_1_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_amiodarone_5_1_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_amiodarone_5ml_2: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_amiodarone_5_2_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_amiodarone_5_2_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_epinephrineIV_5ml_1: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_epinephrineIV_5_1_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_epinephrineIV_5_1_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_epinephrineIV_5ml_2: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_epinephrineIV_5_2_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_epinephrineIV_5_2_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_lidocaine_5ml_1: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_lidocaine_5_1_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_lidocaine_5_1_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_lidocaine_5ml_2: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_lidocaine_5_2_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_lidocaine_5_2_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_ketamine_5ml_1: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_ketamine_5_1_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_ketamine_5_1_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_ketamine_5ml_2: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_ketamine_5_2_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_ketamine_5_2_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_fentanyl_5ml_1: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_fentanyl_5_1_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_fentanyl_5_1_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_fentanyl_5ml_2: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_fentanyl_10_2_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_fentanyl_10_2_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_nalbuphine_5ml_1: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_nalbuphine_5_1_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_nalbuphine_5_1_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_nalbuphine_5ml_2: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_nalbuphine_5_2_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_nalbuphine_5_2_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_lorazepam_5ml_1: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_lorazepam_5_1_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_lorazepam_5_1_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_lorazepam_5ml_2: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_lorazepam_5_2_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_lorazepam_5_2_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_flumazenil_5ml_1: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_flumazenil_5_1_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_flumazenil_5_1_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_flumazenil_5ml_2: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_flumazenil_5_2_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_flumazenil_5_2_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_etomidate_5ml_1: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_etomidate_5_1_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_etomidate_5_1_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_kat_etomidate_5ml_2: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_etomidate_5_2_Display);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Syringe_etomidate_5_2_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
};
