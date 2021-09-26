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

@implementation Definitions(Fjewilfmlkdsmvlksdkjf)
+ (id)testAmigaAlert
{
    id obj = [@"AmigaAlert" asInstance];
    [obj setValue:@"HJKLJDKLSFJDSKLF" forKey:@"text"];
    [obj setValue:@"OK" forKey:@"okText"];
    [obj setValue:@"Cancel" forKey:@"cancelText"];
    return obj;
}
+ (id)AmigaAlert:(id)text
{
    id obj = [@"AmigaAlert" asInstance];
    [obj setValue:text forKey:@"text"];
    return obj;
}
@end

@interface AmigaAlert : IvarObject
{
    id _text;
    Int4 _okRect;
    Int4 _cancelRect;
    id _okText;
    id _cancelText;
    char _buttonDown;
    char _buttonHover;
    int _dialogMode;
    int _x11WaitForFocusOutThenClose;
}
@end

@implementation AmigaAlert
- (int)preferredWidth
{
    return 480;
}
- (int)preferredHeight
{
    if (!_text) {
        return 288;
    }
    id bitmap = [Definitions bitmapWithWidth:1 height:1];
    [bitmap useTopazFont];
    int lineHeight = [bitmap bitmapHeightForText:@"X"];
    id text = [bitmap fitBitmapString:_text width:480-16*2];
    int textHeight = [bitmap bitmapHeightForText:text];
    textHeight += 16+50+lineHeight;
    if (textHeight > 288) {
        return textHeight;
    }
    return 288;
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [bitmap useTopazFont];
    [bitmap setColor:@"white"];
    [bitmap fillRect:r];
    [bitmap setColor:@"#0055aa"];
    int rightBorder = 14;
    [bitmap fillRectangleAtX:r.x+r.w-rightBorder y:r.y w:rightBorder h:r.h];

    // border

    [bitmap drawRectangleAtX:r.x y:r.y x:r.x+r.w-1-rightBorder y:r.y+r.h-1];
    [bitmap drawRectangleAtX:r.x+1 y:r.y+1 x:r.x+r.w-2-rightBorder y:r.y+r.h-2];

    [bitmap drawRectangleAtX:r.x+3 y:r.y+4 x:r.x+r.w-4-rightBorder y:r.y+r.h-5];
    [bitmap drawRectangleAtX:r.x+4 y:r.y+5 x:r.x+r.w-5-rightBorder y:r.y+r.h-6];

    // text

    id text = [bitmap fitBitmapString:_text width:r.w-16*2];
    [bitmap drawBitmapText:text x:r.x+16 y:r.y+16];

    // ok button

    if (_okText) {
        int textWidth = [bitmap bitmapWidthForText:_okText];
        int innerWidth = 50;
        if (textWidth > innerWidth) {
            innerWidth = textWidth;
        }
        _okRect.x = r.x+r.w-rightBorder-10-(innerWidth+16);
        _okRect.y = r.y+r.h-40;
        _okRect.w = innerWidth+16;
        _okRect.h = 30;
        if ((_buttonDown == 'o') && (_buttonHover == 'o')) {
            [bitmap setColor:@"black"];
            [bitmap fillRect:_okRect];
        }
        [bitmap setColor:@"#ff8800"];
        [bitmap drawRectangle:_okRect];
        [bitmap setColor:@"#0055aa"];
        Int4 r1 = _okRect;
        r1.x += 1;
        r1.w -= 2;
        r1.y += 4;
        r1.h -= 8;
        [bitmap drawRectangle:r1];
        [bitmap drawBitmapText:_okText x:_okRect.x+(_okRect.w-textWidth)/2 y:_okRect.y+8];
    } else {
        _okRect.x = 0;
        _okRect.y = 0;
        _okRect.w = 0;
        _okRect.h = 0;
    }

    // cancel button

    if (_cancelText) {
        int textWidth = [bitmap bitmapWidthForText:_cancelText];
        int innerWidth = 50;
        if (textWidth > innerWidth) {
            innerWidth = textWidth;
        }
        _cancelRect.x = r.x+10;
        _cancelRect.y = r.y+r.h-40;
        _cancelRect.w = innerWidth+16;
        _cancelRect.h = 30;
        if ((_buttonDown == 'c') && (_buttonHover == 'c')) {
            [bitmap setColor:@"black"];
            [bitmap fillRect:_cancelRect];
        }
        [bitmap setColor:@"#ff8800"];
        [bitmap drawRectangle:_cancelRect];
        [bitmap setColor:@"#0055aa"];
        Int4 r1 = _cancelRect;
        r1.x += 1;
        r1.w -= 2;
        r1.y += 4;
        r1.h -= 8;
        [bitmap drawRectangle:r1];
        [bitmap drawBitmapText:_cancelText x:_cancelRect.x+(_cancelRect.w-textWidth)/2 y:_cancelRect.y+8];
    } else {
        _cancelRect.x = 0;
        _cancelRect.y = 0;
        _cancelRect.w = 0;
        _cancelRect.h = 0;
    }
}
- (void)handleMouseDown:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    if (_okText && [Definitions isX:mouseX y:mouseY insideRect:_okRect]) {
        _buttonDown = 'o';
        _buttonHover = 'o';
    } else if (_cancelText && [Definitions isX:mouseX y:mouseY insideRect:_cancelRect]) {
        _buttonDown = 'c';
        _buttonHover = 'c';
    } else {
        _buttonDown = 0;
        _buttonHover = 0;
    }
}
- (void)handleMouseMoved:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    if (_okText && [Definitions isX:mouseX y:mouseY insideRect:_okRect]) {
        _buttonHover = 'o';
    } else if (_cancelText && [Definitions isX:mouseX y:mouseY insideRect:_cancelRect]) {
        _buttonHover = 'c';
    } else {
        _buttonHover = 0;
    }
}
- (void)handleMouseUp:(id)event
{
    if (_buttonDown == _buttonHover) {
        if (_buttonDown == 'o') {
            if (_dialogMode) {
                exit(0);
            }
            printf("%@\n", _okText);
            id x11dict = [event valueForKey:@"x11dict"];
            [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
        } else if (_buttonDown == 'c') {
            if (_dialogMode) {
                exit(1);
            }
            id x11dict = [event valueForKey:@"x11dict"];
            [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
        }
    }
    _buttonDown = 0;
    _buttonHover = 0;
}
@end

