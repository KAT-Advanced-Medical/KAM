#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CAT LSTRING(cba_name)
#include "initSettings.inc.sqf"

/*
When a patient enters the unconscious state, there are two things that can happen.
First of all the airway can collapse. In medical sense this mean, the airway can be blocked from your tongue muscle, 'cause of the missing muscle tone.
For example in real life, this will happen to nearly every unconscious person lying on the back.

The second thing that can happen is the the airway occluded state. When a patient is lying on the back and the body puke, it will not leave the mouth space.
It will stay in there and can block the airway too. The right treatment here, is to remove this vomit.
In real life, this will happen sometimes, not quiet often.
*/

ADDON = true;