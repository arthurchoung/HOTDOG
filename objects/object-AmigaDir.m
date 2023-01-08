/*

 HOT DOG Linux

 Copyright (c) 2020 Arthur Choung. All rights reserved.

 Email: arthur -at- hotdoglinux.com

 This file is part of HOT DOG Linux.

 HOT DOG Linux is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <https://www.gnu.org/licenses/>.

 */

#import "HOTDOG.h"

#include <sys/time.h>

#define MAX_CHARS_TO_DRAW 20

static char *amigaPalette =
"b #000000\n"
". #000022\n"
"* #ff8800\n"
"X #0055aa\n"
"o #ffffff\n"
;

static char *leftArrowPalette =
". #000022\n"
"* #ff8800\n"
"X #0055aa\n"
"o #ffffff\n"
;
static char *selectedLeftArrowPalette =
"o #000022\n"
"X #ff8800\n"
"* #0055aa\n"
". #ffffff\n"
;

static char *leftArrowPixels =
"ooooXXXoooo\n"
"ooooXXXoooo\n"
"ooXXXoooooo\n"
"ooXXXoooooo\n"
"XXXoooooooo\n"
"XXXoooooooo\n"
"XXXXXXXXXXX\n"
"XXXXXXXXXXX\n"
"XXXoooooooo\n"
"XXXoooooooo\n"
"ooXXXoooooo\n"
"ooXXXoooooo\n"
"ooooXXXoooo\n"
"ooooXXXoooo\n"
;
static char *rightArrowPixels =
"oooooXXXooo\n"
"oooooXXXooo\n"
"oooooooXXXo\n"
"oooooooXXXo\n"
"oooooooooXX\n"
"oooooooooXX\n"
"XXXXXXXXXXX\n"
"XXXXXXXXXXX\n"
"oooooooooXX\n"
"oooooooooXX\n"
"oooooooXXXo\n"
"oooooooXXXo\n"
"oooooXXXooo\n"
"oooooXXXooo\n"
;
static char *upArrowPixels =
"ooooXXXXXXoooo\n"
"ooooXXXXXXoooo\n"
"ooXXooXXooXXoo\n"
"ooXXooXXooXXoo\n"
"XXooooXXooooXX\n"
"XXooooXXooooXX\n"
"ooooooXXoooooo\n"
"ooooooXXoooooo\n"
"ooooooXXoooooo\n"
"ooooooXXoooooo\n"
"ooooooXXoooooo\n"
"ooooooXXoooooo\n"
;
static char *downArrowPixels =
"ooooooXXoooooo\n"
"ooooooXXoooooo\n"
"ooooooXXoooooo\n"
"ooooooXXoooooo\n"
"ooooooXXoooooo\n"
"ooooooXXoooooo\n"
"XXooooXXooooXX\n"
"XXooooXXooooXX\n"
"ooXXooXXooXXoo\n"
"ooXXooXXooXXoo\n"
"ooooXXXXXXoooo\n"
"ooooXXXXXXoooo\n"
;
static id drawerPalette =
@"b #000000\n"
@". #000022\n"
@"* #ff8800\n"
@"X #0055aa\n"
@"o #ffffff\n"
;

static id drawerPixels =
@"              ...........................................................\n"
@"              ...........................................................\n"
@"          ....oooooooooooooooooooooooooooooooooooooooooooooooooooooo...o.\n"
@"          ....oooooooooooooooooooooooooooooooooooooooooooooooooooooo...o.\n"
@"      ....oooooooooooooooooooooooooooooooooooooooooooooooooooooooo...oo..\n"
@"      ....oooooooooooooooooooooooooooooooooooooooooooooooooooooooo...oo..\n"
@"   ................................................................ooo.o.\n"
@"   ................................................................ooo.o.\n"
@"   ..oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo..oooo..\n"
@"   ..oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo..oooo..\n"
@"   ..ooo......................................................ooo..ooo.o.\n"
@"   ..ooo......................................................ooo..ooo.o.\n"
@"   ..ooo..oooooooooooooooooooooooooooooooooooooooooooooooooo..ooo..oo.o..\n"
@"   ..ooo..oooooooooooooooooooooooooooooooooooooooooooooooooo..ooo..oo.o..\n"
@"   ..ooo..oooooooooooooooooooooooooooooooooooooooooooooooooo..ooo..ooo.o.\n"
@"   ..ooo..oooooooooooooooooooooooooooooooooooooooooooooooooo..ooo..ooo.o.\n"
@"   ..ooo..ooooooooooooooooo...oooooooooo...ooooooooooooooooo..ooo..oo.o..\n"
@"   ..ooo..ooooooooooooooooo...oooooooooo...ooooooooooooooooo..ooo..oo.o..\n"
@"   ..ooo..oooooooooooooooo................oooooooooooooooooo..ooo..o.o.. \n"
@"   ..ooo..oooooooooooooooo................oooooooooooooooooo..ooo..o.o.. \n"
@"   ..ooo..oooooooooooooooooooooooooooooooooooooooooooooooooo..ooo..oo..  \n"
@"   ..ooo..oooooooooooooooooooooooooooooooooooooooooooooooooo..ooo..oo..  \n"
@"   ..ooo..oooooooooooooooooooooooooooooooooooooooooooooooooo..ooo..o..   \n"
@"   ..ooo..oooooooooooooooooooooooooooooooooooooooooooooooooo..ooo..o..   \n"
@"   ..ooo......................................................ooo....    \n"
@"   ..ooo......................................................ooo....    \n"
@"   ..oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo...     \n"
@"   ..oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo...     \n"
@"   ................................................................      \n"
@"   ................................................................      \n"
@"                                                                         \n"
@"                                                                         \n"
@"                                                                         \n"
@"                                                                         \n"
;

static id openDrawerPalette =
@"b #000000\n"
@". #000022\n"
@"* #ff8800\n"
@"X #0055aa\n"
@"o #ffffff\n"
;

static id openDrawerPixels =
@"              ...........................................................\n"
@"              ...........................................................\n"
@"          ....oooooooooooooooooooooooooooooooooooooooooooooooooooooo...o.\n"
@"          ....oooooooooooooooooooooooooooooooooooooooooooooooooooooo...o.\n"
@"      ....oooooooooooooooooooooooooooooooooooooooooooooooooooooooo...oo..\n"
@"      ....oooooooooooooooooooooooooooooooooooooooooooooooooooooooo...oo..\n"
@"   ................................................................ooo.o.\n"
@"   ................................................................ooo.o.\n"
@"   ..oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo..oooo..\n"
@"   ..oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo..oooo..\n"
@"   ..ooo......................................................ooo..ooo.o.\n"
@"   ..ooo......................................................ooo..ooo.o.\n"
@"   ..o...  .. . . . . . . . . . . . . . . . . . . . . . . ....ooo..oo.o..\n"
@"   ..o...  .. . . . . . . . . . . . . . . . . . . . . . . ....ooo..oo.o..\n"
@"  .... . . ..  . . . . . . . . . . . . . . . . . . . . . ..o..ooo..ooo.o.\n"
@"  .... . . ..  . . . . . . . . . . . . . . . . . . . . . ..o..ooo..ooo.o.\n"
@"..........................................................oo..ooo..oo.o..\n"
@"..........................................................oo..ooo..oo.o..\n"
@"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo..oo..ooo..o.o.. \n"
@"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo..oo..ooo..o.o.. \n"
@"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo..oo..ooo..oo..  \n"
@"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo..oo..ooo..oo..  \n"
@"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo..oo..ooo..o..   \n"
@"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo..oo..ooo..o..   \n"
@"..ooooooooooooooooooo...oooooooooo...ooooooooooooooooooo..oo..ooo....    \n"
@"..ooooooooooooooooooo...oooooooooo...ooooooooooooooooooo..oo..ooo....    \n"
@"..oooooooooooooooooo................oooooooooooooooooooo..o..oooo...     \n"
@"..oooooooooooooooooo................oooooooooooooooooooo..o..oooo...     \n"
@"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo...........      \n"
@"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo...........      \n"
@"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo...              \n"
@"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo...              \n"
@"..........................................................               \n"
@"..........................................................               \n"
;

static id textFilePalette =
@"b #000000\n"
@". #000022\n"
@"X #0055AA\n"
@"o #FFFFFF\n"
;
static id textFileSelectedPalette =
@"b #000000\n"
@"o #000022\n"
@"X #0055AA\n"
@". #FFFFFF\n"
;
static id textFilePixels =
@"..............................          \n"
@"..............................          \n"
@"..oooooooooooooooooooooooo..oo..        \n"
@"..oooooooooooooooooooooooo..oo..        \n"
@"..oooooooooooooooooooooooo..oooo..      \n"
@"..oooooooooooooooooooooooo..oooo..      \n"
@"..oooooooooooooooooooooooo..oooooo..    \n"
@"..oooooooooooooooooooooooo..oooooo..    \n"
@"..ooo.........oooooooooooo..oooooooo..  \n"
@"..ooo.........oooooooooooo..oooooooo..  \n"
@"..oooooooooooooooooooooooo..............\n"
@"..oooooooooooooooooooooooo..............\n"
@"..ooo.........oooooooooooooooooooooooo..\n"
@"..ooo.........oooooooooooooooooooooooo..\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"..ooooooo....o..........oo.......ooooo..\n"
@"..ooooooo....o..........oo.......ooooo..\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"..ooo..o........o................ooooo..\n"
@"..ooo..o........o................ooooo..\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"..ooo....................o.......ooooo..\n"
@"..ooo....................o.......ooooo..\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"..ooooooooooooooooooooo..........ooooo..\n"
@"..ooooooooooooooooooooo..........ooooo..\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"........................................\n"
@"........................................\n"
;

