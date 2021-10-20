

# Code Clean up
Cleaned code to comply with:
- sqf_validator.py
- config_validator.py
- config_style_checker.py
<br>
<br />
</br>
# Configured hemtt
- added PBOPREFIX files
- added the cba and ace includes to /includes
<br>
<br />
</br>
# Workflow
This currently one completes tests on a pull request, some parts are mission to build with sqfc currently.
<br>
<br />
</br>
# SQFC
Currently SQFC can only be compiled on a windows machine.

so here is how you do it!

1. Clone the repo locally
2. Configure the P: drive using the setup.py in tools
3. Install hemtt  https://github.com/BrettMayson/HEMTT/releases
4. Download ArmaScriptCompiler https://github.com/dedmen/ArmaScriptCompiler/actions
5. Copy the contents of ArmaScriptCompiler to the root folder of KAT
6. Run  ``hemtt build --release``
7. SQFC will be included in the release in the /releases folder
<br>
<br />
</br>
# Version number
I had no idea what the corect version number should be so, hemtt pulsl the version from ```addons/main/script_version.hpp ```


