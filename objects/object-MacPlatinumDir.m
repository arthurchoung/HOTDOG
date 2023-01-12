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

static int _titleBarHeight = 22;

static char *activeRightBorderTopPalette =
"b #000000\n"
". #777777\n"
"X #888888\n"
"o #999999\n"
"O #AAAAAA\n"
"+ #BBBBBB\n"
"@ #cccccc\n"
"# #DDDDDD\n"
"$ #ffffff\n"
;
static char *activeRightBorderTopPixels =
"b$$$$$$$$$$$$$#b$@@obb\n"
"b$############+b$@@obb\n"
"b$############+b$@@obb\n"
"b$############+b$@@obb\n"
"b$############+b$@@obb\n"
"b$#####bb#####+b$@@obb\n"
"b$####bbbb####+b$@@obb\n"
"b$###bbbbbb###+b$@@obb\n"
"b$##bbbbbbbb##+b$@@obb\n"
"b$############+b$@@obb\n"
"b$############+b$@@obb\n"
"b$############+b$@@obb\n"
"b$############+b$@@obb\n"
"b#+++++++++++++b$@@obb\n"
"bbbbbbbbbbbbbbbb$@@obb\n"
"b.............@b$@@obb\n"
"b.XXXXXXXXXXX+@b$@@obb\n"
;
static char *activeRightBorderMiddlePixels = // uses TopPalette
"b.XOOOOOOOOOO+@b$@@obb\n"
;
static char *activeRightBorderShadow1Pixels =
"b.............@b\n"
;
static char *activeRightBorderShadow2Pixels =
"b.XXXXXXXXXXX+@b\n"
;
static char *activeRightBorderBottomPalette =
"b #000000\n"
". #777777\n"
"X #888888\n"
"o #999999\n"
"O #AAAAAA\n"
"+ #BBBBBB\n"
"@ #cccccc\n"
"# #DDDDDD\n"
"$ #ffffff\n"
;
static char *activeRightBorderBottomPixels =
"bbbbbbbbbbbbbbbb$@@obb\n"
"b$$$$$$$$$$$$$#b$@@obb\n"
"b$############+b$@@obb\n"
"b$############+b$@@obb\n"
"b$############+b$@@obb\n"
"b$############+b$@@obb\n"
"b$##bbbbbbbb##+b$@@obb\n"
"b$###bbbbbb###+b$@@obb\n"
"b$####bbbb####+b$@@obb\n"
"b$#####bb#####+b$@@obb\n"
"b$############+b$@@obb\n"
"b$############+b$@@obb\n"
"b$############+b$@@obb\n"
"b$############+b$@@obb\n"
"b#+++++++++++++b$@@obb\n"
;

static char *disabledRightBorderTopPalette =
"b #000000\n"
". #555555\n"
"X #888888\n"
"o #999999\n"
"O #AAAAAA\n"
"+ #cccccc\n"
"@ #DDDDDD\n"
"# #EEEEEE\n"
"$ #ffffff\n"
;
static char *disabledRightBorderTopPixels =
"b##############b$++obb\n"
"b##############b$++obb\n"
"b##############b$++obb\n"
"b##############b$++obb\n"
"b##############b$++obb\n"
"b######XX######b$++obb\n"
"b#####XXXX#####b$++obb\n"
"b####XXXXXX####b$++obb\n"
"b###XXXXXXXX###b$++obb\n"
"b##############b$++obb\n"
"b##############b$++obb\n"
"b##############b$++obb\n"
"b##############b$++obb\n"
"b##############b$++obb\n"
"b..............b$++obb\n"
;
static char *disabledRightBorderMiddlePixels = // uses TopPalette
"b##############b$++obb\n"
;
static char *disabledRightBorderBottomPalette =
"b #000000\n"
". #555555\n"
"X #777777\n"
"o #888888\n"
"O #999999\n"
"+ #AAAAAA\n"
"@ #cccccc\n"
"# #DDDDDD\n"
"$ #EEEEEE\n"
"% #ffffff\n"
;
static char *disabledRightBorderBottomPixels =
"b..............b%@@Obb\n"
"b$$$$$$$$$$$$$$b%@@Obb\n"
"b$$$$$$$$$$$$$$b%@@Obb\n"
"b$$$$$$$$$$$$$$b%@@Obb\n"
"b$$$$$$$$$$$$$$b%@@Obb\n"
"b$$$$$$$$$$$$$$b%@@Obb\n"
"b$$$oooooooo$$$b%@@Obb\n"
"b$$$$oooooo$$$$b%@@Obb\n"
"b$$$$$oooo$$$$$b%@@Obb\n"
"b$$$$$$oo$$$$$$b%@@Obb\n"
"b$$$$$$$$$$$$$$b%@@Obb\n"
"b$$$$$$$$$$$$$$b%@@Obb\n"
"b$$$$$$$$$$$$$$b%@@Obb\n"
"b$$$$$$$$$$$$$$b%@@Obb\n"
"b$$$$$$$$$$$$$$b%@@Obb\n"
;

static char *inactiveRightBorderPalette =
"b #555555\n"
". #63639C\n"
"X #DDDDDD\n"
"o #EEEEEE\n"
"O #FFFFFF\n"
;

static char *inactiveRightBorderMiddlePixels =
"boooooooooooooobXXXXbb\n"
;

