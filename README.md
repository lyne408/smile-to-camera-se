[TOC]

<!-- toc -->

- [Smile To Camera SE Port by lyne408](#smile-to-camera-se-port-by-lyne408)
  * [Requiements](#requiements)
  * [Features](#features)
  * [Port Records](#port-records)
  * [Issues](#issues)
    + [Compatibility](#compatibility)
    + [Bugs](#bugs)
  * [Downloads](#downloads)
  * [Development](#development)
    + [Build BeinzCameraPlugin](#build-beinzcameraplugin)
    + [Compile Papyrus Scripts](#compile-papyrus-scripts)
  * [Changelogs](#changelogs)
  * [Credits](#credits)
  * [Permissions](#permissions)

<!-- tocstop -->

# Smile To Camera SE Port by lyne408

Let the Dragonborn like looks at you.

## Requiements

- [SKSE64](https://skse.silverlock.org)
	
	Supported Versions:
	- *SKSE64 2.0.16*
	- *SKSE64 2.0.17*
	- *SKSE64 2.0.19*
	
- [SkyUI](https://www.nexusmods.com/skyrimspecialedition/mods/12604)

	Support *SkyUI 5.1+*.

## Features

Head tracking to third person camera and expressing a emotion.

Let the Dragonborn looks at you.

Original LE link: [Smile To Camera](https://www.nexusmods.com/skyrim/mods/92337)

Youtube video showcase link: [Skyrim Showcase : Smile To Camera](https://youtu.be/Yxqj4j2pJ6o)

## Port Records

**No any enhancements or fixes.**

- Upgrade SmileToCamera.esp to Form v44.
- Modify those source codes of *BeinzCameraPlugin* to match SKSE64.

## Issues

Those issues existed in original [Smile To Camera], and also in this port.

May be I'd create another repository to fixess these issues in the future.
But they are not critical issues for me, **personally**.

So **Open Source** means you can modify any MODs youself. And **Programming** makes your life colorful.

### Compatibility

- May be **incompatible** with some **Camera** or **Head Tracking** mods.

	[Smile to Camera] use API `SetLookAt()` and `SetHeadTracking()` which control the head node of player.

	Many camera relative or head tracking relative mods use those APIs.

	Example: [Immersive First Person View-22306-9] makes [Smile to Camera] work incorrectly.

- **Incompatible** with any emotion relative mods.

	Because [Smile to Camera] **Force** to control emotion.
		
### Bugs

- Toggle Key may not work.
- It does not work at some camera states.

	May be caused by incompatible mods or Skyrim internal bugs.
	
	You can press `Tab Key` then release to reset the camera states.
	
	Actually, this bug has been fixed by me, but not release it.

## Downloads

Please read [Requiements section](#requiements) and [Issues section](#issues) first.

- [Smile To Camera SE 0.4](https://github.com/lyne408/smile-to-camera-se/releases/tag/0.4)

## Development

### Build BeinzCameraPlugin

1. Download SKSE64 which version you need, extract it's source codes, open *skse64 solution*.
2. Clone this repository to local disk.
3. Add *BeinzCameraPlugin* as an *Existing Project* of skse64 solution.
4. *Retarget solution* to set the **Windows SDK Version** you've installed, then set the *Configuration Type* of **skse64 project** to **Static library(.lib)**.
5. Build and get the SKSE64 plugin.

### Compile Papyrus Scripts

1. Download **SkyUI Papyrus source codes**, not recommend downloading SkyUI SDK, install it as a mod.
2. Compile Papyrus scripts.

## Changelogs

- 0.4 (2020-04-08)	
	
  - The features are same as original LE version 0.4.
	
## Credits

- [beniz](https://www.nexusmods.com/skyrim/users/4097779)
- [SKSE Team](https://skse.silverlock.org)

## Permissions

Like the original [Smile To Camera](https://www.nexusmods.com/skyrim/mods/92337) page. 

- No Commercial Use.
- Free to modify with original credits.