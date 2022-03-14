#include "script_component.hpp"
////////////////////////////////

////////////////////////////////


[] spawn { 
	_fnc_airpoisen = {
		player setVariable ["kat_chemical_airPoisend",true,true];
		
		[player, "RightArm", "PoisenBP"] call FUNC(medicationLocal);
		kat_lastpoisend = CBA_missionTime;
		waitUntil {(CBA_missionTime - kat_lastpoisend) > 30};
		[] spawn FUNC(handlePoisenDamage);
	};
	

	
	waitUntil {!(player getVariable ["ACE_isUnconscious",false]) };
	waitUntil {player getVariable ["kat_chemical_airPoisend",false] || player getVariable ["kat_chemical_CS",false]};
	if(player getVariable ["kat_chemical_airPoisend",false]) then {
		[] spawn _fnc_airpoisen;
	};
};




