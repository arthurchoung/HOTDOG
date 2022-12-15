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

static id leftScrollArrowPalette =
@". #000022\n"
@"* #ff8800\n"
@"X #0055aa\n"
@"o #ffffff\n"
;
static id selectedLeftScrollArrowPalette =
@"o #000022\n"
@"X #ff8800\n"
@"* #0055aa\n"
@". #ffffff\n"
;

static id leftScrollArrowPixels =
@"ooooXXXoooo\n"
@"ooooXXXoooo\n"
@"ooXXXoooooo\n"
@"ooXXXoooooo\n"
@"XXXoooooooo\n"
@"XXXoooooooo\n"
@"XXXXXXXXXXX\n"
@"XXXXXXXXXXX\n"
@"XXXoooooooo\n"
@"XXXoooooooo\n"
@"ooXXXoooooo\n"
@"ooXXXoooooo\n"
@"ooooXXXoooo\n"
@"ooooXXXoooo\n"
;
static id rightScrollArrowPixels =
@"oooooXXXooo\n"
@"oooooXXXooo\n"
@"oooooooXXXo\n"
@"oooooooXXXo\n"
@"oooooooooXX\n"
@"oooooooooXX\n"
@"XXXXXXXXXXX\n"
@"XXXXXXXXXXX\n"
@"oooooooooXX\n"
@"oooooooooXX\n"
@"oooooooXXXo\n"
@"oooooooXXXo\n"
@"oooooXXXooo\n"
@"oooooXXXooo\n"
;
static id upScrollArrowPixels =
@"ooooXXXXXXoooo\n"
@"ooooXXXXXXoooo\n"
@"ooXXooXXooXXoo\n"
@"ooXXooXXooXXoo\n"
@"XXooooXXooooXX\n"
@"XXooooXXooooXX\n"
@"ooooooXXoooooo\n"
@"ooooooXXoooooo\n"
@"ooooooXXoooooo\n"
@"ooooooXXoooooo\n"
@"ooooooXXoooooo\n"
@"ooooooXXoooooo\n"
;
static id downScrollArrowPixels =
@"ooooooXXoooooo\n"
@"ooooooXXoooooo\n"
@"ooooooXXoooooo\n"
@"ooooooXXoooooo\n"
@"ooooooXXoooooo\n"
@"ooooooXXoooooo\n"
@"XXooooXXooooXX\n"
@"XXooooXXooooXX\n"
@"ooXXooXXooXXoo\n"
@"ooXXooXXooXXoo\n"
@"ooooXXXXXXoooo\n"
@"ooooXXXXXXoooo\n"
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
+ (char *)cStringForAmigaHorizontalScrollBarLeft
{
    return
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
}
+ (char *)cStringForAmigaHorizontalScrollBarMiddle
{
    return
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
}
+ (char *)cStringForAmigaHorizontalScrollBarRight
{
    return
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
}
+ (void)drawAmigaHorizontalScrollBarInBitmap:(id)bitmap x:(int)x0 y:(int)y0 w:(int)w
{
    char *palette = amigaPalette;

    char *left = [Definitions cStringForAmigaHorizontalScrollBarLeft];
    char *middle = [Definitions cStringForAmigaHorizontalScrollBarMiddle];
    char *right = [Definitions cStringForAmigaHorizontalScrollBarRight];

    int widthForLeft = [Definitions widthForCString:left];
    int widthForMiddle = [Definitions widthForCString:middle];
    int widthForRight = [Definitions widthForCString:right];

    int heightForMiddle = [Definitions heightForCString:middle];

    [bitmap drawCString:left palette:palette x:x0 y:y0];
    int x;
    for (x=x0+widthForLeft; x<x0+w-widthForRight; x+=widthForMiddle) {
        [bitmap drawCString:middle palette:palette x:x y:y0];
    }
    [bitmap drawCString:right palette:palette x:x0+w-widthForRight y:y0];
}
+ (char *)cStringForAmigaFuelGaugeTop
{
    return
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
}
+ (char *)cStringForAmigaFuelGaugeMiddle
{
    return
"oo************oo\n"
"oo************oo\n"
;
}
+ (char *)cStringForAmigaFuelGaugeBottom
{
    return
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
}
+ (void)drawAmigaFuelGaugeInBitmap:(id)bitmap x:(int)x0 y:(int)y0 h:(int)h
{
    char *palette = amigaPalette;

    char *top = [Definitions cStringForAmigaFuelGaugeTop];
    char *middle = [Definitions cStringForAmigaFuelGaugeMiddle];
    char *bottom = [Definitions cStringForAmigaFuelGaugeBottom];

    int heightForTop = [Definitions heightForCString:top];
    int heightForMiddle = [Definitions heightForCString:middle];
    int heightForBottom = [Definitions heightForCString:bottom];

    int widthForMiddle = [Definitions widthForCString:middle];

    [bitmap drawCString:top palette:palette x:x0 y:y0];
    for (int y=y0+heightForTop; y<y0+h-heightForBottom; y+=heightForMiddle) {
        [bitmap drawCString:middle palette:palette x:x0 y:y];
    }
    [bitmap drawCString:bottom palette:palette x:x0 y:y0+h-heightForBottom];
}
//FIXME this is the correct one. the other one has one pixel cut off on the right side
+ (char *)cStringForAmigaVerticalScrollBarTop
{
    return
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
}
+ (char *)cStringForAmigaVerticalScrollBarMiddle
{
    return
"ooXXooooooooXXoo\n"
"ooXXooooooooXXoo\n"
;
}
+ (char *)cStringForAmigaVerticalScrollBarBottom
{
    return
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
}
/*
this one has one pixel cut off on the right
+ (char *)cStringForAmigaVerticalScrollBarTop
{
    return
"oooooXXXXXXooo\n"
"oooooXXXXXXooo\n"
"oooXXooXXooXXo\n"
"oooXXooXXooXXo\n"
"oXXooooXXooooX\n"
"oXXooooXXooooX\n"
"oooooooXXooooo\n"
"oooooooXXooooo\n"
"oooooooXXooooo\n"
"oooooooXXooooo\n"
"oooooooXXooooo\n"
"oooooooXXooooo\n"
"oooooooooooooo\n"
"oooooooooooooo\n"
"ooXXXXXXXXXXXX\n"
"ooXXXXXXXXXXXX\n"
;
}
+ (char *)cStringForAmigaVerticalScrollBarMiddle
{
    return
"ooXXooooooooXX\n"
"ooXXooooooooXX\n"
;
}
+ (char *)cStringForAmigaVerticalScrollBarBottom
{
    return
"ooXXXXXXXXXXXX\n"
"ooXXXXXXXXXXXX\n"
"oooooooooooooo\n"
"oooooooooooooo\n"
"oooooooXXooooo\n"
"oooooooXXooooo\n"
"oooooooXXooooo\n"
"oooooooXXooooo\n"
"oooooooXXooooo\n"
"oooooooXXooooo\n"
"oXXooooXXooooX\n"
"oXXooooXXooooX\n"
"oooXXooXXooXXo\n"
"oooXXooXXooXXo\n"
"oooooXXXXXXooo\n"
"oooooXXXXXXooo\n"
;
}
*/
+ (void)drawAmigaVerticalScrollBarInBitmap:(id)bitmap x:(int)x0 y:(int)y0 h:(int)h
{
    char *palette = amigaPalette;

    char *top = [Definitions cStringForAmigaVerticalScrollBarTop];
    char *middle = [Definitions cStringForAmigaVerticalScrollBarMiddle];
    char *bottom = [Definitions cStringForAmigaVerticalScrollBarBottom];

    int heightForTop = [Definitions heightForCString:top];
    int heightForMiddle = [Definitions heightForCString:middle];
    int heightForBottom = [Definitions heightForCString:bottom];

    int widthForMiddle = [Definitions widthForCString:middle];

    [bitmap drawCString:top palette:palette x:x0 y:y0];
    for (int y=y0+heightForTop; y<y0+h-heightForBottom; y+=heightForMiddle) {
        [bitmap drawCString:middle palette:palette x:x0 y:y];
    }
    [bitmap drawCString:bottom palette:palette x:x0 y:y0+h-heightForBottom];
}
@end