static id shellPalette =
@"b #000000\n"
@". #000022\n"
@"* #ff8800\n"
@"X #0055aa\n"
@"o #ffffff\n"
;
static id selectedShellPalette =
@"b #000000\n"
@"o #000022\n"
@"X #ff8800\n"
@"* #0055aa\n"
@". #ffffff\n"
;
static id shellPixels =
@".....................................................\n"
@".....................................................\n"
@".ooooooooooooooooooooooooooooooooooooXoooooXoooooXo..\n"
@".ooooooooooooooooooooooooooooooooooooXoooooXoooooXo..\n"
@".oXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXoooooXoooooXo..\n"
@".oXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXoooooXoooooXo..\n"
@".ooooooooooooooooooooooooooooooooooooXoooooXoooooXo..\n"
@".ooooooooooooooooooooooooooooooooooooXoooooXoooooXo..\n"
@".oXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@".oXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@".oXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@".oXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@".oXXXXooXXXXooXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@".oXXXXooXXXXooXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@".oXXXoooXXXXXooXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@".oXXXoooXXXXXooXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@".oXXXXooXXXXXXooXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@".oXXXXooXXXXXXooXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@".oXXXXooXXXXXooXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@".oXXXXooXXXXXooXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@".oXXXooooXXXooXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@".oXXXooooXXXooXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@".oXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@".oXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@".oXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@".oXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@".oXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@".oXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@".oXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXooooo..\n"
@".oXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXooooo..\n"
@".oXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXoXXXo..\n"
@".oXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXoXXXo..\n"
@".oooooooooooooooooooooooooooooooooooooooooooooooooo..\n"
@".oooooooooooooooooooooooooooooooooooooooooooooooooo..\n"
@".....................................................\n"
@".....................................................\n"
;

static id prefsPalette =
@"b #000000\n"
@". #000022\n"
@"X #ff8800\n"
@"* #0055aa\n"
@"O #ffffff\n"
;
static id prefsPixels =
@"              ...........................................................\n"
@"              ...........................................................\n"
@"          ....OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO...O.\n"
@"          ....OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO...O.\n"
@"      ....OOOOOOOOOOOOOOOOOOO..........OOOOOOOOOOOOOOOOOOOOOOOOOOO...OO..\n"
@"      ....OOOOOOOOOOOOOOOOOOO..........OOOOOOOOOOOOOOOOOOOOOOOOOOO...OO..\n"
@"   ...........................XXXXXXXX.............................OOO.O.\n"
@"   ...........................XXXXXXXX.............................OOO.O.\n"
@"   ..OOOOOOOOOOOOOOOOOOOOO..XXXXXXXXXXXX..OOOOOOOOOOOOOOOOOOOOOOO..OOOO..\n"
@"   ..OOOOOOOOOOOOOOOOOOOOO..XXXXXXXXXXXX..OOOOOOOOOOOOOOOOOOOOOOO..OOOO..\n"
@"   ..OOO...................XXXXX....XXXXX.....................OOO..OOO.O.\n"
@"   ..OOO...................XXXXX....XXXXX.....................OOO..OOO.O.\n"
@"   ..OOO..OOOOOOOOOOOOOOO........O..XXXXX..OOOOOOOOOOOOOOOOO..OOO..OO.O..\n"
@"   ..OOO..OOOOOOOOOOOOOOO........O..XXXXX..OOOOOOOOOOOOOOOOO..OOO..OO.O..\n"
@"   ..OOO..OOOOOOOOOOOOOOOOOOOOOOO..XXXXX..OOOOOOOOOOOOOOOOOO..OOO..OOO.O.\n"
@"   ..OOO..OOOOOOOOOOOOOOOOOOOOOOO..XXXXX..OOOOOOOOOOOOOOOOOO..OOO..OOO.O.\n"
@"   ..OOO..OOOOOOOOOOOOOOOOO...O..XXXXX..OO...OOOOOOOOOOOOOOO..OOO..OO.O..\n"
@"   ..OOO..OOOOOOOOOOOOOOOOO...O..XXXXX..OO...OOOOOOOOOOOOOOO..OOO..OO.O..\n"
@"   ..OOO..OOOOOOOOOOOOOOOO......XXXXX.......OOOOOOOOOOOOOOOO..OOO..O.O.. \n"
@"   ..OOO..OOOOOOOOOOOOOOOO......XXXXX.......OOOOOOOOOOOOOOOO..OOO..O.O.. \n"
@"   ..OOO..OOOOOOOOOOOOOOOOOOO..XXXXX..OOOOOOOOOOOOOOOOOOOOOO..OOO..OO..  \n"
@"   ..OOO..OOOOOOOOOOOOOOOOOOO..XXXXX..OOOOOOOOOOOOOOOOOOOOOO..OOO..OO..  \n"
@"   ..OOO..OOOOOOOOOOOOOOOOOOOO.......OOOOOOOOOOOOOOOOOOOOOOO..OOO..O..   \n"
@"   ..OOO..OOOOOOOOOOOOOOOOOOOO.......OOOOOOOOOOOOOOOOOOOOOOO..OOO..O..   \n"
@"   ..OOO.......................XXXXX..........................OOO....    \n"
@"   ..OOO.......................XXXXX..........................OOO....    \n"
@"   ..OOOOOOOOOOOOOOOOOOOOOOOOO.......OOOOOOOOOOOOOOOOOOOOOOOOOOOO...     \n"
@"   ..OOOOOOOOOOOOOOOOOOOOOOOOO.......OOOOOOOOOOOOOOOOOOOOOOOOOOOO...     \n"
@"   ................................................................      \n"
@"   ................................................................      \n"
@"                                                                         \n"
@"                                                                         \n"
@"                                                                         \n"
@"                                                                         \n"
@"                                                                         \n"
@"                                                                         \n"
;

static id openPrefsPalette =
@"b #000000\n"
@". #000022\n"
@"X #ff8800\n"
@"* #0055aa\n"
@"O #ffffff\n"
;
static id openPrefsPixels =
@"              ...........................................................\n"
@"              ...........................................................\n"
@"          ....OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO...O.\n"
@"          ....OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO...O.\n"
@"      ....OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO...OO..\n"
@"      ....OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO...OO..\n"
@"   ................................................................OOO.O.\n"
@"   ................................................................OOO.O.\n"
@"   ..OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO..OOOO..\n"
@"   ..OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO..OOOO..\n"
@"   ..OOO......................................................OOO..OOO.O.\n"
@"   ..OOO......................................................OOO..OOO.O.\n"
@"   ..O...oo..o.o.o.o.o.o.........o.o.o.o.o.o.o.o.o.o.o.o.o....OOO..OO.O..\n"
@"   ..O...oo..o.o.o.o.o.o.........o.o.o.o.o.o.o.o.o.o.o.o.o....OOO..OO.O..\n"
@"  ....o.o.o..oo.o.o.o...XXXXXXXX....o.o.o.o.o.o.o.o.o.o.o..O..OOO..OOO.O.\n"
@"  ....o.o.o..oo.o.o.o...XXXXXXXX....o.o.o.o.o.o.o.o.o.o.o..O..OOO..OOO.O.\n"
@"......................XXXXXXXXXXXX........................OO..OOO..OO.O..\n"
@"......................XXXXXXXXXXXX........................OO..OOO..OO.O..\n"
@"..OOOOOOOOOOOOOOOOO..XXXXX....XXXXX..OOOOOOOOOOOOOOOOOOO..OO..OOO..O.O.. \n"
@"..OOOOOOOOOOOOOOOOO..XXXXX....XXXXX..OOOOOOOOOOOOOOOOOOO..OO..OOO..O.O.. \n"
@"..OOOOOOOOOOOOOOOOO........O..XXXXX..OOOOOOOOOOOOOOOOOOO..OO..OOO..OO..  \n"
@"..OOOOOOOOOOOOOOOOO........O..XXXXX..OOOOOOOOOOOOOOOOOOO..OO..OOO..OO..  \n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOO..XXXXX..OOOOOOOOOOOOOOOOOOOO..OO..OOO..O..   \n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOO..XXXXX..OOOOOOOOOOOOOOOOOOOO..OO..OOO..O..   \n"
@"..OOOOOOOOOOOOOOOOOOO...O..XXXXX..OO...OOOOOOOOOOOOOOOOO..OO..OOO....    \n"
@"..OOOOOOOOOOOOOOOOOOO...O..XXXXX..OO...OOOOOOOOOOOOOOOOO..OO..OOO....    \n"
@"..OOOOOOOOOOOOOOOOOO......XXXXX.......OOOOOOOOOOOOOOOOOO..O..OOOO...     \n"
@"..OOOOOOOOOOOOOOOOOO......XXXXX.......OOOOOOOOOOOOOOOOOO..O..OOOO...     \n"
@"..OOOOOOOOOOOOOOOOOOOOO..XXXXX..OOOOOOOOOOOOOOOOOOOOOOOO...........      \n"
@"..OOOOOOOOOOOOOOOOOOOOO..XXXXX..OOOOOOOOOOOOOOOOOOOOOOOO...........      \n"
@"..OOOOOOOOOOOOOOOOOOOOOO.......OOOOOOOOOOOOOOOOOOOOOOOOO...              \n"
@"..OOOOOOOOOOOOOOOOOOOOOO.......OOOOOOOOOOOOOOOOOOOOOOOOO...              \n"
@".........................XXXXX............................               \n"
@".........................XXXXX............................               \n"
@"                        .......                                          \n"
@"                        .......                                          \n"
;

