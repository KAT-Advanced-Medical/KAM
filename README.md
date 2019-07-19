<p align="center">
    <img src="https://raw.githubusercontent.com/Katalam/KAM/master/logo.jpg">
</p>

<p align="center">
    <a href="https://github.com/Katalam/KAM/releases/latest">
        <img src="https://img.shields.io/badge/Version-1.0.0.0-blue.svg?style=flat-square" alt="KAM Version">
    </a>
    <a href="https://github.com/Katalam/KAM/issues">
        <img src="https://img.shields.io/github/issues-raw/Katalam/KAM.svg?style=flat-square&label=Issues" alt="KAM Issues">
    </a>
    <a href="https://github.com/Katalam/KAM/releases">
        <img src="https://img.shields.io/github/downloads/Katalam/KAM/total.svg?style=flat-square&label=Downloads" alt="KAM Downloads">
    </a>
    <a href="https://circleci.com/gh/Katalam/KAM">
        <img src="https://circleci.com/gh/Katalam/KAM.svg?style=svg" alt="KAM Build Status">
    </a>
</p>

<p align="center">
    <sup><strong>Requires the latest version of <a href="https://github.com/CBATeam/CBA_A3/releases">CBA A3</a>.<br/>
    Visit me on <a href="https://discord.gg/HbA93HK">Discord</a></strong></sup>
</p>


**The ACE Advanced Medical System is nice, but we can do it better, even on a more realistic way and bring it on another level with these addons.**<br/>
*Created by Katalam*

Big thanks to
---------
+ [Kellerkompanie](http://kellerkompanie.com/)

## Core features

- Airway
  - [x] Airwaymanagement for unconscious patients
    - [x] Head overstretching
    - [x] Intubation
    - [x] Aspiration
- Breathing
  - [x] Oxygen saturation
- Circulation
  - [x] Blood Groups
  - [x] Painkillers
  - [x] Bigger AED with monitoring
- Disability
  - [x] Cut of clothes
  - [x] Allergical reactions
- Exposure
  - [ ] Heat-preserving
- Misc
  - [ ] Big Backpack?
  - [x] Workable IV stand

Known Issues
------------
+ [Issues](https://github.com/Katalam/KAM/issues)

Required
--------
+ [CBA_A3 1.20 or later](http://www.armaholic.com/page.php?id=18767)
+ [ACE3 1.80 or later](https://ace3mod.com/)

Youtube
--------
+ [Airway](https://youtu.be/V0csFQ1PLIw)
+ [Breathing](abc)
+ [Circulation](abc)
+ [Disability](abc)
+ [Exposure](abc)
+ [Misc](abc)

Class Names
--------
+ [click here](https://github.com/Katalam/KAM/wiki/Class-Names)

## Contributing

You can help out with the ongoing development by looking for potential bugs in my code base, or by contributing new features. I am always welcome to new pull requests containing bug fixes, refactors and new features.

### Building
The build process is base on the [ACE3 build process](https://ace3mod.com/wiki/development/setting-up-the-development-environment.html), so you can follow the steps there. Basically the following is needed:
+ correctly setup project drive (P: drive)
+ download/clone KAM GitHub repo
+ switch to the tools/ folder and execute ```python setup.py```
+ you can build by executing ```python build.py``` from the tools folder
+ for testing include your mod by adding ```-mod=x\KAM``` as start parameter

For building release builds see [ACE3 reference](https://ace3mod.com/wiki/development/setting-up-the-development-environment.html).

### Submitting issues and requesting features

Please, use my [Issue Tracker](https://github.com/Katalam/KAM/issues) to report a bug, propose a feature, or suggest changes to the existing ones.

## License

KAM is licensed under the GNU General Public License ([GPLv3](LICENSE)).
