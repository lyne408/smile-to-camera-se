# Smile To Camera SE

## Original

[Smile To Camera](https://www.nexusmods.com/skyrim/mods/92337)

## Disclaimer

src/skse64/* are belong to [SKSE Team](https://skse.silverlock.org), some others belong to [beniz](https://www.nexusmods.com/skyrim/users/4097779).

## Port what?

1. Modify SmileToCamera.esp to Form v44.
2. Modify those source codes of BeinzCameraPlugin  to match SKSE64.

## How to compile those Papyrus scripts?

You need SkyUI SDK, check [SkyUI wiki page](https://github.com/schlangster/skyui/wiki) for more details.

## How to Compile the SKSE64 plugin?

### Requirement

- Visual Studio 2015+

### Steps

1.  Open src/skse64/skse64.sln with Visual Studio.
2. Compile common.
3. Compile skse64_common.
4. Compile skse64.
5. Compile BeinzCameraPlugin.

Then you'll get the SKSE64 plugin BeinzCameraPlugin.dll.