static char *trashCanPalette =
@"b #000000\n"
@". #000022\n"
@"X #FF8800\n"
@"o #0055AA\n"
@"O #FFFFFF\n"
;

static char *trashCanPixels =
@"                                                          \n"
@"                                                          \n"
@"                                                          \n"
@"                                                          \n"
@"                                                          \n"
@"                                                          \n"
@"                                                          \n"
@"                                                          \n"
@"                            ................              \n"
@"                            ................              \n"
@"                           ...            ...             \n"
@"                           ...            ...             \n"
@"                ......................................    \n"
@"                ......................................    \n"
@"              ..X.X.X.X.X.X.XXXXXXXXXXXXXXXXXXXXXXXXXX..  \n"
@"              ..X.X.X.X.X.X.XXXXXXXXXXXXXXXXXXXXXXXXXX..  \n"
@"             ..X.X.X.X.X.X.X.X.X.X.X.XXXXXXXXXXXXXXXXXX.. \n"
@"             ..X.X.X.X.X.X.X.X.X.X.X.XXXXXXXXXXXXXXXXXX.. \n"
@"             ............................................ \n"
@"             ............................................ \n"
@"              ..X.X.X.X.X.X.X.XXXXXXXXXXXXXXXXXXXXXXXX..  \n"
@"              ..X.X.X.X.X.X.X.XXXXXXXXXXXXXXXXXXXXXXXX..  \n"
@"              ...X.X.X.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX..  \n"
@"              ...X.X.X.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX..  \n"
@"               ...X......XXXXXXX.......XXXXXX.....XXX..   \n"
@"               ...X......XXXXXXX.......XXXXXX.....XXX..   \n"
@"               ..X...X.X...XXX...X.X.X..XXX..X.X...XX..   \n"
@"               ..X...X.X...XXX...X.X.X..XXX..X.X...XX..   \n"
@"               ...X...XXX..XXX..X.XXXX..XXX...XXX..XX..   \n"
@"               ...X...XXX..XXX..X.XXXX..XXX...XXX..XX..   \n"
@"               ..X...X.XX..XXX...X.XXX..XXX..X.XX..XX..   \n"
@"               ..X...X.XX..XXX...X.XXX..XXX..X.XX..XX..   \n"
@"                ..X...XXX..XXX..X.XXXX..XXX...XXX..X..    \n"
@"                ..X...XXX..XXX..X.XXXX..XXX...XXX..X..    \n"
@"                ...X...XXX..XX...X.XXX..XX...XXX..XX..    \n"
@"                ...X...XXX..XX...X.XXX..XX...XXX..XX..    \n"
@"                ..X...X.XX..XX..X.XXXX..XX..X.XX..XX..    \n"
@"                ..X...X.XX..XX..X.XXXX..XX..X.XX..XX..    \n"
@"                ...X...XXX..XXX..X.XX..XXX...XXX..XX..    \n"
@"                ...X...XXX..XXX..X.XX..XXX...XXX..XX..    \n"
@"                 ...X...XX..XXX...XXX..XXX..XXX..XX..     \n"
@"                 ...X...XX..XXX...XXX..XXX..XXX..XX..     \n"
@"                 ..X...X.X..XXX..X.XX..XXX...XX..XX..     \n"
@"                 ..X...X.X..XXX..X.XX..XXX...XX..XX..     \n"
@"                 ...X...XXX..XX...XXX..XX...XXX..XX..     \n"
@"                 ...X...XXX..XX...XXX..XX...XXX..XX..     \n"
@"                 ..X.X...XX..XX..X.XX..XX..X.X..XXX..     \n"
@"                 ..X.X...XX..XX..X.XX..XX..X.X..XXX..     \n"
@"             .......X...X.X..XXX..XX..XXX...XX..XX..      \n"
@"             .......X...X.X..XXX..XX..XXX...XX..XX..      \n"
@"    .................X...X...XXX...X..XXX..X...XXX..      \n"
@"    .................X...X...XXX...X..XXX..X...XXX..      \n"
@"....................X.X.....X.X.X....XXXXX....XXXX..      \n"
@"....................X.X.....X.X.X....XXXXX....XXXX..      \n"
@"  .....................X.X.X.X.X.XXXXXXXXXXXXXXX...       \n"
@"  .....................X.X.X.X.X.XXXXXXXXXXXXXXX...       \n"
@"       ..........................................         \n"
@"       ..........................................         \n"
@"                 ....................                     \n"
@"                 ....................                     \n"
;


static char *openTrashCanPalette =
@"b #000000\n"
@". #000022\n"
@"X #FF8800\n"
@"o #0055AA\n"
@"O #FFFFFF\n"
;

static char *openTrashCanPixels =
@"                          ..................              \n"
@"                          ..................              \n"
@"                   .......XXXXXXXXXXXXXXXXXX.......       \n"
@"                   .......XXXXXXXXXXXXXXXXXX.......       \n"
@"              .....XXXXXXXX.................XXXXXXX.....  \n"
@"              .....XXXXXXXX.................XXXXXXX.....  \n"
@"             ..XXXX........X.X.X.XXXXX.X.X.X......XXXXX.. \n"
@"             ..XXXX........X.X.X.XXXXX.X.X.X......XXXXX.. \n"
@"            ..XX....X.X.X.X.X.XXXX.X.XXXX.X.X.X.X.....XX..\n"
@"            ..XX....X.X.X.X.X.XXXX.X.XXXX.X.X.X.X.....XX..\n"
@"             ..X..XX.X.X.X.X.X.X.XXXXX.X.X.X.X.X.XXX..X.. \n"
@"             ..X..XX.X.X.X.X.X.X.XXXXX.X.X.X.X.X.XXX..X.. \n"
@"              ......XXXXXXX.X.X.X.X.X.X.X.X.XXXXXX......  \n"
@"              ......XXXXXXX.X.X.X.X.X.X.X.X.XXXXXX......  \n"
@"                  .........XXXXXXXXXXXXXXXXX........      \n"
@"                  .........XXXXXXXXXXXXXXXXX........      \n"
@"                          ...................             \n"
@"                          ...................             \n"
@"              ..........................................  \n"
@"              ..........................................  \n"
@"              ..X.X.X.X.X.X.X.XXXXXXXXXXXXXXXXXXXXXXXX..  \n"
@"              ..X.X.X.X.X.X.X.XXXXXXXXXXXXXXXXXXXXXXXX..  \n"
@"              ...X.X.X.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX..  \n"
@"              ...X.X.X.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX..  \n"
@"               ...X......XXXXXXX.......XXXXXX.....XXX..   \n"
@"               ...X......XXXXXXX.......XXXXXX.....XXX..   \n"
@"               ..X...X.X...XXX...X.X.X..XXX..X.X...XX..   \n"
@"               ..X...X.X...XXX...X.X.X..XXX..X.X...XX..   \n"
@"               ...X...XXX..XXX..X.XXXX..XXX...XXX..XX..   \n"
@"               ...X...XXX..XXX..X.XXXX..XXX...XXX..XX..   \n"
@"               ..X...X.XX..XXX...X.XXX..XXX..X.XX..XX..   \n"
@"               ..X...X.XX..XXX...X.XXX..XXX..X.XX..XX..   \n"
@"                ..X...XXX..XXX..X.XXXX..XXX...XXX..X..    \n"
@"                ..X...XXX..XXX..X.XXXX..XXX...XXX..X..    \n"
@"                ...X...XXX..XX...X.XXX..XX...XXX..XX..    \n"
@"                ...X...XXX..XX...X.XXX..XX...XXX..XX..    \n"
@"                ..X...X.XX..XX..X.XXXX..XX..X.XX..XX..    \n"
@"                ..X...X.XX..XX..X.XXXX..XX..X.XX..XX..    \n"
@"                ...X...XXX..XXX..X.XX..XXX...XXX..XX..    \n"
@"                ...X...XXX..XXX..X.XX..XXX...XXX..XX..    \n"
@"                 ...X...XX..XXX...XXX..XXX..XXX..XX..     \n"
@"                 ...X...XX..XXX...XXX..XXX..XXX..XX..     \n"
@"                 ..X...X.X..XXX..X.XX..XXX...XX..XX..     \n"
@"                 ..X...X.X..XXX..X.XX..XXX...XX..XX..     \n"
@"                 ...X...XXX..XX...XXX..XX...XXX..XX..     \n"
@"                 ...X...XXX..XX...XXX..XX...XXX..XX..     \n"
@"                 ..X.X...XX..XX..X.XX..XX..X.X..XXX..     \n"
@"                 ..X.X...XX..XX..X.XX..XX..X.X..XXX..     \n"
@"             .......X...X.X..XXX..XX..XXX...XX..XX..      \n"
@"             .......X...X.X..XXX..XX..XXX...XX..XX..      \n"
@"    .................X...X...XXX...X..XXX..X...XXX..      \n"
@"    .................X...X...XXX...X..XXX..X...XXX..      \n"
@"....................X.X.....X.X.X....XXXXX....XXXX..      \n"
@"....................X.X.....X.X.X....XXXXX....XXXX..      \n"
@"  .....................X.X.X.X.X.XXXXXXXXXXXXXXX...       \n"
@"  .....................X.X.X.X.X.XXXXXXXXXXXXXXX...       \n"
@"       ..........................................         \n"
@"       ..........................................         \n"
@"                 ....................                     \n"
@"                 ....................                     \n"
;

