/*

 PEEOS

 Copyright (c) 2020 Arthur Choung. All rights reserved.

 Email: arthur -at- peeos.org

 This file is part of PEEOS.

 PEEOS is free software: you can redistribute it and/or modify it
 under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <https://www.gnu.org/licenses/>.

 */

#import "PEEOS.h"

@implementation Definitions(fjkldsjfkldjslkfjkldsjfk)
+ (char *)cStringForBitmapErrorIcon
{
    return
"........bbbbbbbbbbbbbbbb........\n"
".......bbbbbbbbbbbbbbbbbb.......\n"
"......bbbbbbbbbbbbbbbbbbbb......\n"
".....bbbbbbbbbb.bbbbbbbbbbb.....\n"
"....bbbbbbbbbb...bbbbbbbbbbb....\n"
"...bbbbbbbb.bb...bb..bbbbbbbb...\n"
"..bbbbbbbb...b...b...bbbbbbbbb..\n"
".bbbbbbbbb...b...b...bbbbbbbbbb.\n"
"bbbbbbbb.b...b...b...bbbbbbbbbbb\n"
"bbbbbbb..b...b...b...bbbbbbbbbbb\n"
"bbbbbbb..b...b...b...bbbbbbbbbbb\n"
"bbbbbbb..b...b...b...bbbbbbbbbbb\n"
"bbbbbbb..b...b...b...bbbbbbbbbbb\n"
"bbbbbbb..b...b...b...bbbbbbbbbbb\n"
"bbbbbbb..b...........bbb...bbbbb\n"
"bbbbbbb..............bb....bbbbb\n"
"bbbbbbb..............bb....bbbbb\n"
"bbbbbbb..............b....bbbbbb\n"
"bbbbbbb...................bbbbbb\n"
"bbbbbbb..................bbbbbbb\n"
"bbbbbbb..................bbbbbbb\n"
"bbbbbbb.................bbbbbbbb\n"
"bbbbbbb.................bbbbbbbb\n"
"bbbbbbb................bbbbbbbbb\n"
"bbbbbbb................bbbbbbbbb\n"
".bbbbbb......b........bbbbbbbbb.\n"
"..bbbbbb......b......bbbbbbbbb..\n"
"...bbbbbbbbbbbbbbbbbbbbbbbbbb...\n"
"....bbbbbbbbbbbbbbbbbbbbbbbb....\n"
".....bbbbbbbbbbbbbbbbbbbbbb.....\n"
"......bbbbbbbbbbbbbbbbbbbb......\n"
".......bbbbbbbbbbbbbbbbbb.......\n"
;
}
@end

@implementation Definitions(jfldslkfjdslkjjfklewjkfjslkdf)
+ (int)preferredHeightForBitmapErrorAlert:(id)text width:(int)width
{
    int textWidth = width - 119 - 28;
    id fittedText = [Definitions fitBitmapString:text width:textWidth];

    int minAlertHeight = 18 + 32 + 13 + 28 + 15;
    int textHeight = [Definitions bitmapHeightForText:fittedText];
    int alertHeight = 21 + textHeight + 1 + 28 + 15;
    if (alertHeight < minAlertHeight) {
        alertHeight = minAlertHeight;
    }
    return alertHeight;
}
@end
@interface BitmapErrorAlert : IvarObject
{
    BOOL _mouseDown;
    id _text;
}
@end
@implementation BitmapErrorAlert
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [Definitions drawAlertBorderInBitmap:bitmap rect:r];
    char *bitmapErrorIcon = [Definitions cStringForBitmapErrorIcon];
    char *palette = "b #000000\n. #ffffff\n";
    [bitmap drawCString:bitmapErrorIcon palette:palette x:40 y:18];

    Int4 buttonRect = [Definitions rectWithX:24 y:r.h-15-28 w:68 h:28];
    if (_mouseDown) {
        char *palette = ". #000000\nb #000000\n";
        [Definitions drawDefaultButtonInBitmap:bitmap rect:buttonRect palette:palette];
        [bitmap setColorIntR:255 g:255 b:255 a:255];
        [bitmap drawBitmapText:@"OK" centeredInRect:buttonRect];
    } else {
        char *palette = ". #ffffff\nb #000000\n";
        [Definitions drawDefaultButtonInBitmap:bitmap rect:buttonRect palette:palette];
        [bitmap setColorIntR:0 g:0 b:0 a:255];
        [bitmap drawBitmapText:@"OK" centeredInRect:buttonRect];
    }

    [bitmap setColor:@"black"];
    int textWidth = (int)r.w - 119 - 28;
    id text = [bitmap fitBitmapString:_text width:textWidth];
    [bitmap setColorIntR:0 g:0 b:0 a:255];
    [bitmap drawBitmapText:text x:119 y:21];
    // 28 pixels right margin
}
- (void)handleMouseDown:(id)event
{
    _mouseDown = YES;
}
- (void)handleMouseUp:(id)event
{
    id x11dict = [event valueForKey:@"x11dict"];
    [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
}
@end
@implementation NSString(fjlkdslkjfsdjfjkdlsjfkldsjkf)
- (id)asBitmapErrorAlert
{
    id obj = [@"BitmapErrorAlert" asInstance];
    [obj setValue:self forKey:@"text"];
    return obj;
}
@end
