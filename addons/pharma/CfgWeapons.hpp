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
        picture = QPATHTOF(ui\icon_IV_20.paa);
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
    class kat_EZ_IO: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(EZ_IO_Display);
        picture = QPATHTOF(ui\icon_ez_io.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(IO_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1.5;
        };
    };
    class kat_EJV: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(EJV_Display);
        picture = QPATHTOF(ui\icon_EJV.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(EJV_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
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
     class kat_TXAAuto: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(TXAAuto_Box_Display);
        picture = QPATHTOF(ui\icon_TXAAuto.paa);
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
    class kat_atropineIV: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(AtropineIV_Display);
        picture = QPATHTOF(ui\icon_AtropineIV.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(AtropineIV_DescShort);
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
            mass = 0.5;
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
            mass = 0.5;
        };
    };
    class kat_succinylcholine: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Succinylcholine_displayName);
        picture = QPATHTOF(ui\icon_succinylcholine.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Succinylcholine_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_rocuronium: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Rocuronium_displayName);
        picture = QPATHTOF(ui\icon_rocuronium.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Rocuronium_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_sugammadex: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Sugammadex_displayName);
        picture = QPATHTOF(ui\icon_sugammadex.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Sugammadex_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
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
            mass = 0.5;
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
            mass = 0.5;
        };
    };
    class kat_morphineIV: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(MorphineIV_displayName);
        picture = QPATHTOF(ui\icon_MorphineIV.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(MorphineIV_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_ondansetron: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Ondansetron_displayName);
        picture = QPATHTOF(ui\icon_Ondansetron.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Ondansetron_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_adenosineIV: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(AdenosineIV_displayName);
        picture = QPATHTOF(ui\icon_AdenosineIV.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(AdenosineIV_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_alteplase: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Alteplase_Display);
        picture = QPATHTOF(ui\icon_Alteplase.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Alteplase_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_doxapram: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Doxapram_Display);
        picture = QPATHTOF(ui\icon_Doxapram.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Doxapram_DescShort);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_coag_sense: ACE_ItemCore {
        scope = 2;
        author = "Miss Heda";
        displayName = CSTRING(Coag_Sense_Display);
        picture = QPATHTOF(ui\icon_Coag_Sense.paa);
        descriptionShort = CSTRING(Coag_Sense_Display_DESC);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_txa_10ml_10: ACE_ItemCore {
        scope = 1;
        displayName = KATDISPLAYCSTRING(txa,10ml,10);
        picture = QPATHTOF(ui\syringe_item.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = "";
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_syringe_txa_10ml_20: kat_syringe_txa_10ml_10 {
        displayName = KATDISPLAYCSTRING(txa,10ml,20);
    };
    class kat_syringe_morphineIV_10ml_10: kat_syringe_txa_10ml_10 {
        displayName = KATDISPLAYCSTRING(morphineIV,10ml,10);
    };
    class kat_syringe_morphineIV_10ml_16: kat_syringe_morphineIV_10ml_10 {
        displayName = KATDISPLAYCSTRING(morphineIV,10ml,16);
    };
    class kat_syringe_morphineIV_10ml_20: kat_syringe_morphineIV_10ml_10 {
        displayName = KATDISPLAYCSTRING(morphineIV,10ml,20);
    };
    class kat_syringe_morphineIV_10ml_26: kat_syringe_morphineIV_10ml_10 {
        displayName = KATDISPLAYCSTRING(morphineIV,10ml,26);
    };
    class kat_syringe_morphineIV_10ml_30: kat_syringe_morphineIV_10ml_10 {
        displayName = KATDISPLAYCSTRING(morphineIV,10ml,30);
    };
    class kat_syringe_lidocaine_10ml_10: kat_syringe_txa_10ml_10 {
        displayName = KATDISPLAYCSTRING(lidocaine,10ml,10);
    };
    class kat_syringe_ketamine_10ml_10: kat_syringe_txa_10ml_10 {
        displayName = KATDISPLAYCSTRING(ketamine,10ml,10);
    };
    class kat_syringe_ketamine_10ml_12: kat_syringe_ketamine_10ml_10 {
        displayName = KATDISPLAYCSTRING(ketamine,10ml,12);
    };
    class kat_syringe_ketamine_10ml_14: kat_syringe_ketamine_10ml_10 {
        displayName = KATDISPLAYCSTRING(ketamine,10ml,14);
    };
    class kat_syringe_ketamine_10ml_16: kat_syringe_ketamine_10ml_10 {
        displayName = KATDISPLAYCSTRING(ketamine,10ml,16);
    };
    class kat_syringe_ketamine_10ml_18: kat_syringe_ketamine_10ml_10 {
        displayName = KATDISPLAYCSTRING(ketamine,10ml,18);
    };
    class kat_syringe_ketamine_10ml_20: kat_syringe_ketamine_10ml_10 {
        displayName = KATDISPLAYCSTRING(ketamine,10ml,20);
    };
    class kat_syringe_ketamine_10ml_22: kat_syringe_ketamine_10ml_10 {
        displayName = KATDISPLAYCSTRING(ketamine,10ml,22);
    };
    class kat_syringe_ketamine_10ml_24: kat_syringe_ketamine_10ml_10 {
        displayName = KATDISPLAYCSTRING(ketamine,10ml,24);
    };
    class kat_syringe_ketamine_10ml_26: kat_syringe_ketamine_10ml_10 {
        displayName = KATDISPLAYCSTRING(ketamine,10ml,26);
    };
    class kat_syringe_ketamine_10ml_28: kat_syringe_ketamine_10ml_10 {
        displayName = KATDISPLAYCSTRING(ketamine,10ml,28);
    };
    class kat_syringe_ketamine_10ml_30: kat_syringe_ketamine_10ml_10 {
        displayName = KATDISPLAYCSTRING(ketamine,10ml,30);
    };
    class kat_syringe_fentanyl_10ml_10: kat_syringe_txa_10ml_10 {
        displayName = KATDISPLAYCSTRING(fentanyl,10ml,10);
    };
    class kat_syringe_fentanyl_10ml_12: kat_syringe_fentanyl_10ml_10 {
        displayName = KATDISPLAYCSTRING(fentanyl,10ml,12);
    };
    class kat_syringe_fentanyl_10ml_14: kat_syringe_fentanyl_10ml_10 {
        displayName = KATDISPLAYCSTRING(fentanyl,10ml,14);
    };
    class kat_syringe_fentanyl_10ml_16: kat_syringe_fentanyl_10ml_10 {
        displayName = KATDISPLAYCSTRING(fentanyl,10ml,16);
    };
    class kat_syringe_fentanyl_10ml_18: kat_syringe_fentanyl_10ml_10 {
        displayName = KATDISPLAYCSTRING(fentanyl,10ml,18);
    };
    class kat_syringe_fentanyl_10ml_20: kat_syringe_fentanyl_10ml_10 {
        displayName = KATDISPLAYCSTRING(fentanyl,10ml,20);
    };
    class kat_syringe_fentanyl_10ml_22: kat_syringe_fentanyl_10ml_10 {
        displayName = KATDISPLAYCSTRING(fentanyl,10ml,22);
    };
    class kat_syringe_fentanyl_10ml_24: kat_syringe_fentanyl_10ml_10 {
        displayName = KATDISPLAYCSTRING(fentanyl,10ml,24);
    };
    class kat_syringe_fentanyl_10ml_26: kat_syringe_fentanyl_10ml_10 {
        displayName = KATDISPLAYCSTRING(fentanyl,10ml,26);
    };
    class kat_syringe_fentanyl_10ml_28: kat_syringe_fentanyl_10ml_10 {
        displayName = KATDISPLAYCSTRING(fentanyl,10ml,28);
    };
    class kat_syringe_fentanyl_10ml_30: kat_syringe_fentanyl_10ml_10 {
        displayName = KATDISPLAYCSTRING(fentanyl,10ml,30);
    };
    class kat_syringe_nalbuphine_10ml_10: kat_syringe_txa_10ml_10 {
        displayName = KATDISPLAYCSTRING(nalbuphine,10ml,10);
    };
    class kat_syringe_nalbuphine_10ml_12: kat_syringe_nalbuphine_10ml_10 {
        displayName = KATDISPLAYCSTRING(nalbuphine,10ml,12);
    };
    class kat_syringe_nalbuphine_10ml_14: kat_syringe_nalbuphine_10ml_10 {
        displayName = KATDISPLAYCSTRING(nalbuphine,10ml,14);
    };
    class kat_syringe_nalbuphine_10ml_16: kat_syringe_nalbuphine_10ml_10 {
        displayName = KATDISPLAYCSTRING(nalbuphine,10ml,16);
    };
    class kat_syringe_nalbuphine_10ml_18: kat_syringe_nalbuphine_10ml_10 {
        displayName = KATDISPLAYCSTRING(nalbuphine,10ml,18);
    };
    class kat_syringe_nalbuphine_10ml_20: kat_syringe_nalbuphine_10ml_10 {
        displayName = KATDISPLAYCSTRING(nalbuphine,10ml,20);
    };
    class kat_syringe_nalbuphine_10ml_22: kat_syringe_nalbuphine_10ml_10 {
        displayName = KATDISPLAYCSTRING(nalbuphine,10ml,22);
    };
    class kat_syringe_nalbuphine_10ml_24: kat_syringe_nalbuphine_10ml_10 {
        displayName = KATDISPLAYCSTRING(nalbuphine,10ml,24);
    };
    class kat_syringe_nalbuphine_10ml_26: kat_syringe_nalbuphine_10ml_10 {
        displayName = KATDISPLAYCSTRING(nalbuphine,10ml,26);
    };
    class kat_syringe_nalbuphine_10ml_28: kat_syringe_nalbuphine_10ml_10 {
        displayName = KATDISPLAYCSTRING(nalbuphine,10ml,28);
    };
    class kat_syringe_nalbuphine_10ml_30: kat_syringe_nalbuphine_10ml_10 {
        displayName = KATDISPLAYCSTRING(nalbuphine,10ml,30);
    };
    class kat_syringe_txa_5ml_10: kat_syringe_txa_10ml_10 {
        displayName = KATDISPLAYCSTRING(txa,5ml,10);
    };
    class kat_syringe_txa_5ml_20: kat_syringe_txa_5ml_10 {
        displayName = KATDISPLAYCSTRING(txa,5ml,20);
    };
    class kat_syringe_eaca_5ml_10: kat_syringe_txa_5ml_10 {
        displayName = KATDISPLAYCSTRING(eaca,5ml,10);
    };
    class kat_syringe_eaca_5ml_20: kat_syringe_eaca_5ml_10 {
        displayName = KATDISPLAYCSTRING(eaca,5ml,20);
    };
    class kat_syringe_phenylephrine_5ml_10: kat_syringe_txa_5ml_10 {
        displayName = KATDISPLAYCSTRING(phenylephrine,5ml,10);
    };
    class kat_syringe_phenylephrine_5ml_20: kat_syringe_phenylephrine_5ml_10 {
        displayName = KATDISPLAYCSTRING(phenylephrine,5ml,20);
    };
    class kat_syringe_phenylephrine_5ml_30: kat_syringe_phenylephrine_5ml_10 {
        displayName = KATDISPLAYCSTRING(phenylephrine,5ml,30);
    };
    class kat_syringe_amiodarone_5ml_10: kat_syringe_txa_5ml_10 {
        displayName = KATDISPLAYCSTRING(amiodarone,5ml,10);
    };
    class kat_syringe_amiodarone_5ml_20: kat_syringe_amiodarone_5ml_10 {
        displayName = KATDISPLAYCSTRING(amiodarone,5ml,20);
    };
    class kat_syringe_amiodarone_5ml_30: kat_syringe_amiodarone_5ml_10 {
        displayName = KATDISPLAYCSTRING(amiodarone,5ml,30);
    };
    class kat_syringe_alteplase_5ml_20: kat_syringe_txa_5ml_10 {
        displayName = KATDISPLAYCSTRING(alteplase,5ml,30);
    };
    class kat_syringe_epinephrineIV_5ml_10: kat_syringe_txa_5ml_10 {
        displayName = KATDISPLAYCSTRING(epinephrineIV,5ml,10);
    };
    class kat_syringe_epinephrineIV_5ml_20: kat_syringe_epinephrineIV_5ml_10 {
        displayName = KATDISPLAYCSTRING(epinephrineIV,5ml,20);
    };
    class kat_syringe_lidocaine_5ml_10: kat_syringe_txa_5ml_10 {
        displayName = KATDISPLAYCSTRING(lidocaine,5ml,10);
    };
    class kat_syringe_lidocaine_5ml_12: kat_syringe_lidocaine_5ml_10 {
        displayName = KATDISPLAYCSTRING(lidocaine,5ml,12);
    };
    class kat_syringe_lidocaine_5ml_20: kat_syringe_lidocaine_5ml_10 {
        displayName = KATDISPLAYCSTRING(lidocaine,5ml,20);
    };
    class kat_syringe_lidocaine_5ml_30: kat_syringe_lidocaine_5ml_10 {
        displayName = KATDISPLAYCSTRING(lidocaine,5ml,30);
    };
    class kat_syringe_ketamine_5ml_10: kat_syringe_txa_5ml_10 {
        displayName = KATDISPLAYCSTRING(ketamine,5ml,10);
    };
    class kat_syringe_ketamine_5ml_12: kat_syringe_ketamine_5ml_10 {
        displayName = KATDISPLAYCSTRING(ketamine,5ml,12);
    };
    class kat_syringe_ketamine_5ml_14: kat_syringe_ketamine_5ml_10 {
        displayName = KATDISPLAYCSTRING(ketamine,5ml,14);
    };
    class kat_syringe_ketamine_5ml_16: kat_syringe_ketamine_5ml_10 {
        displayName = KATDISPLAYCSTRING(ketamine,5ml,16);
    };
    class kat_syringe_ketamine_5ml_18: kat_syringe_ketamine_5ml_10 {
        displayName = KATDISPLAYCSTRING(ketamine,5ml,18);
    };
    class kat_syringe_ketamine_5ml_20: kat_syringe_ketamine_5ml_10 {
        displayName = KATDISPLAYCSTRING(ketamine,5ml,20);
    };
    class kat_syringe_ketamine_5ml_22: kat_syringe_ketamine_5ml_10 {
        displayName = KATDISPLAYCSTRING(ketamine,5ml,22);
    };
    class kat_syringe_ketamine_5ml_24: kat_syringe_ketamine_5ml_10 {
        displayName = KATDISPLAYCSTRING(ketamine,5ml,24);
    };
    class kat_syringe_ketamine_5ml_26: kat_syringe_ketamine_5ml_10 {
        displayName = KATDISPLAYCSTRING(ketamine,5ml,26);
    };
    class kat_syringe_ketamine_5ml_28: kat_syringe_ketamine_5ml_10 {
        displayName = KATDISPLAYCSTRING(ketamine,5ml,28);
    };
    class kat_syringe_ketamine_5ml_30: kat_syringe_ketamine_5ml_10 {
        displayName = KATDISPLAYCSTRING(ketamine,5ml,30);
    };
    class kat_syringe_fentanyl_5ml_10: kat_syringe_txa_5ml_10 {
        displayName = KATDISPLAYCSTRING(fentanyl,5ml,10);
    };
    class kat_syringe_fentanyl_5ml_12: kat_syringe_fentanyl_5ml_10 {
        displayName = KATDISPLAYCSTRING(fentanyl,5ml,12);
    };
    class kat_syringe_fentanyl_5ml_14: kat_syringe_fentanyl_5ml_10 {
        displayName = KATDISPLAYCSTRING(fentanyl,5ml,14);
    };
    class kat_syringe_fentanyl_5ml_16: kat_syringe_fentanyl_5ml_10 {
        displayName = KATDISPLAYCSTRING(fentanyl,5ml,16);
    };
    class kat_syringe_fentanyl_5ml_18: kat_syringe_fentanyl_5ml_10 {
        displayName = KATDISPLAYCSTRING(fentanyl,5ml,18);
    };
    class kat_syringe_fentanyl_5ml_20: kat_syringe_fentanyl_5ml_10 {
        displayName = KATDISPLAYCSTRING(fentanyl,5ml,20);
    };
    class kat_syringe_fentanyl_5ml_22: kat_syringe_fentanyl_5ml_10 {
        displayName = KATDISPLAYCSTRING(fentanyl,5ml,22);
    };
    class kat_syringe_fentanyl_5ml_24: kat_syringe_fentanyl_5ml_10 {
        displayName = KATDISPLAYCSTRING(fentanyl,5ml,24);
    };
    class kat_syringe_fentanyl_5ml_26: kat_syringe_fentanyl_5ml_10 {
        displayName = KATDISPLAYCSTRING(fentanyl,5ml,26);
    };
    class kat_syringe_fentanyl_5ml_28: kat_syringe_fentanyl_5ml_10 {
        displayName = KATDISPLAYCSTRING(fentanyl,5ml,28);
    };
    class kat_syringe_fentanyl_5ml_30: kat_syringe_fentanyl_5ml_10 {
        displayName = KATDISPLAYCSTRING(fentanyl,5ml,30);
    };
    class kat_syringe_nalbuphine_5ml_10: kat_syringe_txa_5ml_10 {
        displayName = KATDISPLAYCSTRING(nalbuphine,5ml,10);
    };
    class kat_syringe_nalbuphine_5ml_12: kat_syringe_nalbuphine_5ml_10 {
        displayName = KATDISPLAYCSTRING(nalbuphine,5ml,12);
    };
    class kat_syringe_nalbuphine_5ml_14: kat_syringe_nalbuphine_5ml_10 {
        displayName = KATDISPLAYCSTRING(nalbuphine,5ml,14);
    };
    class kat_syringe_nalbuphine_5ml_16: kat_syringe_nalbuphine_5ml_10 {
        displayName = KATDISPLAYCSTRING(nalbuphine,5ml,16);
    };
    class kat_syringe_nalbuphine_5ml_18: kat_syringe_nalbuphine_5ml_10 {
        displayName = KATDISPLAYCSTRING(nalbuphine,5ml,18);
    };
    class kat_syringe_nalbuphine_5ml_20: kat_syringe_nalbuphine_5ml_10 {
        displayName = KATDISPLAYCSTRING(nalbuphine,5ml,20);
    };
    class kat_syringe_nalbuphine_5ml_22: kat_syringe_nalbuphine_5ml_10 {
        displayName = KATDISPLAYCSTRING(nalbuphine,5ml,22);
    };
    class kat_syringe_nalbuphine_5ml_24: kat_syringe_nalbuphine_5ml_10 {
        displayName = KATDISPLAYCSTRING(nalbuphine,5ml,24);
    };
    class kat_syringe_nalbuphine_5ml_26: kat_syringe_nalbuphine_5ml_10 {
        displayName = KATDISPLAYCSTRING(nalbuphine,5ml,26);
    };
    class kat_syringe_nalbuphine_5ml_28: kat_syringe_nalbuphine_5ml_10 {
        displayName = KATDISPLAYCSTRING(nalbuphine,5ml,28);
    };
    class kat_syringe_nalbuphine_5ml_30: kat_syringe_nalbuphine_5ml_10 {
        displayName = KATDISPLAYCSTRING(nalbuphine,5ml,30);
    };
    class kat_syringe_lorazepam_5ml_10: kat_syringe_txa_5ml_10 {
        displayName = KATDISPLAYCSTRING(lorazepam,5ml,10);
    };
    class kat_syringe_lorazepam_5ml_12: kat_syringe_lorazepam_5ml_10 {
        displayName = KATDISPLAYCSTRING(lorazepam,5ml,12);
    };
    class kat_syringe_lorazepam_5ml_14: kat_syringe_lorazepam_5ml_10 {
        displayName = KATDISPLAYCSTRING(lorazepam,5ml,14);
    };
    class kat_syringe_lorazepam_5ml_16: kat_syringe_lorazepam_5ml_10 {
        displayName = KATDISPLAYCSTRING(lorazepam,5ml,16);
    };
    class kat_syringe_lorazepam_5ml_18: kat_syringe_lorazepam_5ml_10 {
        displayName = KATDISPLAYCSTRING(lorazepam,5ml,18);
    };
    class kat_syringe_lorazepam_5ml_20: kat_syringe_lorazepam_5ml_10 {
        displayName = KATDISPLAYCSTRING(lorazepam,5ml,20);
    };
    class kat_syringe_lorazepam_5ml_22: kat_syringe_lorazepam_5ml_10 {
        displayName = KATDISPLAYCSTRING(lorazepam,5ml,22);
    };
    class kat_syringe_lorazepam_5ml_24: kat_syringe_lorazepam_5ml_10 {
        displayName = KATDISPLAYCSTRING(lorazepam,5ml,24);
    };
    class kat_syringe_lorazepam_5ml_26: kat_syringe_lorazepam_5ml_10 {
        displayName = KATDISPLAYCSTRING(lorazepam,5ml,26);
    };
    class kat_syringe_lorazepam_5ml_28: kat_syringe_lorazepam_5ml_10 {
        displayName = KATDISPLAYCSTRING(lorazepam,5ml,28);
    };
    class kat_syringe_lorazepam_5ml_30: kat_syringe_lorazepam_5ml_10 {
        displayName = KATDISPLAYCSTRING(lorazepam,5ml,30);
    };
    class kat_syringe_flumazenil_5ml_10: kat_syringe_txa_5ml_10 {
        displayName = KATDISPLAYCSTRING(flumazenil,5ml,10);
    };
    class kat_syringe_flumazenil_5ml_20: kat_syringe_flumazenil_5ml_10 {
        displayName = KATDISPLAYCSTRING(flumazenil,5ml,20);
    };
    class kat_syringe_flumazenil_5ml_30: kat_syringe_flumazenil_5ml_10 {
        displayName = KATDISPLAYCSTRING(flumazenil,5ml,30);
    };
    class kat_syringe_etomidate_5ml_10: kat_syringe_txa_5ml_10 {
        displayName = KATDISPLAYCSTRING(etomidate,5ml,10);
    };
    class kat_syringe_etomidate_5ml_12: kat_syringe_etomidate_5ml_10 {
        displayName = KATDISPLAYCSTRING(etomidate,5ml,12);
    };
    class kat_syringe_etomidate_5ml_14: kat_syringe_etomidate_5ml_10 {
        displayName = KATDISPLAYCSTRING(etomidate,5ml,14);
    };
    class kat_syringe_etomidate_5ml_16: kat_syringe_etomidate_5ml_10 {
        displayName = KATDISPLAYCSTRING(etomidate,5ml,16);
    };
    class kat_syringe_etomidate_5ml_18: kat_syringe_etomidate_5ml_10 {
        displayName = KATDISPLAYCSTRING(etomidate,5ml,18);
    };
    class kat_syringe_etomidate_5ml_20: kat_syringe_etomidate_5ml_10 {
        displayName = KATDISPLAYCSTRING(etomidate,5ml,20);
    };
    class kat_syringe_etomidate_5ml_22: kat_syringe_etomidate_5ml_10 {
        displayName = KATDISPLAYCSTRING(etomidate,5ml,22);
    };
    class kat_syringe_etomidate_5ml_24: kat_syringe_etomidate_5ml_10 {
        displayName = KATDISPLAYCSTRING(etomidate,5ml,24);
    };
    class kat_syringe_etomidate_5ml_26: kat_syringe_etomidate_5ml_10 {
        displayName = KATDISPLAYCSTRING(etomidate,5ml,26);
    };
    class kat_syringe_etomidate_5ml_28: kat_syringe_etomidate_5ml_10 {
        displayName = KATDISPLAYCSTRING(etomidate,5ml,28);
    };
    class kat_syringe_etomidate_5ml_30: kat_syringe_etomidate_5ml_10 {
        displayName = KATDISPLAYCSTRING(etomidate,5ml,30);
    };
    class kat_syringe_ondansetron_5ml_10: kat_syringe_txa_5ml_10 {
        displayName = KATDISPLAYCSTRING(ondansetron,5ml,10);
    };
    class kat_syringe_ondansetron_5ml_16: kat_syringe_ondansetron_5ml_10 {
        displayName = KATDISPLAYCSTRING(ondansetron,5ml,16);
    };
    class kat_syringe_ondansetron_5ml_20: kat_syringe_ondansetron_5ml_10 {
        displayName = KATDISPLAYCSTRING(ondansetron,5ml,20);
    };
    class kat_syringe_ondansetron_5ml_26: kat_syringe_ondansetron_5ml_10 {
        displayName = KATDISPLAYCSTRING(ondansetron,5ml,26);
    };
    class kat_syringe_ondansetron_5ml_30: kat_syringe_ondansetron_5ml_10 {
        displayName = KATDISPLAYCSTRING(ondansetron,5ml,30);
    };
    class kat_syringe_morphineIV_5ml_10: kat_syringe_txa_5ml_10 {
        displayName = KATDISPLAYCSTRING(morphineIV,5ml,10);
    };
    class kat_syringe_morphineIV_5ml_16: kat_syringe_morphineIV_5ml_10 {
        displayName = KATDISPLAYCSTRING(morphineIV,5ml,16);
    };
    class kat_syringe_morphineIV_5ml_20: kat_syringe_morphineIV_5ml_10 {
        displayName = KATDISPLAYCSTRING(morphineIV,5ml,20);
    };
    class kat_syringe_morphineIV_5ml_26: kat_syringe_morphineIV_5ml_10 {
        displayName = KATDISPLAYCSTRING(morphineIV,5ml,26);
    };
    class kat_syringe_morphineIV_5ml_30: kat_syringe_morphineIV_5ml_10 {
        displayName = KATDISPLAYCSTRING(morphineIV,5ml,30);
    };
    class kat_syringe_atropineIV_5ml_10: kat_syringe_txa_5ml_10 {
        displayName = KATDISPLAYCSTRING(atropineIV,5ml,10);
    };
    class kat_syringe_atropineIV_5ml_30: kat_syringe_atropineIV_5ml_10 {
        displayName = KATDISPLAYCSTRING(atropineIV,5ml,30);
    };
    class kat_syringe_adenosineIV_5ml_10: kat_syringe_txa_5ml_10 {
        displayName = KATDISPLAYCSTRING(adenosineIV,5ml,10);
    };
    class kat_syringe_adenosineIV_5ml_20: kat_syringe_adenosineIV_5ml_10 {
        displayName = KATDISPLAYCSTRING(adenosineIV,5ml,20);
    };
    class kat_syringe_adenosineIV_5ml_30: kat_syringe_adenosineIV_5ml_10 {
        displayName = KATDISPLAYCSTRING(adenosineIV,5ml,30);
    };
    class kat_syringe_salineIV_5ml_30: kat_syringe_txa_5ml_10 {
        displayName = CSTRING(Syringe_SalineFlush_Display);
        descriptionShort = CSTRING(Syringe_SalineFlush_DescShort);
    };
    class kat_syringe_doxapram_5ml_10: kat_syringe_txa_5ml_10 {
        displayName = KATDISPLAYCSTRING(doxapram,5ml,10);
    };
    class kat_syringe_doxapram_5ml_20: kat_syringe_doxapram_5ml_10 {
        displayName = KATDISPLAYCSTRING(doxapram,5ml,20);
    };
    class kat_syringe_doxapram_5ml_30: kat_syringe_doxapram_5ml_10 {
        displayName = KATDISPLAYCSTRING(doxapram,5ml,30);
    };
};
