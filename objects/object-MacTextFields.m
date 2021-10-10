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

@implementation Definitions(fjdksljfklsdjfdsjkfljdsklfjkfjdskfjksdf)
+ (id)testMacTextFields
{
    id obj = [@"MacTextFields" asInstance];
    id fields = [@"field1:field2:field3:field4:field5:" splitTerminator:@":"];
    [obj setValue:@"JDLFKSJLKDFJKLDSJFKL" forKey:@"text"];
    [obj setValue:fields forKey:@"fields"];
    [obj setValue:@"OK" forKey:@"okText"];
    [obj setValue:@"Cancel" forKey:@"cancelText"];
    [obj setValue:@"1" forKey:@"hidden"];
    return obj;
}
@end

@interface MacTextFields : IvarObject
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
@implementation MacTextFields
- (int)preferredWidth
{
    return 640;
}
- (int)preferredHeight
{
    id bitmap = [Definitions bitmapWithWidth:1 height:1];
    int lineHeight = [bitmap bitmapHeightForText:@"X"];
    int h = 24;
    id w = 640-89-18;
    {
        id text = [bitmap fitBitmapString:_text width:w];
        h += [bitmap bitmapHeightForText:text] + lineHeight;
    }
    h += [_fields count]*27;
    h += 21+28+21;
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
    [Definitions drawAlertBorderInBitmap:bitmap rect:r];
    char *palette = "b #000000\n. #ffffff\n";
    [bitmap drawCString:[Definitions cStringForBitmapMessageIcon] palette:palette x:28 y:28];

    int lineHeight = [bitmap bitmapHeightForText:@"X"];

    // text

    int y = 24;

    {
        int textWidth = r.w - 89 - 18;
        id text = [bitmap fitBitmapString:_text width:textWidth];
        int textHeight = [bitmap bitmapHeightForText:text];
        [bitmap setColorIntR:0 g:0 b:0 a:255];
        [bitmap drawBitmapText:text x:89 y:y];
        y += textHeight + lineHeight;
    }

    int fieldWidth = 0;
    for (int i=0; i<[_fields count]; i++) {
        int w = [bitmap bitmapWidthForText:[_fields nth:i]];
        if (w > fieldWidth) {
            fieldWidth = w;
        }
    }

    {
        for (int i=0; i<[_fields count]; i++) {
            id field = [_fields nth:i];
            [bitmap setColorIntR:0 g:0 b:0 a:255];
            [bitmap drawBitmapText:field x:89+10+fieldWidth-[bitmap bitmapWidthForText:field] y:y+6];

            int x = 89 + 10 + fieldWidth + 10;
            [bitmap setColor:@"black"];
            [bitmap fillRectangleAtX:x y:y w:r.w-x-18 h:22];
            [bitmap setColor:@"white"];
            [bitmap fillRectangleAtX:x+1 y:y+1 w:r.w-x-18-2 h:22-2];

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
                    [bitmap setColorIntR:0 g:0 b:0 a:255];
                    [bitmap drawBitmapText:left x:x+4 y:y+6];
                    x += [bitmap bitmapWidthForText:left]+2;
                }
                if (_cursorBlink) {
                    [bitmap setColor:@"black"];
                    [bitmap drawVerticalLineAtX:x-1+4 y:y+3 y:y+12+6];
                }
                if ([right length]) {
                    [bitmap setColorIntR:0 g:0 b:0 a:255];
                    [bitmap drawBitmapText:right x:x+4 y:y+6];
                }
            } else {
                [bitmap setColorIntR:0 g:0 b:0 a:255];
                [bitmap drawBitmapText:str x:x+4 y:y+6];
            }

            y += 27;
        }
    }

    // ok button

    if (_okText) {
        _okRect = [Definitions rectWithX:r.w-88 y:r.h-21-28 w:70 h:28];
        Int4 innerRect = _okRect;
        innerRect.y += 1;
        if ((_buttonDown == 'o') && (_buttonHover == 'o')) {
            char *palette = ". #000000\nb #000000\nw #ffffff\n";
            [Definitions drawDefaultButtonInBitmap:bitmap rect:_okRect palette:palette];
            [bitmap setColorIntR:255 g:255 b:255 a:255];
            [bitmap drawBitmapText:@"OK" centeredInRect:innerRect];
        } else {
            char *palette = ". #ffffff\nb #000000\nw #ffffff\n";
            [Definitions drawDefaultButtonInBitmap:bitmap rect:_okRect palette:palette];
            [bitmap setColorIntR:0 g:0 b:0 a:255];
            [bitmap drawBitmapText:@"OK" centeredInRect:innerRect];
        }
    } else {
        _okRect.x = 0;
        _okRect.y = 0;
        _okRect.w = 0;
        _okRect.h = 0;
    }

    // cancel button

    if (_cancelText) {
        _cancelRect = [Definitions rectWithX:_okRect.x-70-35 y:r.h-21-28 w:70 h:28];
        if ((_buttonDown == 'c') && (_buttonHover == 'c')) {
            char *palette = ". #000000\nb #000000\nw #ffffff\n";
            [Definitions drawButtonInBitmap:bitmap rect:_cancelRect palette:palette];
            [bitmap setColorIntR:255 g:255 b:255 a:255];
            [bitmap drawBitmapText:_cancelText centeredInRect:_cancelRect];
        } else {
            char *palette = ". #ffffff\nb #000000\nw #ffffff\n";
            [Definitions drawButtonInBitmap:bitmap rect:_cancelRect palette:palette];
            [bitmap setColorIntR:0 g:0 b:0 a:255];
            [bitmap drawBitmapText:_cancelText centeredInRect:_cancelRect];
        }
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
    FILE *fp = (_dialogMode == 1) ? stdout : stderr;
    for (int i=0; i<[_fields count]; i++) {
        id readonly = [_readonly nth:i];
        if (![readonly intValue]) {
            id field = [_fields nth:i];
            id buffer = [_buffers nth:i];
            fprintf(fp, "%@\n", buffer);
        }
    }
    exit(0);
}
@end

