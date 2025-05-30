# World at War Weapon Pack

As seen on the [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3450780956) and [UGX](https://www.ugx-mods.com/forum/mod-releases/75/world-at-war-zombies-weapon-pack/24597/)

## Installation instructions for building this mod:

Install *all* of these assets first, since files from this repo are meant to override some of the assets.

It's advised to make a back-up of wpn_t7_zmb_weapons.gdt, since this will be replaced with a version that doesn't produce duplicate asset errors with Smurphy's Improved BO3 Ray Gun
some might want to make a back-up of core_patch.csv or skip copying the zone_source folder as it is only here to demonstrate that weaponoptions.csv must be commented out
you can skip copying the bin folder as it is only here to demonstrate that \_custom is to be added to converter_gdt_dirs_0.txt
Note also that share\raw\sound\aliases\user_aliases.csv and share\raw\sound\globals\loadspec.csv are replaced if you need to make a back-up of them.

* TheAllNightFall's WaW Weapon Ports (don't forget [Weapon Common](https://drive.google.com/file/d/1pzasvTU0tIFtmKbepyGXPPpdEYNyMXmq)):
  * https://www.devraw.net/approved-assets/theallnightfall/world-at-war-shotguns
  * https://www.devraw.net/approved-assets/theallnightfall/world-at-war-lmg's
  * https://www.devraw.net/approved-assets/theallnightfall/world-at-war-rifles
  * https://www.devraw.net/approved-assets/theallnightfall/world-at-war-smg-ports
  * https://www.devraw.net/approved-assets/theallnightfall/world-at-war-snipers%2Fbolt-action
  * https://www.devraw.net/approved-assets/theallnightfall/world-at-war-pistols
  * https://www.devraw.net/approved-assets/theallnightfall/world-at-war-raygun
* Lamy619's WaW Bouncing Betties Port: https://www.devraw.net/approved-assets/lamy619/waw-bouncing-betties-port
* TheSkyeLord's [M1 Garand Rifle Grenade and Panzerschreck ports](https://www.ugx-mods.com/forum/full-weapons/84/skyes-waw-weapon-ports/24598/) (don't forget [Weapon Common](https://www.icloud.com/iclouddrive/04bF59Ei7A2KzlUMau4i3KBRg#Skye%5FWaW%5FWeapon%5FCommon))
* ZeRoY's Flamethrower: https://drive.google.com/file/d/1k4FVM1TKrOxHhzy53g34k7Hc4W8Jxm6X
* Smurphy's Improved BO3 Ray Gun: https://forum.modme.co/wiki/threads/3714.html
* Etching camo from Smurphy's Remastered WaW PPSh: https://mega.nz/file/u0dljYBS#XneH4eOMTpdzHvuj6BewspVSj1f5JnHOCM1FrGKSsHw
* Kingslayer Kyle's Stielhandgranate (wpn_t7_grenade_german_m24) from the BO3 Gun Pack: https://drive.google.com/file/d/1aMRDiL1esfDM31sb9tIlkgiQzpx6fnKj/view
* L3akMod: https://wiki.modme.co/wiki/black_ops_3/lua_(lui)/Installation.html
* Scobalula's T7MTEnhancements: https://github.com/Scobalula/T7MTEnhancements
* Ronan's Custom Perk & Powerup Shaders: https://forum.modme.co/wiki/threads/3206.html (install in texture_assets\Ronans_Classic_Shaders)
* Humphrey's Shadows of Evil Perk Shaders: https://drive.google.com/file/d/1IroyZV3U7ZDfXGrGMML6we821YXEDlYC/view (install images from 'BO3' folder and PhD Flopper from 'BO2' folder into a single directory: texture_assets\Humphreys_Shadows_of_Evil)
* Booris's Shadow Man Announcer: https://mega.nz/file/UdFzBAIa#oMbcLFIkdNNbcNzIEcfSuXbrpQZtKMsadJCmMHaxupI (NOTE: shadowman_transition.wav and shadowman_die.wav are located at sound_assets\zmb\level\zm_zod\ee in the download but need to be moved to sound_assets\zmb\level\zm_zod\ee\shadowman due to an oversight in the sound aliases file)
* Booris's Dr Monty Announcer: https://mega.nz/file/pZUnXSgI#ep8q0VdDrK2CpwyIaX1072dOC977KqPQW9MStBgg3D4
* J.G's Origins Samantha Announcer: https://drive.google.com/file/d/1Se-dNLd88-Vm-oWGsr2mpA4qfKvng5bP/view?usp=sharing
* Westchief596's BO1 Moon Richtofen Announcer: https://www.devraw.net/approved-assets/westchief596/moon-richtofen-announcer
* VoiceOfJared's Richtofen Announcer: https://drive.google.com/file/d/1q_kTWCKhjMoyHShXDacOMtS_3V7v1IAW/view
* BetiroVal's Classic Mystery Box FX: https://mega.nz/file/8N8RWSwR#qzX95Nii7kD5EBkyMs5QcwINySMMOJv-fCQB3OdfViY
* FrostIceforge's Custom Zombie Eye Colors: https://forum.modme.co/wiki/threads/2274.html
* MadKixs' Perks Shaders in BO3 style: https://forum.modme.co/wiki/threads/2836.html (install images from 'Black Ops 3 Perks' folder, [Perk] phd.tiff and [Perk] double_tap_2.0.tiff from 'Black Ops 2 Perks' folder into a single directory: texture_assets\Custom_Perk_Shaders), this is also what specialty_giant_alt_doubletap_zombies.tiff is taken from
* emptyFXIW.efx file from WETEGG's Infinite Warfare Perk Ports: https://drive.google.com/file/d/1I5-RkXzoDX8zieCfyIPNt4QVNx7R6Nz-/view?usp=sharing
* MikeyRay's Customizable PHD Flopper: https://forum.modme.co/wiki/threads/3537.html
* Pmr360's Black Ops 1/4 - Revive animation: https://www.devraw.net/approved-assets/pmr360/black-ops-1%2F4---revive-animation
* Kingslayer Kyle's World at War HUD: https://drive.google.com/file/d/1TwEbNNcF1H59AsKANSvK-MC_09aAbouk/view (including [BlackOps3Shaders](https://github.com/LG-RZ/BlackOps3Shaders/releases))
* natesmithzombies's Custom Random Weapon Powerup: https://forum.modme.co/wiki/threads/706.html
* Rayjiun's black-and-white visionset: https://discord.com/channels/230615005194616834/230616047613378560/1128724861666218046
* eMoX's T8 Powerup Delayed Drop: https://www.devraw.net/approved-assets/emox/emox---t8-powerup-delayed-drop

Required for TF's Zombie Options:
* natesmithzombies's Zombie Money, Bottomless Clip, Zombie Blood Powerups; ZoekMeMaar's Free Pack a Punch Powerup: https://forum.modme.co/wiki/threads/2831.html (ignore script files, these are installed from this repo)

Then install all files from this repo into your Black Ops III installation apart from the folder chalk_drawing_models, which is for reference purposes only

## Credits

* TheAllNightFall for making this possible with the majority of the weapon ports in this mod
* Scobalula's [Cereberus](https://github.com/Scobalula/Cerberus-Repo/releases/tag/CustomMapsGoVroom) to extract script files for reference purposes from Deadshot.mp4's [COTD Chronicles Conversion Mod](http://steamcommunity.com/sharedfiles/filedetails/?id=2911456494)
* Scobalula's [Greyhound](https://github.com/Scobalula/Greyhound) for image extraction (circuits camo, chalk drawings)
* Scobabula's [HydraX](https://github.com/Scobalula/HydraX) for general asset decompilation, especially map _weapons.csv files
* [Birdman's XModel Tools For Blender](https://github.com/Wast-3/birdmans-xmodel-tools-for-blender)
* Ronan_M for [Custom Powerup Shaders](https://forum.modme.co/wiki/threads/3206.html)
* [Poyzee](https://steamcommunity.com/profiles/76561199105452001) and [Conn6orsuper117](https://steamcommunity.com/id/Conn6orsuper117) for contributing wallbuy layouts for Der Eisendrache (both) and Zetsubou no Shima (Connor)
* [HzRetro](https://www.ugx-mods.com/forum/mlist/hzretro_764845) for contributing wallbuy layout for Origins
* XcDylan93 for dive-to-prone and sprint/reload cancel script
* TheSkyeLord for weaponcamo setup from [his own pack](https://www.ugx-mods.com/forum/full-weapons/84/skyes-waw-weapon-ports/24598/) used by me as a basis for WaW weapons
* Apex for xmodelalias fix ([originally here](https://steamcommunity.com/sharedfiles/filedetails/?id=1833845566), one file extracted with Cerberus and other files downloaded [from here](https://github.com/clixmods/zm_nuked/blob/main/scripts/shared))
* TescoFresco for [TF's Zombie Options](TescoFresco for TF's Zombie Options)
