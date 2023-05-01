class CfgWeapons {
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;

    class kat_PainkillerItem: ACE_ItemCore {
        scope = 2; //This item is not actually used and it is replaced by ace_common_fnc_registerItemReplacement 
        author = "Katalam";
        displayName = CSTRING(Painkillers_Box_Display);
        picture = QPATHTOF(ui\icon_painkillers.paa);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
    class kat_CarbonateItem: ACE_ItemCore {
        scope = 2; //This item is not actually used and it is replaced by ace_common_fnc_registerItemReplacement 
        author = "Mazinski.H";
        displayName = CSTRING(Carbonate_Box_Display);
        picture = QPATHTOF(ui\icon_Carbonate.paa);
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
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.1;
        };
    };
    class kat_syringeBase: ACE_ItemCore {
        scope = 1;
        ace_arsenal_hide = 1;
        picture = QPATHTOF(ui\syringe_item.paa);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.1;
        };
    };
    class kat_IV_16: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(IV_16_Display);
        picture = QPATHTOF(ui\icon_IV_16.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(IV_DescShort);
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
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_naloxoneSyringe: kat_syringeBase {
        displayName = CSTRING(Naloxone_Box_Display);
        descriptionShort = CSTRING(Naloxone_DescShort);
    };
    class kat_EACA: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(EACA_Display);
        picture = QPATHTOF(ui\icon_TXA.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(EACA_DescShort);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.2;
        };
    };
    class kat_EACASyringe: kat_syringeBase {
        displayName = CSTRING(EACA_Display);
        descriptionShort = CSTRING(EACA_DescShort);
    };
    class kat_TXA: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(TXA_Box_Display);
        picture = QPATHTOF(ui\icon_TXA.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(TXA_DescShort);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_TXASyringe: kat_syringeBase {
        displayName = CSTRING(TXA_Box_Display);
        descriptionShort = CSTRING(TXA_DescShort);
    };
    class kat_norepinephrine: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Norep_Box_Display);
        picture = QPATHTOF(ui\norep.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Norep_DescShort);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_norepinephrineSyringe: kat_syringeBase {
        displayName = CSTRING(Norep_Box_Display);
        descriptionShort = CSTRING(Norep_DescShort);
    };
    class kat_phenylephrine: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Phenyl_Box_Display);
        picture = QPATHTOF(ui\phen.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Phenyl_DescShort);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_phenylephrineSyringe: kat_syringeBase {
        displayName = CSTRING(Phenyl_Box_Display);
        descriptionShort = CSTRING(Phenyl_DescShort);
    };
    class kat_nitroglycerin: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Nitro_Box_Display);
        picture = QPATHTOF(ui\nitro.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Nitro_DescShort);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_nitroglycerinSyringe: kat_syringeBase {
        displayName = CSTRING(Nitro_Box_Display);
        descriptionShort = CSTRING(Nitro_DescShort);
    };
    class kat_amiodarone: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Amiodarone_Box_Display);
        picture = QPATHTOF(ui\icon_Amiodarone.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Amiodarone_DescShort);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_amiodaroneSyringe: kat_syringeBase {
        displayName = CSTRING(Amiodarone_Box_Display);
        descriptionShort = CSTRING(Amiodarone_DescShort);
    };
    class kat_lidocaine: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Lidocaine_Box_Display);
        picture = QPATHTOF(ui\icon_Lidocaine.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Lidocaine_DescShort);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_lidocaineSyringe: kat_syringeBase {
        displayName = CSTRING(Lidocaine_Box_Display);
        descriptionShort = CSTRING(Lidocaine_DescShort);
    };
    class kat_atropine: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Atropine_Box_Display);
        picture = QPATHTOF(ui\icon_Atropine.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Atropine_DescShort);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_atropineSyringe: kat_syringeBase {
        displayName = CSTRING(Atropine_Box_Display);
        descriptionShort = CSTRING(Atropine_DescShort);
    };
    class kat_ketamine: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Ketamine_Box_Display);
        picture = QPATHTOF(ui\icon_Ketamine.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Ketamine_DescShort);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_ketamineSyringe: kat_syringeBase {
        displayName = CSTRING(Ketamine_Box_Display);
        descriptionShort = CSTRING(Ketamine_DescShort);
    };
    class kat_fentanyl: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Fentanyl_Box_Display);
        picture = QPATHTOF(ui\icon_Fentanyl.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Fentanyl_DescShort);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_fentanylSyringe: kat_syringeBase {
        displayName = CSTRING(Fentanyl_Box_Display);
        descriptionShort = CSTRING(Fentanyl_DescShort);
    };
    class kat_nalbuphine: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Nalbuphine_Box_Display);
        picture = QPATHTOF(ui\icon_Nalbuphine.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Nalbuphine_DescShort);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        };
    };
    class kat_nalbuphineSyringe: kat_syringeBase {
        displayName = CSTRING(Nalbuphine_Box_Display);
        descriptionShort = CSTRING(Nalbuphine_DescShort);
    };
    class kat_lorazepam: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Lorazepam_displayName);
        picture = QPATHTOF(ui\icon_lorazepam.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Lorazepam_DescShort);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.2;
        };
    };
    class kat_lorazepamSyringe: kat_syringeBase {
        displayName = CSTRING(Lorazepam_displayName);
        descriptionShort = CSTRING(Lorazepam_DescShort);
    };
    class kat_flumazenil: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Flumazenil_displayName);
        picture = QPATHTOF(ui\icon_flumazenil.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Flumazenil_DescShort);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.2;
        };
    };
    class kat_flumazenilSyringe: kat_syringeBase {
        displayName = CSTRING(Flumazenil_displayName);
        descriptionShort = CSTRING(Flumazenil_DescShort);
    };
    class kat_etomidate: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Etomidate_displayName);
        picture = QPATHTOF(ui\icon_etomidate.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Etomidate_DescShort);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.2;
        };
    };
    class kat_etomidateSyringe: kat_syringeBase {
        displayName = CSTRING(Etomidate_displayName);
        descriptionShort = CSTRING(Etomidate_DescShort);
    };
    class kat_syringe: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Syringe_displayName);
        descriptionShort = CSTRING(Syringe_DescUse);
        picture = QPATHTOF(ui\syringe_item.paa);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.1;
        };
    };
};
