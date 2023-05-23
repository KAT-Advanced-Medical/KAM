class CfgGlasses
{
	class None;
	class kat_armband_red_cross: None
	{
		author = "Miss Heda, vccv9040 (Swedish Forces Pack)";
		displayname = CSTRING(Armband_Red_Cross_ItemName);
		hiddenSelections[] = {"Armband"};
		hiddenSelectionsTextures[] = {QPATHTOF(models\armband\ArmbandWC.paa)};
		model = QPATHTOF(models\armband\Armband.p3d);
		picture = QPATHTOF(ui\ArmbandWhiteCross.paa);
		mass = 2;
	};

	class kat_armband_medic: kat_armband_red_cross
	{
		author= "Miss Heda, vccv9040 (Swedish Forces Pack)";
		displayname = CSTRING(Armband_Medic_ItemName);
		hiddenSelectionsTextures[] = {QPATHTOF(models\armband\ArmbandWCM.paa)};
		picture= QPATHTOF(ui\ArmbandWhiteCrossMedic.paa);
	};

	class kat_armband_doctor: kat_armband_red_cross
	{
		author= "Miss Heda, vccv9040 (Swedish Forces Pack)";
		displayname = CSTRING(Armband_Doctor_ItemName);
		hiddenSelectionsTextures[] = {QPATHTOF(models\armband\ArmbandWCD.paa)};
		picture= QPATHTOF(ui\ArmbandWhiteCrossDoctor.paa);
	};

	class kat_armband_kat: kat_armband_red_cross
	{
		author= "Miss Heda, vccv9040 (Swedish Forces Pack)";
		displayname = CSTRING(Armband_Kat_ItemName);
		hiddenSelectionsTextures[] = {QPATHTOF(models\armband\ArmbandKAT.paa)};
		picture= QPATHTOF(ui\ArmbandKat.paa);
	};
};

