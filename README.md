# Black Ops 1 Weapon Pack

As seen on the [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2987931258) and [UGX](https://www.ugx-mods.com/forum/mod-releases/75/black-ops-1-zombies-weapon-pack/23821/)  
This version is cut down to meet asset limits so that Call of the Dead is able to load, will not work on other maps:
* Removed duplicate PhD Flopper Machine assets
* Removed FX from eMoX Timed Drop Powerups (delay still works but you won't see where it drops beforehand)
* Removed zombie side-step/rolling option
* Removed HUD, Powerup Icon options (never worked on COTD)
* Removed WaW weapon assets
* Removed duplicate claymore assets
* Removed Ray Gun Mark II option
* Removed Winter's Howl option
* Removed Mystery Box FX option
 
## Installation instructions for building this mod:

Install *all* of these assets first, since files from this repo are meant to override some of the assets. L3akMod and T7MTEnhancements are required additions to ensure Mod Tools can properly build the mod.

It's advised to make a back-up of wpn_t7_zmb_weapons.gdt, black_ops_3_fx.gdt since this will be replaced with a version that doesn't produce duplicate asset errors with Smurphy's Improved BO3 Ray Gun
some might want to make a back-up of core_patch.csv or skip copying the zone_source folder as it is only here to demonstrate that weaponoptions.csv must be commented out
you can skip copying the bin folder as it is only here to demonstrate that \_custom is to be added to converter_gdt_dirs_0.txt
Note also that share\raw\sound\aliases\user_aliases.csv and share\raw\sound\globals\loadspec.csv are replaced if you need to make a back-up of them.

* TheSkyeLord's BO1 Weapon Ports: https://www.ugx-mods.com/forum/full-weapons/84/skyes-bo1-weapon-ports/23143/
* TheAllNightFall's Weapon Ports (don't forget [Weapon Common](https://drive.google.com/file/d/1pzasvTU0tIFtmKbepyGXPPpdEYNyMXmq):
  * https://www.devraw.net/approved-assets/theallnightfall/world-at-war-shotguns
  * https://www.devraw.net/approved-assets/theallnightfall/world-at-war-lmg's
  * https://www.devraw.net/approved-assets/theallnightfall/world-at-war-rifles
  * https://www.devraw.net/approved-assets/theallnightfall/world-at-war-smg-ports
  * https://www.devraw.net/approved-assets/theallnightfall/world-at-war-snipers%2Fbolt-action
  * https://www.devraw.net/approved-assets/theallnightfall/world-at-war-raygun
  * https://www.devraw.net/approved-assets/theallnightfall/black-ops-1-thundergun
* Lamy619's [WaW Bouncing Betties Port](https://www.devraw.net/approved-assets/lamy619/waw-bouncing-betties-port)
* Carrabella & WetEgg's Black ops 1 and 2 crossbow, as modified by Nebmajin with script by XcDylan93: https://www.mediafire.com/file/pdzafk5dg9t05tg/Bo1_Bo2_Crossbows_fixed.zip/file
* L3akMod: https://wiki.modme.co/wiki/black_ops_3/lua_(lui)/Installation.html
* Scobalula's T7MTEnhancements: https://github.com/Scobalula/T7MTEnhancements
* Smurphy's Improved BO3 Ray Gun: https://forum.modme.co/wiki/threads/3714.html
* Smurphy's Remastered WaW PPSh: https://mega.nz/file/u0dljYBS#XneH4eOMTpdzHvuj6BewspVSj1f5JnHOCM1FrGKSsHw
* Hogarth935's Black Ops 1 Style PaP Camo: https://www.devraw.net/approved-assets/hogarth/black-ops-1-pap-camo
* Ronan's Custom Perk & Powerup Shaders: https://forum.modme.co/wiki/threads/3206.html (install in texture_assets\Ronans_Classic_Shaders)
* JBird632's Custom Claymores: https://youtu.be/iYP_CdMhwG4
* pmr360's Black Ops Cold War Ballistic Knife and Crossbow https://forum.modme.co/wiki/threads/3540.html (don't install 'h1' folders (shellejects) in source_data and model_export, these are already included in Skye's ports; remember to install WEAPON COMMON, if you don't want to fully install then specific files used include sound_assets, t9_sounds_template.csv, fx_muz_md_smk_air_ .efx files, knife_ballistic_reticle.png, reticle_crossbow.png - images needed to be defined in _wpn_t9_common.gdt)
* natesmithzombies's Custom Random Weapon Powerup: https://forum.modme.co/wiki/threads/706.html
* Kingslayer Kyle's Ray Gun Mark II from the BO3 Gun Pack: https://drive.google.com/file/d/1aMRDiL1esfDM31sb9tIlkgiQzpx6fnKj/view (remember to install wpn_t7_common_fx, share\raw\fx\dlc5\zmb_weapon\fx_raygun2_ .efx files need to be renamed to fx_raygunii_)
* Humphrey's Shadows of Evil Perk Shaders: https://drive.google.com/file/d/1IroyZV3U7ZDfXGrGMML6we821YXEDlYC/view (install images from 'BO3' folder and PhD Flopper from 'BO2' folder into a single directory: texture_assets\Humphreys_Shadows_of_Evil)
* Booris's Shadow Man Announcer: https://mega.nz/file/UdFzBAIa#oMbcLFIkdNNbcNzIEcfSuXbrpQZtKMsadJCmMHaxupI (NOTE: shadowman_transition.wav and shadowman_die.wav are located at sound_assets\zmb\level\zm_zod\ee in the download but need to be moved to sound_assets\zmb\level\zm_zod\ee\shadowman due to an oversight in the sound aliases file)
* Booris's Dr Monty Announcer: https://mega.nz/file/pZUnXSgI#ep8q0VdDrK2CpwyIaX1072dOC977KqPQW9MStBgg3D4
* J.G's Origins Samantha Announcer: https://drive.google.com/file/d/1Se-dNLd88-Vm-oWGsr2mpA4qfKvng5bP/view?usp=sharing
* Westchief596's BO1 Moon Richtofen Announcer: https://www.devraw.net/approved-assets/westchief596/moon-richtofen-announcer
* VoiceOfJared's Richtofen Announcer: https://drive.google.com/file/d/1q_kTWCKhjMoyHShXDacOMtS_3V7v1IAW/view
* BetiroVal's Classic Mystery Box FX: https://mega.nz/file/8N8RWSwR#qzX95Nii7kD5EBkyMs5QcwINySMMOJv-fCQB3OdfViY (NOTE: p7_zm_der_magic_box_beam_rainbow.tif is already included in this repo and has been renamed to p7_zm_der_magic_box_beam_rainbow_classic.tif)
* FrostIceforge's Custom Zombie Eye Colors: https://forum.modme.co/wiki/threads/2274.html
* MadKixs' Perks Shaders in BO3 style: https://forum.modme.co/wiki/threads/2836.html (install images from 'Black Ops 3 Perks' folder, [Perk] phd.tiff and [Perk] double_tap_2.0.tiff from 'Black Ops 2 Perks' folder into a single directory: texture_assets\Custom_Perk_Shaders), this is also what specialty_giant_alt_doubletap_zombies.tiff is taken from, this is also what specialty_giant_alt_doubletap_zombies.tiff is taken from
* emptyFXIW.efx file from WETEGG's Infinite Warfare Perk Ports: https://drive.google.com/file/d/1I5-RkXzoDX8zieCfyIPNt4QVNx7R6Nz-/view?usp=sharing
* Rayjiun's black-and-white visionset: https://discord.com/channels/230615005194616834/230616047613378560/1128724861666218046
* Sten from Skye's CoD WWII Weapon Ports: https://www.ugx-mods.com/forum/full-weapons/84/skyes-wwii-weapon-ports-page-1/23134/
* ai_zombie_spets_roll_ and ai_zombie_spets_sidestep_left_ .xanim files (xanim_export\black_ops_3\zombie) from Harrybo21's New BT Stuff v3.0.0: https://mega.nz/file/bSAxWQJS#weh95pMZWuSmnV0kpgzt5mFtk7qZ4xq06E23PBOOOMQ
* MikeyRay's Customizable PHD Flopper: https://forum.modme.co/wiki/threads/3537.html
* Pmr360's Black Ops 1/4 - Revive animation: https://www.devraw.net/approved-assets/pmr360/black-ops-1%2F4---revive-animation
* Kingslayer Kyle's Black Ops 1 HUD: https://drive.google.com/file/d/1JXbn3z1mvVpmrm1qOIGdSLCdLljXBiFd/view
* GCPeinhardt's Winter's Howl: https://discord.com/channels/230615005194616834/233220803439755264/1328900707969142798
* eMoX's T8 Powerup Delayed Drop: https://www.devraw.net/approved-assets/emox/emox---t8-powerup-delayed-drop

Then install all files from this repo into your Black Ops III installation apart from the folder chalk_drawing_models, which is for reference purposes only

## Credits

* TheSkyeLord for making this possible with the majority of the weapon ports in this mod, also the source for these wallbuy assets:
  * chalk drawing images for Gewehr 43, M1A1 Carbine, StG 44, MP40, Kar98k, Thompson M1A1, Type 100, FG42, M30 from Skye's CoD WWII Weapon Ports: https://www.ugx-mods.com/forum/full-weapons/84/skyes-wwii-weapon-ports-page-1/23134/
  * chalk drawing for M1897 Trebuchet from Skye's BO4 Weapon Ports: https://www.ugx-mods.com/forum/full-weapons/84/skyes-bo4-weapon-ports/23133/ 
* TheAllNightFall for making the WaW weapon part of the mod possible
* [Beandon](https://steamcommunity.com/id/Beandon11) for providing Death Machine announcer voicelines
* [N7aster](https://steamcommunity.com/profiles/76561199467224180) for providing Black Ops explosion sounds (weapons, PhD Flopper) and "FIVE" quotes from Ascension's Red Telephones
* Scobalula's [Cereberus](https://github.com/Scobalula/Cerberus-Repo/releases/tag/CustomMapsGoVroom) to extract script files for reference purposes from Deadshot.mp4's [COTD Chronicles Conversion Mod](http://steamcommunity.com/sharedfiles/filedetails/?id=2911456494)
* Scobalula's [Greyhound](https://github.com/Scobalula/Greyhound) for image extraction (circuits camo, chalk drawings)
* Scobabula's [HydraX](https://github.com/Scobalula/HydraX) for general asset decompilation, especially map _weapons.csv files
* [Birdman's XModel Tools For Blender](https://github.com/Wast-3/birdmans-xmodel-tools-for-blender)
* Scobalula's [Bo3Mutators](https://github.com/Scobalula/Bo3Mutators) for options menu set-up, and Serious for pointing this out to me
* Logical Edits for [Custom Perk Icons set-up](https://www.youtube.com/watch?v=m_HqGZy0afs&feature=youtu.be)
* TescoFresco for [TF's Zombie Options](https://github.com/tescfresc/TFs-Zombie-Options)
* Harrybo21 for crossbow bolt FX and PaP 'monkey bomb' set-up from Blundergat Weapon Pack: https://www.devraw.net/releases/blundergat-weapon-pack
* XcDylan93 for [dive-to-prone and sprint/reload cancel script]() and [improved Winter's](https://discord.com/channels/230615005194616834/230616047613378560/1416092794048483509) [Howl Scripts](https://discord.com/channels/230615005194616834/230616047613378560/1415799187668209719)
* [hb21_black_ops_3_fx_library_v2.1.0](https://mega.nz/file/6WYARBxB#-NUWhmjzCySBXx9FCBpTy_wvjhe5FsyBec7nPKYwOl0) for fx_muz_thundergun_1p.efx, fx_muz_thundergun_3p.efx, fx_trail_thundergun.efx, fx_muz_thundergun_1p_ug.efx, fx_muz_thundergun_3p_ug.efx, fx_trail_thundergun_ug.efx, fx_muz_thundergun_1p_ug_child.efx, fx_trail_thundergun_tread.efx, fx_trail_thundergun_tread_ug.efx, fx_muz_thundergun_1p_ug_child.efx and pre-requisites gfx_ring_thin_nocull, gfx_fog_slow_md_anim_em_nocull, gfx_decal_blast_white_01
* Apex for xmodelalias fix ([originally here](https://steamcommunity.com/sharedfiles/filedetails/?id=1833845566), one file extracted with Cerberus and other files downloaded [from here](https://github.com/clixmods/zm_nuked/blob/main/scripts/shared))
* Underbarrel HUD scripting and some image assets are from T5_HUD by GCP, Kingslayer, Kyle, Lilrifa, Jarik, Scobalula, DTZxPorter