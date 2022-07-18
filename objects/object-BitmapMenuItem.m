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

static char *macComputerMenuIconPalette =
"b #000000\n"
". #222222\n"
"X #444444\n"
"o #606060\n"
"O #777777\n"
"+ #DD0000\n"
"@ #00BB00\n"
"# #868A8E\n"
"$ #A0A0A0\n"
"% #C3C7CB\n"
"& #cccccc\n"
"* #CCCCFF\n"
"= #ffffff\n"
;

static char *macComputerMenuIconPixels =
"            \n"
"            \n"
" bbbbbbbbbb \n"
"b&&&&&&&&&&b\n"
"b&XXXXXXXX&b\n"
"b&X******=&b\n"
"b&X******=&b\n"
"b&X******=&b\n"
"b&X******=&b\n"
"b&X******=&b\n"
"b&O=======&b\n"
"b&&&&&&&&&&b\n"
"b&@&&&&&&&&b\n"
"b&+&&&bbbb&b\n"
"b&&&&&&&&&&b\n"
" ......bbbb \n"
" bbbbbbbbbb \n"
"            \n"
"            \n"
"            \n"
;
@implementation Definitions(fnmjkdfsjkfsdjkeklwfmklsdmfksdkfm)
+ (id)MacComputerMenuItem
{
    id pixels = nscstr(macComputerMenuIconPixels);
    id palette = nscstr(macComputerMenuIconPalette);
    id highlightedPalette = nscstr(macComputerMenuIconPalette);

    id obj = [@"BitmapMenuItem" asInstance];
    [obj setValue:pixels forKey:@"pixels"];
    [obj setValue:palette forKey:@"palette"];
    [obj setValue:highlightedPalette forKey:@"highlightedPalette"];
    return obj;
}
@end

static char *macHelpMenuIconPalette =
"b #000000\n"
". #111111\n"
"X #222222\n"
"o #333333\n"
"O #444444\n"
"+ #555555\n"
"@ #606060\n"
"# #777777\n"
"$ #ffff00\n"
"% #888888\n"
"& #A0A0A0\n"
"* #AAAAAA\n"
"= #BBBBBB\n"
"- #C3C7CB\n"
"; #cccccc\n"
": #DDDDDD\n"
"> #EEEEEE\n"
"c #ffffff\n"
;
static char *macHelpMenuIconPixels =
"               \n"
"  ***********  \n"
" =;>=+obo+=>;* \n"
"*;>=b*$=bbb=>;+\n"
"*:$.bXcc.bbb$:+\n"
"*:$#b%c$obbb$:+\n"
"*:$c:cc:bbb=$:+\n"
"*:$$cc=%bX;$$:+\n"
"*:>$$c%b#=$$>:+\n"
"**:>$$%O=$$>:=+\n"
"**=:>$;%:$>:=*+\n"
"%**=:+ObO+:=*%+\n"
"%%**=;:>:;=*%%+\n"
"%#%%*+ObO+*%%#+\n"
" ##%%*XbX*%%#+ \n"
"  +++++++++++  \n"
;
@implementation Definitions(fnmeklwfmklsdmfksdkfm)
+ (id)MacHelpMenuItem
{
    id pixels = nscstr(macHelpMenuIconPixels);
    id palette = nscstr(macHelpMenuIconPalette);
    id highlightedPalette = nscstr(macHelpMenuIconPalette);

    id obj = [@"BitmapMenuItem" asInstance];
    [obj setValue:pixels forKey:@"pixels"];
    [obj setValue:palette forKey:@"palette"];
    [obj setValue:highlightedPalette forKey:@"highlightedPalette"];
    return obj;
}
@end

static char *hotdogPalette =
"b #000000\n"
". #EECC99\n"
"r #BB3333\n"
;
static char *hotdogHighlightedPalette =
"b #FFFFFF\n"
"r #EECC99\n"
". #BB3333\n"
;
/*
static char *hotdogHighlightedPalette =
"b #FFFFFF\n"
"r #E3C597\n"
". #BE2E36\n"
;
*/

static char *hotdogPixels =
"                   \n"
"    bb             \n"
"   b..b            \n"
" rrrr..b           \n"
"rrbbrr..b          \n"
"rb..brr..b         \n"
"b....brr..bb       \n"
"b.....brr...bb     \n"
"b......brrr...bbb  \n"
"b.......bbrrr....b \n"
" b........bbrrrrr  \n"
"  b.........bbbrrr \n"
"   b...........brrr\n"
"    bb.........brrr\n"
"      bb.......brrr\n"
"        bb....brrr \n"
"          bbbb     \n"
;

static char *bananaPalette =
"b #000000\n"
"w #ffffff\n"
"y #ffff00\n"
;

static char *bananaHighlightedPalette =
"b #000000\n"
"w #ffff00\n"
"y #ffff00\n"
;


static char *bananaPixels =
".................\n"
"........b........\n"
".......bwb.......\n"
"......bwyyb......\n"
".....bwyyyyb.....\n"
".....bwyyyyb.....\n"
".....bwbybyb.....\n"
".....bwbybyb.....\n"
".....bwbybyb.....\n"
".....bwyyyyb.....\n"
".b..bbwyyyybb..b.\n"
"b.bbbwyybyyybbbyb\n"
"byyyyyyybyyyyyyyb\n"
".byyyyybbbyyyyyb.\n"
"..bbbbb...bbbbb..\n"
;

@implementation Definitions(jfkldsjlkfsjffjdkslfjdsklfjskdd)
+ (id)HotDog
{
    id pixels = nscstr(hotdogPixels);
    id palette = nscstr(hotdogPalette);
    id highlightedPalette = nscstr(hotdogHighlightedPalette);

    id obj = [@"BitmapMenuItem" asInstance];
    [obj setValue:pixels forKey:@"pixels"];
    [obj setValue:palette forKey:@"palette"];
    [obj setValue:highlightedPalette forKey:@"highlightedPalette"];
    return obj;
}
+ (id)BananaPeel
{
    id pixels = nscstr(bananaPixels);
    id palette = nscstr(bananaPalette);
    id highlightedPalette = nscstr(bananaHighlightedPalette);

    id obj = [@"BitmapMenuItem" asInstance];
    [obj setValue:pixels forKey:@"pixels"];
    [obj setValue:palette forKey:@"palette"];
    [obj setValue:highlightedPalette forKey:@"highlightedPalette"];
    return obj;
}
@end

@interface BitmapMenuItem : IvarObject
{
    id _pixels;
    id _palette;
    id _highlightedPalette;
}
@end

@implementation BitmapMenuItem
@end

