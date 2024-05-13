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

@implementation Definitions(fjdksljfklsdjfdsjkfljdsklfjkf)
+ (id)testAmigaTextFields
{
    id obj = [@"AmigaTextFields" asInstance];
    id fields = [@"field1:field2:field3:field4:field5:" splitTerminator:@":"];
    [obj setValue:@"JDLFKSJLKDFJKLDSJFKL" forKey:@"text"];
    [obj setValue:fields forKey:@"fields"];
    [obj setValue:@"OK" forKey:@"okText"];
    [obj setValue:@"Cancel" forKey:@"cancelText"];
    [obj setValue:@"1" forKey:@"hidden"];
    return obj;
}
@end

@interface AmigaTextFields : IvarObject
{
    id _text;
    id _fields;
    id _buffers;
    id _readonly;
    int _cursorBlink;
    int _cursorPos;
    int _currentField;
    int _returnKeyDown;

    Int4 _okRect;
    Int4 _cancelRect;
    id _okText;
    id _cancelText;
    char _buttonDown;
    char _buttonHover;
    int _dialogMode;
    int _hidden;
}
@end
@implementation AmigaTextFields
- (int)preferredWidth
{
    return 640;
}
- (int)preferredHeight
{
    id bitmap = [Definitions bitmapWithWidth:1 height:1];
    [bitmap useTopazFont];
    int lineHeight = [bitmap bitmapHeightForText:@"X"];
    int h = 16;
    int w = 640;
    {
        id text = [bitmap fitBitmapString:_text width:w-16*2];
        h += [bitmap bitmapHeightForText:text] + lineHeight;
    }
    h += [_fields count]*36;
    h += 50;
    return h;
}

- (void)handleBackgroundUpdate:(id)event
{
    _cursorBlink--;
    if (_cursorBlink < 0) {
        _cursorBlink = 1;
    }
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

    {
        id text = [bitmap fitBitmapString:_text width:r.w-16*2];
        [bitmap drawBitmapText:text x:r.x+16 y:y];
        int textHeight = [bitmap bitmapHeightForText:text];
        y += textHeight + 20;
    }

    int fieldWidth = 0;
    for (int i=0; i<[_fields count]; i++) {
        int w = [bitmap bitmapWidthForText:[_fields nth:i]];
        if (w > fieldWidth) {
            fieldWidth = w;
        }
    }

    {
        int x = 5;
        for (int i=0; i<[_fields count]; i++) {
            id field = [_fields nth:i];
            [bitmap setColor:@"#0055aa"];
            [bitmap drawBitmapText:field x:10+fieldWidth-[bitmap bitmapWidthForText:field] y:y+6];

            int x = 10 + fieldWidth + 10;
            [bitmap drawRectangleAtX:x y:y w:r.w-x-10-rightBorder h:26];
            [bitmap fillRectangleAtX:x+2 y:y+2 w:r.w-x-10-4-rightBorder h:26-4];

            id str = [_buffers nth:i];
            if (!str) {
                str = @"";
            }
            if (_hidden) {
                str = [[[str mutableCopy] autorelease] destructiveReplaceCharactersNotInString:@"" withChar:'*'];
            }

            if (_currentField == i) {
                id left = [str stringToIndex:_cursorPos];
                id right = [str stringFromIndex:_cursorPos];
                if ([left length]) {
                    [bitmap setColor:@"#ffffff"];
                    [bitmap drawBitmapText:left x:x+4 y:y+6];
                    x += [bitmap bitmapWidthForText:left]+2;
                }
                if (_cursorBlink) {
                    [bitmap setColor:@"#ff8800"];
                    [bitmap drawVerticalLineAtX:x-1+4 y:y+3 y:y+23];
                }
                if ([right length]) {
                    [bitmap setColor:@"#ffffff"];
                    [bitmap drawBitmapText:right x:x+4 y:y+6];
                }
            } else {
                [bitmap setColor:@"#ffffff"];
                [bitmap drawBitmapText:str x:x+4 y:y+6];
            }

            y += 36;
        }
    }

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
        if (((_buttonDown == 'o') && (_buttonHover == 'o')) || _returnKeyDown) {
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

- (void)handleKeyDown:(id)event
{
    if (!_buffers) {
        id arr = nsarr();
        for (int i=0; i<[_fields count]; i++) {
            id elt = [_fields nth:i];
            [arr addObject:@""];
        }
        [self setValue:arr forKey:@"buffers"];
    }
    id buf = [_buffers nth:_currentField];
    id str = [event valueForKey:@"keyString"];
    if ([str isEqual:@"space"]) {
        str = @" ";
    }
    if ([str length] == 1) {
        if (![buf length]) {
            [_buffers replaceObjectAtIndex:_currentField withObject:str];
            _cursorPos = 1;
            _cursorBlink = 1;
        } else {
            id left = [buf stringToIndex:_cursorPos];
            id right = [buf stringFromIndex:_cursorPos];
            id newBuf = nsfmt(@"%@%@%@", left, str, right);
            [_buffers replaceObjectAtIndex:_currentField withObject:newBuf];
            _cursorPos++;
            _cursorBlink = 1;
        }
    } else if ([str isEqual:@"left"]) {
        if (_cursorPos - 1 >= 0) {
            _cursorPos--;
        }
        _cursorBlink = 1;
    } else if ([str isEqual:@"right"]) {
        if (_cursorPos + 1 <= [buf length]) {
            _cursorPos++;
        }
        _cursorBlink = 1;
    } else if ([str isEqual:@"backspace"]) {
        if (_cursorPos >= 1) {
            id left = (_cursorPos > 1) ? [buf stringToIndex:_cursorPos-1] : @"";
            id right = [buf stringFromIndex:_cursorPos];
            id newBuf = nsfmt(@"%@%@", left, right);
            [_buffers replaceObjectAtIndex:_currentField withObject:newBuf];
            _cursorPos--;
        }
        _cursorBlink = 1;
    } else if ([str isEqual:@"return"]) {
        _returnKeyDown = YES;
    } else if ([str isEqual:@"tab"]) {
        if ([_fields count] > 1) {
            _currentField++;
            if (_currentField >= [_fields count]) {
                _currentField = 0;
            }
            _cursorPos = [[_buffers nth:_currentField] length];
            _cursorBlink = 2;
        }
    } else if ([str isEqual:@"shifttab"]) {
        if ([_fields count] > 1) {
            _currentField--;
            if (_currentField < 0) {
                _currentField = [_fields count]-1;
            }
            _cursorPos = [[_buffers nth:_currentField] length];
            _cursorBlink = 2;
        }
    }
}
- (void)handleKeyUp:(id)event
{
    id str = [event valueForKey:@"keyString"];
    if ([str isEqual:@"return"]) {
        if (_returnKeyDown) {
            if (_dialogMode) {
                [self exitWithDialogMode];
            }
            id x11Dict = [event valueForKey:@"x11dict"];
            [x11Dict setValue:@"1" forKey:@"shouldCloseWindow"];
            _returnKeyDown = NO;
        }
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
                [self exitWithDialogMode];
            }
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
- (void)exitWithDialogMode
{
    for (int i=0; i<[_fields count]; i++) {
        id readonly = [_readonly nth:i];
        if (![readonly intValue]) {
            id field = [_fields nth:i];
            id buffer = [_buffers nth:i];
            if (_dialogMode == 1) {
                NSOut(@"%@\n", buffer);
            } else {
                NSErr(@"%@\n", buffer);
            }
        }
    }
    exit(0);
}
@end