static char *inactiveBottomBorderPalette =
"b #555555\n"
". #63639C\n"
"X #DDDDDD\n"
"o #EEEEEE\n"
"O #FFFFFF\n"
;
static char *inactiveBottomBorderLeftPixels =
"bXXXXb\n"
"bXXXXb\n"
"bXXXXb\n"
"bXXXXb\n"
"bXXXXb\n"
"bXXXXb\n"
"bXXXXb\n"
"bXXXXb\n"
"bXXXXb\n"
"bXXXXb\n"
"bXXXXb\n"
"bXXXXb\n"
"bXXXXb\n"
"bXXXXb\n"
"bXXXXb\n"
"bXXXXb\n"
"bXXXXX\n"
"bXXXXX\n"
"bXXXXX\n"
"bXXXXX\n"
"bbbbbb\n"
"  bbbb\n"
;
static char *inactiveBottomBorderMiddlePixels =
"b\n"
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
"o\n"
"o\n"
"o\n"
"o\n"
"b\n"
"X\n"
"X\n"
"X\n"
"X\n"
"b\n"
"b\n"
;
static char *inactiveBottomBorderRightPixels =
"bbbbbbbbbbbbbbbbXXXXbb\n"
"bXXXXXXXXXXXXXXXXXXXbb\n"
"bXXXXXXXXXXXXXXXXXXXbb\n"
"bXXXXXXXXXXXXXXXXXXXbb\n"
"bXXXXXXXXXXXXXXXXXXXbb\n"
"bXXXXXXXXXXXXXXXXXXXbb\n"
"bXXXXXXXXXXXXXXXXXXXbb\n"
"bXXXXXXXXXXXXXXXXXXXbb\n"
"bXXXXXXXXXXXXXXXXXXXbb\n"
"bXXXXXXXXXXXXXXXXXXXbb\n"
"bXXXXXXXXXXXXXXXXXXXbb\n"
"bXXXXXXXXXXXXXXXXXXXbb\n"
"bXXXXXXXXXXXXXXXXXXXbb\n"
"bXXXXXXXXXXXXXXXXXXXbb\n"
"bXXXXXXXXXXXXXXXXXXXbb\n"
"bXXXXXXXXXXXXXXXXXXXbb\n"
"XXXXXXXXXXXXXXXXXXXXbb\n"
"XXXXXXXXXXXXXXXXXXXXbb\n"
"XXXXXXXXXXXXXXXXXXXXbb\n"
"XXXXXXXXXXXXXXXXXXXXbb\n"
"bbbbbbbbbbbbbbbbbbbbbb\n"
"bbbbbbbbbbbbbbbbbbbbbb\n"
;
static char *disabledBottomBorderLeftPalette =
"b #000000\n"
". #555555\n"
"X #888888\n"
"o #999999\n"
"O #cccccc\n"
"+ #EEEEEE\n"
"@ #ffffff\n"
;
static char *disabledBottomBorderLeftPixels =
"b@OOobbbbbbbbbbbbbbbb\n"
"b@OOob++++++++++++++.\n"
"b@OOob++++++++++++++.\n"
"b@OOob++++++++++++++.\n"
"b@OOob++++++++X+++++.\n"
"b@OOob+++++++XX+++++.\n"
"b@OOob++++++XXX+++++.\n"
"b@OOob+++++XXXX+++++.\n"
"b@OOob+++++XXXX+++++.\n"
"b@OOob++++++XXX+++++.\n"
"b@OOob+++++++XX+++++.\n"
"b@OOob++++++++X+++++.\n"
"b@OOob++++++++++++++.\n"
"b@OOob++++++++++++++.\n"
"b@OOob++++++++++++++.\n"
"b@OOobbbbbbbbbbbbbbbb\n"
"b@OOO@@@@@@@@@@@@@@@@\n"
"b@OOOOOOOOOOOOOOOOOOO\n"
"b@OOOOOOOOOOOOOOOOOOO\n"
"bOooooooooooooooooooo\n"
"bbbbbbbbbbbbbbbbbbbbb\n"
"@@bbbbbbbbbbbbbbbbbbb\n"
;
static char *disabledBottomBorderMiddlePixels = // uses LeftPalette
"b\n"
"+\n"
"+\n"
"+\n"
"+\n"
"+\n"
"+\n"
"+\n"
"+\n"
"+\n"
"+\n"
"+\n"
"+\n"
"+\n"
"+\n"
"b\n"
"@\n"
"O\n"
"O\n"
"o\n"
"b\n"
"b\n"
;
static char *disabledBottomBorderRightPalette =
"b #000000\n"
". #555555\n"
"X #777777\n"
"o #888888\n"
"O #999999\n"
"+ #AAAAAA\n"
"@ #cccccc\n"
"# #DDDDDD\n"
"$ #EEEEEE\n"
"% #ffffff\n"
;
static char *disabledBottomBorderRightPixels =
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb%@@Obb\n"
".$$$$$$$$$$$$$$b%%%%%%%%%%%%%%%%@@Obb\n"
".$$$$$$$$$$$$$$b%@@@@@@@@@@@@@@@@@Obb\n"
".$$$$$$$$$$$$$$b%@@@@@@@@@@@@@@@@@Obb\n"
".$$$$$o$$$$$$$$b%@@@@@@@%%@@@@@@@@Obb\n"
".$$$$$oo$$$$$$$b%@@@@@@%@X@@@@@@@@Obb\n"
".$$$$$ooo$$$$$$b%@@@@@%@X@%%@@@@@@Obb\n"
".$$$$$oooo$$$$$b%@@@@%@X@%@X@@@@@@Obb\n"
".$$$$$oooo$$$$$b%@@@%@X@%@X@%%@@@@Obb\n"
".$$$$$ooo$$$$$$b%@@%@X@%@X@%@X@@@@Obb\n"
".$$$$$oo$$$$$$$b%@@+X@%@X@%@X@@@@@Obb\n"
".$$$$$o$$$$$$$$b%@@@@%@X@%@X@@@@@@Obb\n"
".$$$$$$$$$$$$$$b%@@@@+X@%@X@@@@@@@Obb\n"
".$$$$$$$$$$$$$$b%@@@@@@%@X@@@@@@@@Obb\n"
".$$$$$$$$$$$$$$b%@@@@@@+X@@@@@@@@@Obb\n"
"bbbbbbbbbbbbbbbb%@@@@@@@@@@@@@@@@@Obb\n"
"%%%%%%%%%%%%%%%%%@@@@@@@@@@@@@@@@@Obb\n"
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Obb\n"
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Obb\n"
"OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOObb\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
;

static char *activeBottomBorderLeftPalette =
"b #000000\n"
". #777777\n"
"X #888888\n"
"o #999999\n"
"O #AAAAAA\n"
"+ #BBBBBB\n"
"@ #cccccc\n"
"# #DDDDDD\n"
"$ #ffffff\n"
;
static char *activeBottomBorderLeftPixels =
"b$@@obbbbbbbbbbbbbbbbbb\n"
"b$@@ob$$$$$$$$$$$$$#b..\n"
"b$@@ob$############+b.X\n"
"b$@@ob$############+b.X\n"
"b$@@ob$#######b####+b.X\n"
"b$@@ob$######bb####+b.X\n"
"b$@@ob$#####bbb####+b.X\n"
"b$@@ob$####bbbb####+b.X\n"
"b$@@ob$####bbbb####+b.X\n"
"b$@@ob$#####bbb####+b.X\n"
"b$@@ob$######bb####+b.X\n"
"b$@@ob$#######b####+b.X\n"
"b$@@ob$############+b.X\n"
"b$@@ob$############+b.+\n"
"b$@@ob#+++++++++++++b@@\n"
"b$@@obbbbbbbbbbbbbbbbbb\n"
"b$@@@$$$$$$$$$$$$$$$$$$\n"
"b$@@@@@@@@@@@@@@@@@@@@@\n"
"b$@@@@@@@@@@@@@@@@@@@@@\n"
"b@ooooooooooooooooooooo\n"
"bbbbbbbbbbbbbbbbbbbbbbb\n"
"$$bbbbbbbbbbbbbbbbbbbbb\n"
;
static char *activeBottomBorderMiddlePixels = // uses LeftPalette
"b\n"
".\n"
"X\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"+\n"
"@\n"
"b\n"
"$\n"
"@\n"
"@\n"
"o\n"
"b\n"
"b\n"
;
static char *activeBottomBorderShadow1Pixels = // uses LeftPalette
"b\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
"@\n"
"b\n"
"$\n"
"@\n"
"@\n"
"o\n"
"b\n"
"b\n"
;
static char *activeBottomBorderShadow2Pixels = // uses LeftPalette
"b\n"
".\n"
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
"+\n"
"@\n"
"b\n"
"$\n"
"@\n"
"@\n"
"o\n"
"b\n"
"b\n"
;


static char *activeBottomBorderRightPalette =
"b #000000\n"
". #777777\n"
"X #888888\n"
"o #999999\n"
"O #AAAAAA\n"
"+ #BBBBBB\n"
"@ #cccccc\n"
"# #DDDDDD\n"
"$ #ffffff\n"
;
static char *activeBottomBorderRightPixels =
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb$@@obb\n"
"b$$$$$$$$$$$$$#b$$$$$$$$$$$$$$$$@@obb\n"
"b$############+b$@@@@@@@@@@@@@@@@@obb\n"
"b$############+b$@@@@@@@@@@@@@@@@@obb\n"
"b$####b#######+b$@@@@@@@$$@@@@@@@@obb\n"
"b$####bb######+b$@@@@@@$@.@@@@@@@@obb\n"
"b$####bbb#####+b$@@@@@$@.@$$@@@@@@obb\n"
"b$####bbbb####+b$@@@@$@.@$@.@@@@@@obb\n"
"b$####bbbb####+b$@@@$@.@$@.@$$@@@@obb\n"
"b$####bbb#####+b$@@$@.@$@.@$@.@@@@obb\n"
"b$####bb######+b$@@O.@$@.@$@.@@@@@obb\n"
"b$####b#######+b$@@@@$@.@$@.@@@@@@obb\n"
"b$############+b$@@@@O.@$@.@@@@@@@obb\n"
"b$############+b$@@@@@@$@.@@@@@@@@obb\n"
"b#+++++++++++++b$@@@@@@O.@@@@@@@@@obb\n"
"bbbbbbbbbbbbbbbb$@@@@@@@@@@@@@@@@@obb\n"
"$$$$$$$$$$$$$$$$$@@@@@@@@@@@@@@@@@obb\n"
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@obb\n"
"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@obb\n"
"ooooooooooooooooooooooooooooooooooobb\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
;
//////////////////////////////

