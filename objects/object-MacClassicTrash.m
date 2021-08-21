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
@". #ffffff\n"
;

static id selectedTrashPalette =
@". #000000\n"
@"b #ffffff\n"
;

static id trashPixels =
@"        bbbbbb        \n"
@"       b......b       \n"
@" bbbbbbbbbbbbbbbbbbbb \n"
@"b....................b\n"
@"bbbbbbbbbbbbbbbbbbbbbb\n"
@" b..................b \n"
@" b..................b \n"
@" b..b...b...b...b...b \n"
@" b...b...b...b...b..b \n"
@" b...b...b...b...b..b \n"
@" b...b...b...b...b..b \n"
@" b...b...b...b...b..b \n"
@" b...b...b...b...b..b \n"
@" b...b...b...b...b..b \n"
@" b...b...b...b...b..b \n"
@" b...b...b...b...b..b \n"
@" b...b...b...b...b..b \n"
@" b...b...b...b...b..b \n"
@" b...b...b...b...b..b \n"
@" b...b...b...b...b..b \n"
@" b...b...b...b...b..b \n"
@" b...b...b...b...b..b \n"
@" b...b...b...b...b..b \n"
@" b...b...b...b...b..b \n"
@" b...b...b...b...b..b \n"
@" b...b...b...b...b..b \n"
@" b...b...b...b...b..b \n"
@" b...b...b...b...b..b \n"
@" b..b...b...b...b...b \n"
@" b..................b \n"
@" b..................b \n"
@" bbbbbbbbbbbbbbbbbbbb \n"
;


@implementation Definitions(INMfewlfmklsdmvklsjdklfjklsdffjdkslmfklxcmvklcfdsmkfmekkfxkl)
+ (id)MacClassicTrash
{
    id obj = [@"MacClassicTrash" asInstance];
    return obj;
}
@end


@interface MacClassicTrash : IvarObject
{
}
@end
@implementation MacClassicTrash
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

