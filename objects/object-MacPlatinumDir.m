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




@implementation Definitions(hkukgfdfthfnvbchjgfjygikghjghfjgfjdksfjksdkdjkfsdkjfjdksfjkfj)
+ (id)MacPlatinumDir:(id)path
{
    id obj = [@"MacPlatinumDir" asInstance];
    [obj setValue:path forKey:@"path"];
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

    id _dragX11Dict;

    id _path;
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
    if ([_path isDirectory]) {
        chdir([_path UTF8String]);
    }

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
- (void)updateDirectory:(Int4)r
{
    if ([_path isDirectory]) {
        chdir([_path UTF8String]);
    }

    id bitmap = [Definitions bitmapWithWidth:1 height:1];
    [bitmap useGenevaFont];
    id arr = [@"." contentsOfDirectory];
    arr = [arr asFileArray];
    int x = 40;
    int y = 5;
    for (int i=0; i<[arr count]; i++) {
        id elt = [arr nth:i];
        id object = nil;
        id filePath = [elt valueForKey:@"filePath"];
        id fileType = [elt valueForKey:@"fileType"];
        if ([fileType isEqual:@"file"]) {
            if ([[filePath lowercaseString] hasSuffix:@".txt"]) {
                object = [@"MacPlatinumReadmeIcon" asInstance];
            } else {
                object = [@"MacPlatinumDocumentIcon" asInstance];
            }
        } else if ([fileType isEqual:@"directory"]) {
            object = [@"MacPlatinumFolderIcon" asInstance];
        }
        if (!object) {
            continue;
        }
        [object setValue:filePath forKey:@"path"];
        [elt setValue:object forKey:@"object"];
        int w = 16;
        if ([object respondsToSelector:@selector(preferredWidth)]) {
            w = [object preferredWidth];
        }
        int h = 16;
        if ([object respondsToSelector:@selector(preferredHeight)]) {
            h = [object preferredHeight];
        }
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
    time_t timestamp = [_path fileModificationTimestamp];
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
        _timestamp = [_path fileModificationTimestamp];
        [self updateDirectory:r];
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
        id object = [elt valueForKey:@"object"];
        if ([elt intValueForKey:@"isSelected"]) {
            Int4 r1;
            r1.x = r.x+x;
            r1.y = r.y+y;
            r1.w = w;
            r1.h = h;
            if ([object respondsToSelector:@selector(drawInBitmap:rect:context:)]) {
                id dict = nsdict();
                [dict setValue:@"1" forKey:@"isSelected"];
                [object drawInBitmap:bitmap rect:r1 context:dict];
            }
        } else {
            Int4 r1;
            r1.x = r.x+x;
            r1.y = r.y+y;
            r1.w = w;
            r1.h = h;
            if ([object respondsToSelector:@selector(drawInBitmap:rect:context:)]) {
                [object drawInBitmap:bitmap rect:r1 context:nil];
            }
        }
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
        id text = _path;
        if (!text) {
            text = _title;
            if (!text) {
                text = @"(no title)";
            }
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
            if (![elt intValueForKey:@"isSelected"]) {
                for (int j=0; j<[_array count]; j++) {
                    id jelt = [_array nth:j];
                    [jelt setValue:nil forKey:@"isSelected"];
                }
                [elt setValue:@"1" forKey:@"isSelected"];
            }
            _buttonDownOffsetX = mouseX - x;
            _buttonDownOffsetY = mouseY - y;
            struct timeval tv;
            gettimeofday(&tv, NULL);
            id timestamp = nsfmt(@"%ld.%06ld", tv.tv_sec, tv.tv_usec);
            if (_buttonDownTimestamp && ([timestamp doubleValue] - [_buttonDownTimestamp doubleValue] <= 0.3)) {
                if ([_path isDirectory]) {
                    chdir([_path UTF8String]);
                }

                id filePath = [elt valueForKey:@"filePath"];
                if ([filePath length]) {
                    if ([filePath isDirectory]) {
                        [Definitions openMacPlatinumDirForPath:filePath];
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

            unsigned long win = [[_selectionBox valueForKey:@"window"] unsignedLongValue];
            if (win) {
                [windowManager XRaiseWindow:win];
            }
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
        id x11dict = [event valueForKey:@"x11dict"];
        int mouseRootX = [event intValueForKey:@"mouseRootX"];
        int mouseRootY = [event intValueForKey:@"mouseRootY"];

        if (!_dragX11Dict) {

            int selectedCount = 0;
            int minX = 0;
            int minY = 0;
            int maxX = 0;
            int maxY = 0;
            for (int i=0; i<[_array count]; i++) {
                id elt = [_array nth:i];
                if (![elt intValueForKey:@"isSelected"]) {
                    continue;
                }
                int x = [elt intValueForKey:@"x"];
                int y = [elt intValueForKey:@"y"];
                int w = [elt intValueForKey:@"w"];
                int h = [elt intValueForKey:@"h"];
                if (!selectedCount) {
                    minX = x;
                    minY = y;
                    maxX = x+w-1;
                    maxY = y+h-1;
                } else {
                    if (x < minX) {
                        minX = x;
                    }
                    if (y < minY) {
                        minY = y;
                    }
                    if (x+w-1 > maxX) {
                        maxX = x+w-1;
                    }
                    if (y+h-1 > maxY) {
                        maxY = y+h-1;
                    }
                }
                selectedCount++;
            }
            int selectionWidth = maxX - minX + 1;
            int selectionHeight = maxY - minY + 1;

            id bitmap = [Definitions bitmapWithWidth:selectionWidth height:selectionHeight];
            id context = nsdict();
            [context setValue:@"1" forKey:@"isSelected"];
            for (int i=0; i<[_array count]; i++) {
                id elt = [_array nth:i];
                if (![elt intValueForKey:@"isSelected"]) {
                    continue;
                }
                int x = [elt intValueForKey:@"x"];
                int y = [elt intValueForKey:@"y"];
                int w = [elt intValueForKey:@"w"];
                int h = [elt intValueForKey:@"h"];
                id object = [elt valueForKey:@"object"];
                Int4 r;
                r.x = x - minX;
                r.y = y - minY;
                r.w = w;
                r.h = h;
                if ([object respondsToSelector:@selector(drawInBitmap:rect:context:)]) {
                    [object drawInBitmap:bitmap rect:r context:context];
                }
            }

            int x = [_buttonDown intValueForKey:@"x"] + _buttonDownOffsetX - minX;
            int y = [_buttonDown intValueForKey:@"y"] + _buttonDownOffsetY - minY;
            _buttonDownOffsetX = x;
            _buttonDownOffsetY = y;

            id selectionBitmap = [@"SelectionBitmap" asInstance];
            [selectionBitmap setValue:bitmap forKey:@"bitmap"];
            id windowManager = [event valueForKey:@"windowManager"];
            id newx11dict = [windowManager openWindowForObject:selectionBitmap x:mouseRootX - _buttonDownOffsetX y:mouseRootY - _buttonDownOffsetY w:selectionWidth h:selectionHeight overrideRedirect:YES];
            [self setValue:newx11dict forKey:@"dragX11Dict"];
        } else {

            int newX = mouseRootX - _buttonDownOffsetX;
            int newY = mouseRootY - _buttonDownOffsetY;

            [_dragX11Dict setValue:nsfmt(@"%d", newX) forKey:@"x"];
            [_dragX11Dict setValue:nsfmt(@"%d", newY) forKey:@"y"];

            [_dragX11Dict setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];
        }
    }
}

- (void)handleMouseUp:(id)event
{
    if ([_buttonDown isEqual:@"closeButton"] && [_buttonDown isEqual:_buttonHover]) {
        id x11dict = [event valueForKey:@"x11dict"];
        [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
        return;
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
    if (_dragX11Dict) {

        id windowManager = [event valueForKey:@"windowManager"];
        unsigned long window = [_dragX11Dict unsignedLongValueForKey:@"window"];
        int mouseRootX = [event intValueForKey:@"mouseRootX"];
        int mouseRootY = [event intValueForKey:@"mouseRootY"];

        unsigned long underneathWindow = [windowManager topMostWindowUnderneathWindow:window x:mouseRootX y:mouseRootY];
        if (underneathWindow) {
            id underneathx11dict = [windowManager dictForObjectWindow:underneathWindow];
            id x11dict = [event valueForKey:@"x11dict"];
            if (underneathx11dict == x11dict) {
//                [nsfmt(@"Dropped onto %@", x11dict) showAlert];
            } else {
                id object = [underneathx11dict valueForKey:@"object"];
                if ([object respondsToSelector:@selector(handleDragAndDrop:)]) {
                    [object handleDragAndDrop:_dragX11Dict];
                } else {
//                    [nsfmt(@"Dropped onto window %lu", underneathWindow) showAlert];
                }
            }
        } else {
//            [@"Dropped onto desktop" showAlert];
        }

        [_dragX11Dict setValue:@"1" forKey:@"shouldCloseWindow"];
        [self setValue:nil forKey:@"dragX11Dict"];
    }
    [self setValue:nil forKey:@"buttonDown"];
    [self setValue:nil forKey:@"buttonHover"];
}

- (void)handleFocusInEvent:(id)event
{
NSLog(@"handleFocusInEvent");
    if (!_path) {
        return;
    }

    id windowManager = [event valueForKey:@"windowManager"];
    id objectWindows = [windowManager valueForKey:@"objectWindows"];
    for (int i=0; i<[objectWindows count]; i++) {
        id elt = [objectWindows nth:i];
        id object = [elt valueForKey:@"object"];
        id className = [object className];
        if ([className isEqual:@"MacColorComputerIcon"]) {
            id path = [object valueForKey:@"path"];
            if ([path isEqual:_path]) {
                [elt setValue:@"1" forKey:@"isSelected"];
                [elt setValue:@"1" forKey:@"needsRedraw"];
                continue;
            }
        }
        [elt setValue:nil forKey:@"isSelected"];
        [elt setValue:@"1" forKey:@"needsRedraw"];
    }
}


@end

