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
@"X #444444\n"
@"o #555555\n"
@"+ #777777\n"
@"@ #888888\n"
@"$ #aaaaaa\n"
@"% #bbbbbb\n"
@"& #dddddd\n"
@"* #ffffff\n"
;

static id selectedTrashPalette =
@"b #000000\n"
@". #111111\n"
@"X #222222\n"
@"o #2a2a2a\n"
@"+ #3b3b3b\n"
@"@ #444444\n"
@"$ #555555\n"
@"% #5d5d5d\n"
@"& #6e6e6e\n"
@"* #7f7f7f\n"
;

static id trashPixels =
@"        bbbbbb        \n"
@"       b+&&$+Xb       \n"
@" bbbbbbbbbbbbbbbbbbbb \n"
@"bX++$$&*&&$$@@+++ooXXb\n"
@"bbbbbbbbbbbbbbbbbbbbbb\n"
@" b+$%&&&%%%$$$$++ooob \n"
@" b+$%***&&&&$$$$$+oob \n"
@" b+$&***+&&&$o$$++oob \n"
@" b+$$&*+$$&&o++$+.+ob \n"
@" b+$$&*+$$&&o++$+.oob \n"
@" b+$$&*+$$&&o++$+.oob \n"
@" b+$$&*+$$&&o++$+.oob \n"
@" b+$$&*+$$&&o++$+.oob \n"
@" b+$$&*+$$&&o++$+.oob \n"
@" b+$$&*+$$&&o++$+.oob \n"
@" b+$$&*+$$&&o++$+.oob \n"
@" b+$$&*+$$&&o++$+.oob \n"
@" b+$$&*+$$&&o++$+.oob \n"
@" b+$$&*+$$&&o++$+.oob \n"
@" b+$$&*+$$&&o++$+.oob \n"
@" b+$$&*+$$&&o++$+.oob \n"
@" b+$$&*+$$&&o++$+.oob \n"
@" b+$$&*+$$&&o++$+.oob \n"
@" b+$$&*+$$&&o++$+.oob \n"
@" b+$$&*+$$&&o++$+.oob \n"
@" b+$$&*+$$&&o++$+.oob \n"
@" b+$$&*+$$&&o++$+.oob \n"
@" b+$$&*+$$&&o++$+.oob \n"
@" b+$&***+&&&$o$$+o+ob \n"
@" b+$%***&&&&&$$$++oob \n"
@" b+$&***&&%%$$+++ooob \n"
@"  bbbbbbbbbbbbbbbbbb  \n"
;


@implementation Definitions(INMfewlfmklsdmvklsjdklfjklsdffjdkslmfklxcmvklcfdsmkfmekkfxdsfmneoiiooikl)
+ (id)MacColorTrash
{
    id obj = [@"MacColorTrash" asInstance];
    return obj;
}
@end


@interface MacColorTrash : IvarObject
{
}
@end
@implementation MacColorTrash
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

