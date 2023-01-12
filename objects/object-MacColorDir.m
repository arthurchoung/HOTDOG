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

static char *inactiveTitleBarRightPixels =
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
;
static char *activeTitleBarRightPixels =
"bbb\n"
"@bb\n"
"@bb\n"
"@bb\n"
"@bb\n"
"@bb\n"
"@bb\n"
"@bb\n"
"@bb\n"
"@bb\n"
"@bb\n"
"@bb\n"
"@bb\n"
"@bb\n"
"@bb\n"
"@bb\n"
"@bb\n"
"@bb\n"
"bbb\n"
;

static char *inactiveInfoBarLeftPixels = 
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
;
static char *inactiveInfoBarRightPixels = 
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
"gb\n"
;
static char *infoBarLeftPixels = 
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
;
static char *infoBarMiddlePixels = 
"%\n"
"%\n"
"%\n"
"%\n"
"%\n"
"%\n"
"%\n"
"%\n"
"%\n"
"%\n"
"%\n"
"%\n"
"%\n"
"%\n"
"%\n"
"%\n"
"%\n"
"b\n"
"%\n"
"b\n"
;
static char *infoBarRightPixels = 
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
;

static char *inactiveResizeButtonPixels =
"bbbbbbbbbbbbbbbgb\n"
"b%%%%%%%%%%%%%%gb\n"
"b%%%%%%%%%%%%%%gb\n"
"b%%%%%%%%%%%%%%gb\n"
"b%%%%%%%%%%%%%%gb\n"
"b%%%%%%%%%%%%%%gb\n"
"b%%%%%%%%%%%%%%gb\n"
"b%%%%%%%%%%%%%%gb\n"
"b%%%%%%%%%%%%%%gb\n"
"b%%%%%%%%%%%%%%gb\n"
"b%%%%%%%%%%%%%%gb\n"
"b%%%%%%%%%%%%%%gb\n"
"b%%%%%%%%%%%%%%gb\n"
"b%%%%%%%%%%%%%%gb\n"
"b%%%%%%%%%%%%%%gb\n"
"ggggggggggggggggb\n"
"bbbbbbbbbbbbbbbbb\n"
;
static char *resizeButtonPixels =
"bbbbbbbbbbbbbbbbb\n"
"b$$$$$$$$$$$$$$bb\n"
"b$$$$$$$$$$$$$$bb\n"
"b$$......$$$$$$bb\n"
"b$$.#####....$$bb\n"
"b$$.#yyy.####$$bb\n"
"b$$.#yyy.+++.$$bb\n"
"b$$.#yyy.+++.$$bb\n"
"b$$.#....+++.$$bb\n"
"b$$$.#++++++.$$bb\n"
"b$$$.#++++++.$$bb\n"
"b$$$.#++++++.$$bb\n"
"b$$$.#.......$$bb\n"
"b$$$$$$$$$$$$$$bb\n"
"b$$$$$$$$$$$$$$bb\n"
"bbbbbbbbbbbbbbbbb\n"
"bbbbbbbbbbbbbbbbb\n"
;

static char *verticalKnobPixels =
"gggggggggggggg\n"
"#############.\n"
"#************.\n"
"#***@@@@@@***.\n"
"#***######***.\n"
"#***zzzzzz***.\n"
"#***######***.\n"
"#***zzzzzz***.\n"
"#***######***.\n"
"#***zzzzzz***.\n"
"#***######***.\n"
"#***zzzzzz***.\n"
"#***######***.\n"
"#************.\n"
"#************.\n"
"..............\n"
;

static char *horizontalKnobPixels =
"g##############.\n"
"g#*************.\n"
"g#*************.\n"
"g#*************.\n"
"g#*@#z#z#z#z#**.\n"
"g#*@#z#z#z#z#**.\n"
"g#*@#z#z#z#z#**.\n"
"g#*@#z#z#z#z#**.\n"
"g#*@#z#z#z#z#**.\n"
"g#*@#z#z#z#z#**.\n"
"g#*************.\n"
"g#*************.\n"
"g#*************.\n"
"g...............\n"
;

