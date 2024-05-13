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

#define BUFSIZE 16384

@implementation Definitions(fjekwlfmkldsmfkldsjflk)
+ (id)testAmigaProgramBox
{
    id obj = [@"AmigaProgramBox" asInstance];
    [obj setValue:@"TITLE" forKey:@"text"];
    [obj setValue:@"OK" forKey:@"okText"];
    return obj;
}
@end

@interface AmigaProgramBox : IvarObject
{
    char _separator;
    BOOL _eof;
    id _text;
    id _line;
    int _returnKeyDown;
    Int4 _okRect;
    id _okText;
    char _buttonDown;
    char _buttonHover;
    int _dialogMode;
    id _partialLine;
}
@end
@implementation AmigaProgramBox
- (int)preferredWidth
{
    return 640;
}
- (int)preferredHeight
{
    return 400;
}
- (int)fileDescriptor
{
    if (_eof) {
        return -1;
    }
    return 0;
}
- (void)handleFileDescriptorOld
{
    if (_eof) {
        return;
    }
    char buf[BUFSIZE];
    int n = read(0, buf, BUFSIZE-1);
    if (n < 0) {
        // error, actually
        _eof = YES;
        return;
    }
    if (n == 0) {
        _eof = YES;
        return;
    }
    int sep = (_separator) ? _separator : '\r';
    buf[n] = 0;
    char *p = &buf[0];
    for (int i=n-1; i>=0; i--) {
        if (buf[i] == sep) {
            if (buf[i+1]) {
                p = &buf[i+1];
                break;
            }
            buf[i] = 0;
        }
    }
    id line = nsfmt(@"%s", p);
    [self setValue:line forKey:@"line"];
}
- (void)handleFileDescriptor
{
    if (_eof) {
        return;
    }
    char buf[BUFSIZE];
    int n = read(0, buf, BUFSIZE-1);
    if (n < 0) {
        // error, actually
        _eof = YES;
        return;
    }
    if (n == 0) {
        _eof = YES;
        return;
    }
    int sep = (_separator) ? _separator : '\r';
    buf[n] = 0;
    char *p = &buf[0];
    for(;;) {
        char *q = strchr(p, sep);
        if (q) {
            id line = nscstrn(p, q-p);
            q++;
            if (_partialLine) {
                line = nsfmt(@"%@%@", _partialLine, line);
                [self setValue:line forKey:@"line"];
                [self setValue:nil forKey:@"partialLine"];
            } else {
                [self setValue:line forKey:@"line"];
            }
            p = q;
        } else {
            if (*p) {
                id line = nsfmt(@"%s", p);
                if (_partialLine) {
                    line = nsfmt(@"%@%@", _partialLine, line);
                    [self setValue:line forKey:@"partialLine"];
                } else {
                    [self setValue:line forKey:@"partialLine"];
                }
            }
            break;
        }
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

    if (_line) {
        id text = [bitmap fitBitmapString:_line width:r.w-16*2];
        [bitmap drawBitmapText:text x:r.x+16 y:y];
        y += 32;
    }

    // ok button

    _okRect.x = 0;
    _okRect.y = 0;
    _okRect.w = 0;
    _okRect.h = 0;
    if (_okText) {
        if (_eof) {
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
            id text = @"Please wait...";
            int textWidth = [bitmap bitmapWidthForText:text];
            [bitmap setColor:@"#0055aa"];
            [bitmap drawBitmapText:text x:r.x+r.w-rightBorder-10-textWidth-8 y:r.y+r.h-40+8];
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
            if (_eof) {
                if (_dialogMode) {
                    exit(0);
                }
                id x11dict = [event valueForKey:@"x11dict"];
                [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
            }
            _returnKeyDown = NO;
        }
    }
}
@end