@implementation Definitions(fmeiowfmkdsljvklxcmkljfklds)
+ (id)AmigaBuiltInDir:(id)builtin
{
    id obj = [Definitions AmigaDir];
    [obj setValue:@"1" forKey:@"doNotUpdate"];
    id arr = nsarr();
    if ([builtin isEqual:@"Workbench1.3"]) {
        int x = 20;
        int y = 20;
        int w = [Definitions widthForCString:[drawerPixels UTF8String]];
        int h = [Definitions heightForCString:[drawerPixels UTF8String]];
        id elt;
        elt = nsdict();
        [elt setValue:nsfmt(@"%d", x) forKey:@"x"];
        [elt setValue:nsfmt(@"%d", y) forKey:@"y"];
        [elt setValue:nsfmt(@"%d", w) forKey:@"w"];
        [elt setValue:nsfmt(@"%d", h) forKey:@"h"];
        [elt setValue:@"Utilities" forKey:@"filePath"];
        [elt setValue:drawerPalette forKey:@"palette"];
        [elt setValue:drawerPixels forKey:@"pixels"];
        [elt setValue:openDrawerPalette forKey:@"selectedPalette"];
        [elt setValue:openDrawerPixels forKey:@"selectedPixels"];
        [elt setValue:[@"hotdog amigabuiltindir" split] forKey:@"doubleClickCommand"];
        [arr addObject:elt];
        x += w + 20;
        elt = nsdict();
        [elt setValue:nsfmt(@"%d", x) forKey:@"x"];
        [elt setValue:nsfmt(@"%d", y) forKey:@"y"];
        [elt setValue:nsfmt(@"%d", w) forKey:@"w"];
        [elt setValue:nsfmt(@"%d", h) forKey:@"h"];
        [elt setValue:@"System" forKey:@"filePath"];
        [elt setValue:drawerPalette forKey:@"palette"];
        [elt setValue:drawerPixels forKey:@"pixels"];
        [elt setValue:openDrawerPalette forKey:@"selectedPalette"];
        [elt setValue:openDrawerPixels forKey:@"selectedPixels"];
        [elt setValue:[@"hotdog amigabuiltindir" split] forKey:@"doubleClickCommand"];
        [arr addObject:elt];
        x += w + 20;
        elt = nsdict();
        [elt setValue:nsfmt(@"%d", x) forKey:@"x"];
        [elt setValue:nsfmt(@"%d", y) forKey:@"y"];
        [elt setValue:nsfmt(@"%d", w) forKey:@"w"];
        [elt setValue:nsfmt(@"%d", h) forKey:@"h"];
        [elt setValue:@"Expansion" forKey:@"filePath"];
        [elt setValue:drawerPalette forKey:@"palette"];
        [elt setValue:drawerPixels forKey:@"pixels"];
        [elt setValue:openDrawerPalette forKey:@"selectedPalette"];
        [elt setValue:openDrawerPixels forKey:@"selectedPixels"];
        [elt setValue:[@"hotdog amigabuiltindir" split] forKey:@"doubleClickCommand"];
        [arr addObject:elt];
        x += w + 20;
        elt = nsdict();
        [elt setValue:nsfmt(@"%d", x) forKey:@"x"];
        [elt setValue:nsfmt(@"%d", y) forKey:@"y"];
        [elt setValue:nsfmt(@"%d", w) forKey:@"w"];
        [elt setValue:nsfmt(@"%d", h) forKey:@"h"];
        [elt setValue:@"Empty" forKey:@"filePath"];
        [elt setValue:drawerPalette forKey:@"palette"];
        [elt setValue:drawerPixels forKey:@"pixels"];
        [elt setValue:openDrawerPalette forKey:@"selectedPalette"];
        [elt setValue:openDrawerPixels forKey:@"selectedPixels"];
        [elt setValue:[@"hotdog amigabuiltindir" split] forKey:@"doubleClickCommand"];
        [arr addObject:elt];
        x = 20;
        y += h + 20;
        w = [Definitions widthForCString:[shellPixels UTF8String]];
        h = [Definitions heightForCString:[shellPixels UTF8String]];
        elt = nsdict();
        [elt setValue:nsfmt(@"%d", x) forKey:@"x"];
        [elt setValue:nsfmt(@"%d", y) forKey:@"y"];
        [elt setValue:nsfmt(@"%d", w) forKey:@"w"];
        [elt setValue:nsfmt(@"%d", h) forKey:@"h"];
        [elt setValue:@"Shell" forKey:@"filePath"];
        [elt setValue:shellPalette forKey:@"palette"];
        [elt setValue:shellPixels forKey:@"pixels"];
        [elt setValue:selectedShellPalette forKey:@"selectedPalette"];
        [elt setValue:shellPixels forKey:@"selectedPixels"];
        [elt setValue:[@"xterm -geometry 80x50 -bg #0055aa -fg white -cr #ff8800 +bc +uc" split] forKey:@"doubleClickCommand"];
        [arr addObject:elt];
        x += w + 20;
        w = [Definitions widthForCString:[prefsPixels UTF8String]];
        h = [Definitions heightForCString:[prefsPixels UTF8String]];
        elt = nsdict();
        [elt setValue:nsfmt(@"%d", x) forKey:@"x"];
        [elt setValue:nsfmt(@"%d", y) forKey:@"y"];
        [elt setValue:nsfmt(@"%d", w) forKey:@"w"];
        [elt setValue:nsfmt(@"%d", h) forKey:@"h"];
        [elt setValue:@"Prefs" forKey:@"filePath"];
        [elt setValue:prefsPalette forKey:@"palette"];
        [elt setValue:prefsPixels forKey:@"pixels"];
        [elt setValue:openPrefsPalette forKey:@"selectedPalette"];
        [elt setValue:openPrefsPixels forKey:@"selectedPixels"];
        [elt setValue:[@"hotdog amigabuiltindir" split] forKey:@"doubleClickCommand"];
        [arr addObject:elt];
        x += w + 20;
        w = [Definitions widthForCString:[trashCanPixels UTF8String]];
        h = [Definitions heightForCString:[trashCanPixels UTF8String]];
        elt = nsdict();
        [elt setValue:nsfmt(@"%d", x) forKey:@"x"];
        [elt setValue:nsfmt(@"%d", y) forKey:@"y"];
        [elt setValue:nsfmt(@"%d", w) forKey:@"w"];
        [elt setValue:nsfmt(@"%d", h) forKey:@"h"];
        [elt setValue:@"Trash" forKey:@"filePath"];
        [elt setValue:trashCanPalette forKey:@"palette"];
        [elt setValue:trashCanPixels forKey:@"pixels"];
        [elt setValue:openTrashCanPalette forKey:@"selectedPalette"];
        [elt setValue:openTrashCanPixels forKey:@"selectedPixels"];
        [elt setValue:[@"hotdog amigabuiltindir" split] forKey:@"doubleClickCommand"];
        [arr addObject:elt];
    }
    [obj setValue:arr forKey:@"array"];
    return obj;
}
@end


