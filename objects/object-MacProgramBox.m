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

@implementation Definitions(fjekwlfmkldsmfkldsjflkfjdskfjksd)
+ (id)testMacProgramBox
{
    id obj = [@"MacProgramBox" asInstance];
    [obj setValue:@"TITLE" forKey:@"text"];
    [obj setValue:@"OK" forKey:@"okText"];
    return obj;
}
@end

@interface MacProgramBox : IvarObject
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
@implementation MacProgramBox
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
    [Definitions drawAlertBorderInBitmap:bitmap rect:r];
    char *palette = "b #000000\n. #ffffff\n";
    [bitmap drawCString:[Definitions cStringForBitmapMessageIcon] palette:palette x:28 y:28];

    int x = 89;
    int y = 24;

    // text

    int textWidth = r.w - 89 - 18;
    if (_text) {
        id text = [bitmap fitBitmapString:_text width:textWidth];
        int textHeight = [bitmap bitmapHeightForText:text];
        [bitmap setColorIntR:0 g:0 b:0 a:255];
        [bitmap drawBitmapText:text x:x y:y];
        y += textHeight + 16;
    }

    if (_line) {
        id text = [bitmap fitBitmapString:_line width:textWidth];
        [bitmap drawBitmapText:text x:x y:y];
        y += 32;
    }

    // ok button

    _okRect.x = 0;
    _okRect.y = 0;
    _okRect.w = 0;
    _okRect.h = 0;
    if (_okText) {
        if (_eof) {
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
            id text = @"Please wait...";
            int textWidth = [bitmap bitmapWidthForText:text];
            [bitmap setColor:@"#000000"];
            Int4 textRect = [Definitions rectWithX:r.w-18-textWidth y:r.h-21-28 w:70 h:28];
            textRect.y += 1;
            [bitmap drawBitmapText:text centeredInRect:textRect];
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
                id x11dict = [event valueForKey:@"x11dict"];
                [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
            }
            _returnKeyDown = NO;
        }
    }
}
@end