static char *inactiveInfoBarLeftPalette =
"b #555555\n"
". #DDDDDD\n"
"X #EEEEEE\n"
"o #ffffff\n"
;
static char *inactiveInfoBarLeftPixels = 
"b....b\n"
"b....b\n"
"b....b\n"
"b....b\n"
"b....b\n"
"b....b\n"
"b....b\n"
"b....b\n"
"b....b\n"
"b....b\n"
"b....b\n"
"b....b\n"
"b....b\n"
"b....b\n"
"b....b\n"
"b....b\n"
"b....b\n"
"b....b\n"
"b....b\n"
"b....b\n"
"b....b\n"
;
static char *inactiveInfoBarMiddlePixels = // uses LeftPalette
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
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
"b\n"
;
static char *inactiveInfoBarRightPalette = 
"b #555555\n"
". #DDDDDD\n"
"X #EEEEEE\n"
"o #ffffff\n"
;
static char *inactiveInfoBarRightPixels = 
"b....bb\n"
"b....bb\n"
"b....bb\n"
"b....bb\n"
"b....bb\n"
"b....bb\n"
"b....bb\n"
"b....bb\n"
"b....bb\n"
"b....bb\n"
"b....bb\n"
"b....bb\n"
"b....bb\n"
"b....bb\n"
"b....bb\n"
"b....bb\n"
"b....bb\n"
"b....bb\n"
"b....bb\n"
"b....bb\n"
"b....bb\n"
;
static char *activeInfoBarLeftPalette =
"b #000000\n"
". #999999\n"
"X #AAAAAA\n"
"o #cccccc\n"
"O #DDDDDD\n"
"+ #ffffff\n"
;
static char *activeInfoBarLeftPixels = 
"b+oo.b+\n"
"b+oo.b+\n"
"b+oo.b+\n"
"b+oo.b+\n"
"b+oo.b+\n"
"b+oo.b+\n"
"b+oo.b+\n"
"b+oo.b+\n"
"b+oo.b+\n"
"b+oo.b+\n"
"b+oo.b+\n"
"b+oo.b+\n"
"b+oo.b+\n"
"b+oo.b+\n"
"b+oo.b+\n"
"b+oo.b+\n"
"b+oo.b+\n"
"b+oo.b+\n"
"b+oo.b+\n"
"b+oo.bO\n"
"b+oo.bb\n"
;
static char *activeInfoBarMiddlePixels = // uses LeftPalette
"+\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"X\n"
"b\n"
;
static char *activeInfoBarRightPalette =
"b #000000\n"
". #888888\n"
"X #999999\n"
"o #AAAAAA\n"
"O #cccccc\n"
"+ #DDDDDD\n"
"@ #EEEEEE\n"
"# #ffffff\n"
;
static char *activeInfoBarRightPixels = 
"+b#OOXbb\n"
"ob#OOXbb\n"
"ob#OOXbb\n"
"ob#OOXbb\n"
"ob#OOXbb\n"
"ob#OOXbb\n"
"ob#OOXbb\n"
"ob#OOXbb\n"
"ob#OOXbb\n"
"ob#OOXbb\n"
"ob#OOXbb\n"
"ob#OOXbb\n"
"ob#OOXbb\n"
"ob#OOXbb\n"
"ob#OOXbb\n"
"ob#OOXbb\n"
"ob#OOXbb\n"
"ob#OOXbb\n"
"ob#OOXbb\n"
"ob#OOXbb\n"
"bb#OOXbb\n"
;

static char *verticalKnobPalette =
"b #000000\n"
". #777777\n"
"X #333399\n"
"o #6666CC\n"
"O #888888\n"
"+ #999999\n"
"@ #AAAAAA\n"
"# #BBBBBB\n"
"$ #9999FF\n"
"% #cccccc\n"
"& #CCCCFF\n"
"* #EEEEEE\n"
"= #ffffff\n"
;
static char *verticalKnobPixels =
"bbbbbbbbbbbbbbbb\n"
"b*&&&&&&&&&&&&$b\n"
"b&$$$$$$$$$$$$ob\n"
"b&$$$$$$$$$$$$ob\n"
"b&$$*&&&&&&$$$ob\n"
"b&$$$XXXXXXX$$ob\n"
"b&$$*&&&&&&$$$ob\n"
"b&$$$XXXXXXX$$ob\n"
"b&$$*&&&&&&$$$ob\n"
"b&$$$XXXXXXX$$ob\n"
"b&$$*&&&&&&$$$ob\n"
"b&$$$XXXXXXX$$ob\n"
"b&$$$$$$$$$$$$ob\n"
"b&$$$$$$$$$$$$ob\n"
"b&$$$$$$$$$$$$ob\n"
"b$ooooooooooooob\n"
"bbbbbbbbbbbbbbbb\n"
;
static char *verticalKnobDownPalette =
"b #000000\n"
". #000055\n"
"X #747474\n"
"o #777777\n"
"O #7C7C7C\n"
"+ #333399\n"
"@ #6666CC\n"
"# #888888\n"
"$ #898989\n"
"% #8B8B8B\n"
"& #999999\n"
"* #9D9D9D\n"
"= #A9A9A9\n"
"- #AAAAAA\n"
"; #BBBBBB\n"
": #bdbdbd\n"
"> #9999FF\n"
", #c9c9c9\n"
"< #cccccc\n"
"1 #D2D2D2\n"
"2 #d9d9d9\n"
"3 #DDDDDD\n"
"4 #CCCCFF\n"
"5 #e0e0e0\n"
"6 #EAEAEA\n"
"7 #f0f0f0\n"
"8 #ffffff\n"
;
static char *verticalKnobDownPixels =
"bbbbbbbbbbbbbbbb\n"
"b4>>>>>>>>>>>>@b\n"
"b>@@@@@@@@@@@@+b\n"
"b>@@@@@@@@@@@@+b\n"
"b>@@4>>>>>>@@@+b\n"
"b>@@@.......@@+b\n"
"b>@@4>>>>>>@@@+b\n"
"b>@@@.......@@+b\n"
"b>@@4>>>>>>@@@+b\n"
"b>@@@.......@@+b\n"
"b>@@4>>>>>>@@@+b\n"
"b>@@@.......@@+b\n"
"b>@@@@@@@@@@@@+b\n"
"b>@@@@@@@@@@@@+b\n"
"b>@@@@@@@@@@@@+b\n"
"b@+++++++++++++b\n"
"bbbbbbbbbbbbbbbb\n"
;
static char *horizontalKnobPalette =
"b #000000\n"
". #777777\n"
"X #333399\n"
"o #6666CC\n"
"O #888888\n"
"+ #999999\n"
"@ #AAAAAA\n"
"# #BBBBBB\n"
"$ #9999FF\n"
"% #cccccc\n"
"& #CCCCFF\n"
"* #EEEEEE\n"
"= #ffffff\n"
;

