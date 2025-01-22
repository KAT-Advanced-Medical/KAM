class CfgWeapons {
    class ACE_ItemCore;
    class CBA_MiscItem_ItemInfo;
    class kat_basicDiagnostic: ACE_ItemCore {
        scope = 2;
        author = "Mazinski";
        displayName = CSTRING(basicDiagnostic_display);
        descriptionShort = CSTRING(basicDiagnostic_description);
        picture = QPATHTOF(ui\basicDiagnostic.paa);
        ACE_isMedicalItem = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 8;
        };
    };
};
