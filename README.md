# Black Ops 1 Weapon Pack

As seen on the [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2987931258) and [UGX](https://www.ugx-mods.com/forum/mod-releases/75/black-ops-1-zombies-weapon-pack/23821/)

## Installation instructions:

Install *all* of these assets first, since files from this repo are meant to override some of the assets. L3akMod and T7MTEnhancements are required additions to ensure Mod Tools can properly build the mod.

It's advised to make a back-up of wpn_t7_zmb_weapons.gdt, since this will be replaced with a version that doesn't produce duplicate asset errors with Smurphy's Improved BO3 Ray Gun

* TheSkyeLord's BO1 Weapon Ports: https://www.ugx-mods.com/forum/full-weapons/84/skyes-bo1-weapon-ports/23143/
* L3akMod: https://wiki.modme.co/wiki/black_ops_3/lua_(lui)/Installation.html
* Scobalula's T7MTEnhancements: https://github.com/Scobalula/T7MTEnhancements
* Smurphy's Improved BO3 Ray Gun: https://forum.modme.co/wiki/threads/3714.html
* Smurphy's Remastered WaW PPSh: https://www.devraw.net/releases/remastered-waw-ppsh
* Hogarth935's Black Ops 1 Style PaP Camo: https://www.devraw.net/forums/submit-releases/black-ops-1-style-pap-camo
* Ronan's Custom Perk & Powerup Shaders: https://forum.modme.co/wiki/threads/3206.html (install in texture_assets\Ronans_Classic_Shaders)
* JBird632's Custom Claymores: https://youtu.be/iYP_CdMhwG4
* pmr360's Black Ops Cold War Ballistic Knife and Crossbow https://forum.modme.co/wiki/threads/3540.html (don't install 'h1' folders (shellejects) in source_data and model_export, these are already included in Skye's ports; remember to install WEAPON COMMON, if you don't want to fully install then specific files used include sound_assets, t9_sounds_template.csv, fx_muz_md_smk_air_ .efx files, knife_ballistic_reticle.png, reticle_crossbow.png - images needed to be defined in _wpn_t9_common.gdt)
* natesmithzombies's Custom Random Weapon Powerup: https://forum.modme.co/wiki/threads/706.html
* Kingslayer Kyle's Ray Gun Mark II from the BO3 Gun Pack: https://drive.google.com/file/d/1aMRDiL1esfDM31sb9tIlkgiQzpx6fnKj/view (remember to install wpn_t7_common_fx, share\raw\fx\dlc5\zmb_weapon\fx_raygun2_ .efx files need to be renamed to fx_raygunii_)
* Humphrey's Shadows of Evil Perk Shaders: https://www.devraw.net/releases/shadows-of-evil-perk-shaders (install images from 'BO3' folder and PhD Flopper from 'BO2' folder into a single directory: texture_assets\Humphreys_Shadows_of_Evil)
* Booris's Shadow Man Announcer: https://www.devraw.net/releases/shadow-man-announcer (NOTE: shadowman_transition.wav and shadowman_die.wav are located at sound_assets\zmb\level\zm_zod\ee in the download but need to be moved to sound_assets\zmb\level\zm_zod\ee\shadowman due to an oversight in the sound aliases file)
* Booris's Dr Monty Announcer: https://www.devraw.net/releases/dr.-monty-announcer
* J.G's Origins Samantha Announcer: https://www.devraw.net/releases/origins-samantha-announcer
* Westchief596's BO1 Moon Richtofen Announcer: https://www.devraw.net/releases/bo1-moon-richtofen-announcer-
* VoiceOfJared's Richtofen Announcer: https://www.devraw.net/releases/richtofen-announcer
* BetiroVal's Classic Mystery Box FX: https://www.devraw.net/forums/submit-releases/classic-mystery-box-fx/dl-245bf982-f8a7-4ad2-ac61-c3292e07f3ce (NOTE: p7_zm_der_magic_box_beam_rainbow.tif is already included in this repo and has been renamed to p7_zm_der_magic_box_beam_rainbow_classic.tif)
* FrostIceforge's Custom Zombie Eye Colors: https://forum.modme.co/wiki/threads/2274.html
* MadKixs' Perks Shaders in BO3 style: https://forum.modme.co/wiki/threads/2836.html (install images from 'Black Ops 3 Perks' folder, [Perk] phd.tiff and [Perk] double_tap_2.0.tiff from 'Black Ops 2 Perks' folder into a single directory: texture_assets\Custom_Perk_Shaders), this is also what specialty_giant_alt_doubletap_zombies.tiff is taken from, this is also what specialty_giant_alt_doubletap_zombies.tiff is taken from
* emptyFXIW.efx file from WETEGG's Infinite Warfare Perk Ports: https://www.devraw.net/releases/infinite-warfare-perk-ports
* Rayjiun's black-and-white visionset: https://discord.com/channels/230615005194616834/230616047613378560/1128724861666218046
* Sten from Skye's CoD WWII Weapon Ports: https://www.ugx-mods.com/forum/full-weapons/84/skyes-wwii-weapon-ports-page-1/23134/
* ai_zombie_spets_roll_ and ai_zombie_spets_sidestep_left_ .xanim files (xanim_export\black_ops_3\zombie) from Harrybo21's New BT Stuff v3.0.0: https://www.devraw.net/releases/bt-stuff-presets
* MikeyRay's Customizable PHD Flopper: https://forum.modme.co/wiki/threads/3537.html

