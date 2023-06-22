class cfgGlasses
{
    class G_RegulatorMask_F;
    class kat_mask_M50: G_RegulatorMask_F
    {
        author = "Assaultboy";
        displayname = "M50 Promask";
        model = QPATHTOF(models\kat_mask_m50.p3d);
        picture = QPATHTOF(ui\maskM50.paa);
        identityTypes[] = {};
        mass = 4;

    };
    
    class kat_mask_M04: kat_mask_M50
    {
        author = "Assaultboy";
        displayname = "M04 Promask";
        model = QPATHTOF(models\kat_mask_m04.p3d);
        picture = QPATHTOF(ui\maskM04.paa);
    };
};