static char *horizontalKnobPixels =
"bbbbbbbbbbbbbbbbb\n"
"b*&&&&&&&&&&&&&$b\n"
"b&$$$$$$$$$$$$$ob\n"
"b&$$$$$$$$$$$$$ob\n"
"b&$$*$*$*$*$$$$ob\n"
"b&$$&X&X&X&X$$$ob\n"
"b&$$&X&X&X&X$$$ob\n"
"b&$$&X&X&X&X$$$ob\n"
"b&$$&X&X&X&X$$$ob\n"
"b&$$&X&X&X&X$$$ob\n"
"b&$$&X&X&X&X$$$ob\n"
"b&$$$X$X$X$X$$$ob\n"
"b&$$$$$$$$$$$$$ob\n"
"b&$$$$$$$$$$$$$ob\n"
"b$oooooooooooooob\n"
"bbbbbbbbbbbbbbbbb\n"
;
static char *horizontalKnobDownPalette =
"b #000000\n"
". #000055\n"
"X #555555\n"
"o #777777\n"
"O #333399\n"
"+ #6666CC\n"
"@ #888888\n"
"# #999999\n"
"$ #AAAAAA\n"
"% #BBBBBB\n"
"& #9999FF\n"
"* #cccccc\n"
"= #DDDDDD\n"
"- #CCCCFF\n"
"; #ffffff\n"
;
static char *horizontalKnobDownPixels =
"bbbbbbbbbbbbbbbbb\n"
"b-&&&&&&&&&&&&&+b\n"
"b&+++++++++++++Ob\n"
"b&+++++++++++++Ob\n"
"b&++-+-+-+-++++Ob\n"
"b&++&.&.&.&.+++Ob\n"
"b&++&.&.&.&.+++Ob\n"
"b&++&.&.&.&.+++Ob\n"
"b&++&.&.&.&.+++Ob\n"
"b&++&.&.&.&.+++Ob\n"
"b&++&.&.&.&.+++Ob\n"
"b&+++.+.+.+.+++Ob\n"
"b&+++++++++++++Ob\n"
"b&+++++++++++++Ob\n"
"b+OOOOOOOOOOOOOOb\n"
"bbbbbbbbbbbbbbbbb\n"
;
static char *leftArrowDownPalette =
"b #000000\n"
". #222222\n"
"X #555555\n"
"o #777777\n"
"O #333399\n"
"+ #6666CC\n"
"@ #888888\n"
"# #999999\n"
"$ #AAAAAA\n"
"% #BBBBBB\n"
"& #9999FF\n"
"* #cccccc\n"
"= #DDDDDD\n"
"- #CCCCFF\n"
"; #EEEEEE\n"
": #ffffff\n"
;
static char *leftArrowDownPixels =
"bbbbbbbbbbbbbbbb\n"
"bXXXXXXXXXXXXXob\n"
"bXoooooooooooo#b\n"
"bXoooooooooooo#b\n"
"bXoooooooboooo#b\n"
"bXoooooobboooo#b\n"
"bXooooobbboooo#b\n"
"bXoooobbbboooo#b\n"
"bXoooobbbboooo#b\n"
"bXooooobbboooo#b\n"
"bXoooooobboooo#b\n"
"bXoooooooboooo#b\n"
"bXoooooooooooo#b\n"
"bXoooooooooooo#b\n"
"bo#############b\n"
"bbbbbbbbbbbbbbbb\n"
;
static char *rightArrowDownPalette =
"b #000000\n"
". #555555\n"
"X #777777\n"
"o #333399\n"
"O #6666CC\n"
"+ #888888\n"
"@ #999999\n"
"# #AAAAAA\n"
"$ #BBBBBB\n"
"% #9999FF\n"
"& #cccccc\n"
"* #DDDDDD\n"
"= #CCCCFF\n"
"- #EEEEEE\n"
"; #ffffff\n"
;
static char *rightArrowDownPixels =
"bbbbbbbbbbbbbbbb\n"
"b.............Xb\n"
"b.XXXXXXXXXXXX@b\n"
"b.XXXXXXXXXXXX@b\n"
"b.XXXXbXXXXXXX@b\n"
"b.XXXXbbXXXXXX@b\n"
"b.XXXXbbbXXXXX@b\n"
"b.XXXXbbbbXXXX@b\n"
"b.XXXXbbbbXXXX@b\n"
"b.XXXXbbbXXXXX@b\n"
"b.XXXXbbXXXXXX@b\n"
"b.XXXXbXXXXXXX@b\n"
"b.XXXXXXXXXXXX@b\n"
"b.XXXXXXXXXXXX@b\n"
"bX@@@@@@@@@@@@@b\n"
"bbbbbbbbbbbbbbbb\n"
;
static char *upArrowDownPalette =
"b #000000\n"
". #555555\n"
"X #777777\n"
"o #333399\n"
"O #6666CC\n"
"+ #888888\n"
"@ #999999\n"
"# #AAAAAA\n"
"$ #BBBBBB\n"
"% #9999FF\n"
"& #cccccc\n"
"* #DDDDDD\n"
"= #CCCCFF\n"
"- #EEEEEE\n"
"; #ffffff\n"
;
static char *upArrowDownPixels =
"bbbbbbbbbbbbbbbb\n"
"b.............Xb\n"
"b.XXXXXXXXXXXX@b\n"
"b.XXXXXXXXXXXX@b\n"
"b.XXXXXXXXXXXX@b\n"
"b.XXXXXXXXXXXX@b\n"
"b.XXXXXbbXXXXX@b\n"
"b.XXXXbbbbXXXX@b\n"
"b.XXXbbbbbbXXX@b\n"
"b.XXbbbbbbbbXX@b\n"
"b.XXXXXXXXXXXX@b\n"
"b.XXXXXXXXXXXX@b\n"
"b.XXXXXXXXXXXX@b\n"
"b.XXXXXXXXXXXX@b\n"
"bX@@@@@@@@@@@@@b\n"
"bbbbbbbbbbbbbbbb\n"
;

static char *downArrowDownPalette =
"b #000000\n"
". #555555\n"
"X #777777\n"
"o #333399\n"
"O #6666CC\n"
"+ #888888\n"
"@ #999999\n"
"# #AAAAAA\n"
"$ #BBBBBB\n"
"% #9999FF\n"
"& #cccccc\n"
"* #DDDDDD\n"
"= #CCCCFF\n"
"- #EEEEEE\n"
"; #ffffff\n"
;
static char *downArrowDownPixels =
"bbbbbbbbbbbbbbbb\n"
"b.............Xb\n"
"b.XXXXXXXXXXXX@b\n"
"b.XXXXXXXXXXXX@b\n"
"b.XXXXXXXXXXXX@b\n"
"b.XXXXXXXXXXXX@b\n"
"b.XXbbbbbbbbXX@b\n"
"b.XXXbbbbbbXXX@b\n"
"b.XXXXbbbbXXXX@b\n"
"b.XXXXXbbXXXXX@b\n"
"b.XXXXXXXXXXXX@b\n"
"b.XXXXXXXXXXXX@b\n"
"b.XXXXXXXXXXXX@b\n"
"b.XXXXXXXXXXXX@b\n"
"bX@@@@@@@@@@@@@b\n"
"bbbbbbbbbbbbbbbb\n"
;

static char *moveSelectionTopLeftPixels =
"bw\n"
"ww\n"
;
static char *moveSelectionTopPixels =
"bw\n"
"bw\n"
;
static char *moveSelectionLeftPixels =
"bb\n"
"ww\n"
;
static char *moveSelectionRightPixels =
"bw\n"
"wb\n"
;
static char *moveSelectionBottomPixels =
"bw\n"
"wb\n"
;
static char *resizeSelectionHorizontalPixels =
"bw\n"
;
static char *resizeSelectionVerticalPixels =
"b\n"
"w\n"
;

