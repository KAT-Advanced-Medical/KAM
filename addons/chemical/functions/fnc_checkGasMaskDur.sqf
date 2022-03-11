#include "script_component.hpp"
///////////////////////////////

///////////////////////////////

params ["_target","_player"];


if (_player == _target) then {
    [_player, "Gear", 1] call ace_common_fnc_doGesture;
};
 
[{_this call FUNC(displayGasMaskDur)}, [_target], 1] call CBA_fnc_waitAndExecute;
