#include "..\script_component.hpp"

params["_patient"];

private _amount = [_patient] call FUNC(getNumberOfTourniquets);
_amount > 0