Required for TF's Zombie Options:
* natesmithzombies's Zombie Money, Bottomless Clip, Zombie Blood Powerups; ZoekMeMaar's Free Pack a Punch Powerup: https://forum.modme.co/wiki/threads/2831.html (ignore script files, these are installed from this repo)

Then install all files from this repo into your Black Ops III installation apart from the folder chalk_drawing_models, which is for reference purposes only

## Credits

* TheSkyeLord for making this possible with the majority of the weapon ports in this mod, also the source for these wallbuy assets:
  * chalk drawing images for Gewehr 43, M1A1 Carbine, StG 44, MP40, Kar98k, Thompson M1A1, Type 100, FG42, M30 from Skye's CoD WWII Weapon Ports: https://www.ugx-mods.com/forum/full-weapons/84/skyes-wwii-weapon-ports-page-1/23134/
  * chalk drawing for M1897 Trebuchet from Skye's BO4 Weapon Ports: https://www.ugx-mods.com/forum/full-weapons/84/skyes-bo4-weapon-ports/23133/ 
* [Beandon](https://steamcommunity.com/id/Beandon11) for providing Death Machine announcer voicelines
* [N7aster](https://steamcommunity.com/profiles/76561199467224180) for providing Black Ops explosion sounds (weapons, PhD Flopper) and "FIVE" quotes from Ascension's Red Telephones
* Scobalula's [Greyhound](https://github.com/Scobalula/Greyhound) for image extraction (circuits camo, chalk drawings)
* Scobabula's [HydraX](https://github.com/Scobalula/HydraX) for general asset decompilation, especially map _weapons.csv files
* [Birdman's XModel Tools For Blender](https://github.com/Wast-3/birdmans-xmodel-tools-for-blender)
* Scobalula's [Bo3Mutators](https://github.com/Scobalula/Bo3Mutators) for options menu set-up, and Serious for pointing this out to me
* Logical Edits for [Custom Perk Icons set-up](https://www.youtube.com/watch?v=m_HqGZy0afs&feature=youtu.be)
* TescoFresco for [TF's Zombie Options](https://github.com/tescfresc/TFs-Zombie-Options)
* Harrybo21 for crossbow bolt FX and PaP 'monkey bomb' set-up from Blundergat Weapon Pack: https://www.devraw.net/releases/blundergat-weapon-pack