# CcAutoWash-Ba

### STATUS: WORKING
Pretty much as good as it needs to be, few minor refinements may come.

## DESCRIPTION
RamDisks will always be cut fine, as they need not eat system ram, obviously this is intended for people whom put their, TEMP and TMP, on a RamDisk loaded from image, and are intending to have their computer on for longer periods. To clean a ramdisk, this requires a certain delay after the user logon, in order to process the cleaning, yes I'm sure task manager can delay it, but, its good to have it a little longer and I want it running from the start menu, the start menu is the last location it checks, and the user is required to logon. This clearly is a simple idea, but, that is the point, I am presenting an idea to enhance RamDisk optimization where the space is limited, and its, comically named `AutoWash` after `Fifth Element` and done in the style of my newer batch files.

### PREVIEW
```

Script Initialized...


CcAutoWash In 10s..
..Executing CCleaner..
..Cleaning Complete.


...Script Complete.

```

## INSTRUCTION
1. Put batch into same dir as `CCleaner64.exe`.
2. Create a shortcut to it in `C:\Users\(YourUserName)\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`.
3. Restart computer, no errors is good.

### REQUIREMENTS
- CCleaner (64bit).
- Batch file support.
- Temp/Tmp folders on a RamDisk loaded from image.
- RamDisk software.

### NOTATION
- If you are looking for RamDisk software, then I can suggest [ImDisk](https://github.com/LTRData/ImDisk) for a free one limited to one drive, however, regardless of the program, I had to keep the RamDisk under a certain size in order for Windows not to timeout on boot, even loading from mSATA, it was about 6144MB (4096 + 2048), 4096MB was a safe value.
- To avoid issues with running out of space when copying files on windows, then use [TetraCopy](https://www.codesector.com/teracopy), as it does direct copies through memory, instead of using the temp folder. After doing this, the only issues I have had is with using PACT to auto clean my Fallout 4 mods, pact uses python partly, so, maybe I will be exploring this more later, if there are further issues, I will be sticking to PowerShell.  
- I tried to do some complicated method of stats going through TEMP/TMP path, as no way of knowing pre-defined RamDisk letter, but, ran into path lengh issues, so kept it simple.
 

## DISCLAIMER
This software is subject to the terms in License.Txt, covering usage, distribution, and modifications. For full details on your rights and obligations, refer to License.Txt.
