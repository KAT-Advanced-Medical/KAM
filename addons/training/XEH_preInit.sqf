#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

// Per frame handler of the guided training of this player, -1 while none is running
GVAR(tutorialHandle) = -1;

ADDON = true;