@implementation Definitions(fjeiwofmkdsomvklcxjvlksjdfkjds)
static char *horizontalScrollBarLeft =
"ooooooooooooooooo\n"
"ooooooooooooooooo\n"
"ooooooXXXooooooXX\n"
"ooooooXXXooooooXX\n"
"ooooXXXooooooooXX\n"
"ooooXXXooooooooXX\n"
"ooXXXooooooooooXX\n"
"ooXXXooooooooooXX\n"
"ooXXXXXXXXXXXooXX\n"
"ooXXXXXXXXXXXooXX\n"
"ooXXXooooooooooXX\n"
"ooXXXooooooooooXX\n"
"ooooXXXooooooooXX\n"
"ooooXXXooooooooXX\n"
"ooooooXXXooooooXX\n"
"ooooooXXXooooooXX\n"
"ooooooooooooooooo\n"
"ooooooooooooooooo\n"
;
static char *horizontalScrollBarMiddleOrange =
"o\n"
"o\n"
"X\n"
"X\n"
"*\n"
"*\n"
"*\n"
"*\n"
"*\n"
"*\n"
"*\n"
"*\n"
"*\n"
"*\n"
"X\n"
"X\n"
"o\n"
"o\n"
;
static char *horizontalScrollBarMiddleWhite =
"o\n"
"o\n"
"X\n"
"X\n"
"o\n"
"o\n"
"o\n"
"o\n"
"o\n"
"o\n"
"o\n"
"o\n"
"o\n"
"o\n"
"X\n"
"X\n"
"o\n"
"o\n"
;
static char *horizontalScrollBarMiddleBlue =
"o\n"
"o\n"
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
"o\n"
"o\n"
;
static char *horizontalScrollBarRight =
"ooooooooooooooooo\n"
"ooooooooooooooooo\n"
"XXoooooooXXXooooo\n"
"XXoooooooXXXooooo\n"
"XXoooooooooXXXooo\n"
"XXoooooooooXXXooo\n"
"XXoooooooooooXXoo\n"
"XXoooooooooooXXoo\n"
"XXooXXXXXXXXXXXoo\n"
"XXooXXXXXXXXXXXoo\n"
"XXoooooooooooXXoo\n"
"XXoooooooooooXXoo\n"
"XXoooooooooXXXooo\n"
"XXoooooooooXXXooo\n"
"XXoooooooXXXooooo\n"
"XXoooooooXXXooooo\n"
"ooooooooooooooooo\n"
"ooooooooooooooooo\n"
;
static char *fuelGaugeTop =
"oo............oo\n"
"oo............oo\n"
"oo...oooooo...oo\n"
"oo...oooooo...oo\n"
"oo...oo.......oo\n"
"oo...oo.......oo\n"
"oo...oooo.....oo\n"
"oo...oooo.....oo\n"
"oo...oo.......oo\n"
"oo...oo.......oo\n"
"oo...oo.......oo\n"
"oo...oo.......oo\n"
"oo............oo\n"
"oo............oo\n"
;
static char *fuelGaugeMiddleWithFuel =
"oo************oo\n"
;
static char *fuelGaugeMiddleWithoutFuel =
"oo............oo\n"
;
static char *fuelGaugeBottom =
"oo............oo\n"
"oo............oo\n"
"oo...oooooo...oo\n"
"oo...oooooo...oo\n"
"oo...oo.......oo\n"
"oo...oo.......oo\n"
"oo...oooo.....oo\n"
"oo...oooo.....oo\n"
"oo...oo.......oo\n"
"oo...oo.......oo\n"
"oo...oooooo...oo\n"
"oo...oooooo...oo\n"
"oo............oo\n"
"oo............oo\n"
;
+ (void)drawAmigaFuelGaugeInBitmap:(id)bitmap x:(int)x0 y:(int)y0 h:(int)h pct:(double)freepct
{
    char *palette = amigaPalette;

    char *top = fuelGaugeTop;
    char *middleWithFuel = fuelGaugeMiddleWithFuel;
    char *middleWithoutFuel = fuelGaugeMiddleWithoutFuel;
    char *bottom = fuelGaugeBottom;

    int heightForTop = [Definitions heightForCString:top];
    int heightForMiddle = [Definitions heightForCString:middleWithFuel];
    int heightForBottom = [Definitions heightForCString:bottom];

    int widthForMiddle = [Definitions widthForCString:middleWithFuel];

    [bitmap drawCString:top palette:palette x:x0 y:y0];
    int ystart = y0+heightForTop;
    int yend = y0+h-heightForBottom;
    for (int y=ystart; y<yend; y+=heightForMiddle) {
        double pct = ((double)(y - ystart) / (double)(yend - ystart));
        if (pct < freepct) {
            [bitmap drawCString:middleWithoutFuel palette:palette x:x0 y:y];
        } else {
            [bitmap drawCString:middleWithFuel palette:palette x:x0 y:y];
        }
    }
    [bitmap drawCString:bottom palette:palette x:x0 y:y0+h-heightForBottom];
}
static char *verticalScrollBarTop =
"oooooXXXXXXooooo\n"
"oooooXXXXXXooooo\n"
"oooXXooXXooXXooo\n"
"oooXXooXXooXXooo\n"
"oXXooooXXooooXXo\n"
"oXXooooXXooooXXo\n"
"oooooooXXooooooo\n"
"oooooooXXooooooo\n"
"oooooooXXooooooo\n"
"oooooooXXooooooo\n"
"oooooooXXooooooo\n"
"oooooooXXooooooo\n"
"oooooooooooooooo\n"
"oooooooooooooooo\n"
"ooXXXXXXXXXXXXoo\n"
"ooXXXXXXXXXXXXoo\n"
;
static char *verticalScrollBarMiddleOrange = 
"ooXX********XXoo\n"
;
static char *verticalScrollBarMiddleWhite = 
"ooXXooooooooXXoo\n"
;
static char *verticalScrollBarMiddleBlue = 
"ooXXXXXXXXXXXXoo\n"
;
static char *verticalScrollBarBottom =
"ooXXXXXXXXXXXXoo\n"
"ooXXXXXXXXXXXXoo\n"
"oooooooooooooooo\n"
"oooooooooooooooo\n"
"oooooooXXooooooo\n"
"oooooooXXooooooo\n"
"oooooooXXooooooo\n"
"oooooooXXooooooo\n"
"oooooooXXooooooo\n"
"oooooooXXooooooo\n"
"oXXooooXXooooXXo\n"
"oXXooooXXooooXXo\n"
"oooXXooXXooXXooo\n"
"oooXXooXXooXXooo\n"
"oooooXXXXXXooooo\n"
"oooooXXXXXXooooo\n"
;

@end


@implementation Definitions(hkukgfdfthfnvbchjgfjygikghjghfjgj)
+ (id)AmigaDir
{
    id obj = [@"AmigaDir" asInstance];
    [obj setValue:[@"." asRealPath] forKey:@"title"];
    [obj updateDiskFreePct];
    return obj;
}
@end

@interface AmigaDir : IvarObject
{
    BOOL _doNotUpdate;
    time_t _timestamp;
    id _array;
    id _buttonDown;
    id _buttonHover;
    int _buttonDownOffsetX;
    int _buttonDownOffsetY;
    id _buttonDownTimestamp;
    id _selected;
    Int4 _leftArrowRect;
    Int4 _rightArrowRect;
    Int4 _upArrowRect;
    Int4 _downArrowRect;

    Int4 _titleBarRect;
    Int4 _closeButtonRect;
    Int4 _lowerButtonRect;
    Int4 _raiseButtonRect;
    Int4 _titleTextRect;
    int _buttonDownX;
    int _buttonDownY;
    int _buttonDownW;
    int _buttonDownH;

    double _diskFreePct;
    int _horizontalKnobX;
    int _horizontalKnobW;
    int _horizontalKnobVal;
    int _horizontalKnobMaxVal;
    int _verticalKnobY;
    int _verticalKnobH;
    int _verticalKnobVal;
    int _verticalKnobMaxVal;

    int _contentXMin;
    int _contentXMax;
    int _contentYMin;
    int _contentYMax;
    int _visibleX;
    int _visibleY;
    int _visibleW;
    int _visibleH;

    id _title;
}
@end
@implementation AmigaDir
- (void)updateDiskFreePct
{
    id cmd = nsarr();
    [cmd addObject:@"hotdog-getDiskUsage.pl"];
    id output = [[cmd runCommandAndReturnOutput] asString];
    double pct = [output doubleValueForKey:@"pct"];
    _diskFreePct = 1.0-pct;
}
- (int)preferredWidth
{
    return 600;
}
- (int)preferredHeight
{
    return 360;
}
- (void)updateFromCurrentDirectory:(Int4)r
{
    id bitmap = [Definitions bitmapWithWidth:1 height:1];
    [bitmap useTopazFont];
    id arr = [@"." contentsOfDirectory];
    arr = [arr asFileArray];
    int x = 20;
    int y = 10;
    for (int i=0; i<[arr count]; i++) {
        id elt = [arr nth:i];
        id palette = nil;
        id pixels = nil;
        id selectedPalette = nil;
        id selectedPixels = nil;
        id fileType = [elt valueForKey:@"fileType"];
        if ([fileType isEqual:@"file"]) {
            palette = textFilePalette;
            pixels = textFilePixels;
            selectedPalette = textFileSelectedPalette;
            selectedPixels = textFilePixels;
        } else if ([fileType isEqual:@"directory"]) {
            id filePath = [elt valueForKey:@"filePath"];
            if ([filePath isEqual:@"Trash"]) {
                palette = trashCanPalette;
                pixels = trashCanPixels;
                selectedPalette = openTrashCanPalette;
                selectedPixels = openTrashCanPixels;
            } else {
                palette = drawerPalette;
                pixels = drawerPixels;
                selectedPalette = drawerPalette;
                selectedPixels = openDrawerPixels;
            }
        }
        if (!palette || !pixels) {
            continue;
        }
        [elt setValue:palette forKey:@"palette"];
        [elt setValue:pixels forKey:@"pixels"];
        [elt setValue:selectedPalette forKey:@"selectedPalette"];
        [elt setValue:selectedPixels forKey:@"selectedPixels"];
        int w = [Definitions widthForCString:[pixels UTF8String]];
        int h = [Definitions heightForCString:[pixels UTF8String]];
        int textWidth = [Definitions bitmapWidthForText:@"X"]*MAX_CHARS_TO_DRAW;
        if (textWidth > w) {
            if (x + textWidth + 5 >= r.w) {
                x = 20;
                y += h + 30;
            }
            x += (textWidth - w) / 2;
            [elt setValue:nsfmt(@"%d", x) forKey:@"x"];
            [elt setValue:nsfmt(@"%d", y) forKey:@"y"];
            [elt setValue:nsfmt(@"%d", w) forKey:@"w"];
            [elt setValue:nsfmt(@"%d", h) forKey:@"h"];
            x += w + ((textWidth - w) / 2) + 20;
        } else {
            if (x + w + 5 >= r.w) {
                x = 20;
                y += h + 30;
            }
            [elt setValue:nsfmt(@"%d", x) forKey:@"x"];
            [elt setValue:nsfmt(@"%d", y) forKey:@"y"];
            [elt setValue:nsfmt(@"%d", w) forKey:@"w"];
            [elt setValue:nsfmt(@"%d", h) forKey:@"h"];
            x += w + 20;
        }
    }
    [self setValue:arr forKey:@"array"];
}

- (void)handleBackgroundUpdate:(id)event
{
    if (_doNotUpdate) {
        return;
    }
    time_t timestamp = [@"." fileModificationTimestamp];
    if (timestamp != _timestamp) {
        _timestamp = 0;
    }
}