static char *inactiveBottomLeftPixels =
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
".\n"
;
static char *inactiveBottomMiddlePixels =
"b\n"
"%\n"
"%\n"
"%\n"
"%\n"
"%\n"
"%\n"
"%\n"
"%\n"
"%\n"
"%\n"
"%\n"
"%\n"
"%\n"
"%\n"
"g\n"
"b\n"
;
static char *leftArrowPixels =
"bbbbbbbbbbbbbbbb\n"
"b%%%%%%%%%%%%%ob\n"
"b%&&&&&&.&&&&&ob\n"
"b%&&&&&..&&&&&ob\n"
"b%&&&&.@.&&&&&ob\n"
"b%&&&.@@.....&ob\n"
"b%&&.@@@@@@@.&ob\n"
"b%&.@@@@@@@@.&ob\n"
"b%&&.@@@@@@@.&ob\n"
"b%&&&.@@.....&ob\n"
"b%&&&&.@.&&&&&ob\n"
"b%&&&&&..&&&&&ob\n"
"b%&&&&&&.&&&&&ob\n"
"b%&&&&&&&&&&&&ob\n"
"boooooooooooooob\n"
"bbbbbbbbbbbbbbbb\n"
".bbbbbbbbbbbbbbb\n"
;
static char *leftArrowDownPixels =
"bbbbbbbbbbbbbbbb\n"
"b%%%%%%%%%%%%%wb\n"
"b%xxxxxxbxxxxxwb\n"
"b%xxxxxbbxxxxxwb\n"
"b%xxxxbbbxxxxxwb\n"
"b%xxxbbbbbbbbxwb\n"
"b%xxbbbbbbbbbxwb\n"
"b%xbbbbbbbbbbxwb\n"
"b%xxbbbbbbbbbxwb\n"
"b%xxxbbbbbbbbxwb\n"
"b%xxxxbbbxxxxxwb\n"
"b%xxxxxbbxxxxxwb\n"
"b%xxxxxxbxxxxxwb\n"
"b%xxxxxxxxxxxxwb\n"
"bwwwwwwwwwwwwwwb\n"
"bbbbbbbbbbbbbbbb\n"
".bbbbbbbbbbbbbbb\n"
;
static char *rightArrowPixels =
"bbbbbbbbbbbbbbb\n"
"b%%%%%%%%%%%%%o\n"
"b%&&&&&.&&&&&&o\n"
"b%&&&&&..&&&&&o\n"
"b%&&&&&.@.&&&&o\n"
"b%&.....@@.&&&o\n"
"b%&.@@@@@@@.&&o\n"
"b%&.@@@@@@@@.&o\n"
"b%&.@@@@@@@.&&o\n"
"b%&.....@@.&&&o\n"
"b%&&&&&.@.&&&&o\n"
"b%&&&&&..&&&&&o\n"
"b%&&&&&.&&&&&&o\n"
"b%&&&&&&&&&&&&o\n"
"boooooooooooooo\n"
"bbbbbbbbbbbbbbb\n"
"bbbbbbbbbbbbbbb\n"
;
static char *rightArrowDownPixels =
"bbbbbbbbbbbbbbb\n"
"b%%%%%%%%%%%%%w\n"
"b%xxxxxbxxxxxxw\n"
"b%xxxxxbbxxxxxw\n"
"b%xxxxxbbbxxxxw\n"
"b%xbbbbbbbbxxxw\n"
"b%xbbbbbbbbbxxw\n"
"b%xbbbbbbbbbbxw\n"
"b%xbbbbbbbbbxxw\n"
"b%xbbbbbbbbxxxw\n"
"b%xxxxxbbbxxxxw\n"
"b%xxxxxbbxxxxxw\n"
"b%xxxxxbxxxxxxw\n"
"b%xxxxxxxxxxxxw\n"
"bwwwwwwwwwwwwww\n"
"bbbbbbbbbbbbbbb\n"
"bbbbbbbbbbbbbbb\n"
;
static char *upArrowPixels =
"b%%%%%%%%%%%%%obb\n"
"b%&&&&&&&&&&&&obb\n"
"b%&&&&&.&&&&&&obb\n"
"b%&&&&.@.&&&&&obb\n"
"b%&&&.@@@.&&&&obb\n"
"b%&&.@@@@@.&&&obb\n"
"b%&.@@@@@@@.&&obb\n"
"b%....@@@....&obb\n"
"b%&&&.@@@.&&&&obb\n"
"b%&&&.@@@.&&&&obb\n"
"b%&&&.@@@.&&&&obb\n"
"b%&&&.....&&&&obb\n"
"b%&&&&&&&&&&&&obb\n"
"boooooooooooooobb\n"
"bbbbbbbbbbbbbbbbb\n"
;
static char *upArrowDownPixels =
"b%%%%%%%%%%%%%wbb\n"
"b%xxxxxxxxxxxxwbb\n"
"b%xxxxxbxxxxxxwbb\n"
"b%xxxxbbbxxxxxwbb\n"
"b%xxxbbbbbxxxxwbb\n"
"b%xxbbbbbbbxxxwbb\n"
"b%xbbbbbbbbbxxwbb\n"
"b%bbbbbbbbbbbxwbb\n"
"b%xxxbbbbbxxxxwbb\n"
"b%xxxbbbbbxxxxwbb\n"
"b%xxxbbbbbxxxxwbb\n"
"b%xxxbbbbbxxxxwbb\n"
"b%xxxxxxxxxxxxwbb\n"
"bwwwwwwwwwwwwwwbb\n"
"bbbbbbbbbbbbbbbbb\n"
;

static char *downArrowPixels =
"bbbbbbbbbbbbbbbbb\n"
"b%%%%%%%%%%%%%obb\n"
"b%&&&&&&&&&&&&obb\n"
"b%&&&.....&&&&obb\n"
"b%&&&.@@@.&&&&obb\n"
"b%&&&.@@@.&&&&obb\n"
"b%&&&.@@@.&&&&obb\n"
"b%....@@@....&obb\n"
"b%&.@@@@@@@.&&obb\n"
"b%&&.@@@@@.&&&obb\n"
"b%&&&.@@@.&&&&obb\n"
"b%&&&&.@.&&&&&obb\n"
"b%&&&&&.&&&&&&obb\n"
"b%&&&&&&&&&&&&obb\n"
"boooooooooooooobb\n"
;
static char *downArrowDownPixels =
"bbbbbbbbbbbbbbbbb\n"
"b%%%%%%%%%%%%%wbb\n"
"b%xxxxxxxxxxxxwbb\n"
"b%xxxbbbbbxxxxwbb\n"
"b%xxxbbbbbxxxxwbb\n"
"b%xxxbbbbbxxxxwbb\n"
"b%xxxbbbbbxxxxwbb\n"
"b%bbbbbbbbbbbxwbb\n"
"b%xbbbbbbbbbxxwbb\n"
"b%xxbbbbbbbxxxwbb\n"
"b%xxxbbbbbxxxxwbb\n"
"b%xxxxbbbxxxxxwbb\n"
"b%xxxxxbxxxxxxwbb\n"
"b%xxxxxxxxxxxxwbb\n"
"bwwwwwwwwwwwwwwbb\n"
;
static char *disabledBottomScrollBarLeftPixels =
"bbbbbbbbbbbbbbbb\n"
"b$$$$$$$$$$$$$$o\n"
"b$$$$$$o$$$$$$$o\n"
"b$$$$$oo$$$$$$$o\n"
"b$$$$o$o$$$$$$$o\n"
"b$$$o$$ooooo$$$o\n"
"b$$o$$$$$$$o$$$o\n"
"b$o$$$$$$$$o$$$o\n"
"b$o$$$$$$$$o$$$o\n"
"b$$o$$$$$$$o$$$o\n"
"b$$$o$$ooooo$$$o\n"
"b$$$$o$o$$$$$$$o\n"
"b$$$$$oo$$$$$$$o\n"
"b$$$$$$o$$$$$$$o\n"
"b$$$$$$$$$$$$$$o\n"
"bbbbbbbbbbbbbbbb\n"
"%bbbbbbbbbbbbbbb\n"
;
static char *disabledBottomScrollBarRightPixels =
"bbbbbbbbbbbbbbb\n"
"o$$$$$$$$$$$$$$\n"
"o$$$$$$$o$$$$$$\n"
"o$$$$$$$oo$$$$$\n"
"o$$$$$$$o$o$$$$\n"
"o$$$ooooo$$o$$$\n"
"o$$$o$$$$$$$o$$\n"
"o$$$o$$$$$$$$o$\n"
"o$$$o$$$$$$$$o$\n"
"o$$$o$$$$$$$o$$\n"
"o$$$ooooo$$o$$$\n"
"o$$$$$$$o$o$$$$\n"
"o$$$$$$$oo$$$$$\n"
"o$$$$$$$o$$$$$$\n"
"o$$$$$$$$$$$$$$\n"
"bbbbbbbbbbbbbbb\n"
"bbbbbbbbbbbbbbb\n"
;
static char *disabledBottomScrollBarMiddlePixels =
"b\n"
"$\n"
"$\n"
"$\n"
"$\n"
"$\n"
"$\n"
"$\n"
"$\n"
"$\n"
"$\n"
"$\n"
"$\n"
"$\n"
"$\n"
"b\n"
"b\n"
;
static char *activeBottomScrollBarPixels =
"bbbb\n"
"&o&&\n"
"&&&o\n"
"&o&&\n"
"&&&o\n"
"&o&&\n"
"&&&o\n"
"&o&&\n"
"&&&o\n"
"&o&&\n"
"&&&o\n"
"&o&&\n"
"&&&o\n"
"&o&&\n"
"&&&o\n"
"bbbb\n"
"bbbb\n"
;
static char *activeRightScrollBarPixels =
"bo&&&o&&&o&&&o&bb\n"
"b&&o&&&o&&&o&&&bb\n"
;
static char *disabledRightScrollBarMiddlePixels =
"b$$$$$$$$$$$$$$bb\n"
;
static char *inactiveRightMiddlePixels =
"b%%%%%%%%%%%%%%gb\n"
;
static char *disabledRightScrollBarTopPixels =
"b$$$$$$$$$$$$$$bb\n"
"b$$$$$$$$$$$$$$bb\n"
"b$$$$$$oo$$$$$$bb\n"
"b$$$$$o$$o$$$$$bb\n"
"b$$$$o$$$$o$$$$bb\n"
"b$$$o$$$$$$o$$$bb\n"
"b$$o$$$$$$$$o$$bb\n"
"b$oooo$$$$oooo$bb\n"
"b$$$$o$$$$o$$$$bb\n"
"b$$$$o$$$$o$$$$bb\n"
"b$$$$o$$$$o$$$$bb\n"
"b$$$$oooooo$$$$bb\n"
"b$$$$$$$$$$$$$$bb\n"
"b$$$$$$$$$$$$$$bb\n"
"boooooooooooooobb\n"
;
static char *disabledRightScrollBarBottomPixels =
"boooooooooooooobb\n"
"b$$$$$$$$$$$$$$bb\n"
"b$$$$$$$$$$$$$$bb\n"
"b$$$$oooooo$$$$bb\n"
"b$$$$o$$$$o$$$$bb\n"
"b$$$$o$$$$o$$$$bb\n"
"b$$$$o$$$$o$$$$bb\n"
"b$oooo$$$$oooo$bb\n"
"b$$o$$$$$$$$o$$bb\n"
"b$$$o$$$$$$o$$$bb\n"
"b$$$$o$$$$o$$$$bb\n"
"b$$$$$o$$o$$$$$bb\n"
"b$$$$$$oo$$$$$$bb\n"
"b$$$$$$$$$$$$$$bb\n"
"b$$$$$$$$$$$$$$bb\n"
;

