class CfgWeapons {
    class ACE_ItemCore;
    class kat_basicDiagnostic: ACE_ItemCore {
        scope = 2;
        author = "Mazinski";
        displayName = CSTRING(basicDiagnostic_display);
        descriptionShort = CSTRING(basicDiagnostic_description);
        picture = QPATHTOF(ui\BPCuff.paa); // FLAG
        icon = "";
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 8;
        };
    };
};