- (BOOL)shouldAnimate
{
    if ([_buttonDown isEqual:@"leftArrow"]) {
    } else if ([_buttonDown isEqual:@"rightArrow"]) {
    } else if ([_buttonDown isEqual:@"upArrow"]) {
    } else if ([_buttonDown isEqual:@"downArrow"]) {
    } else {
        return NO;
    }
    if ([_buttonDown isEqual:_buttonHover]) {
        return YES;
    }
    return NO;
}
- (void)beginIteration:(id)event rect:(Int4)r
{
    if ([_buttonDown isEqual:_buttonHover]) {
        if ([_buttonDown isEqual:@"leftArrow"]) {
            _visibleX += 10;
        } else if ([_buttonDown isEqual:@"rightArrow"]) {
            _visibleX -= 10;
        } else if ([_buttonDown isEqual:@"upArrow"]) {
            _visibleY += 10;
        } else if ([_buttonDown isEqual:@"downArrow"]) {
            _visibleY -= 10;
        }
    }

    int titleBarHeight = 20;
    int closeButtonWidth = 24;
    int lowerButtonWidth = 26;
    int raiseButtonWidth = 26;
    _titleBarRect.x = 0;//r.x;
    _titleBarRect.y = 0;//r.y;
    _titleBarRect.w = r.w;
    _titleBarRect.h = titleBarHeight;
    _closeButtonRect.x = 4;//r.x+4
    _closeButtonRect.y = 0;//r.y
    _closeButtonRect.w = closeButtonWidth;
    _closeButtonRect.h = titleBarHeight;
    _lowerButtonRect.x = /*r.x+*/r.w-3-lowerButtonWidth-raiseButtonWidth+2;
    _lowerButtonRect.y = 0;//r.y
    _lowerButtonRect.w = lowerButtonWidth;
    _lowerButtonRect.h = titleBarHeight;
    _raiseButtonRect.x = /*r.x+*/r.w-3-raiseButtonWidth;
    _raiseButtonRect.y = 0;//r.y
    _raiseButtonRect.w = raiseButtonWidth;
    _raiseButtonRect.h = titleBarHeight;
    _titleTextRect.x = /*r.x+*/4+closeButtonWidth+2;
    _titleTextRect.y = /*r.y+*/2;
    _titleTextRect.w = _lowerButtonRect.x - _titleTextRect.x - 2;
    _titleTextRect.h = titleBarHeight;

    _leftArrowRect.x = /*r.x+*/2;
    _leftArrowRect.y = /*r.y+*/r.h-16;
    _leftArrowRect.w = 11;
    _leftArrowRect.h = 14;
    _rightArrowRect.x = /*r.x+*/r.w-16-2-11;
    _rightArrowRect.y = /*r.y+*/r.h-16;
    _rightArrowRect.w = 11;
    _rightArrowRect.h = 14;
    _upArrowRect.x = /*r.x+*/r.w-16+1;
    _upArrowRect.y = /*r.y+*/titleBarHeight;
    _upArrowRect.w = 14;
    _upArrowRect.h = 12;
    _downArrowRect.x = /*r.x+*/r.w-16+1;
    _downArrowRect.y = /*r.y+*/r.h-18-12;
    _downArrowRect.w = 14;
    _downArrowRect.h = 12;

    _contentXMin = 0;
    _contentXMax = 0;
    _contentYMin = 0;
    _contentYMax = 0;
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        int x = [elt intValueForKey:@"x"];
        int y = [elt intValueForKey:@"y"];
        int w = [elt intValueForKey:@"w"];
        int h = [elt intValueForKey:@"h"];
        if (x < _contentXMin) {
            _contentXMin = x;
        }
        if (x+w > _contentXMax) {
            _contentXMax = x+w;
        }
        if (y < _contentYMin) {
            _contentYMin = y;
        }
        if (y+h > _contentYMax) {
            _contentYMax = y+h+16;
        }
    }
    _contentXMax += 14 + 20;
    _contentYMax += 20 + 10 + 20;
    _visibleW = r.w;
    _visibleH = r.h;
    if (_contentXMin > _visibleX) {
        _contentXMin = _visibleX;
    }
    if (_contentXMax < _visibleX+_visibleW-1) {
        _contentXMax = _visibleX+_visibleW-1;
    }
    if (_contentYMin > _visibleY) {
        _contentYMin = _visibleY;
    }
    if (_contentYMax < _visibleY+_visibleH-1) {
        _contentYMax = _visibleY+_visibleH-1;
    }
    int contentWidth = _contentXMax - _contentXMin;
    int contentHeight = _contentYMax - _contentYMin;
    double wpct = (double)_visibleW / (double)contentWidth;
    _horizontalKnobX = _leftArrowRect.x+_leftArrowRect.w+4;
    _horizontalKnobMaxVal = (_rightArrowRect.x-5)-_horizontalKnobX;
    _horizontalKnobW = (double)_horizontalKnobMaxVal*wpct;
    _horizontalKnobMaxVal -= _horizontalKnobW;
    double xpct = (double)(_visibleX-_contentXMin)/(double)(contentWidth-_visibleW);
    if (xpct < 0.0) {
        xpct = 0.0;
    } else if (xpct > 1.0) {
        xpct = 1.0;
    }
    _horizontalKnobVal = (double)_horizontalKnobMaxVal*xpct;

    double hpct = (double)_visibleH / (double)contentHeight;
    _verticalKnobY = _upArrowRect.y+_upArrowRect.h+4;
    _verticalKnobMaxVal = (_downArrowRect.y-5)-_verticalKnobY;
    _verticalKnobH = (double)_verticalKnobMaxVal*hpct;
    _verticalKnobMaxVal -= _verticalKnobH;
    double ypct = (double)(_visibleY-_contentYMin)/(double)(contentHeight-_visibleH);
    if (ypct < 0.0) {
        ypct = 0.0;
    } else if (ypct > 1.0) {
        ypct = 1.0;
    }
    _verticalKnobVal = (double)_verticalKnobMaxVal*ypct;


    
    if (_doNotUpdate) {
        return;
    }
    if (!_timestamp) {
        _timestamp = [@"." fileModificationTimestamp];
        [self updateFromCurrentDirectory:r];
    }
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)r context:(id)context
{
    [bitmap useTopazFont];
    [bitmap setColor:@"#0055aa"];
    [bitmap fillRect:r];
    [bitmap setColor:@"white"];
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        int x = -_visibleX + [elt intValueForKey:@"x"] + 16;
        int y = -_visibleY + [elt intValueForKey:@"y"] + 20;
        int w = [elt intValueForKey:@"w"];
        int h = [elt intValueForKey:@"h"];
        if (_selected == elt) {
            id palette = [elt valueForKey:@"selectedPalette"];
            id pixels = [elt valueForKey:@"selectedPixels"];
            if (palette && pixels) {
                [bitmap drawCString:[pixels UTF8String] palette:[palette UTF8String] x:r.x+x y:r.y+y];
            }
        } else {
            id palette = [elt valueForKey:@"palette"];
            id pixels = [elt valueForKey:@"pixels"];
            if (palette && pixels) {
                [bitmap drawCString:[pixels UTF8String] palette:[palette UTF8String] x:r.x+x y:r.y+y];
            }
        }
        id filePath = [elt valueForKey:@"filePath"];
        if ([filePath length] > MAX_CHARS_TO_DRAW) {
            id a = [filePath stringToIndex:(MAX_CHARS_TO_DRAW/2)-1];
            id b = [filePath stringFromIndex:(MAX_CHARS_TO_DRAW/2)+1];
            filePath = nsfmt(@"%@..%@", a, b);
        }
        [bitmap drawBitmapText:filePath centeredAtX:x+w/2 y:y+h-8];
    }
    [Definitions drawAmigaFuelGaugeInBitmap:bitmap x:r.x y:r.y+20 h:r.h-20-18 pct:_diskFreePct];
    [self drawVerticalScrollBarInBitmap:bitmap x:r.x+r.w-16 y:r.y+20 h:r.h-20-18];
    [self drawHorizontalScrollBarInBitmap:bitmap x:r.x y:r.y+r.h-18 w:r.w-16];
    if ([_buttonDown isEqual:@"leftArrow"] && [_buttonHover isEqual:@"leftArrow"]) {
        [bitmap drawCString:leftArrowPixels palette:selectedLeftArrowPalette x:_leftArrowRect.x y:_leftArrowRect.y];
    }
    if ([_buttonDown isEqual:@"rightArrow"] && [_buttonHover isEqual:@"rightArrow"]) {
        [bitmap drawCString:rightArrowPixels palette:selectedLeftArrowPalette x:_rightArrowRect.x y:_rightArrowRect.y];
    }
    if ([_buttonDown isEqual:@"upArrow"] && [_buttonHover isEqual:@"upArrow"]) {
        [bitmap drawCString:upArrowPixels palette:selectedLeftArrowPalette x:_upArrowRect.x y:_upArrowRect.y];
    }
    if ([_buttonDown isEqual:@"downArrow"] && [_buttonHover isEqual:@"downArrow"]) {
        [bitmap drawCString:downArrowPixels palette:selectedLeftArrowPalette x:_downArrowRect.x y:_downArrowRect.y];
    }

    [bitmap drawCString:[Definitions cStringForAmigaResizeButtonPixels] palette:(([_buttonDown isEqual:@"resizeButton"]) ? selectedLeftArrowPalette : leftArrowPalette) x:r.x+r.w-16 y:r.y+r.h-18];


    // title bar
    char *palette = leftArrowPalette;
    char *highlightedPalette = selectedLeftArrowPalette;
    [Definitions drawInBitmap:bitmap left:[Definitions cStringForAmigaTitleBarLeftPixels] middle:[Definitions cStringForAmigaTitleBarMiddlePixels] right:[Definitions cStringForAmigaTitleBarRightPixels] x:_titleBarRect.x y:_titleBarRect.y w:_titleBarRect.w palette:palette];

    [bitmap drawCString:[Definitions cStringForAmigaCloseButtonPixels] palette:(([_buttonDown isEqual:@"closeButton"] && [_buttonHover isEqual:@"closeButton"]) ? highlightedPalette : palette) x:_closeButtonRect.x y:_closeButtonRect.y];
    [bitmap drawCString:[Definitions cStringForAmigaLowerButtonPixels] palette:palette x:_lowerButtonRect.x y:_lowerButtonRect.y];
    [bitmap drawCString:[Definitions cStringForAmigaRaiseButtonPixels] palette:palette x:_raiseButtonRect.x y:_raiseButtonRect.y];
    if ([_buttonDown isEqual:_buttonHover]) {
        if ([_buttonDown isEqual:@"lowerButton"]) {
            [bitmap drawCString:[Definitions cStringForAmigaLowerButtonPixels] palette:highlightedPalette x:_lowerButtonRect.x y:_lowerButtonRect.y];
        } else if ([_buttonDown isEqual:@"raiseButton"]) {
            [bitmap drawCString:[Definitions cStringForAmigaRaiseButtonPixels] palette:highlightedPalette x:_raiseButtonRect.x y:_raiseButtonRect.y];
        }
    }

    id text = _title;
    if (!text) {
        text = @"(no title)";
    }

    text = [[[bitmap fitBitmapString:text width:_titleTextRect.w-14] split:@"\n"] nth:0];

    int textWidth = [bitmap bitmapWidthForText:text];
    [Definitions drawInBitmap:bitmap left:[Definitions cStringForAmigaTextBackgroundPixels] middle:[Definitions cStringForAmigaTextBackgroundPixels] right:[Definitions cStringForAmigaTextBackgroundPixels] x:_titleTextRect.x y:_titleBarRect.y w:textWidth+3 palette:palette];
    [bitmap setColorIntR:0x00 g:0x55 b:0xaa a:0xff];
    [bitmap drawBitmapText:text x:_titleTextRect.x y:_titleTextRect.y];

    BOOL hasFocus = NO;
    {
        id windowManager = [@"windowManager" valueForKey];
        unsigned long focusInEventWindow = [[windowManager valueForKey:@"focusInEventWindow"] unsignedLongValue];
        unsigned long win = [[context valueForKey:@"window"] unsignedLongValue];
        if (focusInEventWindow && (focusInEventWindow == win)) {
            hasFocus = YES;
        }
    }

    if (!hasFocus /*![context intValueForKey:@"hasFocus"]*/) {
        Int4 rr = _titleBarRect;
        [Definitions drawInBitmap:bitmap left:[Definitions cStringForAmigaInactiveTitleBarPixels] middle:[Definitions cStringForAmigaInactiveTitleBarPixels] right:[Definitions cStringForAmigaInactiveTitleBarPixels] x:_titleTextRect.x y:_titleBarRect.y w:_titleTextRect.w palette:palette];
    }
}