static id folderPalette =
@"b #000000\n"
@". #9999ff\n"
@"X #ccccff\n"
@"o #ffffff\n"
;
static id selectedFolderPalette = 
@"b #000000\n"
@". #26267f\n"
@"X #33337f\n"
@"o #7f7f7f\n"
;
static id folderPixels =
@"     bbbbbbb                   \n"
@"    bXXXXXXXb                  \n"
@"   bXXXXXXXXXb                 \n"
@"  bXXXXXXXXXXXb                \n"  
@" bXXXXXXXXXXXXXbbbbbbbbbbbbbbb \n"
@"bXXXXXXXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"booooooooooooooooooooooooooooob\n"
@"boXoXoXoXoXoXoXoXoXoXoXoXoXoX.b\n"
@"bXoXoXoXoXoXoXoXoXoXoXoXoXoXo.b\n"
@"boXoXoXoXoXoXoXoXoXoXoXoXoXoX.b\n"
@"bXoXoXoXoXoXoXoXoXoXoXoXoXoXo.b\n"
@"boXoXoXoXoXoXoXoXoXoXoXoXoXoX.b\n"
@"bXoXoXoXoXoXoXoXoXoXoXoXoXoXo.b\n"
@"boXoXoXoXoXoXoXoXoXoXoXoXoXoX.b\n"
@"bXoXoXoXoXoXoXoXoXoXoXoXoXoXo.b\n"
@"boXoXoXoXoXoXoXoXoXoXoXoXoXoX.b\n"
@"bXoXoXoXoXoXoXoXoXoXoXoXoXoXo.b\n"
@"boXoXoXoXoXoXoXoXoXoXoXoXoXoX.b\n"
@"bXoXoXoXoXoXoXoXoXoXoXoXoXoXo.b\n"
@"boXoXoXoXoXoXoXoXoXoXoXoXoXoX.b\n"
@"bXoXoXoXoXoXoXoXoXoXoXoXoXoXo.b\n"
@"boXoXoXoXoXoXoXoXoXoXoXoXoXoX.b\n"
@"bXoXoXoXoXoXoXoXoXoXoXoXoXoXo.b\n"
@"boXoXoXoXoXoXoXoXoXoXoXoXoXoX.b\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
;

static id documentPalette =
@"b #000000\n"
@". #cccccc\n"
@"X #eeeeee\n"
@"o #ffffff\n"
;
static id selectedDocumentPalette =
@"b #000000\n"
@". #666666\n"
@"X #777777\n"
@"o #ffffff\n"
;
static id documentPixels =
@"bbbbbbbbbbbbbbbbbbb      \n"
@"bXXXXXXXXXXXXXXXXXbb     \n"
@"bXXXXXXXXXXXXXXXXXb.b    \n"
@"bXXXXXXXXXXXXXXXXXb..b   \n"
@"bXXXXXXXXXXXXXXXXXb...b  \n"
@"bXXXXXXXXXXXXXXXXXb....b \n"
@"bXXXXXXXXXXXXXXXXXbbbbbbb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bXXXXXXXXXXXXXXXXXXXXXXXb\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbb\n"
;
static id readmePalette =
@"b #000000\n"
@". #777777\n"
@"X #888888\n"
@"o #eeeeee\n"
@"O #ffffff\n"
;
static id selectedReadmePalette =
@"b #000000\n"
@". #3b3b3b\n"
@"X #444444\n"
@"o #777777\n"
@"O #7f7f7f\n"
;
static id readmePixels =
@"OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO \n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
@"boooooooooooooooooooooooooooobO\n"
@"bo....ooOboooooooooooooo....obb\n"
@"boooooooboobbobbbobbobboooooobb\n"
@"bo....obobobbobobobbobbo....obb\n"
@"bo....oooooboooooooooboo....obb\n"
@"boooooooooooooooooooooooooooobb\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"boooooooooooooooooooooooooooobb\n"
@"boobbboboobobbbboobbooobboobobb\n"
@"boobooooobooooooobooboboobobobb\n"
@"booooooobooooboooooboobobbooobb\n"
@"boobobobooboobooobooboboobobobb\n"
@"boooooooooooooooooooooooooooobb\n"
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
@"boooooooooooooooooooooooooooobb\n"
@"bo......oobbbbbbbbbboo......obb\n"
@"bo......obObOOOOOOOObo......obb\n"
@"boooooooobbbbbbbbbbbboooooooobb\n"
@"bo......obXXXXXXXXXXbo......obb\n"
@"boooooooobXXXXXXXXXXboooooooobb\n"
@"bo......obXXXXXXXXXXbo......obb\n"
@"boooooooobXXXXXXXXXXboooooooobb\n"
@"bo......obXXXXXXXXXXbo......obb\n"
@"booooooooobbbbbbbbbbooooooooobb\n"
@"bo......oooooooooooooo......obb\n"
@"boooooooooo........oooooooooobb\n"
@" ooooooooooooooooooooooooooooo \n"
;

