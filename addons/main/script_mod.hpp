// COMPONENT should be defined in the script_component.hpp and included BEFORE this hpp

#define MAINPREFIX x
#define PREFIX kat

#include "script_version.hpp"

#define VERSION     MAJOR.MINOR
#define VERSION_STR MAJOR.MINOR.PATCH
#define VERSION_AR  MAJOR,MINOR,PATCHLVL,BUILD

#define VERSION_CONFIG version = MAJOR.MINOR; versionStr = QUOTE(MAJOR.MINOR.PATCH); versionAr[] = {MAJOR,MINOR,PATCH}

// MINIMAL required version for the Mod. Components can specify others..
#define REQUIRED_VERSION 2.14
#define REQUIRED_CBA_VERSION {3,15,7}

#ifdef COMPONENT_BEAUTIFIED
    #define COMPONENT_NAME QUOTE(KAT - COMPONENT_BEAUTIFIED)
#else
    #define COMPONENT_NAME QUOTE(KAT - COMPONENT)
#endif