- (void)handleMouseDown:(id)event
{
    {
        id x11dict = [event valueForKey:@"x11dict"];
        unsigned long win = [[x11dict valueForKey:@"window"] unsignedLongValue];
        id windowManager = [@"windowManager" valueForKey];
        [windowManager XRaiseWindow:win];
    }


    [self setValue:nil forKey:@"buttonDown"];
    [self setValue:nil forKey:@"buttonHover"];

    [self setValue:nil forKey:@"selected"];
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    int viewWidth = [event intValueForKey:@"viewWidth"];
    int viewHeight = [event intValueForKey:@"viewHeight"];
    
    if ([Definitions isX:mouseX y:mouseY insideRect:_leftArrowRect]) {
        [self setValue:@"leftArrow" forKey:@"buttonDown"];
        [self setValue:@"leftArrow" forKey:@"buttonHover"];
        _visibleX += 10;
        return;
    }
    if ([Definitions isX:mouseX y:mouseY insideRect:_rightArrowRect]) {
        [self setValue:@"rightArrow" forKey:@"buttonDown"];
        [self setValue:@"rightArrow" forKey:@"buttonHover"];
        _visibleX -= 10;
        return;
    }
    if ([Definitions isX:mouseX y:mouseY insideRect:_upArrowRect]) {
        [self setValue:@"upArrow" forKey:@"buttonDown"];
        [self setValue:@"upArrow" forKey:@"buttonHover"];
        _visibleY += 10;
        return;
    }
    if ([Definitions isX:mouseX y:mouseY insideRect:_downArrowRect]) {
        [self setValue:@"downArrow" forKey:@"buttonDown"];
        [self setValue:@"downArrow" forKey:@"buttonHover"];
        _visibleY -= 10;
        return;
    }
    if (mouseX >= viewWidth-16) {
        if (mouseY >= viewHeight-16) {
            [self setValue:@"resizeButton" forKey:@"buttonDown"];
            [self setValue:nil forKey:@"buttonHover"];
            _buttonDownX = mouseX;
            _buttonDownY = mouseY;
            _buttonDownW = viewWidth;
            _buttonDownH = viewHeight;
            return;
        }
    }
    if ([Definitions isX:mouseX y:mouseY insideRect:_closeButtonRect]) {
        [self setValue:@"closeButton" forKey:@"buttonDown"];
        [self setValue:@"closeButton" forKey:@"buttonHover"];
        _buttonDownX = mouseX;
        _buttonDownY = mouseY;
        _buttonDownW = viewWidth;
        _buttonDownH = viewHeight;
        return;
    }
    if ([Definitions isX:mouseX y:mouseY insideRect:_raiseButtonRect]) {
        [self setValue:@"raiseButton" forKey:@"buttonDown"];
        [self setValue:@"raiseButton" forKey:@"buttonHover"];
        _buttonDownX = mouseX;
        _buttonDownY = mouseY;
        _buttonDownW = viewWidth;
        _buttonDownH = viewHeight;
        return;
    }
    if ([Definitions isX:mouseX y:mouseY insideRect:_lowerButtonRect]) {
        [self setValue:@"lowerButton" forKey:@"buttonDown"];
        [self setValue:@"lowerButton" forKey:@"buttonHover"];
        _buttonDownX = mouseX;
        _buttonDownY = mouseY;
        _buttonDownW = viewWidth;
        _buttonDownH = viewHeight;
        return;
    }
    if ([Definitions isX:mouseX y:mouseY insideRect:_titleBarRect]) {
        [self setValue:@"titleBar" forKey:@"buttonDown"];
        [self setValue:nil forKey:@"buttonHover"];
        _buttonDownX = mouseX;
        _buttonDownY = mouseY;
        _buttonDownW = viewWidth;
        _buttonDownH = viewHeight;
        return;
    }

    if (mouseY > _leftArrowRect.y) {
        if (mouseY < _leftArrowRect.y+_leftArrowRect.h-1) {
            if (mouseX < _horizontalKnobX) {
            } else if (mouseX < _horizontalKnobX+_horizontalKnobVal) {
                _visibleX -= _visibleW;
                if (_visibleX < _contentXMin) {
                    _visibleX = _contentXMin;
                }
                return;
            } else if (mouseX < _horizontalKnobX+_horizontalKnobVal+_horizontalKnobW) {
                [self setValue:@"horizontalScrollBar" forKey:@"buttonDown"];
                _buttonDownX = mouseX - (_horizontalKnobX+_horizontalKnobVal);
                return;
            } else if (mouseX < _horizontalKnobX+_horizontalKnobMaxVal+_horizontalKnobW) {
                _visibleX += _visibleW;
                if (_visibleX > _contentXMax+1 - _visibleW) {
                    _visibleX = _contentXMax+1 - _visibleW;
                }
                return;
            }
        }
    }

    if (mouseX > _upArrowRect.x) {
        if (mouseX < _upArrowRect.x+_upArrowRect.w-1) {
            if (mouseY < _verticalKnobY) {
            } else if (mouseY < _verticalKnobY+_verticalKnobVal) {
                _visibleY -= _visibleH;
                if (_visibleY < _contentYMin) {
                    _visibleY = _contentYMin;
                }
                return;
            } else if (mouseY < _verticalKnobY+_verticalKnobVal+_verticalKnobH) {
                [self setValue:@"verticalScrollBar" forKey:@"buttonDown"];
                _buttonDownY = mouseY - (_verticalKnobY+_verticalKnobVal);
                return;
            } else if (mouseY < _verticalKnobY+_verticalKnobMaxVal+_verticalKnobH) {
                _visibleY += _visibleH;
                if (_visibleY > _contentYMax+1 - _visibleH) {
                    _visibleY = _contentYMax+1 - _visibleH;
                }
                return;
            }
        }
    }


    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        int x = -_visibleX + [elt intValueForKey:@"x"] + 16;
        int y = -_visibleY + [elt intValueForKey:@"y"] + 20;
        int w = [elt intValueForKey:@"w"];
        int h = [elt intValueForKey:@"h"];
        if ((mouseX >= x) && (mouseX < x+w) && (mouseY >= y) && (mouseY < y+h)) {
            [self setValue:elt forKey:@"buttonDown"];
            [self setValue:elt forKey:@"selected"];
            _buttonDownOffsetX = mouseX - x;
            _buttonDownOffsetY = mouseY - y;
            struct timeval tv;
            gettimeofday(&tv, NULL);
            id timestamp = nsfmt(@"%ld.%06ld", tv.tv_sec, tv.tv_usec);
            if (_buttonDownTimestamp && ([timestamp doubleValue] - [_buttonDownTimestamp doubleValue] <= 0.3)) {
                id command = [_selected valueForKey:@"doubleClickCommand"];
                if (command) {
                    [command runCommandInBackground];
                } else {
                    id filePath = [_selected valueForKey:@"filePath"];
                    if ([filePath length]) {
                        if ([filePath isDirectory]) {
                            id cmd = nsarr();
                            [cmd addObject:@"hotdog"];
                            [cmd addObject:@"amigadir"];
                            [cmd addObject:filePath];
                            [cmd runCommandInBackground];
                        } else {
                            id cmd = nsarr();   
                            [cmd addObject:@"hotdog-open:.pl"];
                            [cmd addObject:filePath];
                            [cmd runCommandInBackground];
                        }
                    }
                }
                [self setValue:nil forKey:@"buttonDownTimestamp"];
            } else {
                [self setValue:timestamp forKey:@"buttonDownTimestamp"];
            }
            break;
        }
    }
}

