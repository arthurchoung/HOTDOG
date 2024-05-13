/*

 HOTDOG

 Copyright (c) 2020 Arthur Choung. All rights reserved.

 Email: arthur -at- hotdogpucko.com

 This file is part of HOTDOG.

 HOTDOG is free software: you can redistribute it and/or modify
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

static Int4 rectWithPadding_w_h_(Int4 r, int paddingWidth, int paddingHeight)
{
    Int4 result = r;
    result.x -= paddingWidth;
    result.y -= paddingHeight;
    result.w += paddingWidth*2;
    result.h += paddingHeight*2;
    return result;
}

@implementation Definitions(fmeiowmvkdsvijewi)
+ (id)AmigaGuruMeditation
{
    id obj = [@"AmigaGuruMeditation" asInstance];
    id text = @"Software Failure.   Press left mouse button to continue.";
    [obj setValue:text forKey:@"text"];
    return obj;
}
@end

@interface AmigaGuruMeditation : IvarObject
{
    int _iteration;
    id _text;
    int _HOTDOGNOFRAME;
}
@end
@implementation AmigaGuruMeditation
- (id)init
{
    self = [super init];
    if (self) {
        _HOTDOGNOFRAME = 1;
    }
    return self;
}
- (int)preferredWidth
{
    id bitmap = [[Definitions bitmapWithWidth:1 height:1] autorelease];
    [bitmap useTopazFont];
    return [bitmap bitmapWidthForText:_text] + 80;
}
- (int)preferredHeight
{
    return 74;
}
- (BOOL)shouldAnimate
{
    return YES;
}
- (void)handleBackgroundUpdate:(id)event
{
    _iteration++;
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    if (_iteration % 2 == 0) {
        [bitmap setColor:@"red"];
        [bitmap fillRect:r];
        Int4 r1 = rectWithPadding_w_h_(r, -8, -8);
        [bitmap setColor:@"black"];
        [bitmap fillRect:r1];
    } else {
        [bitmap setColor:@"black"];
        [bitmap fillRect:r];
    }
    [bitmap useTopazFont];
    [bitmap setColor:@"red"];
    [bitmap drawBitmapText:_text centeredAtX:r.x+r.w/2 y:8];
    [bitmap drawBitmapText:@"Guru Meditation #00000004.00000000" centeredAtX:r.x+r.w/2 y:36];
}
- (void)handleMouseDown:(id)event
{
    exit(0);
}
@end