@implementation Definitions(hkukgfdfthfnvbchjgfjygikghjghfjgj)
+ (id)AmigaDir
{
    id obj = [@"AmigaDir" asInstance];
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
    Int4 _leftScrollArrowRect;
    Int4 _rightScrollArrowRect;
    Int4 _upScrollArrowRect;
    Int4 _downScrollArrowRect;
    int _originX;
    int _originY;

    Int4 _titleBarRect;
    Int4 _closeButtonRect;
    Int4 _lowerButtonRect;
    Int4 _raiseButtonRect;
    Int4 _titleTextRect;
    int _buttonDownX;
    int _buttonDownY;
    int _buttonDownW;
    int _buttonDownH;
}
@end
@implementation AmigaDir
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
    int y = 20 + 5;
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
    if ([_buttonDown isEqual:@"leftScrollArrow"]) {
    } else if ([_buttonDown isEqual:@"rightScrollArrow"]) {
    } else if ([_buttonDown isEqual:@"upScrollArrow"]) {
    } else if ([_buttonDown isEqual:@"downScrollArrow"]) {
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
        if ([_buttonDown isEqual:@"leftScrollArrow"]) {
            _originX += 10;
        } else if ([_buttonDown isEqual:@"rightScrollArrow"]) {
            _originX -= 10;
        } else if ([_buttonDown isEqual:@"upScrollArrow"]) {
            _originY += 10;
        } else if ([_buttonDown isEqual:@"downScrollArrow"]) {
            _originY -= 10;
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

    _leftScrollArrowRect.x = r.x+2;
    _leftScrollArrowRect.y = r.y+r.h-16;
    _leftScrollArrowRect.w = 11;
    _leftScrollArrowRect.h = 14;
    _rightScrollArrowRect.x = r.x+r.w-16-2-11;
    _rightScrollArrowRect.y = r.y+r.h-16;
    _rightScrollArrowRect.w = 11;
    _rightScrollArrowRect.h = 14;
    _upScrollArrowRect.x = r.x+r.w-16+1;
    _upScrollArrowRect.y = r.y+titleBarHeight;
    _upScrollArrowRect.w = 14;
    _upScrollArrowRect.h = 12;
    _downScrollArrowRect.x = r.x+r.w-16+1;
    _downScrollArrowRect.y = r.y+r.h-18-12;
    _downScrollArrowRect.w = 14;
    _downScrollArrowRect.h = 12;

    if (_doNotUpdate) {
        return;
    }
    if (!_timestamp) {
        _timestamp = [@"." fileModificationTimestamp];
        [self updateFromCurrentDirectory:r];
    }
}
- (void)calculateRects:(Int4)r
{
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)r context:(id)context
{
    [bitmap useTopazFont];
    [bitmap setColor:@"#0055aa"];
    [bitmap fillRect:r];
    [bitmap setColor:@"white"];
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        int x = _originX + 14 + [elt intValueForKey:@"x"];
        int y = _originY + [elt intValueForKey:@"y"];
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
    [Definitions drawAmigaFuelGaugeInBitmap:bitmap x:r.x y:r.y+20 h:r.h-20-18];
    [Definitions drawAmigaVerticalScrollBarInBitmap:bitmap x:r.x+r.w-16 y:r.y+20 h:r.h-20-18];
    [Definitions drawAmigaHorizontalScrollBarInBitmap:bitmap x:r.x y:r.y+r.h-18 w:r.w-16];
    if ([_buttonDown isEqual:@"leftScrollArrow"] && [_buttonHover isEqual:@"leftScrollArrow"]) {
        [bitmap drawCString:[leftScrollArrowPixels UTF8String] palette:[selectedLeftScrollArrowPalette UTF8String] x:_leftScrollArrowRect.x y:_leftScrollArrowRect.y];
    }
    if ([_buttonDown isEqual:@"rightScrollArrow"] && [_buttonHover isEqual:@"rightScrollArrow"]) {
        [bitmap drawCString:[rightScrollArrowPixels UTF8String] palette:[selectedLeftScrollArrowPalette UTF8String] x:_rightScrollArrowRect.x y:_rightScrollArrowRect.y];
    }
    if ([_buttonDown isEqual:@"upScrollArrow"] && [_buttonHover isEqual:@"upScrollArrow"]) {
        [bitmap drawCString:[upScrollArrowPixels UTF8String] palette:[selectedLeftScrollArrowPalette UTF8String] x:_upScrollArrowRect.x y:_upScrollArrowRect.y];
    }
    if ([_buttonDown isEqual:@"downScrollArrow"] && [_buttonHover isEqual:@"downScrollArrow"]) {
        [bitmap drawCString:[downScrollArrowPixels UTF8String] palette:[selectedLeftScrollArrowPalette UTF8String] x:_downScrollArrowRect.x y:_downScrollArrowRect.y];
    }

    [bitmap drawCString:[Definitions cStringForAmigaResizeButtonPixels] palette:(([_buttonDown isEqual:@"resizeButton"]) ? [selectedLeftScrollArrowPalette UTF8String] : [leftScrollArrowPalette UTF8String]) x:r.x+r.w-16 y:r.y+r.h-18];


    // title bar
    char *palette = [leftScrollArrowPalette UTF8String];
    char *highlightedPalette = [selectedLeftScrollArrowPalette UTF8String];
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

    id text = [context valueForKey:@"name"];
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
    [self setValue:nil forKey:@"buttonDown"];
    [self setValue:nil forKey:@"buttonHover"];

    [self setValue:nil forKey:@"selected"];
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    int viewWidth = [event intValueForKey:@"viewWidth"];
    int viewHeight = [event intValueForKey:@"viewHeight"];
    
    if ([Definitions isX:mouseX y:mouseY insideRect:_leftScrollArrowRect]) {
        [self setValue:@"leftScrollArrow" forKey:@"buttonDown"];
        [self setValue:@"leftScrollArrow" forKey:@"buttonHover"];
        _originX += 10;
        return;
    }
    if ([Definitions isX:mouseX y:mouseY insideRect:_rightScrollArrowRect]) {
        [self setValue:@"rightScrollArrow" forKey:@"buttonDown"];
        [self setValue:@"rightScrollArrow" forKey:@"buttonHover"];
        _originX -= 10;
        return;
    }
    if ([Definitions isX:mouseX y:mouseY insideRect:_upScrollArrowRect]) {
        [self setValue:@"upScrollArrow" forKey:@"buttonDown"];
        [self setValue:@"upScrollArrow" forKey:@"buttonHover"];
        _originY += 10;
        return;
    }
    if ([Definitions isX:mouseX y:mouseY insideRect:_downScrollArrowRect]) {
        [self setValue:@"downScrollArrow" forKey:@"buttonDown"];
        [self setValue:@"downScrollArrow" forKey:@"buttonHover"];
        _originY -= 10;
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


    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        int x = _originX + 14 + [elt intValueForKey:@"x"];
        int y = _originY + [elt intValueForKey:@"y"];
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
                            [cmd addObject:@"dir"];
                            [cmd addObject:filePath];
                            [cmd runCommandInBackground];
                        } else {
                            id cmd = nsarr();   
                            [cmd addObject:@"hotdog-handleFile:.pl"];
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
    if ([_buttonDown isEqual:@"leftScrollArrow"]) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_leftScrollArrowRect]) {
            [self setValue:_buttonDown forKey:@"buttonHover"];
        } else {
            [self setValue:nil forKey:@"buttonHover"];
        }
    } else if ([_buttonDown isEqual:@"rightScrollArrow"]) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_rightScrollArrowRect]) {
            [self setValue:_buttonDown forKey:@"buttonHover"];
        } else {
            [self setValue:nil forKey:@"buttonHover"];
        }
    } else if ([_buttonDown isEqual:@"upScrollArrow"]) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_upScrollArrowRect]) {
            [self setValue:_buttonDown forKey:@"buttonHover"];
        } else {
            [self setValue:nil forKey:@"buttonHover"];
        }
    } else if ([_buttonDown isEqual:@"downScrollArrow"]) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_downScrollArrowRect]) {
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
    } else {
        [_buttonDown setValue:nsfmt(@"%d", mouseX - _buttonDownOffsetX) forKey:@"x"];
        [_buttonDown setValue:nsfmt(@"%d", mouseY - _buttonDownOffsetY) forKey:@"y"];
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

@end

/*

static id leftScrollArrowPixels =
@"ooooXXXoooo\n"
@"bbbbbbbbbbb\n"
@"ooXXXoooooo\n"
@"bbbbbbbbbbb\n"
@"XXXoooooooo\n"
@"bbbbbbbbbbb\n"
@"XXXXXXXXXXX\n"
@"bbbbbbbbbbb\n"
@"XXXoooooooo\n"
@"bbbbbbbbbbb\n"
@"ooXXXoooooo\n"
@"bbbbbbbbbbb\n"
@"ooooXXXoooo\n"
@"bbbbbbbbbbb\n"
;
static id rightScrollArrowPixels =
@"oooooXXXooo\n"
@"bbbbbbbbbbb\n"
@"oooooooXXXo\n"
@"bbbbbbbbbbb\n"
@"oooooooooXX\n"
@"bbbbbbbbbbb\n"
@"XXXXXXXXXXX\n"
@"bbbbbbbbbbb\n"
@"oooooooooXX\n"
@"bbbbbbbbbbb\n"
@"oooooooXXXo\n"
@"bbbbbbbbbbb\n"
@"oooooXXXooo\n"
@"bbbbbbbbbbb\n"
;
static id upScrollArrowPixels =
@"ooooXXXXXXoooo\n"
@"bbbbbbbbbbbbbb\n"
@"ooXXooXXooXXoo\n"
@"bbbbbbbbbbbbbb\n"
@"XXooooXXooooXX\n"
@"bbbbbbbbbbbbbb\n"
@"ooooooXXoooooo\n"
@"bbbbbbbbbbbbbb\n"
@"ooooooXXoooooo\n"
@"bbbbbbbbbbbbbb\n"
@"ooooooXXoooooo\n"
@"bbbbbbbbbbbbbb\n"
;
static id downScrollArrowPixels =
@"ooooooXXoooooo\n"
@"bbbbbbbbbbbbbb\n"
@"ooooooXXoooooo\n"
@"bbbbbbbbbbbbbb\n"
@"ooooooXXoooooo\n"
@"bbbbbbbbbbbbbb\n"
@"XXooooXXooooXX\n"
@"bbbbbbbbbbbbbb\n"
@"ooXXooXXooXXoo\n"
@"bbbbbbbbbbbbbb\n"
@"ooooXXXXXXoooo\n"
@"bbbbbbbbbbbbbb\n"
;
static id drawerPixels =
@"              ...........................................................\n"
@"              bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"          ....oooooooooooooooooooooooooooooooooooooooooooooooooooooo...o.\n"
@"          bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"      ....oooooooooooooooooooooooooooooooooooooooooooooooooooooooo...oo..\n"
@"      bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ................................................................ooo.o.\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ..oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo..oooo..\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ..ooo......................................................ooo..ooo.o.\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ..ooo..oooooooooooooooooooooooooooooooooooooooooooooooooo..ooo..oo.o..\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ..ooo..oooooooooooooooooooooooooooooooooooooooooooooooooo..ooo..ooo.o.\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ..ooo..ooooooooooooooooo...oooooooooo...ooooooooooooooooo..ooo..oo.o..\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ..ooo..oooooooooooooooo................oooooooooooooooooo..ooo..o.o.. \n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
@"   ..ooo..oooooooooooooooooooooooooooooooooooooooooooooooooo..ooo..oo..  \n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
@"   ..ooo..oooooooooooooooooooooooooooooooooooooooooooooooooo..ooo..o..   \n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb   \n"
@"   ..ooo......................................................ooo....    \n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb    \n"
@"   ..oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo...     \n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb     \n"
@"   ................................................................      \n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb      \n"
@"                                                                         \n"
@"                                                                         \n"
@"                                                                         \n"
@"                                                                         \n"
;
static id openDrawerPixels =
@"              ...........................................................\n"
@"              bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"          ....oooooooooooooooooooooooooooooooooooooooooooooooooooooo...o.\n"
@"          bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"      ....oooooooooooooooooooooooooooooooooooooooooooooooooooooooo...oo..\n"
@"      bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ................................................................ooo.o.\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ..oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo..oooo..\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ..ooo......................................................ooo..ooo.o.\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ..o...  .. . . . . . . . . . . . . . . . . . . . . . . ....ooo..oo.o..\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"  .... . . ..  . . . . . . . . . . . . . . . . . . . . . ..o..ooo..ooo.o.\n"
@"  bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..........................................................oo..ooo..oo.o..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo..oo..ooo..o.o.. \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
@"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo..oo..ooo..oo..  \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
@"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo..oo..ooo..o..   \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb   \n"
@"..ooooooooooooooooooo...oooooooooo...ooooooooooooooooooo..oo..ooo....    \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb    \n"
@"..oooooooooooooooooo................oooooooooooooooooooo..o..oooo...     \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb     \n"
@"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo...........      \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb      \n"
@"..oooooooooooooooooooooooooooooooooooooooooooooooooooooo...              \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb              \n"
@"..........................................................               \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb               \n"
;
static id textFilePixels =
@"..............................          \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb          \n"
@"..oooooooooooooooooooooooo..oo..        \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb        \n"
@"..oooooooooooooooooooooooo..oooo..      \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb      \n"
@"..oooooooooooooooooooooooo..oooooo..    \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb    \n"
@"..ooo.........oooooooooooo..oooooooo..  \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
@"..oooooooooooooooooooooooo..............\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..ooo.........oooooooooooooooooooooooo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..ooooooo....o..........oo.......ooooo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..ooo..o........o................ooooo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..ooo....................o.......ooooo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..ooooooooooooooooooooo..........ooooo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..oooooooooooooooooooooooooooooooooooo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"........................................\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
;

static id shellPixels =
@".....................................................\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@".ooooooooooooooooooooooooooooooooooooXoooooXoooooXo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@".oXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXoooooXoooooXo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@".ooooooooooooooooooooooooooooooooooooXoooooXoooooXo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@".oXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@".oXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@".oXXXXooXXXXooXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@".oXXXoooXXXXXooXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@".oXXXXooXXXXXXooXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@".oXXXXooXXXXXooXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@".oXXXooooXXXooXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@".oXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@".oXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@".oXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@".oXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXooooo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@".oXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXoXXXo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@".oooooooooooooooooooooooooooooooooooooooooooooooooo..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@".....................................................\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
;

static id prefsPixels =
@"              ...........................................................\n"
@"              bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"          ....OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO...O.\n"
@"          bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"      ....OOOOOOOOOOOOOOOOOOO..........OOOOOOOOOOOOOOOOOOOOOOOOOOO...OO..\n"
@"      bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ...........................XXXXXXXX.............................OOO.O.\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ..OOOOOOOOOOOOOOOOOOOOO..XXXXXXXXXXXX..OOOOOOOOOOOOOOOOOOOOOOO..OOOO..\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ..OOO...................XXXXX....XXXXX.....................OOO..OOO.O.\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ..OOO..OOOOOOOOOOOOOOO........O..XXXXX..OOOOOOOOOOOOOOOOO..OOO..OO.O..\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ..OOO..OOOOOOOOOOOOOOOOOOOOOOO..XXXXX..OOOOOOOOOOOOOOOOOO..OOO..OOO.O.\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ..OOO..OOOOOOOOOOOOOOOOO...O..XXXXX..OO...OOOOOOOOOOOOOOO..OOO..OO.O..\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ..OOO..OOOOOOOOOOOOOOOO......XXXXX.......OOOOOOOOOOOOOOOO..OOO..O.O.. \n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
@"   ..OOO..OOOOOOOOOOOOOOOOOOO..XXXXX..OOOOOOOOOOOOOOOOOOOOOO..OOO..OO..  \n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
@"   ..OOO..OOOOOOOOOOOOOOOOOOOO.......OOOOOOOOOOOOOOOOOOOOOOO..OOO..O..   \n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb   \n"
@"   ..OOO.......................XXXXX..........................OOO....    \n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb    \n"
@"   ..OOOOOOOOOOOOOOOOOOOOOOOOO.......OOOOOOOOOOOOOOOOOOOOOOOOOOOO...     \n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb     \n"
@"   ................................................................      \n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb      \n"
@"                                                                         \n"
@"                                                                         \n"
@"                                                                         \n"
@"                                                                         \n"
@"                                                                         \n"
@"                                                                         \n"
;
static id openPrefsPixels =
@"              ...........................................................\n"
@"              bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"          ....OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO...O.\n"
@"          bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"      ....OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO...OO..\n"
@"      bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ................................................................OOO.O.\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ..OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO..OOOO..\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ..OOO......................................................OOO..OOO.O.\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"   ..O...oo..o.o.o.o.o.o.........o.o.o.o.o.o.o.o.o.o.o.o.o....OOO..OO.O..\n"
@"   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"  ....o.o.o..oo.o.o.o...XXXXXXXX....o.o.o.o.o.o.o.o.o.o.o..O..OOO..OOO.O.\n"
@"  bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"......................XXXXXXXXXXXX........................OO..OOO..OO.O..\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"..OOOOOOOOOOOOOOOOO..XXXXX....XXXXX..OOOOOOOOOOOOOOOOOOO..OO..OOO..O.O.. \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
@"..OOOOOOOOOOOOOOOOO........O..XXXXX..OOOOOOOOOOOOOOOOOOO..OO..OOO..OO..  \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
@"..OOOOOOOOOOOOOOOOOOOOOOOOO..XXXXX..OOOOOOOOOOOOOOOOOOOO..OO..OOO..O..   \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb   \n"
@"..OOOOOOOOOOOOOOOOOOO...O..XXXXX..OO...OOOOOOOOOOOOOOOOO..OO..OOO....    \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb    \n"
@"..OOOOOOOOOOOOOOOOOO......XXXXX.......OOOOOOOOOOOOOOOOOO..O..OOOO...     \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb     \n"
@"..OOOOOOOOOOOOOOOOOOOOO..XXXXX..OOOOOOOOOOOOOOOOOOOOOOOO...........      \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb      \n"
@"..OOOOOOOOOOOOOOOOOOOOOO.......OOOOOOOOOOOOOOOOOOOOOOOOO...              \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb              \n"
@".........................XXXXX............................               \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb               \n"
@"                        .......                                          \n"
@"                        bbbbbbb                                          \n"
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
@"                            bbbbbbbbbbbbbbbb              \n"
@"                           ...            ...             \n"
@"                           bbb            bbb             \n"
@"                ......................................    \n"
@"                bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb    \n"
@"              ..X.X.X.X.X.X.XXXXXXXXXXXXXXXXXXXXXXXXXX..  \n"
@"              bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
@"             ..X.X.X.X.X.X.X.X.X.X.X.XXXXXXXXXXXXXXXXXX.. \n"
@"             bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
@"             ............................................ \n"
@"             bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
@"              ..X.X.X.X.X.X.X.XXXXXXXXXXXXXXXXXXXXXXXX..  \n"
@"              bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
@"              ...X.X.X.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX..  \n"
@"              bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
@"               ...X......XXXXXXX.......XXXXXX.....XXX..   \n"
@"               bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb   \n"
@"               ..X...X.X...XXX...X.X.X..XXX..X.X...XX..   \n"
@"               bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb   \n"
@"               ...X...XXX..XXX..X.XXXX..XXX...XXX..XX..   \n"
@"               bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb   \n"
@"               ..X...X.XX..XXX...X.XXX..XXX..X.XX..XX..   \n"
@"               bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb   \n"
@"                ..X...XXX..XXX..X.XXXX..XXX...XXX..X..    \n"
@"                bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb    \n"
@"                ...X...XXX..XX...X.XXX..XX...XXX..XX..    \n"
@"                bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb    \n"
@"                ..X...X.XX..XX..X.XXXX..XX..X.XX..XX..    \n"
@"                bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb    \n"
@"                ...X...XXX..XXX..X.XX..XXX...XXX..XX..    \n"
@"                bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb    \n"
@"                 ...X...XX..XXX...XXX..XXX..XXX..XX..     \n"
@"                 bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb     \n"
@"                 ..X...X.X..XXX..X.XX..XXX...XX..XX..     \n"
@"                 bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb     \n"
@"                 ...X...XXX..XX...XXX..XX...XXX..XX..     \n"
@"                 bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb     \n"
@"                 ..X.X...XX..XX..X.XX..XX..X.X..XXX..     \n"
@"                 bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb     \n"
@"             .......X...X.X..XXX..XX..XXX...XX..XX..      \n"
@"             bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb      \n"
@"    .................X...X...XXX...X..XXX..X...XXX..      \n"
@"    bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb      \n"
@"....................X.X.....X.X.X....XXXXX....XXXX..      \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb      \n"
@"  .....................X.X.X.X.X.XXXXXXXXXXXXXXX...       \n"
@"  bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb       \n"
@"       ..........................................         \n"
@"       bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb         \n"
@"                 ....................                     \n"
@"                 bbbbbbbbbbbbbbbbbbbb                     \n"
;
static char *openTrashCanPixels =
@"                          ..................              \n"
@"                          bbbbbbbbbbbbbbbbbb              \n"
@"                   .......XXXXXXXXXXXXXXXXXX.......       \n"
@"                   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb       \n"
@"              .....XXXXXXXX.................XXXXXXX.....  \n"
@"              bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
@"             ..XXXX........X.X.X.XXXXX.X.X.X......XXXXX.. \n"
@"             bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
@"            ..XX....X.X.X.X.X.XXXX.X.XXXX.X.X.X.X.....XX..\n"
@"            bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"             ..X..XX.X.X.X.X.X.X.XXXXX.X.X.X.X.X.XXX..X.. \n"
@"             bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
@"              ......XXXXXXX.X.X.X.X.X.X.X.X.XXXXXX......  \n"
@"              bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
@"                  .........XXXXXXXXXXXXXXXXX........      \n"
@"                  bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb      \n"
@"                          ...................             \n"
@"                          bbbbbbbbbbbbbbbbbbb             \n"
@"              ..........................................  \n"
@"              bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
@"              ..X.X.X.X.X.X.X.XXXXXXXXXXXXXXXXXXXXXXXX..  \n"
@"              bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
@"              ...X.X.X.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX..  \n"
@"              bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
@"               ...X......XXXXXXX.......XXXXXX.....XXX..   \n"
@"               bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb   \n"
@"               ..X...X.X...XXX...X.X.X..XXX..X.X...XX..   \n"
@"               bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb   \n"
@"               ...X...XXX..XXX..X.XXXX..XXX...XXX..XX..   \n"
@"               bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb   \n"
@"               ..X...X.XX..XXX...X.XXX..XXX..X.XX..XX..   \n"
@"               bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb   \n"
@"                ..X...XXX..XXX..X.XXXX..XXX...XXX..X..    \n"
@"                bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb    \n"
@"                ...X...XXX..XX...X.XXX..XX...XXX..XX..    \n"
@"                bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb    \n"
@"                ..X...X.XX..XX..X.XXXX..XX..X.XX..XX..    \n"
@"                bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb    \n"
@"                ...X...XXX..XXX..X.XX..XXX...XXX..XX..    \n"
@"                bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb    \n"
@"                 ...X...XX..XXX...XXX..XXX..XXX..XX..     \n"
@"                 bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb     \n"
@"                 ..X...X.X..XXX..X.XX..XXX...XX..XX..     \n"
@"                 bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb     \n"
@"                 ...X...XXX..XX...XXX..XX...XXX..XX..     \n"
@"                 bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb     \n"
@"                 ..X.X...XX..XX..X.XX..XX..X.X..XXX..     \n"
@"                 bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb     \n"
@"             .......X...X.X..XXX..XX..XXX...XX..XX..      \n"
@"             bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb      \n"
@"    .................X...X...XXX...X..XXX..X...XXX..      \n"
@"    bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb      \n"
@"....................X.X.....X.X.X....XXXXX....XXXX..      \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb      \n"
@"  .....................X.X.X.X.X.XXXXXXXXXXXXXXX...       \n"
@"  bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb       \n"
@"       ..........................................         \n"
@"       bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb         \n"
@"                 ....................                     \n"
@"                 bbbbbbbbbbbbbbbbbbbb                     \n"
;
+ (char *)cStringForAmigaHorizontalScrollBarLeft
{
    return
"ooooooooooooooo\n"
"bbbbbbbbbbbbbbb\n"
"ooooXXXooooooXX\n"
"bbbbbbbbbbbbbbb\n"
"ooXXXooooooooXX\n"
"bbbbbbbbbbbbbbb\n"
"XXXooooooooooXX\n"
"bbbbbbbbbbbbbbb\n"
"XXXXXXXXXXXooXX\n"
"bbbbbbbbbbbbbbb\n"
"XXXooooooooooXX\n"
"bbbbbbbbbbbbbbb\n"
"ooXXXooooooooXX\n"
"bbbbbbbbbbbbbbb\n"
"ooooXXXooooooXX\n"
"bbbbbbbbbbbbbbb\n"
;
}
+ (char *)cStringForAmigaHorizontalScrollBarMiddle
{
    return
"o\n"
"b\n"
"X\n"
"b\n"
"o\n"
"b\n"
"o\n"
"b\n"
"o\n"
"b\n"
"o\n"
"b\n"
"o\n"
"b\n"
"X\n"
"b\n"
;
}
+ (char *)cStringForAmigaHorizontalScrollBarRight
{
    return
"ooooooooooooooo\n"
"bbbbbbbbbbbbbbb\n"
"XXoooooooXXXooo\n"
"bbbbbbbbbbbbbbb\n"
"XXoooooooooXXXo\n"
"bbbbbbbbbbbbbbb\n"
"XXoooooooooooXX\n"
"bbbbbbbbbbbbbbb\n"
"XXooXXXXXXXXXXX\n"
"bbbbbbbbbbbbbbb\n"
"XXoooooooooooXX\n"
"bbbbbbbbbbbbbbb\n"
"XXoooooooooXXXo\n"
"bbbbbbbbbbbbbbb\n"
"XXoooooooXXXooo\n"
"bbbbbbbbbbbbbbb\n"
;
}
+ (char *)cStringForAmigaFuelGaugeTop
{
    return
"............oo\n"
"bbbbbbbbbbbbbb\n"
"...oooooo...oo\n"
"bbbbbbbbbbbbbb\n"
"...oo.......oo\n"
"bbbbbbbbbbbbbb\n"
"...oooo.....oo\n"
"bbbbbbbbbbbbbb\n"
"...oo.......oo\n"
"bbbbbbbbbbbbbb\n"
"...oo.......oo\n"
"bbbbbbbbbbbbbb\n"
"............oo\n"
"bbbbbbbbbbbbbb\n"
;
}
+ (char *)cStringForAmigaFuelGaugeMiddle
{
    return
"************oo\n"
"bbbbbbbbbbbbbb\n"
;
}
+ (char *)cStringForAmigaFuelGaugeBottom
{
    return
"............oo\n"
"bbbbbbbbbbbbbb\n"
"...oooooo...oo\n"
"bbbbbbbbbbbbbb\n"
"...oo.......oo\n"
"bbbbbbbbbbbbbb\n"
"...oooo.....oo\n"
"bbbbbbbbbbbbbb\n"
"...oo.......oo\n"
"bbbbbbbbbbbbbb\n"
"...oooooo...oo\n"
"bbbbbbbbbbbbbb\n"
"............oo\n"
"bbbbbbbbbbbbbb\n"
;
}
+ (char *)cStringForAmigaVerticalScrollBarTop
{
    return
"oooooXXXXXXooo\n"
"bbbbbbbbbbbbbb\n"
"oooXXooXXooXXo\n"
"bbbbbbbbbbbbbb\n"
"oXXooooXXooooX\n"
"bbbbbbbbbbbbbb\n"
"oooooooXXooooo\n"
"bbbbbbbbbbbbbb\n"
"oooooooXXooooo\n"
"bbbbbbbbbbbbbb\n"
"oooooooXXooooo\n"
"bbbbbbbbbbbbbb\n"
"oooooooooooooo\n"
"bbbbbbbbbbbbbb\n"
"ooXXXXXXXXXXXX\n"
"bbbbbbbbbbbbbb\n"
;
}
+ (char *)cStringForAmigaVerticalScrollBarMiddle
{
    return
"ooXXooooooooXX\n"
"bbbbbbbbbbbbbb\n"
;
}
+ (char *)cStringForAmigaVerticalScrollBarBottom
{
    return
"ooXXXXXXXXXXXX\n"
"bbbbbbbbbbbbbb\n"
"oooooooooooooo\n"
"bbbbbbbbbbbbbb\n"
"oooooooXXooooo\n"
"bbbbbbbbbbbbbb\n"
"oooooooXXooooo\n"
"bbbbbbbbbbbbbb\n"
"oooooooXXooooo\n"
"bbbbbbbbbbbbbb\n"
"oXXooooXXooooX\n"
"bbbbbbbbbbbbbb\n"
"oooXXooXXooXXo\n"
"bbbbbbbbbbbbbb\n"
"oooooXXXXXXooo\n"
"bbbbbbbbbbbbbb\n"
;
}
*/

