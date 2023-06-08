class cfgGlasses
{
	class G_RegulatorMask_base_F;
	class G_RegulatorMask_F: G_RegulatorMask_base_F
	{
		ACE_Overlay = QPATHTOF(ui\overlay_style_m50.paa);
	};
	
	class G_AirPurifyingRespirator_02_base_F;
	class G_AirPurifyingRespirator_02_black_F :G_AirPurifyingRespirator_02_base_F
	{
		ACE_Overlay = QPATHTOF(ui\overlay_style_m50.paa);
	};
	
	class G_AirPurifyingRespirator_02_olive_F :G_AirPurifyingRespirator_02_base_F
	{
		ACE_Overlay = QPATHTOF(ui\overlay_style_m50.paa);
	};
	
	class G_AirPurifyingRespirator_02_sand_F :G_AirPurifyingRespirator_02_base_F
	{
		ACE_Overlay = QPATHTOF(ui\overlay_style_m50.paa);
	};
	
	class G_AirPurifyingRespirator_01_F :G_AirPurifyingRespirator_02_base_F
	{
		ACE_Overlay = QPATHTOF(ui\overlay_style_m50.paa);
	};
	
	class G_CBRN_M50: G_RegulatorMask_F
	{
		author = "Assaultboy";
		displayname = "M50 Promask";
		model = QPATHTOF(models\kat_mask_m50.p3d);
		picture = QPATHTOF(ui\maskM50.paa);
		identityTypes[] = {};
		mass = 4;
	};
	
	class G_CBRN_M04: G_CBRN_M50
	{
		author = "Assaultboy";
		displayname = "M04 Promask";
		model = QPATHTOF(models\kat_mask_m04.p3d);
		picture = QPATHTOF(ui\maskM04.paa);
	};
};