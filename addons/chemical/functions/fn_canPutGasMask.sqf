#include "script_component.hpp"
//////////////////////////

//////////////////////////

params ["_player", "_patient"];

//abfrage ob gasmaske vorhanden hinzufügen
!(_patient call ACE_common_fnc_isAwake) && ([_player,_patient] call FUNC(hasGasmask)) && !(goggles _patient in KAT_AVAIL_GASMASK)