@implementation Definitions(hkukgfdfthfnvbchjgfjygikghjghfjgfjdksfjksdkdjkfsdkjfj)
+ (id)MacColorDir
{
    id obj = [@"MacColorDir" asInstance];
    [obj setValue:[@"." asRealPath] forKey:@"title"];
    [obj updateDiskFreeText];
    [obj calculateDiskUsed];
    return obj;
}
@end

@interface MacColorDir : IvarObject
{
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
    Int4 _maximizeButtonRect;
    Int4 _titleBarTextRect;
    int _buttonDownX;
    int _buttonDownY;
    int _buttonDownW;
    int _buttonDownH;

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
    id _numberOfItemsText;
    id _diskUsedText;
    id _diskFreeText;
    id _diskUsedProcess;

    int _disableHorizontalScrollBar;
    int _disableVerticalScrollBar;

    id _selectionBox;
    int _selectionBoxRootX;
    int _selectionBoxRootY;
}
@end
@implementation MacColorDir
- (int *)x11WindowMaskPointsForWidth:(int)w height:(int)h
{
    static int points[5];
    points[0] = 5; // length of array including this number

    points[1] = 0; // lower left corner
    points[2] = h-1;

    points[3] = w-1; // upper right corner
    points[4] = 0;
    return points;
}
- (void)updateNumberOfItemsText
{
    id str = nsfmt(@"%d items", [_array count]);
    [self setValue:str forKey:@"numberOfItemsText"];
}
- (void)updateDiskFreeText
{
    id cmd = nsarr();
    [cmd addObject:@"hotdog-getDiskUsage.pl"];
    id output = [[cmd runCommandAndReturnOutput] asString];
    int available = [output intValueForKey:@"available"];
    id arr = nsarr();
    for(;;) {
        int val = available % 1000;
        available /= 1000;
        if (available > 0) {
            [arr addObject:nsfmt(@"%.3d", val)];
            continue;
        } else {
            [arr addObject:nsfmt(@"%d", val)];
            break;
        }
    }
    arr = [arr asReverseArray];
            
    id str = nsfmt(@"%@K available", [arr join:@","]);
    [self setValue:str forKey:@"diskFreeText"];
}
- (void)calculateDiskUsed
{
    [self setValue:@"Calculating..." forKey:@"diskUsedText"];
    id cmd = nsarr();
    [cmd addObject:@"hotdog-getFileUsage.pl"];
    id process = [cmd runCommandAndReturnProcess];
    [self setValue:process forKey:@"diskUsedProcess"];
}
- (int)fileDescriptor
{
    if (_diskUsedProcess) {
        return [_diskUsedProcess fileDescriptor];
    }
    return -1;
}
- (void)handleFileDescriptor
{
    if (_diskUsedProcess) {
        [_diskUsedProcess handleFileDescriptor];
        id str = [[_diskUsedProcess valueForKey:@"data"] asString];
        int total = [str intValueForKey:@"total"];
        
        id arr = nsarr();
        for(;;) {
            int val = total % 1000;
            total /= 1000;
            if (total > 0) {
                [arr addObject:nsfmt(@"%.3d", val)];
                continue;
            } else {
                [arr addObject:nsfmt(@"%d", val)];
                break;
            }
        }
        arr = [arr asReverseArray];
                
        str = nsfmt(@"%@K in disk", [arr join:@","]);
        [self setValue:str forKey:@"diskUsedText"];
    }
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
    [bitmap useMonacoFont];
    id arr = [@"." contentsOfDirectory];
    arr = [arr asFileArray];
    int x = 40;
    int y = 5;
    for (int i=0; i<[arr count]; i++) {
        id elt = [arr nth:i];
        id palette = nil;
        id pixels = nil;
        id selectedPalette = nil;
        id selectedPixels = nil;
        id fileType = [elt valueForKey:@"fileType"];
        if ([fileType isEqual:@"file"]) {
            id filePath = [elt valueForKey:@"filePath"];
            if ([[filePath lowercaseString] hasSuffix:@".txt"]) {
                palette = readmePalette;
                pixels = readmePixels;
                selectedPalette = selectedReadmePalette;
                selectedPixels = readmePixels;
            } else {
                palette = documentPalette;
                pixels = documentPixels;
                selectedPalette = selectedDocumentPalette;
                selectedPixels = documentPixels;
            }
        } else if ([fileType isEqual:@"directory"]) {
            palette = folderPalette;
            pixels = folderPixels;
            selectedPalette = selectedFolderPalette;
            selectedPixels = folderPixels;
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
        if (x + w + 5 >= r.w) {
            x = 40;
            y += h + 30;
        }
        [elt setValue:nsfmt(@"%d", x) forKey:@"x"];
        [elt setValue:nsfmt(@"%d", y) forKey:@"y"];
        [elt setValue:nsfmt(@"%d", w) forKey:@"w"];
        [elt setValue:nsfmt(@"%d", h) forKey:@"h"];
        x += w + 50 + 20;
    }
    [self setValue:arr forKey:@"array"];
    [self updateNumberOfItemsText];
}

- (void)handleBackgroundUpdate:(id)event
{
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
    if (!_timestamp) {
        _timestamp = [@"." fileModificationTimestamp];
        [self updateFromCurrentDirectory:r];
    }

    if ([_buttonDown isEqual:_buttonHover]) {
        if ([_buttonDown isEqual:@"leftArrow"]) {
            _visibleX -= 10;
            if (_visibleX < _contentXMin) {
                _visibleX = _contentXMin;
            }
        } else if ([_buttonDown isEqual:@"rightArrow"]) {
            _visibleX += 10;
            if (_visibleX > _contentXMax+1 - _visibleW) {
                _visibleX = _contentXMax+1 - _visibleW;
            }
        } else if ([_buttonDown isEqual:@"upArrow"]) {
            _visibleY -= 10;
            if (_visibleY < _contentYMin) {
                _visibleY = _contentYMin;
            }
        } else if ([_buttonDown isEqual:@"downArrow"]) {
            _visibleY += 10;
            if (_visibleY > _contentYMax+1 - _visibleH) {
                _visibleY = _contentYMax+1 - _visibleH;
            }
        }
    }

    _titleBarRect = [Definitions rectWithX:0/*r.x*/ y:0/*r.y*/ w:r.w h:19];
    _titleBarTextRect = _titleBarRect;
    _titleBarTextRect.x = 21 + 4;
    _titleBarTextRect.w -= (21+4)*2;

    _closeButtonRect.x = 8;
    _closeButtonRect.y = 0;
    _closeButtonRect.w = 13;
    _closeButtonRect.h = 19;

    _maximizeButtonRect.x = r.w-8-13;
    _maximizeButtonRect.y = 0;
    _maximizeButtonRect.w = 13;
    _maximizeButtonRect.h = 19;

    _leftArrowRect.x = 0;
    _leftArrowRect.y = r.h-17;
    _leftArrowRect.w = 16;
    _leftArrowRect.h = 17;
    _rightArrowRect.x = r.w-17-15;
    _rightArrowRect.y = r.h-17;
    _rightArrowRect.w = 16;
    _rightArrowRect.h = 17;
    _upArrowRect.x = r.w-17;
    _upArrowRect.y = 19+20;
    _upArrowRect.w = 16;
    _upArrowRect.h = 15;
    _downArrowRect.x = r.w-17;
    _downArrowRect.y = r.h-17-15;
    _downArrowRect.w = 16;
    _downArrowRect.h = 15;

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
    _contentXMax += 17 + 1 + 20;
    _contentYMax += 19 + 20 + 17 + 20;
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
    _horizontalKnobX = _leftArrowRect.x+_leftArrowRect.w;
    _horizontalKnobW = 16;
    _horizontalKnobMaxVal = _rightArrowRect.x-_horizontalKnobX-_horizontalKnobW;
    double xpct = (double)(_visibleX-_contentXMin)/(double)(contentWidth-_visibleW);
    if (xpct < 0.0) {
        xpct = 0.0;
    } else if (xpct > 1.0) {
        xpct = 1.0;
    }
    if (![_buttonDown isEqual:@"horizontalKnob"]) {
        _horizontalKnobVal = (double)_horizontalKnobMaxVal*xpct;
    }

    double hpct = (double)_visibleH / (double)contentHeight;
    _verticalKnobY = _upArrowRect.y+_upArrowRect.h;
    _verticalKnobH = 16;
    _verticalKnobMaxVal = _downArrowRect.y-_verticalKnobY-_verticalKnobH;
    double ypct = (double)(_visibleY-_contentYMin)/(double)(contentHeight-_visibleH);
    if (ypct < 0.0) {
        ypct = 0.0;
    } else if (ypct > 1.0) {
        ypct = 1.0;
    }
    if (![_buttonDown isEqual:@"verticalKnob"]) {
        _verticalKnobVal = (double)_verticalKnobMaxVal*ypct;
    }

    _disableHorizontalScrollBar = 0;
    if (_visibleX == _contentXMin) {
        if (_visibleX + _visibleW - 1 == _contentXMax) {
            _disableHorizontalScrollBar = 1;
        }
    }
    _disableVerticalScrollBar = 0;
    if (_visibleY == _contentYMin) {
        if (_visibleY + _visibleH - 1 == _contentYMax) {
            _disableVerticalScrollBar = 1;
        }
    }
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)r context:(id)context
{
    [bitmap useMonacoFont];
    [bitmap setColor:@"white"];
    [bitmap fillRect:r];
    [bitmap setColor:@"black"];
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        int x = -_visibleX + [elt intValueForKey:@"x"];
        int y = -_visibleY + [elt intValueForKey:@"y"] + 19 + 20;
        int w = [elt intValueForKey:@"w"];
        int h = [elt intValueForKey:@"h"];
        if ((_selected == elt) || [elt intValueForKey:@"isSelected"]) {
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
        [bitmap drawBitmapText:filePath centeredAtX:x+w/2 y:y+h-2];
    }

    BOOL hasFocus = NO;
    {
        id windowManager = [@"windowManager" valueForKey];
        unsigned long focusInEventWindow = [[windowManager valueForKey:@"focusInEventWindow"] unsignedLongValue];
        unsigned long win = [[context valueForKey:@"window"] unsignedLongValue];
        if (focusInEventWindow && (focusInEventWindow == win)) {
            hasFocus = YES;
        }
    }

    if (hasFocus) {
        char *palette = [Definitions cStringForMacColorPalette];
        char *left = [Definitions cStringForMacColorActiveTitleBarLeftPixels];
        char *middle = [Definitions cStringForMacColorActiveTitleBarMiddlePixels];
        char *right = activeTitleBarRightPixels;
        [Definitions drawInBitmap:bitmap left:left palette:palette middle:middle palette:palette right:right palette:palette x:_titleBarRect.x y:_titleBarRect.y w:_titleBarRect.w];

        if ([_buttonDown isEqual:@"closeButton"] && [_buttonHover isEqual:@"closeButton"]) {
            char *pixels = [Definitions cStringForMacColorButtonDownPixels];
            [bitmap drawCString:pixels palette:palette x:_closeButtonRect.x y:_closeButtonRect.y];
        } else {
            char *pixels = [Definitions cStringForMacColorCloseButtonPixels];
            [bitmap drawCString:pixels palette:palette x:_closeButtonRect.x y:_closeButtonRect.y];
        }
        if ([_buttonDown isEqual:@"maximizeButton"] && [_buttonHover isEqual:@"maximizeButton"]) {
            char *pixels = [Definitions cStringForMacColorButtonDownPixels];
            [bitmap drawCString:pixels palette:palette x:_maximizeButtonRect.x y:_maximizeButtonRect.y];
        } else {
            char *pixels = [Definitions cStringForMacColorMaximizeButtonPixels];
            [bitmap drawCString:pixels palette:palette x:_maximizeButtonRect.x y:_maximizeButtonRect.y];
        }
    } else {
        char *palette = [Definitions cStringForMacColorPalette];
        char *left = [Definitions cStringForMacColorInactiveTitleBarLeftPixels];
        char *middle = [Definitions cStringForMacColorInactiveTitleBarMiddlePixels];
        char *right = inactiveTitleBarRightPixels;
        [Definitions drawInBitmap:bitmap left:left palette:palette middle:middle palette:palette right:right palette:palette x:_titleBarRect.x y:_titleBarRect.y w:_titleBarRect.w];
    }

    if (_titleBarTextRect.w > 0) {
        id text = _title;
        if (!text) {
            text = @"(no title)";
        }

        [bitmap useChicagoFont];

        text = [[[bitmap fitBitmapString:text width:_titleBarTextRect.w-14] split:@"\n"] nth:0];
        if (text) {
            int textWidth = [bitmap bitmapWidthForText:text];
            int backWidth = textWidth + 14;
            int backX = _titleBarTextRect.x + ((_titleBarTextRect.w - backWidth) / 2);
            int textX = backX + 7;
            if (hasFocus) {
                [bitmap setColor:@"white"];
                [bitmap fillRect:[Definitions rectWithX:backX y:_titleBarTextRect.y+2 w:backWidth h:16]];
                [bitmap setColorIntR:0 g:0 b:0 a:255];
                [bitmap drawBitmapText:text x:textX y:_titleBarTextRect.y+4];
            } else {
                [bitmap setColorIntR:0 g:0 b:0 a:255];
                [bitmap drawBitmapText:text x:textX y:_titleBarTextRect.y+4];
            }
        }

        [bitmap useMonacoFont];
    }

    int infoBarHeight = 20;
    if (infoBarHeight) {
        char *palette = [Definitions cStringForMacColorPalette];
        if (hasFocus) {
            [Definitions drawInBitmap:bitmap left:infoBarLeftPixels middle:infoBarMiddlePixels right:infoBarRightPixels x:r.x y:r.y+19 w:r.w palette:palette];
        } else {
            [Definitions drawInBitmap:bitmap left:inactiveInfoBarLeftPixels middle:infoBarMiddlePixels right:inactiveInfoBarRightPixels x:r.x y:r.y+19 w:r.w palette:palette];
        }
        [bitmap useGenevaFont];
        [bitmap setColorIntR:0 g:0 b:0 a:255];
        if (_numberOfItemsText) {
            [bitmap drawBitmapText:_numberOfItemsText x:20 y:r.y+19+5];
        }
        if (_diskUsedText) {
            int textWidth = [bitmap bitmapWidthForText:_diskUsedText];
            [bitmap drawBitmapText:_diskUsedText x:r.x+(r.w-textWidth)/2 y:r.y+19+5];
        }
        if (_diskFreeText) {
            int textWidth = [bitmap bitmapWidthForText:_diskFreeText];
            [bitmap drawBitmapText:_diskFreeText x:r.x+r.w-20-textWidth y:r.y+19+5];
        }

    }

    {
        char *middle = "b\n";
        if (hasFocus) {
            char *palette = "b #000000\n";
            [Definitions drawInBitmap:bitmap top:middle palette:palette middle:middle palette:palette bottom:middle palette:palette x:r.x y:r.y+19+infoBarHeight h:r.h-19-infoBarHeight-17];
        } else {
            char *palette = "b #555555\n";
            [Definitions drawInBitmap:bitmap top:middle palette:palette middle:middle palette:palette bottom:middle palette:palette x:r.x y:r.y+19+infoBarHeight h:r.h-19-infoBarHeight-17];
        }
    }
    {
        char *top = upArrowPixels;
        char *middle = activeRightScrollBarPixels;
        char *bottom = downArrowPixels;
        char *palette = [Definitions cStringForMacColorPalette];
        if (hasFocus) {
            if (_disableVerticalScrollBar) {
                top = disabledRightScrollBarTopPixels;
                middle = disabledRightScrollBarMiddlePixels;
                bottom = disabledRightScrollBarBottomPixels;
            } else {
                if ([_buttonDown isEqual:@"upArrow"] && [_buttonHover isEqual:@"upArrow"]) {
                    top = upArrowDownPixels;
                } else if ([_buttonDown isEqual:@"downArrow"] && [_buttonHover isEqual:@"downArrow"]) {
                    bottom = downArrowDownPixels;
                }
            }
        } else {
            top = inactiveRightMiddlePixels;
            middle = inactiveRightMiddlePixels;
            bottom = inactiveRightMiddlePixels;
        }
        [Definitions drawInBitmap:bitmap top:top palette:palette middle:middle palette:palette bottom:bottom palette:palette x:r.x+r.w-17 y:r.y+19+infoBarHeight h:r.h-19-infoBarHeight-17];

        if (hasFocus && !_disableVerticalScrollBar) {
            [bitmap drawCString:verticalKnobPixels palette:palette x:r.x+r.w-16 y:_verticalKnobY+_verticalKnobVal];
            if ([_buttonDown isEqual:@"verticalKnob"]) {
                char *h = [Definitions cStringForMacWindowSelectionHorizontal];
                char *v = [Definitions cStringForMacWindowSelectionVertical];
                char *palette = "b #000000\nw #ffffff\n";
                [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x+r.w-16 y:_verticalKnobY+_verticalKnobVal w:14 palette:palette];
                [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x+r.w-16 y:_verticalKnobY+_verticalKnobVal+1 h:16-2];
                [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x+r.w-16+14-1 y:_verticalKnobY+_verticalKnobVal+1 h:16-2];
                [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x+r.w-16 y:_verticalKnobY+_verticalKnobVal+16-1 w:14 palette:palette];
            }
        }
    }

    {
        char *left = leftArrowPixels;
        char *middle = activeBottomScrollBarPixels;
        char *right = rightArrowPixels;
        char *palette = [Definitions cStringForMacColorPalette];
        if (hasFocus) {
            if (_disableHorizontalScrollBar) {
                left = disabledBottomScrollBarLeftPixels;
                middle = disabledBottomScrollBarMiddlePixels;
                right = disabledBottomScrollBarRightPixels;
            } else {
                if ([_buttonDown isEqual:@"leftArrow"] && [_buttonHover isEqual:@"leftArrow"]) {
                    left = leftArrowDownPixels;
                } else if ([_buttonDown isEqual:@"rightArrow"] && [_buttonHover isEqual:@"rightArrow"]) {
                    right = rightArrowDownPixels;
                }
            }
        } else {
            left = inactiveBottomLeftPixels;
            middle = inactiveBottomMiddlePixels;
            right = inactiveBottomMiddlePixels;
        }
        [Definitions drawInBitmap:bitmap left:left middle:middle right:right x:r.x y:r.y+r.h-17 w:r.w-17 palette:palette];

        if (hasFocus && !_disableHorizontalScrollBar) { 
            [bitmap drawCString:horizontalKnobPixels palette:palette x:_horizontalKnobX+_horizontalKnobVal y:r.y+r.h-16];
            if ([_buttonDown isEqual:@"horizontalKnob"]) {
                char *h = [Definitions cStringForMacWindowSelectionHorizontal];
                char *v = [Definitions cStringForMacWindowSelectionVertical];
                char *palette = "b #000000\nw #ffffff\n";
                [Definitions drawInBitmap:bitmap left:h middle:h right:h x:_horizontalKnobX+_horizontalKnobVal y:r.y+r.h-16 w:16 palette:palette];
                [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:_horizontalKnobX+_horizontalKnobVal y:r.y+r.h-16+1 h:14-2];
                [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:_horizontalKnobX+_horizontalKnobVal+16-1 y:r.y+r.h-16+1 h:14-2];
                [Definitions drawInBitmap:bitmap left:h middle:h right:h x:_horizontalKnobX+_horizontalKnobVal y:r.y+r.h-16+14-1 w:16 palette:palette];
            }
        }
    }



    {
        char *pixels = resizeButtonPixels;
        if (!hasFocus) {
            pixels = inactiveResizeButtonPixels;
        }
        char *palette = [Definitions cStringForMacColorPalette];
        [bitmap drawCString:pixels palette:palette x:r.w-17 y:r.h-17];
    }

    if (hasFocus) {
        char *palette = "b #000000\nw #ffffff\n";
        if ([_buttonDown isEqual:@"titleBar"]) {
            char *h = [Definitions cStringForMacWindowSelectionHorizontal];
            char *v = [Definitions cStringForMacWindowSelectionVertical];
            [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x y:r.y w:r.w palette:palette];
            [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x y:r.y+1 h:r.h+1-2];
            [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x+r.w-1 y:r.y+1 h:r.h+1-2];
            [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x y:r.y+r.h-1 w:r.w palette:palette];
        } else if ([_buttonDown isEqual:@"resizeButton"]) {
            char *h = [Definitions cStringForMacWindowSelectionHorizontal];
            char *v = [Definitions cStringForMacWindowSelectionVertical];
            [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x y:r.y w:r.w palette:palette];
            [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x y:r.y+18 w:r.w palette:palette];
            [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x y:r.y+1 h:r.h-2];
            [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x+r.w-2 y:r.y+1 h:r.h-2];
            [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x+r.w-2-15 y:r.y+1+18 h:r.h-2-18];
            [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x y:r.y+r.h-2 w:r.w palette:palette];
            [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x y:r.y+r.h-2-15 w:r.w palette:palette];
        }
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
        if (_disableHorizontalScrollBar) {
            return;
        }
        [self setValue:@"leftArrow" forKey:@"buttonDown"];
        [self setValue:@"leftArrow" forKey:@"buttonHover"];
        _visibleX -= 10;
        if (_visibleX < _contentXMin) {
            _visibleX = _contentXMin;
        }
        return;
    }
    if ([Definitions isX:mouseX y:mouseY insideRect:_rightArrowRect]) {
        if (_disableHorizontalScrollBar) {
            return;
        }
        [self setValue:@"rightArrow" forKey:@"buttonDown"];
        [self setValue:@"rightArrow" forKey:@"buttonHover"];
        _visibleX += 10;
        if (_visibleX > _contentXMax+1 - _visibleW) {
            _visibleX = _contentXMax+1 - _visibleW;
        }
        return;
    }
    if ([Definitions isX:mouseX y:mouseY insideRect:_upArrowRect]) {
        if (_disableVerticalScrollBar) {
            return;
        }
        [self setValue:@"upArrow" forKey:@"buttonDown"];
        [self setValue:@"upArrow" forKey:@"buttonHover"];
        _visibleY -= 10;
        if (_visibleY < _contentYMin) {
            _visibleY = _contentYMin;
        }
        return;
    }
    if ([Definitions isX:mouseX y:mouseY insideRect:_downArrowRect]) {
        if (_disableVerticalScrollBar) {
            return;
        }
        [self setValue:@"downArrow" forKey:@"buttonDown"];
        [self setValue:@"downArrow" forKey:@"buttonHover"];
        _visibleY += 10;
        if (_visibleY > _contentYMax+1 - _visibleH) {
            _visibleY = _contentYMax+1 - _visibleH;
        }
        return;
    }
    if (mouseX >= viewWidth-17) {
        if (mouseY >= viewHeight-17) {
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
    if ([Definitions isX:mouseX y:mouseY insideRect:_maximizeButtonRect]) {
        [self setValue:@"maximizeButton" forKey:@"buttonDown"];
        [self setValue:@"maximizeButton" forKey:@"buttonHover"];
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
            if (_disableHorizontalScrollBar) {
                return;
            }
            if (mouseX < _horizontalKnobX) {
            } else if (mouseX < _horizontalKnobX+_horizontalKnobVal) {
                _visibleX -= _visibleW;
                if (_visibleX < _contentXMin) {
                    _visibleX = _contentXMin;
                }
                return;
            } else if (mouseX < _horizontalKnobX+_horizontalKnobVal+_horizontalKnobW) {
                [self setValue:@"horizontalKnob" forKey:@"buttonDown"];
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
            if (_disableVerticalScrollBar) {
                return;
            }
            if (mouseY < _verticalKnobY) {
            } else if (mouseY < _verticalKnobY+_verticalKnobVal) {
                _visibleY -= _visibleH;
                if (_visibleY < _contentYMin) {
                    _visibleY = _contentYMin;
                }
                return;
            } else if (mouseY < _verticalKnobY+_verticalKnobVal+_verticalKnobH) {
                [self setValue:@"verticalKnob" forKey:@"buttonDown"];
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
        int x = -_visibleX + [elt intValueForKey:@"x"];
        int y = -_visibleY + [elt intValueForKey:@"y"] + 19 + 20;
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
                id filePath = [_selected valueForKey:@"filePath"];
                if ([filePath length]) {
                    if ([filePath isDirectory]) {
                        id cmd = nsarr();
                        [cmd addObject:@"hotdog"];
                        [cmd addObject:@"maccolordir"];
                        [cmd addObject:filePath];
                        [cmd runCommandInBackground];
                    } else {
                        id cmd = nsarr();
                        [cmd addObject:@"hotdog-open:.pl"];
                        [cmd addObject:filePath];
                        [cmd runCommandInBackground];
                    }
                }
                [self setValue:nil forKey:@"buttonDownTimestamp"];
            } else {
                [self setValue:timestamp forKey:@"buttonDownTimestamp"];
            }
            return;
        }
    }

    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        [elt setValue:nil forKey:@"isSelected"];
    }

    if (_selectionBox) {
        [_selectionBox setValue:@"1" forKey:@"shouldCloseWindow"];
        [self setValue:nil forKey:@"selectionBox"];
    }

    _selectionBoxRootX = [event intValueForKey:@"mouseRootX"];
    _selectionBoxRootY = [event intValueForKey:@"mouseRootY"];
    [self setValue:@"selectionBox" forKey:@"buttonDown"];
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
    } else if ([_buttonDown isEqual:@"maximizeButton"]) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_maximizeButtonRect]) {
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
    } else if ([_buttonDown isEqual:@"horizontalKnob"]) {
        _horizontalKnobVal = mouseX - _horizontalKnobX - _buttonDownX;
        if (_horizontalKnobVal < 0) {
            _horizontalKnobVal = 0;
        } else if (_horizontalKnobVal > _horizontalKnobMaxVal) {
            _horizontalKnobVal = _horizontalKnobMaxVal;
        }

    } else if ([_buttonDown isEqual:@"verticalKnob"]) {
        _verticalKnobVal = mouseY - _verticalKnobY - _buttonDownY;
        if (_verticalKnobVal < 0) {
            _verticalKnobVal = 0;
        } else if (_verticalKnobVal > _verticalKnobMaxVal) {
            _verticalKnobVal = _verticalKnobMaxVal;
        }
    } else if ([_buttonDown isEqual:@"selectionBox"]) {

        id windowManager = [event valueForKey:@"windowManager"];

        int mouseRootX = [event intValueForKey:@"mouseRootX"];
        int mouseRootY = [event intValueForKey:@"mouseRootY"];
        int newX = _selectionBoxRootX;
        int newY = _selectionBoxRootY;
        int newWidth = mouseRootX - _selectionBoxRootX;
        int newHeight = mouseRootY - _selectionBoxRootY;
        if (newWidth == 0) {
            newWidth = 1;
        } else if (newWidth < 0) {
            newX = mouseRootX;
            newWidth *= -1;
            newWidth++;
        }
        if (newHeight == 0) {
            newHeight = 1;
        } else if (newHeight < 0) {
            newY = mouseRootY;
            newHeight *= -1;
            newHeight++;
        }
        if (!_selectionBox) {
            id object = [@"SelectionBox" asInstance];
            id dict = [windowManager openWindowForObject:object x:newX y:newY w:newWidth h:newHeight overrideRedirect:YES];
            [self setValue:dict forKey:@"selectionBox"];
        } else {
            [_selectionBox setValue:nsfmt(@"%d", newX) forKey:@"x"];
            [_selectionBox setValue:nsfmt(@"%d", newY) forKey:@"y"];
            [_selectionBox setValue:nsfmt(@"%d", newWidth) forKey:@"w"];
            [_selectionBox setValue:nsfmt(@"%d", newHeight) forKey:@"h"];
            [_selectionBox setValue:@"1" forKey:@"needsRedraw"];
            [_selectionBox setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];
            [_selectionBox setValue:nsfmt(@"%d %d", newWidth, newHeight) forKey:@"resizeWindow"];
        }

        id x11dict = [event valueForKey:@"x11dict"];
        int windowX = [x11dict intValueForKey:@"x"];
        int windowY = [x11dict intValueForKey:@"y"];
        int windowW = [x11dict intValueForKey:@"w"];
        int windowH = [x11dict intValueForKey:@"h"];
        int selectionX = newX - windowX;
        int selectionMaxX = selectionX + newWidth - 1;
        if (selectionX < 0) {
            selectionX = 0;
        }
        if (selectionMaxX > windowX + windowW - 1) {
            selectionMaxX = windowX + windowX - 1;
        }
        int selectionY = newY - windowY;
        int selectionMaxY = selectionY + newHeight - 1;
        if (selectionY < 0) {
            selectionY = 0;
        }
        if (selectionMaxY > windowY + windowH - 1) {
            selectionMaxY = windowY + windowH - 1;
        }
        selectionX += _visibleX;
        selectionY += _visibleY;
        selectionMaxX += _visibleX;
        selectionMaxY += _visibleY;
        Int4 r = [Definitions rectWithX:selectionX y:selectionY w:selectionMaxX-selectionX+1 h:selectionMaxY-selectionY+1];

        for (int i=0; i<[_array count]; i++) {
            id elt = [_array nth:i];
            int x = [elt intValueForKey:@"x"] + 1;
            int y = [elt intValueForKey:@"y"] + 19 + 20;
            int w = [elt intValueForKey:@"w"];
            int h = [elt intValueForKey:@"h"];
            Int4 r2 = [Definitions rectWithX:x y:y w:w h:h];
            if ([Definitions doesRect:r intersectRect:r2]) {
                [elt setValue:@"1" forKey:@"isSelected"];
            } else {
                [elt setValue:nil forKey:@"isSelected"];
            }
        }

    } else {
        [_buttonDown setValue:nsfmt(@"%d", mouseX - _buttonDownOffsetX + _visibleX) forKey:@"x"];
        [_buttonDown setValue:nsfmt(@"%d", mouseY - _buttonDownOffsetY + _visibleY - 19 - 20) forKey:@"y"];
        [self setValue:nil forKey:@"buttonDownTimestamp"];
    }
}

