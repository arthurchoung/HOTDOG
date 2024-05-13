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

@implementation Definitions(fmklsdfjklsdmfklsdlkf)
+ (id)testChatBubble
{
    id obj = [@"ChatBubble" asInstance];
    [obj setValue:@"5" forKey:@"timer"];
    [obj setValue:@"ABC" forKey:@"text"];
    return obj;
}
@end

@interface ChatBubble : IvarObject
{
    int _timer;
    int _maxWidth;
    id _text;
    id _fgcolor;
    id _bgcolor;
}
@end
@implementation ChatBubble
- (void)handleBackgroundUpdate:(id)event
{
    if (_timer > 0) {
        _timer--;
        if (_timer == 0) {
            id x11dict = [event valueForKey:@"x11dict"];
            [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
        }
    }
}
- (int)preferredWidth
{
    Int4 r;
    r.x = 0;
    r.y = 0;
    r.w = 200;
    if (_maxWidth) {
        r.w = _maxWidth;
    }
    r.h = 1000;
    id bitmap = [Definitions bitmapWithWidth:1 height:1];
    id fgcolor = [@"black" asRGBColor];
    id bgcolor = [@"white" asRGBColor];
    Int4 chatRect = [Definitions drawChatBubbleInBitmap:bitmap rect:r text:_text fgcolor:fgcolor bgcolor:bgcolor flipHorizontal:NO flipVertical:YES];
    return chatRect.w;
}
- (int)preferredHeight
{
    Int4 r;
    r.x = 0;
    r.y = 0;
    r.w = 200;
    if (_maxWidth) {
        r.w = _maxWidth;
    }
    r.h = 480;
    id bitmap = [Definitions bitmapWithWidth:1 height:1];
    id fgcolor = @"black";
    if (_fgcolor) {
        fgcolor = _fgcolor;
    }
    fgcolor = [fgcolor asRGBColor];
    id bgcolor = @"white";
    if (_bgcolor) {
        bgcolor = _bgcolor;
    }
    bgcolor = [bgcolor asRGBColor];
    Int4 chatRect = [Definitions drawChatBubbleInBitmap:bitmap rect:r text:_text fgcolor:fgcolor bgcolor:bgcolor flipHorizontal:NO flipVertical:YES];
    return chatRect.h;
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r context:(id)context
{
    id fgcolor = @"black";
    if (_fgcolor) {
        fgcolor = _fgcolor;
    }
    fgcolor = [fgcolor asRGBColor];
    id bgcolor = @"white";
    if (_bgcolor) {
        bgcolor = _bgcolor;
    }
    bgcolor = [bgcolor asRGBColor];
    [Definitions drawChatBubbleInBitmap:bitmap rect:r text:_text fgcolor:fgcolor bgcolor:bgcolor flipHorizontal:NO flipVertical:YES];

    id windowManager = [@"windowManager" valueForKey];
    unsigned long win = [[context valueForKey:@"window"] unsignedLongValue];
    if (win) {
        [windowManager addMaskToWindow:win bitmap:bitmap];
    }
}
- (void)handleMouseDown:(id)event
{
    id x11dict = [event valueForKey:@"x11dict"];
    [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
}
@end

