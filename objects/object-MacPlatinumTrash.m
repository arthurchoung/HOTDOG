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

static id trashPalette =
@"b #000000\n"
@". #222222\n"
@"X #333333\n"
@"o #323240\n"
@"O #333341\n"
@"+ #343443\n"
@"@ #363647\n"
@"# #363648\n"
@"$ #37374A\n"
@"% #3A3A4F\n"
@"& #3A3A50\n"
@"* #3C3C53\n"
@"= #3C3C54\n"
@"- #444444\n"
@"; #40405A\n"
@": #40405B\n"
@"> #40405C\n"
@", #555555\n"
@"< #434361\n"
@"1 #464666\n"
@"2 #49496C\n"
@"3 #4F4F77\n"
@"4 #53537E\n"
@"5 #666666\n"
@"6 #777777\n"
@"7 #555583\n"
@"8 #575787\n"
@"9 #5A5A8B\n"
@"0 #5C5C90\n"
@"q #5E5E93\n"
@"e #888888\n"
@"r #AAAAAA\n"
@"t #BBBBBB\n"
@"y #DDDDDD\n"
@"u #CFCFE1\n"
@"i #FFFFFF\n"
;

static id selectedTrashPalette =
@"b #000000\n"
@". #222222\n"
@"X #333333\n"
@"o #323240\n"
@"O #333341\n"
@"+ #343443\n"
@"@ #363647\n"
@"# #363648\n"
@"$ #37374A\n"
@"% #3A3A4F\n"
@"& #3A3A50\n"
@"* #3C3C53\n"
@"= #3C3C54\n"
@"- #444444\n"
@"; #40405A\n"
@": #40405B\n"
@"> #40405C\n"
@", #555555\n"
@"< #434361\n"
@"1 #464666\n"
@"2 #49496C\n"
@"3 #4F4F77\n"
@"4 #53537E\n"
@"5 #666666\n"
@"6 #777777\n"
@"7 #555583\n"
@"8 #575787\n"
@"9 #5A5A8B\n"
@"0 #5C5C90\n"
@"q #5E5E93\n"
@"e #888888\n"
@"r #AAAAAA\n"
@"t #BBBBBB\n"
@"y #DDDDDD\n"
@"u #CFCFE1\n"
@"i #FFFFFF\n"
;

static id trashPixels =
@"     8.2      8.2               \n"
@"    8.y.2    8.i.2              \n"
@"   8.yyy......iii.2             \n"
@"  8b.........iiiii.3            \n"
@"8bby.iiyyyy.iii.ittb            \n"
@"bbty.iiyyy.iii.y.tt.-           \n"
@"bbtt.iyyy.iii.yyy.-,b           \n"
@"b6bt.yyy.iiy.yytt-,eb           \n"
@"biebbby.iyy.tt6--,eeb           \n"
@"beiie,bbbbbbb..eee6,b           \n"
@"beyyiittttttttee6,--b           \n"
@" .-yyyyyyttree6,.bbbbb2         \n"
@" b6,5tyyytrree6.,yy6trb         \n"
@" brtte6,,---XXX,yyeyytb.        \n"
@" brrriyyyttreebyytyyiytb2       \n"
@" br6ryii6yytrbtyyeyiiiyb.       \n"
@" br6ryi6rryt,btiyeyiiiyeb       \n"
@" br6ryi6rryt,byityiiiiiyb2      \n"
@" br6ryi6rryt,byyeyiiii---b      \n"
@" br6ryi6rryt,byyeyiiiy.t-b      \n"
@" br6ryi6rryt,btteyyyit-b.eb0    \n"
@" br6ryi6rryt,brr6yyyittb-yb380  \n"
@" br6ryi6rryt,brr6tye---.ib#*<38q\n"
@" br6ryi6rryt,bee,tyeb,e6ybO@%>28\n"
@" br6ryi6rryt,bee,ty6-beyb.oO@%;4\n"
@" br6ryi6rryt,b-6,ey6-.bbboo+$=17\n"
@" brrryi6rryt,,.,,,y66---bo+@%:30\n"
@" brryyi6rryt,6b,,,tye---b+#&:39 \n"
@" .6yyiii6yytt,b-,,eyte-b+#&:39  \n"
@" 3.briiyyyyrrre.,,-eteeb#:13q   \n"
@"   3bbbrrttrr6bb---,6,b&:39q    \n"
@"     3;.bbbbb....bbbbb;30       \n"
;


@implementation Definitions(INMfefdisfjwlfmklsdmvklsjdklfjklsdffjdkslmfklxcmvklcfdsmkfmekkfxdsfmneoiiooikl)
+ (id)MacPlatinumTrash
{
    id obj = [@"MacPlatinumTrash" asInstance];
    return obj;
}
@end


@interface MacPlatinumTrash : IvarObject
{
}
@end
@implementation MacPlatinumTrash
- (int)preferredWidth
{
    return 80;//[Definitions widthForCString:[trashPixels UTF8String]]+10;
}
- (int)preferredHeight
{
    return 50;//[Definitions heightForCString:[trashPixels UTF8String]]+10;
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [bitmap setColor:@"white"];
    [bitmap fillRect:r];
    [bitmap drawCString:[trashPixels UTF8String] palette:[trashPalette UTF8String] x:r.x+5 y:r.y+5];
}

@end

