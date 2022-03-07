# KAT Medical

<p align="center">
    <img src="https://raw.githubusercontent.com/Tomcat-SG/KAM/master/logo.jpg">
</p>

<p align="center">
    <a href="https://github.com/Tomcat-SG/KAM/releases/latest">
        <img src="https://img.shields.io/badge/Version-2.0-blue.svg?style=flat-square" alt="KAM Version">
    </a>
    <a href="https://github.com/Tomcat-SG/KAM/issues">
        <img src="https://img.shields.io/github/issues-raw/Tomcat-SG/KAM.svg?style=flat-square&label=Issues" alt="KAM Issues">
    </a>
    <a href="https://github.com/Tomcat-SG/KAM/releases/latest">
        <img src="https://img.shields.io/github/downloads/Tomcat-SG/KAM/total.svg?style=flat-square&label=Downloads" alt="KAM Downloads">
    </a>
</p>

<p align="center">
    <sup><strong>Download latest stable release on <a href="https://steamcommunity.com/sharedfiles/filedetails/?id=2020940806">steam</a>.<br/>
    Visit us on <a href="https://discord.gg/HbA93HK">Discord</a></strong></sup>
</p>


**The ACE Advanced Medical System is nice, but we can do it better, even on a more realistic way and bring it on another level with these addons.**

Originaly created by Katalam, currently maintained by Tomcat, Kygan and YetheSamartaka.

## Big thanks to

- [Katalam](https://github.com/Katalam)
- [Kellerkompanie](http://kellerkompanie.com/)
- [Tomcat-SG](https://github.com/Tomcat-SG)
- [Kygan/Conrimaceogain](https://github.com/Conrimaceogain)
- [YetheSamartaka](https://github.com/YetheSamartaka)
- [regiregi22](https://github.com/regiregi22)

## Disclaimer from current Developers

- This Git is for Development use, full playable version is also on Steam availible (https://steamcommunity.com/sharedfiles/filedetails/?id=2020940806)
- Everybody can make Pull/Push request
- As this addon depends on ACE, some of its updates may break KAT, so fix from our side can take some time
- New features are still in development

## Core features

- Airway
  - [x] Airway management for unconscious patients
    - [x] Head overstretching
    - [x] Intubation
    - [x] Aspiration
    - [x] Items such as Guedel tube, KingLT and Acuvacc
- Breathing
  - [x] Oxygen saturation
  - [x] Pulse-oximeter
  - [x] Pneumothorax, tension pneumothorax and hemothorax
- Circulation
  - [x] Blood Groups
  - [x] Painkillers
  - [x] Automated external defibrillators
  - [x] Settable sucess CPR chances per medical level expertise
- Burns
  - [ ] Burn injuries
  - [ ] Burn injuries treatment
- Exposure
  - [ ] Heat-preserving?
- Misc
  - [ ] Big Backpack?
  - [x] Workable IV stand

## Known Issues

- [Issues](https://github.com/Tomcat-SG/KAM/issues)

## Required

- [CBA_A3 v3.15.0 or later](https://steamcommunity.com/sharedfiles/filedetails/?id=450814997)
- [ACE3 3.13.4 or later](https://steamcommunity.com/sharedfiles/filedetails/?id=463939057)

## Youtube - Currently outdated

- [Airway](https://youtu.be/V0csFQ1PLIw)
- [Breathing](abc)
- [Circulation](abc)
- [Disability](abc)
- [Exposure](abc)
- [Misc](abc)

## Class Names - WIP

- [click here](https://github.com/Katalam/kat_aceAdvMedical/wiki/Class-Names)

## Contributing

You can help out with the ongoing development by looking for potential bugs in my code base, or by contributing new features. I am always welcome to new pull requests containing bug fixes, refactors and new features.

### Building

The build process is base on the [ACE3 build process](https://ace3mod.com/wiki/development/setting-up-the-development-environment.html), so you can follow the steps there. Basically the following is needed:

- correctly setup project drive (P: drive)
- download/clone kat_aceAdvMedical GitHub repo
- switch to the tools/ folder and execute ```python setup.py```
- you can build by executing ```python build.py``` from the tools folder
- for testing include your mod by adding ```-mod=x\kat``` as start parameter

For building release builds see [ACE3 reference](https://ace3mod.com/wiki/development/setting-up-the-development-environment.html).

### Submitting issues and requesting features

Please, use my [Issue Tracker](https://github.com/Katalam/kat_aceAdvMedical/issues) to report a bug, propose a feature, or suggest changes to the existing ones.

## License

This work is licensed under [GPL 3.0](https://www.gnu.org/licenses/gpl-3.0.html)