static id folderPalette =
@". #202040\n"
@"X #282850\n"
@"o #303060\n"
@"O #303068\n"
@"+ #383870\n"
@"@ #383878\n"
@"# #505050\n"
@"$ #585858\n"
@"% #606060\n"
@"& #686868\n"
@"* #707070\n"
@"= #787878\n"
@"- #404080\n"
@"; #404088\n"
@": #484888\n"
@"> #484890\n"
@", #484898\n"
@"< #505098\n"
@"1 #5050A0\n"
@"2 #5850A0\n"
@"3 #5858A0\n"
@"4 #5858A8\n"
@"5 #5858B0\n"
@"6 #6058B0\n"
@"7 #6060B0\n"
@"8 #6060B8\n"
@"9 #6868B8\n"
@"0 #6060C0\n"
@"q #6868C0\n"
@"w #6060C8\n"
@"e #7878D8\n"
@"r #7878E0\n"
@"t #8078E0\n"
@"y #808080\n"
@"u #888888\n"
@"i #909090\n"
@"p #989898\n"
@"a #A0A0A0\n"
@"s #b8b8b8\n"
@"d #8080E0\n"
@"f #8080E8\n"
@"g #8888E8\n"
@"h #8888F0\n"
@"j #9090F0\n"
@"k #9898F0\n"
@"l #9090F8\n"
@"z #9898F8\n"
@"x #A0A0F0\n"
@"c #A8A0F0\n"
@"v #A0A8F0\n"
@"b #A8A8F0\n"
@"n #A8A8F8\n"
@"m #B0A8F0\n"
@"M #A8B0F0\n"
@"N #B0B0F0\n"
@"B #B0B0F8\n"
@"V #B8B0F8\n"
@"C #B8B8F8\n"
@"Z #C0B8F8\n"
@"A #C8C8C8\n"
@"S #C8C8D0\n"
@"D #C8C8D8\n"
@"F #D0D0D0\n"
@"G #D8D8D8\n"
@"H #C0C0F8\n"
@"J #C8C0F8\n"
@"K #C8C8F8\n"
@"L #D0C8F8\n"
@"P #D0D0F8\n"
@"I #D8D8F8\n"
@"U #e0e0e0\n"
@"Y #e8e8e8\n"
@"T #E0E0F8\n"
@"R #F8F8F8\n"
;
static id folderPixels =
@"  41XD                          \n"
@"  1zq1oD                        \n"
@"84+fzzq1oD                      \n"
@"7Td,+fllq1oD                    \n"
@"7KKTd,@fllq1oD oooD             \n"
@"6LKKKId,@flhq1oqhq1oD           \n"
@"4KKKKKKId,@rhhqhfdhq1oD         \n"
@"4KKKKKJHHId,@rhgfddtf5o         \n"
@"4KKKKHHHHHHId,@qfddtre1D        \n"
@"3KKKHHHHHHHCCId,@qdtreqoD       \n"
@"2KKHHHHHHHCCCCCId,@qrre1o       \n"
@"1KHHHHHHHCCCCCCCBId,@qeq.       \n"
@"<HHHHHHHZCCCCCVBBBBId@q9.       \n"
@"<HHHHHZCCCCCCVBBBBBBNPo0.       \n"
@"<HHHHZZCCCCCVBBBBNBmbeo5.       \n"
@">HHHHCCCCCCVBBBBBBmbbeo5.       \n"
@">HHHZCCCCCVBBBBBBNbbbeo1.       \n"
@">HHCCCCCCCBBBBNNNnbbbeo,.       \n"
@":HZCCCCCCBBBBBNMbbbbbeo,.       \n"
@":ZCCCCCVBBBBBNNnbbbbbeo,.       \n"
@";ezCCCVBBBBBNNbbbbbbceo,.sFU    \n"
@"SO-ezCBBBBBNmbbbbbbvxeo,.*isFU  \n"
@"  SO-ezBBBBmbbbbbbxxxeo,.$&*isFY\n"
@"    SO-ezBBnbbbbbxxxxeo,.#$%*uaF\n"
@"      SO-ezbbbbbxxxxxeo,.##$%*yA\n"
@"        SO-ezbbbxxxxxeo,.##$&=pA\n"
@"          SO-ejxxxxxxeo,.#$%*ysU\n"
@"            SO-ejxxxkeo,.$%*ysG \n"
@"              SO-ejkkeo,.&*ysG  \n"
@"                SO-qeeo,.*ysG   \n"
@"                  SO-wo,.ysG    \n"
@"                    So..*sU     \n"
;
static id selectedFolderPalette = 
@". #101020\n"
@"X #101028\n"
@"o #181830\n"
@"O #181838\n"
@"+ #202040\n"
@"@ #202048\n"
@"# #282848\n"
@"$ #282850\n"
@"% #282858\n"
@"& #302858\n"
@"* #303058\n"
@"= #303060\n"
@"- #383868\n"
@"; #383870\n"
@": #403870\n"
@"> #484848\n"
@", #505050\n"
@"< #585858\n"
@"1 #404070\n"
@"2 #404078\n"
@"3 #484878\n"
@"4 #505078\n"
@"5 #585078\n"
@"6 #505878\n"
@"7 #585878\n"
@"8 #605878\n"
@"9 #606060\n"
@"0 #686868\n"
@"q #606078\n"
@"w #686078\n"
@"e #686878\n"
@"r #707070\n"
@"t #707078\n"
@"y #787878\n"
@"u #808080\n"
@"i #888888\n"
@"p #909090\n"
@"a #A0A0A0\n"
@"s #b0b0b0\n"
@"d #C0C0C0\n"
@"f #C0C0C8\n"
@"g #C8C8C8\n"
@"h #D0D0D0\n"
@"j #D8D8D8\n"
@"k #e0e0e0\n"
@"l #e8e8e8\n"
@"z #F8F8F8\n"
;
static id selectedFolderPixels =
@"  $$Xf                          \n"
@"  $3=$of                        \n"
@"*$O133=$of                      \n"
@"*t1@O133=$of                    \n"
@"*qqt1@O133=$of ooof             \n"
@"&wqqqe1@O132=$o=2=$of           \n"
@"$qqqqqqe1@O;22=2112=$of         \n"
@"$qqqqqqqqe1@O;21111:1%o         \n"
@"$qqqqqqqqqqe1@O=111:;-$f        \n"
@"$qqqqqqqqqq77e1@O=1:;-=of       \n"
@"$qqqqqqqqq77777e1@O=;;-$o       \n"
@"$qqqqqqqq77777777e1@O=-=.       \n"
@"#qqqqqqq87777777777e1O=*.       \n"
@"#qqqqq877777777777777eo=.       \n"
@"#qqqq8877777777777754-o%.       \n"
@"@qqqq7777777777777544-o%.       \n"
@"@qqq87777777777777444-o$.       \n"
@"@qq777777777777774444-o@.       \n"
@"+q8777777777777644444-o@.       \n"
@"+87777777777777444444-o@.       \n"
@"+-3777777777774444444-o@.shk    \n"
@"fo+-37777777544444444-o@.0ishk  \n"
@"  fo+-377775444444444-o@.,<0ishl\n"
@"    fo+-3774444444444-o@.>,<9uah\n"
@"      fo+-34444444444-o@.>>,<9yd\n"
@"        fo+-344444444-o@.>>,<rpg\n"
@"          fo+-3444444-o@.>,<9ysk\n"
@"            fo+-34443-o@.,<0ysj \n"
@"              fo+-333-o@.<0ysj  \n"
@"                fo+=--o@.0ysj   \n"
@"                  fo+=o@.ysj    \n"
@"                    fo..0sk     \n"
;