- (void)handleMouseUp:(id)event
{
    if ([_buttonDown isEqual:@"closeButton"] && [_buttonDown isEqual:_buttonHover]) {
        exit(0);
    }
    if ([_buttonDown isEqual:@"maximizeButton"] && [_buttonDown isEqual:_buttonHover]) {
/*
        id x11dict = [event valueForKey:@"x11dict"];
        id windowManager = [event valueForKey:@"windowManager"];
        [windowManager raiseObjectWindow:x11dict];
*/
    }
    if ([_buttonDown isEqual:@"horizontalKnob"]) {
        int contentWidth = _contentXMax - _contentXMin - _visibleW;
        double pct = 0.0;
        if (_horizontalKnobMaxVal) {
            pct = (double)_horizontalKnobVal / (double)_horizontalKnobMaxVal;
        }
        _visibleX = _contentXMin + contentWidth*pct;
    }
    if ([_buttonDown isEqual:@"verticalKnob"]) {
        int contentHeight = _contentYMax - _contentYMin - _visibleH;
        double pct = 0.0;
        if (_verticalKnobMaxVal) {
            pct = (double)_verticalKnobVal / (double)_verticalKnobMaxVal;
        }
        _visibleY = _contentYMin + contentHeight*pct;
    }
    if ([_buttonDown isEqual:@"selectionBox"]) {
        if (_selectionBox) {
            [_selectionBox setValue:@"1" forKey:@"shouldCloseWindow"];
            [self setValue:nil forKey:@"selectionBox"];
        }
    }
    [self setValue:nil forKey:@"buttonDown"];
    [self setValue:nil forKey:@"buttonHover"];
}

@end

