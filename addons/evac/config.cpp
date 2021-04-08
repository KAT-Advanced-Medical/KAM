#include "BIS_AddonInfo.hpp"
class CfgPatches
{
	class kat_evac
	{
		name="Attachable Stretcher";
		units[]={};
		weapons[]={"Attachable_Stretcher"};
		requiredVersion=1;
		requiredAddons[]=
		{
			"cba_main"
		};
		author="Battlekeeper"
	};
};

class CfgWeapons
{
	class ToolKit;
	class Attachable_Stretcher: ToolKit
	{
		author = "Battlekeeper";
		picture = "\evac\img\stretcher.paa";
		displayName = "Attachable Stretcher";
		descriptionShort = "Allows you to attach a stretcher";
		class ItemInfo
		{
			mass = 20;
			uniformModel = "\A3\Weapons_F\Items\Toolkit";
			type = 620;
			allowedSlots[] = {801,701,901};
			scope = 0;
		};
	};
};


class CfgFunctions
{
	class Rev
	{
		class stretcher
		{
			file="\evac\functions";
			class stretcher_init {postInit=1;};
			class stretcher_attach {};
		};
	};
};