- (void)handleMouseMoved:(id)event
{
    if (!_buttonDown) {
        return;
    }
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    if ([_buttonDown isEqual:@"leftArrow"]) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_leftArrowRect]) {
            [self setValue:_buttonDown forKey:@"buttonHover"];
        } else {
            [self setValue:nil forKey:@"buttonHover"];
        }
    } else if ([_buttonDown isEqual:@"rightArrow"]) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_rightArrowRect]) {
            [self setValue:_buttonDown forKey:@"buttonHover"];
        } else {
            [self setValue:nil forKey:@"buttonHover"];
        }
    } else if ([_buttonDown isEqual:@"upArrow"]) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_upArrowRect]) {
            [self setValue:_buttonDown forKey:@"buttonHover"];
        } else {
            [self setValue:nil forKey:@"buttonHover"];
        }
    } else if ([_buttonDown isEqual:@"downArrow"]) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_downArrowRect]) {
            [self setValue:_buttonDown forKey:@"buttonHover"];
        } else {
            [self setValue:nil forKey:@"buttonHover"];
        }
    } else if ([_buttonDown isEqual:@"closeButton"]) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_closeButtonRect]) {
            [self setValue:_buttonDown forKey:@"buttonHover"];
        } else {
            [self setValue:nil forKey:@"buttonHover"];
        }
        return;
    } else if ([_buttonDown isEqual:@"raiseButton"]) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_raiseButtonRect]) {
            [self setValue:_buttonDown forKey:@"buttonHover"];
        } else {
            [self setValue:nil forKey:@"buttonHover"];
        }
        return;
    } else if ([_buttonDown isEqual:@"lowerButton"]) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_lowerButtonRect]) {
            [self setValue:_buttonDown forKey:@"buttonHover"];
        } else {
            [self setValue:nil forKey:@"buttonHover"];
        }
        return;
    } else if ([_buttonDown isEqual:@"titleBar"]) {
        int mouseRootX = [event intValueForKey:@"mouseRootX"];
        int mouseRootY = [event intValueForKey:@"mouseRootY"];
        int viewHeight = [event intValueForKey:@"viewHeight"];

        id dict = [event valueForKey:@"x11dict"];

        int newX = mouseRootX - _buttonDownX;
        int newY = mouseRootY - _buttonDownY;

        [dict setValue:nsfmt(@"%d", newX) forKey:@"x"];
        [dict setValue:nsfmt(@"%d", newY) forKey:@"y"];

        [dict setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];
        return;
    } else if ([_buttonDown isEqual:@"resizeButton"]) {
        int viewWidth = [event intValueForKey:@"viewWidth"];
        int viewHeight = [event intValueForKey:@"viewHeight"];

        id dict = [event valueForKey:@"x11dict"];

        int newWidth = mouseX + (_buttonDownW - _buttonDownX);
        if (newWidth < 100) {
            newWidth = 100;
        }
        int newHeight = mouseY + (_buttonDownH - _buttonDownY);
        if (newHeight < 100) {
            newHeight = 100;
        }
        [dict setValue:nsfmt(@"%d %d", newWidth, newHeight) forKey:@"resizeWindow"];
        return;
    } else if ([_buttonDown isEqual:@"horizontalScrollBar"]) {
        _horizontalKnobVal = mouseX - _horizontalKnobX - _buttonDownX;
        if (_horizontalKnobVal < 0) {
            _horizontalKnobVal = 0;
        } else if (_horizontalKnobVal > _horizontalKnobMaxVal) {
            _horizontalKnobVal = _horizontalKnobMaxVal;
        }

        int contentWidth = _contentXMax - _contentXMin - _visibleW;
        double pct = 0.0;
        if (_horizontalKnobMaxVal) {
            pct = (double)_horizontalKnobVal / (double)_horizontalKnobMaxVal;
        }
        _visibleX = _contentXMin + contentWidth*pct;
    } else if ([_buttonDown isEqual:@"verticalScrollBar"]) {
        _verticalKnobVal = mouseY - _verticalKnobY - _buttonDownY;
        if (_verticalKnobVal < 0) {
            _verticalKnobVal = 0;
        } else if (_verticalKnobVal > _verticalKnobMaxVal) {
            _verticalKnobVal = _verticalKnobMaxVal;
        }

        int contentHeight = _contentYMax - _contentYMin - _visibleH;
        double pct = 0.0;
        if (_verticalKnobMaxVal) {
            pct = (double)_verticalKnobVal / (double)_verticalKnobMaxVal;
        }
        _visibleY = _contentYMin + contentHeight*pct;
    } else {
        [_buttonDown setValue:nsfmt(@"%d", mouseX - _buttonDownOffsetX + _visibleX - 16) forKey:@"x"];
        [_buttonDown setValue:nsfmt(@"%d", mouseY - _buttonDownOffsetY + _visibleY - 20) forKey:@"y"];
        [self setValue:nil forKey:@"buttonDownTimestamp"];
    }
}

- (void)handleMouseUp:(id)event
{
    if ([_buttonDown isEqual:@"closeButton"] && [_buttonDown isEqual:_buttonHover]) {
        exit(0);
    }
    if ([_buttonDown isEqual:@"raiseButton"] && [_buttonDown isEqual:_buttonHover]) {
        id x11dict = [event valueForKey:@"x11dict"];
        id windowManager = [event valueForKey:@"windowManager"];
        [windowManager raiseObjectWindow:x11dict];
    }
    if ([_buttonDown isEqual:@"lowerButton"] && [_buttonDown isEqual:_buttonHover]) {
        id x11dict = [event valueForKey:@"x11dict"];
        id windowManager = [event valueForKey:@"windowManager"];
        [windowManager lowerObjectWindow:x11dict];
    }
    [self setValue:nil forKey:@"buttonDown"];
    [self setValue:nil forKey:@"buttonHover"];
}

- (void)drawHorizontalScrollBarInBitmap:(id)bitmap x:(int)x0 y:(int)y0 w:(int)w
{
    BOOL buttonDown = ([_buttonDown isEqual:@"horizontalScrollBar"]) ? YES : NO;

    char *palette = amigaPalette;

    char *left = horizontalScrollBarLeft;
    char *middleOrange = horizontalScrollBarMiddleOrange;
    char *middleWhite = horizontalScrollBarMiddleWhite;
    char *middleBlue = horizontalScrollBarMiddleBlue;
    char *right = horizontalScrollBarRight;

    int widthForLeft = [Definitions widthForCString:left];
    int widthForMiddle = [Definitions widthForCString:middleWhite];
    int widthForRight = [Definitions widthForCString:right];

    int heightForMiddle = [Definitions heightForCString:middleWhite];

    [bitmap drawCString:left palette:palette x:x0 y:y0];
    int xstart = x0+widthForLeft;
    int xend = x0+w-widthForRight;
    for (int x=xstart; x<xend; x+=widthForMiddle) {
        if (x < _horizontalKnobX+_horizontalKnobVal) {
            [bitmap drawCString:middleBlue palette:palette x:x y:y0];
        } else if (x > _horizontalKnobX+_horizontalKnobVal+_horizontalKnobW) {
            [bitmap drawCString:middleBlue palette:palette x:x y:y0];
        } else {
            if (buttonDown) {
                [bitmap drawCString:middleOrange palette:palette x:x y:y0];
            } else {
                [bitmap drawCString:middleWhite palette:palette x:x y:y0];
            }
        }
    }
    [bitmap drawCString:right palette:palette x:x0+w-widthForRight y:y0];
}
- (void)drawVerticalScrollBarInBitmap:(id)bitmap x:(int)x0 y:(int)y0 h:(int)h
{
    BOOL buttonDown = ([_buttonDown isEqual:@"verticalScrollBar"]) ? YES : NO;

    char *palette = amigaPalette;

    char *top = verticalScrollBarTop;
    char *middleOrange = verticalScrollBarMiddleOrange;
    char *middleWhite = verticalScrollBarMiddleWhite;
    char *middleBlue = verticalScrollBarMiddleBlue;
    char *bottom = verticalScrollBarBottom;

    int heightForTop = [Definitions heightForCString:top];
    int heightForMiddle = [Definitions heightForCString:middleWhite];
    int heightForBottom = [Definitions heightForCString:bottom];

    int widthForMiddle = [Definitions widthForCString:middleWhite];

    [bitmap drawCString:top palette:palette x:x0 y:y0];
    int ystart = y0+heightForTop;
    int yend = y0+h-heightForBottom;
    for (int y=ystart; y<yend; y+=heightForMiddle) {
        if (y < _verticalKnobY+_verticalKnobVal) {
            [bitmap drawCString:middleBlue palette:palette x:x0 y:y];
        } else if (y > _verticalKnobY+_verticalKnobVal+_verticalKnobH) {
            [bitmap drawCString:middleBlue palette:palette x:x0 y:y];
        } else {
            if (buttonDown) {
                [bitmap drawCString:middleOrange palette:palette x:x0 y:y];
            } else {
                [bitmap drawCString:middleWhite palette:palette x:x0 y:y];
            }
        }
    }
    [bitmap drawCString:bottom palette:palette x:x0 y:y0+h-heightForBottom];
}
@end