static id documentPalette =
@"b #000000\n"
@". #080000\n"
@"X #080808\n"
@"o #080810\n"
@"O #101010\n"
@"+ #181818\n"
@"@ #182020\n"
@"# #202020\n"
@"$ #202820\n"
@"% #202028\n"
@"& #282828\n"
@"* #302828\n"
@"= #283028\n"
@"- #303030\n"
@"; #383838\n"
@": #404040\n"
@"> #404048\n"
@", #404848\n"
@"< #484848\n"
@"1 #485050\n"
@"2 #505050\n"
@"3 #505058\n"
@"4 #585858\n"
@"5 #606060\n"
@"6 #706868\n"
@"7 #707070\n"
@"8 #787878\n"
@"9 #787880\n"
@"0 #808080\n"
@"q #888888\n"
@"w #909090\n"
@"e #989898\n"
@"r #A0A0A0\n"
@"t #a8a8a8\n"
@"y #b0b0b0\n"
@"u #b8b8b8\n"
@"i #C0C0C0\n"
@"p #D0D0D0\n"
@"a #D8D8D8\n"
@"s #e0e0e0\n"
@"d #e8e8e8\n"
@"f #f0f0f0\n"
@"g #F8F8F8\n"
;
static id documentPixels =
@"54444222<<<<:::;;;;s            \n"
@"4ggggggfffffddddds:2s           \n"
@"4ggggggfffffddddds>i4s          \n"
@"4ggggggfffffddddds<fu5s         \n"
@"4ggggggfffffddddds2gsy4s        \n"
@"4ggggggfffffddddds2ggat2s       \n"
@"3ggggggfffffddddds2<<:;-*       \n"
@"2ggggggfffffdddddsp09876&       \n"
@"2ggggggfffffdddddssuytte&       \n"
@"2ggggggfffffdddddsssssae&       \n"
@"2ggggggfffffdddddsssssae%       \n"
@"1ggggggfffffdddddsssssae#       \n"
@"<ggggggfffffdddddsssssae#       \n"
@"<ggggggfffffdddddsssssar#       \n"
@"<ggggggfffffdddddsssssar#       \n"
@"<ggggggfffffdddddsssssar+       \n"
@",ggggggfffffdddddsssssar+       \n"
@":ggggggfffffdddddsssssar+       \n"
@":ggggggfffffdddddsssssat+       \n"
@":ggggggfffffdddddsssssatO       \n"
@":ggggggfffffdddddsssssatO       \n"
@":ggggggfffffdddddsssssatO       \n"
@";ggggggfffffdddddsssssatO       \n"
@";ggggggfffffdddddsssssato       \n"
@";ggggggfffffdddddsssssayX       \n"
@";ggggggfffffdddddsssssayX       \n"
@";ggggggfffffdddddsssssayXad     \n"
@"-ggggggfffffdddddsssssay.ruad   \n"
@"-ggggggfffffdddddsssssaybqruiad \n"
@"-ggggggfffffdddddsssssaub8qrtusf\n"
@"-ggggggfffffdddddsssssaub88wris \n"
@"-=&&&$###@++++OOOOXXXXXbb80euaf \n"
;
static id selectedDocumentPalette =
@"b #000000\n"
@". #000008\n"
@"X #080808\n"
@"o #081010\n"
@"O #101010\n"
@"+ #181010\n"
@"@ #101810\n"
@"# #181818\n"
@"$ #202020\n"
@"% #202828\n"
@"& #282828\n"
@"* #303030\n"
@"= #383030\n"
@"- #383838\n"
@"; #383840\n"
@": #404040\n"
@"> #484848\n"
@", #505050\n"
@"< #585858\n"
@"1 #606060\n"
@"2 #686868\n"
@"3 #707070\n"
@"4 #787878\n"
@"5 #888888\n"
@"6 #909090\n"
@"7 #989898\n"
@"8 #A0A0A0\n"
@"9 #b0b0b0\n"
@"0 #b8b8b8\n"
@"q #D0D0D0\n"
@"w #D8D8D8\n"
@"e #e0e0e0\n"
@"r #e8e8e8\n"
@"t #f0f0f0\n"
@"y #F8F8F8\n"
;
static id selectedDocumentPixels =
@"*&&&&&&&$$$$$$$####e            \n"
@"&44444444444333333$&e           \n"
@"&44444444444333333$1&e          \n"
@"&44444444444333333$4<*e         \n"
@"&44444444444333333&43<&e        \n"
@"&44444444444333333&442,&e       \n"
@"&44444444444333333&$$$##+       \n"
@"&444444444443333332:;--=O       \n"
@"&444444444443333333<<,,>O       \n"
@"&4444444444433333333332>O       \n"
@"&4444444444433333333332>O       \n"
@"%4444444444433333333332>O       \n"
@"$4444444444433333333332>O       \n"
@"$4444444444433333333332,O       \n"
@"$4444444444433333333332,O       \n"
@"$4444444444433333333332,X       \n"
@"$4444444444433333333332,X       \n"
@"$4444444444433333333332,X       \n"
@"$4444444444433333333332,X       \n"
@"$4444444444433333333332,X       \n"
@"$4444444444433333333332,X       \n"
@"$4444444444433333333332,X       \n"
@"#4444444444433333333332,X       \n"
@"#4444444444433333333332,.       \n"
@"#4444444444433333333332<b       \n"
@"#4444444444433333333332<b       \n"
@"#4444444444433333333332<bqr     \n"
@"#4444444444433333333332<b69qr   \n"
@"#4444444444433333333332<b3690qr \n"
@"#4444444444433333333332<b23689wt\n"
@"#4444444444433333333332<b11470e \n"
@"#@OOOOOOOoXXXXXXXXbbbbbbb1359qt \n"
;
static id readmePalette =
@"b #000000\n"
@". #707070\n"
@"X #888888\n"
@"o #e8e8e8\n"
@"O #F8F8F8\n"
;
static id readmePixels =
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
@"boooooooooooooooooooooooooooob \n"
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
@"booooooooooooooooooooooooooooob\n"
@" bbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
;
static id selectedReadmePalette =
@"b #000000\n"
@". #383838\n"
@"X #404040\n"
@"o #707070\n"
@"O #787878\n"
@"+ #F8F8F8\n"
;
static id selectedReadmePixels =
@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
@"boooooooooooooooooooooooooooob \n"
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
@"booooooooooooooooooooooooooooob\n"
@" bbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
;

@implementation Definitions(hkukgfdfthfnvbchjgfjygikghjghfjgfjdksfjksdkdjkfsdkjfjdksfjkfj)
+ (id)MacPlatinumDir
{
    id obj = [@"MacPlatinumDir" asInstance];
    [obj setValue:[@"." asRealPath] forKey:@"title"];
    [obj updateDiskFreeText];
    return obj;
}
@end

