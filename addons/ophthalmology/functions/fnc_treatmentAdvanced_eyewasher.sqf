#include "..\script_component.hpp"
/*
 * Author: Katalam
 * Handles the treatment of dust or heavy dust in eyes
 * with an eye washer.
 *
 * Return Value:
 * None
 *
 * Public: No
 *
 */

params ["_medic", "_patient"];

_this call FUNC(treatmentAdvanced_eyewash);
