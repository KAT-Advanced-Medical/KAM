class CfgWeapons {
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;

    class kat_PainkillerItem: ACE_ItemCore {
        scope = 1; // no mistake, just a placeholder, cause ACE can't handle magazines. DO NOT USE!
        author = "Katalam";
        displayName = CSTRING(Painkillers_Box_Display);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0;
        };
    };
    class kat_CarbonateItem: ACE_ItemCore {
        scope = 1; // no mistake, just a placeholder, cause ACE can't handle magazines. DO NOT USE!
        author = "Mazinski.H";
        displayName = CSTRING(Carbonate_Box_Display);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0;
        };
    };
    class kat_AED: ACE_ItemCore {
        scope = 2;
        author = "Katalam";
        displayName = CSTRING(AED_DISPLAYNAME);
        picture = QPATHTOF(ui\defib.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Defibrillator_F.p3d";
        descriptionShort = "$STR_ACEP_circulation_AED_DESCRIPTION";
        descriptionUse = "$STR_ACEP_circulation_AED_DESCRIPTION";
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 30;
        };
    };
    class kat_X_AED: kat_AED {
        scope = 2;
        displayName = CSTRING(X_Display);
        picture = QPATHTOF(ui\x-series.paa);
        model = QPATHTOF(models\aedx\aedx.p3d);
        descriptionShort = CSTRING(X_Desc);
        descriptionUse = CSTRING(X_Desc);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 100;
        };
    };
    class kat_IV_16: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(IV_16_Display);
        picture = QPATHTOF(ui\icon_IV_16.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(IV_DescShort);
        descriptionUse = CSTRING(IV_DescUse);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.1;
        }; 
    };
    class kat_IO_FAST: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(IO_45_Display);
        picture = QPATHTOF(ui\icon_fast_io.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(IO_DescShort);
        descriptionUse = CSTRING(IV_DescUse);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.1;
        }; 
    };
    class kat_naloxone: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Naloxone_Box_Display);
        picture = QPATHTOF(ui\icon_Naloxone.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Naloxone_DescShort);
        descriptionUse = CSTRING(Naloxone_DescUse);
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
        descriptionUse = CSTRING(TXA_DescUse);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.2;
        }; 
    };
    class kat_EACA: ACE_ItemCore {
        scope = 2;
        displayName = "EACA";
        picture = QPATHTOF(ui\icon_TXA.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(EACA_DescShort);
        descriptionUse = CSTRING(EACA_DescUse);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.2;
        };
    };
    class kat_norepinephrine: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Norep_Box_Display);
        picture = QPATHTOF(ui\norep.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Norep_DescShort);
        descriptionUse = CSTRING(Norep_DescUse);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.2;
        }; 
    };
    class kat_phenylephrine: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Phenyl_Box_Display);
        picture = QPATHTOF(ui\phen.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Phenyl_DescShort);
        descriptionUse = CSTRING(Phenyl_DescUse);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.2;
        }; 
    };
    class kat_nitroglycerin: ACE_ItemCore {
        scope = 2;
        displayName = CSTRING(Nitro_Box_Display);
        picture = QPATHTOF(ui\nitro.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Nitro_DescShort);
        descriptionUse = CSTRING(Nitro_DescUse);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.2;
        }; 
    };
    class kat_lidocaine: ACE_ItemCore {
        scope = 2;
        displayName = "Lidocaine";
        picture = QPATHTOF(ui\lidocaine.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Lidocaine_DescShort);
        descriptionUse = CSTRING(Lidocaine_DescUse);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.2;
        }; 
    };
    class kat_etomidate: ACE_ItemCore {
        scope = 2;
        displayName = "Etomidate";
        picture = QPATHTOF(ui\etomidate.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Etomidate_DescShort);
        descriptionUse = CSTRING(Etomidate_DescUse);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.2;
        }; 
    };
    class kat_lorazepam: ACE_ItemCore {
        scope = 2;
        displayName = "Lorazepam";
        picture = QPATHTOF(ui\lorazepam.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Lorazepam_DescShort);
        descriptionUse = CSTRING(Lorazepam_DescUse);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.2;
        }; 
    };
    class kat_flumazenil: ACE_ItemCore {
        scope = 2;
        displayName = "Flumazenil";
        picture = QPATHTOF(ui\flumazenil.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Flumazenil_DescShort);
        descriptionUse = CSTRING(Flumazenil_DescUse);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.2;
        }; 
    };
    class kat_scalpel: ACE_ItemCore {
        scope = 2;
        displayName = "Scalpel";
        picture = QPATHTOF(ui\scalpel.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Scalpel_DescShort);
        descriptionUse = CSTRING(Scalpel_DescUse);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.2;
        }; 
    };
    class kat_retractor: ACE_ItemCore {
        scope = 2;
        displayName = "Retractor";
        picture = QPATHTOF(ui\retractor.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Retractor_DescShort);
        descriptionUse = CSTRING(Retractor_DescUse);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        }; 
    };
    class kat_clamp: ACE_ItemCore {
        scope = 2;
        displayName = "Clamp";
        picture = QPATHTOF(ui\clamp.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Clamp_DescShort);
        descriptionUse = CSTRING(Clamp_DescUse);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.5;
        }; 
    };
    class kat_plate: ACE_ItemCore {
        scope = 2;
        displayName = "Bone Plate";
        picture = QPATHTOF(ui\plate.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Plate_DescShort);
        descriptionUse = CSTRING(Plate_DescUse);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 0.3;
        }; 
    };
    class kat_vacuum: ACE_ItemCore {
        scope = 2;
        displayName = "Dressing Vacuum";
        picture = QPATHTOF(ui\vacuum.paa);
        model = "\A3\Structures_F_EPA\Items\Medical\Painkillers_F.p3d";
        descriptionShort = CSTRING(Vacuum_DescShort);
        descriptionUse = CSTRING(Vacuum_DescUse);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 5;
        };
    };
};