@interface MacPlatinumDir : IvarObject
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
    Int4 _shadeButtonRect;
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
    id _diskFreeText;

    int _disableHorizontalScrollBar;
    int _disableVerticalScrollBar;

    id _selectionBox;
    int _selectionBoxRootX;
    int _selectionBoxRootY;
}
@end
@implementation MacPlatinumDir
- (int *)x11WindowMaskPointsForWidth:(int)w height:(int)h
{
    static int points[9];
    points[0] = 9; // length of array including this number

    points[1] = 0; // lower left corner
    points[2] = h-1;
    points[3] = 1;
    points[4] = h-1;

    points[5] = w-1; // upper right corner
    points[6] = 0;
    points[7] = w-1;
    points[8] = 1;
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
            
    id str = nil;
    if (available >= 1024*1024) {
        str = nsfmt(@"%.1f GB available", (double)available / (1024.0*1024.0));
    } else if (available >= 1024) {
        str = nsfmt(@"%.1f MB available", (double)available / 1024.0);
    } else {
        str = nsfmt(@"%d KB available", available);
    }
    [self setValue:str forKey:@"diskFreeText"];
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
    [bitmap useGenevaFont];
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
                selectedPixels = selectedReadmePixels;
            } else {
                palette = documentPalette;
                pixels = documentPixels;
                selectedPalette = selectedDocumentPalette;
                selectedPixels = selectedDocumentPixels;
            }
        } else if ([fileType isEqual:@"directory"]) {
            palette = folderPalette;
            pixels = folderPixels;
            selectedPalette = selectedFolderPalette;
            selectedPixels = selectedFolderPixels;
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

    _titleBarRect = [Definitions rectWithX:0/*r.x*/ y:0/*r.y*/ w:r.w h:_titleBarHeight];
    _titleBarTextRect = _titleBarRect;
    _titleBarTextRect.x = 21 + 4;
    _titleBarTextRect.w -= (21+4)*2;

    _closeButtonRect.x = 4;
    _closeButtonRect.y = 4;
    _closeButtonRect.w = 13;
    _closeButtonRect.h = 13;

    _shadeButtonRect.x = r.w-18;
    _shadeButtonRect.y = 4;
    _shadeButtonRect.w = 13;
    _shadeButtonRect.h = 13;

    _maximizeButtonRect.x = r.w-18-3-13;
    _maximizeButtonRect.y = 4;
    _maximizeButtonRect.w = 13;
    _maximizeButtonRect.h = 13;

    _leftArrowRect.x = 5;
    _leftArrowRect.y = r.h-22;
    _leftArrowRect.w = 16;
    _leftArrowRect.h = 16;
    _rightArrowRect.x = r.w-22-15;
    _rightArrowRect.y = r.h-22;
    _rightArrowRect.w = 16;
    _rightArrowRect.h = 16;
    _upArrowRect.x = r.w-22;
    _upArrowRect.y = _titleBarHeight+20;
    _upArrowRect.w = 16;
    _upArrowRect.h = 16;
    _downArrowRect.x = r.w-22;
    _downArrowRect.y = r.h-22-15;
    _downArrowRect.w = 16;
    _downArrowRect.h = 16;

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
    _contentYMax += _titleBarHeight + 20 + 17 + 20;
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
    _horizontalKnobX = 21;
    _horizontalKnobW = 15;
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
    _verticalKnobY = 22 + 21 + 15;
    _verticalKnobH = 15;
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
    [bitmap useGenevaFont];
    [bitmap setColor:@"white"];
    [bitmap fillRect:r];
    [bitmap setColor:@"black"];
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        int x = -_visibleX + [elt intValueForKey:@"x"];
        int y = -_visibleY + [elt intValueForKey:@"y"] + _titleBarHeight + 20;
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
        char *leftPalette = [Definitions cStringForMacPlatinumActiveTitleBarLeftPalette];
        char *leftPixels = [Definitions cStringForMacPlatinumActiveTitleBarLeftPixels];
        char *middlePalette = [Definitions cStringForMacPlatinumActiveTitleBarMiddlePalette];
        char *middlePixels = [Definitions cStringForMacPlatinumActiveTitleBarMiddlePixels];
        char *rightPalette = [Definitions cStringForMacPlatinumActiveTitleBarRightPalette];
        char *rightPixels = [Definitions cStringForMacPlatinumActiveTitleBarRightPixels];
        [Definitions drawInBitmap:bitmap left:leftPixels palette:leftPalette middle:middlePixels palette:middlePalette right:rightPixels palette:rightPalette x:_titleBarRect.x y:_titleBarRect.y w:_titleBarRect.w];

        if ([_buttonDown isEqual:@"closeButton"] && [_buttonHover isEqual:@"closeButton"]) {
            char *palette = [Definitions cStringForMacPlatinumCloseButtonDownPalette];
            char *pixels = [Definitions cStringForMacPlatinumCloseButtonDownPixels];
            [bitmap drawCString:pixels palette:palette x:_closeButtonRect.x y:_closeButtonRect.y];
        }
        if ([_buttonDown isEqual:@"shadeButton"] && [_buttonHover isEqual:@"shadeButton"]) {
            char *palette = [Definitions cStringForMacPlatinumShadeButtonDownPalette];
            char *pixels = [Definitions cStringForMacPlatinumShadeButtonDownPixels];
            [bitmap drawCString:pixels palette:palette x:_shadeButtonRect.x y:_shadeButtonRect.y];
        }
        if ([_buttonDown isEqual:@"maximizeButton"] && [_buttonHover isEqual:@"maximizeButton"]) {
            char *palette = [Definitions cStringForMacPlatinumMaximizeButtonDownPalette];
            char *pixels = [Definitions cStringForMacPlatinumMaximizeButtonDownPixels];
            [bitmap drawCString:pixels palette:palette x:_maximizeButtonRect.x y:_maximizeButtonRect.y];
        }
    } else {
        char *leftPalette = [Definitions cStringForMacPlatinumInactiveTitleBarLeftPalette];
        char *leftPixels = [Definitions cStringForMacPlatinumInactiveTitleBarLeftPixels];
        char *middlePalette = [Definitions cStringForMacPlatinumInactiveTitleBarMiddlePalette];
        char *middlePixels = [Definitions cStringForMacPlatinumInactiveTitleBarMiddlePixels];
        char *rightPalette = [Definitions cStringForMacPlatinumInactiveTitleBarRightPalette];
        char *rightPixels = [Definitions cStringForMacPlatinumInactiveTitleBarRightPixels];
        [Definitions drawInBitmap:bitmap left:leftPixels palette:leftPalette middle:middlePixels palette:middlePalette right:rightPixels palette:rightPalette x:_titleBarRect.x y:_titleBarRect.y w:_titleBarRect.w];
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
                char *palette = [Definitions cStringForMacPlatinumActiveTitleBarRightPalette];
                char *titleTextLeft = [Definitions cStringForMacPlatinumActiveTitleBarTextLeftPixels];
                char *titleTextRight = [Definitions cStringForMacPlatinumActiveTitleBarTextRightPixels];
                [bitmap setColor:@"#ccccccff"];
                [bitmap fillRect:[Definitions rectWithX:backX y:_titleBarTextRect.y+2 w:backWidth h:16]];
                [bitmap drawCString:titleTextLeft palette:palette x:backX y:_titleBarTextRect.y];
                [bitmap drawCString:titleTextRight palette:palette x:backX+backWidth-1 y:_titleBarTextRect.y];
                [bitmap setColorIntR:0 g:0 b:0 a:255];
                [bitmap drawBitmapText:text x:textX y:_titleBarTextRect.y+4];
            } else {
                [bitmap setColorIntR:0x77 g:0x77 b:0x77 a:255];
                [bitmap drawBitmapText:text x:textX y:_titleBarTextRect.y+4];
            }
        }

        [bitmap useGenevaFont];
    }

    int infoBarHeight = 21;
    if (infoBarHeight) {
        if (hasFocus) {
            [Definitions drawInBitmap:bitmap left:activeInfoBarLeftPixels palette:activeInfoBarLeftPalette middle:activeInfoBarMiddlePixels palette:activeInfoBarLeftPalette right:activeInfoBarRightPixels palette:activeInfoBarRightPalette x:r.x y:r.y+_titleBarHeight w:r.w];
        } else {
            [Definitions drawInBitmap:bitmap left:inactiveInfoBarLeftPixels palette:inactiveInfoBarLeftPalette middle:inactiveInfoBarMiddlePixels palette:inactiveInfoBarLeftPalette right:inactiveInfoBarRightPixels palette:inactiveInfoBarRightPalette x:r.x y:r.y+_titleBarHeight w:r.w];
        }
        id text = nil;
        if (_numberOfItemsText && _diskFreeText) {
            text = nsfmt(@"%@, %@", _numberOfItemsText, _diskFreeText);
        } else if (_numberOfItemsText) {
            text = _numberOfItemsText;
        } else if (_diskFreeText) {
            text = _diskFreeText;
        }
        if (text) {
            [bitmap useGenevaFont];
            if (hasFocus) {
                [bitmap setColorIntR:0 g:0 b:0 a:255];
            } else {
                [bitmap setColor:@"#777777"];
            }
            int textWidth = [bitmap bitmapWidthForText:text];
            [bitmap drawBitmapText:text x:r.x+(r.w-textWidth)/2 y:r.y+_titleBarHeight+5];
        }

    }

    {
        char *middle = [Definitions cStringForMacPlatinumActiveLeftBorderPixels];
        if (hasFocus) {
            char *palette = [Definitions cStringForMacPlatinumActiveLeftBorderPalette];
            [Definitions drawInBitmap:bitmap top:middle palette:palette middle:middle palette:palette bottom:middle palette:palette x:r.x y:r.y+_titleBarHeight+infoBarHeight h:r.h-_titleBarHeight-infoBarHeight-17];
        } else {
            char *palette = [Definitions cStringForMacPlatinumInactiveLeftBorderPalette];
            [Definitions drawInBitmap:bitmap top:middle palette:palette middle:middle palette:palette bottom:middle palette:palette x:r.x y:r.y+_titleBarHeight+infoBarHeight h:r.h-_titleBarHeight-infoBarHeight-17];
        }
    }
    {
        char *topPixels = activeRightBorderTopPixels;
        char *middlePixels = activeRightBorderMiddlePixels;
        char *bottomPixels = activeRightBorderBottomPixels;
        char *topPalette = activeRightBorderTopPalette;
        char *middlePalette = activeRightBorderTopPalette;
        char *bottomPalette = activeRightBorderBottomPalette;
        if (hasFocus) {
            if (_disableVerticalScrollBar) {
                topPixels = disabledRightBorderTopPixels;
                topPalette = disabledRightBorderTopPalette;
                middlePixels = disabledRightBorderMiddlePixels;
                middlePalette = disabledRightBorderTopPalette;
                bottomPixels = disabledRightBorderBottomPixels;
                bottomPalette = disabledRightBorderBottomPalette;
            }
        } else {
            topPixels = inactiveRightBorderMiddlePixels;
            middlePixels = inactiveRightBorderMiddlePixels;
            bottomPixels = inactiveRightBorderMiddlePixels;
            topPalette = inactiveRightBorderPalette;
            middlePalette = inactiveRightBorderPalette;
            bottomPalette = inactiveRightBorderPalette;
        }
        [Definitions drawInBitmap:bitmap top:topPixels palette:topPalette middle:middlePixels palette:middlePalette bottom:bottomPixels palette:bottomPalette x:r.x+r.w-22 y:r.y+_titleBarHeight+infoBarHeight h:r.h-_titleBarHeight-infoBarHeight-22];

        if (hasFocus && !_disableVerticalScrollBar) {
            if ([_buttonDown isEqual:@"verticalKnob"]) {
                [bitmap drawCString:verticalKnobDownPixels palette:verticalKnobDownPalette x:r.x+r.w-22 y:-1+_verticalKnobY+_verticalKnobVal];
            } else {
                [bitmap drawCString:verticalKnobPixels palette:verticalKnobPalette x:r.x+r.w-22 y:-1+_verticalKnobY+_verticalKnobVal];
            }
            if (_verticalKnobVal < _verticalKnobMaxVal - 2) {
                [bitmap drawCString:activeRightBorderShadow1Pixels palette:activeRightBorderTopPalette x:r.x+r.w-22 y:-1+_verticalKnobY+_verticalKnobVal+16];
                [bitmap drawCString:activeRightBorderShadow2Pixels palette:activeRightBorderTopPalette x:r.x+r.w-22 y:-1+_verticalKnobY+_verticalKnobVal+17];
            } else if (_verticalKnobVal == _verticalKnobMaxVal - 2) {
                [bitmap drawCString:activeRightBorderShadow1Pixels palette:activeRightBorderTopPalette x:r.x+r.w-22 y:-1+_verticalKnobY+_verticalKnobVal+16];
            }
            if ([_buttonDown isEqual:@"upArrow"] && [_buttonHover isEqual:@"upArrow"]) {
                [bitmap drawCString:upArrowDownPixels palette:upArrowDownPalette x:_upArrowRect.x y:_upArrowRect.y];
            } else if ([_buttonDown isEqual:@"downArrow"] && [_buttonHover isEqual:@"downArrow"]) {
                [bitmap drawCString:downArrowDownPixels palette:downArrowDownPalette x:_downArrowRect.x y:_downArrowRect.y];
            }
        }
    }

    {
        char *leftPixels = activeBottomBorderLeftPixels;
        char *middlePixels = activeBottomBorderMiddlePixels;
        char *rightPixels = activeBottomBorderRightPixels;
        char *leftPalette = activeBottomBorderLeftPalette;
        char *middlePalette = activeBottomBorderLeftPalette;
        char *rightPalette = activeBottomBorderRightPalette;
        if (hasFocus) {
            if (_disableHorizontalScrollBar) {
                leftPixels = disabledBottomBorderLeftPixels;
                middlePixels = disabledBottomBorderMiddlePixels;
                rightPixels = disabledBottomBorderRightPixels;
                leftPalette = disabledBottomBorderLeftPalette;
                middlePalette = disabledBottomBorderLeftPalette;
                rightPalette = disabledBottomBorderRightPalette;
            }
        } else {
            leftPixels = inactiveBottomBorderLeftPixels;
            leftPalette = inactiveBottomBorderPalette;
            middlePixels = inactiveBottomBorderMiddlePixels;
            middlePalette = inactiveBottomBorderPalette;
            rightPixels = inactiveBottomBorderRightPixels;
            rightPalette = inactiveBottomBorderPalette;
        }
        [Definitions drawInBitmap:bitmap left:leftPixels palette:leftPalette middle:middlePixels palette:middlePalette right:rightPixels palette:rightPalette x:r.x y:r.y+r.h-22 w:r.w];

        if (hasFocus && !_disableHorizontalScrollBar) { 
            if ([_buttonDown isEqual:@"horizontalKnob"]) {
                [bitmap drawCString:horizontalKnobDownPixels palette:horizontalKnobDownPalette x:-1+_horizontalKnobX+_horizontalKnobVal y:r.y+r.h-22];
            } else {
                [bitmap drawCString:horizontalKnobPixels palette:horizontalKnobPalette x:-1+_horizontalKnobX+_horizontalKnobVal y:r.y+r.h-22];
            }
            if (_horizontalKnobVal < _horizontalKnobMaxVal - 2) {
                [bitmap drawCString:activeBottomBorderShadow1Pixels palette:activeBottomBorderLeftPalette x:-1+_horizontalKnobX+_horizontalKnobVal+16 y:r.y+r.h-22];
                [bitmap drawCString:activeBottomBorderShadow2Pixels palette:activeBottomBorderLeftPalette x:-1+_horizontalKnobX+_horizontalKnobVal+17 y:r.y+r.h-22];
            } else if (_horizontalKnobVal == _horizontalKnobMaxVal - 2) {
                [bitmap drawCString:activeBottomBorderShadow1Pixels palette:activeBottomBorderLeftPalette x:-1+_horizontalKnobX+_horizontalKnobVal+16 y:r.y+r.h-22];
            }
            if ([_buttonDown isEqual:@"leftArrow"] && [_buttonHover isEqual:@"leftArrow"]) {
                [bitmap drawCString:leftArrowDownPixels palette:leftArrowDownPalette x:_leftArrowRect.x y:_leftArrowRect.y];
            } else if ([_buttonDown isEqual:@"rightArrow"] && [_buttonHover isEqual:@"rightArrow"]) {
                [bitmap drawCString:rightArrowDownPixels palette:rightArrowDownPalette x:_rightArrowRect.x y:_rightArrowRect.y];
            }
        }
    }




    if (hasFocus) {
        char *palette = "b #000000\nw #ffffff\n";
        if ([_buttonDown isEqual:@"titleBar"]) {
            char *palette = "b #000000\nw #ffffff\n";
            char *topLeft = moveSelectionTopLeftPixels;
            char *top = moveSelectionTopPixels;
            char *left = moveSelectionLeftPixels;
            char *right = moveSelectionRightPixels;
            char *bottom = moveSelectionBottomPixels;
            [Definitions drawInBitmap:bitmap left:topLeft middle:top right:right x:r.x y:r.y w:r.w palette:palette];
            [Definitions drawInBitmap:bitmap top:left palette:palette middle:left palette:palette bottom:bottom palette:palette x:r.x y:r.y+2 h:r.h-4];
            [Definitions drawInBitmap:bitmap top:right palette:palette middle:right palette:palette bottom:right palette:palette x:r.x+r.w-2 y:r.y+2 h:r.h-4];
            [Definitions drawInBitmap:bitmap left:bottom middle:bottom right:bottom x:r.x y:r.y+r.h-2 w:r.w palette:palette];
        } else if ([_buttonDown isEqual:@"resizeButton"]) {
            int leftBorder = 6;
            int rightBorder = 6+1;
            int topBorder = 22;
            int bottomBorder = 6+1;
            char *palette = "b #000000\nw #ffffff\n";
            char *h = resizeSelectionHorizontalPixels;
            char *v = resizeSelectionVerticalPixels;
            [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x y:r.y w:r.w palette:palette];
            [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x y:r.y+1 h:r.h-2];
            [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x+r.w-1 y:r.y+1 h:r.h-2];
            [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x y:r.y+r.h-1 w:r.w palette:palette];

            [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x+leftBorder-1 y:r.y+topBorder-1 w:r.w-(leftBorder-1)-(leftBorder-1) palette:palette];
            [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x+leftBorder-1 y:r.y+topBorder-1 h:r.h-(topBorder-1)-5];
            [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x+r.w-7 y:r.y+topBorder-1 h:r.h-(topBorder-1)-(bottomBorder+15-1)];
            [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x+leftBorder-1 y:r.y+r.h-7 w:r.w-(leftBorder-1)-(rightBorder+15-1) palette:palette];

            [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x+r.w-(rightBorder+15) y:r.y+r.h-(bottomBorder+15) h:bottomBorder+15-5];
            [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x+r.w-(rightBorder+15) y:r.y+r.h-(bottomBorder+15) w:bottomBorder+15-5 palette:palette];
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
    if ([Definitions isX:mouseX y:mouseY insideRect:_shadeButtonRect]) {
        [self setValue:@"shadeButton" forKey:@"buttonDown"];
        [self setValue:@"shadeButton" forKey:@"buttonHover"];
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
        int y = -_visibleY + [elt intValueForKey:@"y"] + _titleBarHeight + 20;
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
                        [cmd addObject:@"macplatinumdir"];
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
    } else if ([_buttonDown isEqual:@"shadeButton"]) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_shadeButtonRect]) {
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

        int contentWidth = _contentXMax - _contentXMin - _visibleW;
        double pct = 0.0;
        if (_horizontalKnobMaxVal) {
            pct = (double)_horizontalKnobVal / (double)_horizontalKnobMaxVal;
        }
        _visibleX = _contentXMin + contentWidth*pct;
    } else if ([_buttonDown isEqual:@"verticalKnob"]) {
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
        [_buttonDown setValue:nsfmt(@"%d", mouseY - _buttonDownOffsetY + _visibleY - _titleBarHeight - 20) forKey:@"y"];
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

