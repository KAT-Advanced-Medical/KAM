#include "..\script_component.hpp"
/*
 * Author: MiszczuZPolski
 * Shows a guided training hint.
 *
 * Arguments:
 * 0: Title <STRING>
 * 1: Text <STRING>
 * 2: Progress line shown under the title <STRING> (default: "")
 * 3: Show without the hint sound <BOOL> (default: false)
 *
 * Return Value:
 * None
 *
 * Example:
 * ["Airway", "Check the airway of the patient."] call kat_training_fnc_showTutorialHint
 *
 * Public: No
 */

params [["_title", "", [""]], ["_text", "", [""]], ["_progress", "", [""]], ["_silent", false, [false]]];

private _hint = parseText format ["<t size='1.3' color='#f5c542'>%1</t><br/><t size='0.9' color='#aaaaaa'>%2</t><br/><br/>%3", _title, _progress, _text];

if (_silent) then {
    hintSilent _hint;
} else {
    hint _hint;
};
