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

#define BUFSIZE 16384

@implementation Definitions(fjekwlfmkldsmfkldsjflfjdskfjkdsk)
+ (id)testAmigaPrgBox:(id)cmd
{
    id process = [cmd runCommandAndReturnProcess];
    id obj = [@"AmigaPrgBox" asInstance];
    [obj setValue:process forKey:@"process"];
    [obj setValue:@"TITLE" forKey:@"text"];
    [obj setValue:@"OK" forKey:@"okText"];
    return obj;
}
@end

@interface AmigaPrgBox : IvarObject
{
    id _process;
    char _separator;
    id _text;
    int _returnKeyDown;
    Int4 _okRect;
    id _okText;
    char _buttonDown;
    char _buttonHover;
    int _dialogMode;
}
@end
@implementation AmigaPrgBox
- (int)preferredWidth
{
    return 640;
}
- (int)preferredHeight
{
    return 400;
}
- (int *)fileDescriptors
{
    if ([_process respondsToSelector:@selector(fileDescriptors)]) {
        return [_process fileDescriptors];
    }
    return 0;
}
- (void)handleFileDescriptor:(int)fd
{
    if (_process) {
        [_process handleFileDescriptor:fd];
    }
}
- (void)endIteration:(id)event
{
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

    int y = r.y+16;

    if (_text) {
        id text = [bitmap fitBitmapString:_text width:r.w-16*2];
        [bitmap drawBitmapText:text x:r.x+16 y:y];
        int textHeight = [bitmap bitmapHeightForText:text];
        y += textHeight + 16;
    }

    if (_process) {
        id outtext = [[_process valueForKey:@"data"] asString];
        if (!outtext) {
            outtext = @"";
        }
        id errtext = [[_process valueForKey:@"errdata"] asString];
        if (!errtext) {
            errtext = @"";
        }
        id text = nsfmt(@"%@\n%@", outtext, errtext);
        text = [bitmap fitBitmapString:text width:r.w-16*2];
        [bitmap drawBitmapText:text x:r.x+16 y:y];
        y += 32;
    }

    // ok button

    _okRect.x = 0;
    _okRect.y = 0;
    _okRect.w = 0;
    _okRect.h = 0;
    if (_okText) {
        id okText = _okText;
        if (![_process valueForKey:@"status"]) {
            okText = @"Stop";
        }

        int textWidth = [bitmap bitmapWidthForText:okText];
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
        [bitmap drawBitmapText:okText x:_okRect.x+(_okRect.w-textWidth)/2 y:_okRect.y+8];
    }

}
- (void)handleMouseDown:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    if (_okText && [Definitions isX:mouseX y:mouseY insideRect:_okRect]) {
        _buttonDown = 'o';
        _buttonHover = 'o';
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
            id x11dict = [event valueForKey:@"x11dict"];
            [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
        }
    }
    _buttonDown = 0;
    _buttonHover = 0;
}
- (void)handleKeyDown:(id)event
{
    id keyString = [event valueForKey:@"keyString"];
    if ([keyString isEqual:@"return"]) {
        _returnKeyDown = YES;
    }
}
- (void)handleKeyUp:(id)event
{
    id keyString = [event valueForKey:@"keyString"];
    if ([keyString isEqual:@"return"]) {
        if (_returnKeyDown) {
            id x11dict = [event valueForKey:@"x11dict"];
            [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
            _returnKeyDown = NO;
        }
    }
}
@end

