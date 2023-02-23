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

static char *borderPalette =
"b #000000\n"
". #ffffff\n"
;

static char *topBorderLeftPixels = 
"bbb\n"
"b..\n"
"b..\n"
"b..\n"
;
static char *topBorderMiddlePixels = 
"b\n"
".\n"
".\n"
"b\n"
;
static char *topBorderRightPixels = 
"bbb\n"
"..b\n"
"..b\n"
"..b\n"
;
static char *leftBorderPixels = 
"b..b\n"
;
static char *rightBorderPixels = 
"b..b\n"
;
static char *bottomBorderLeftPixels = 
"b..\n"
"b..\n"
"b..\n"
"bbb\n"
;
static char *bottomBorderMiddlePixels = 
"b\n"
".\n"
".\n"
"b\n"
;
static char *bottomBorderRightPixels = 
"..b\n"
"..b\n"
"..b\n"
"bbb\n"
;

static char *buttonPalette =
"b #000000\n"
". #ffffff\n"
;


static char *defaultButtonLeftPixels =
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
;
static char *defaultButtonMiddlePixels =
"b\n"
"b\n"
"b\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
"b\n"
"b\n"
"b\n"
;
static char *defaultButtonDownMiddlePixels =
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
;
static char *defaultButtonRightPixels =
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
"bbb\n"
;

static char *buttonLeftPixels =
"   \n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
" bb\n"
"   \n"
;
static char *buttonMiddlePixels =
" \n"
"b\n"
"b\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
"b\n"
"b\n"
" \n"
;
static char *buttonDownMiddlePixels =
" \n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
"b\n"
" \n"
;
static char *buttonRightPixels =
"   \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"bb \n"
"   \n"
;

@implementation Definitions(fjekwlfmkldsmfkldsjflkfjdskfjksdfjdksfjksd)
+ (id)testAtariSTProgramBox
{
    id obj = [@"AtariSTProgramBox" asInstance];
    [obj setValue:@"TITLE" forKey:@"text"];
    [obj setValue:@"OK" forKey:@"okText"];
    return obj;
}
@end

@interface AtariSTProgramBox : IvarObject
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
@implementation AtariSTProgramBox
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
    [bitmap useAtariSTFont];

    [bitmap setColor:@"white"];
    [bitmap fillRect:r];
    [Definitions drawInBitmap:bitmap left:topBorderLeftPixels middle:topBorderMiddlePixels right:topBorderRightPixels x:r.x y:r.y w:r.w palette:borderPalette];
    [Definitions drawInBitmap:bitmap top:leftBorderPixels palette:borderPalette middle:leftBorderPixels palette:borderPalette bottom:leftBorderPixels palette:borderPalette x:r.x y:r.y+4 h:r.h-8];
    [Definitions drawInBitmap:bitmap top:rightBorderPixels palette:borderPalette middle:rightBorderPixels palette:borderPalette bottom:rightBorderPixels palette:borderPalette x:r.x+r.w-4 y:r.y+4 h:r.h-8];
    [Definitions drawInBitmap:bitmap left:bottomBorderLeftPixels middle:bottomBorderMiddlePixels right:bottomBorderRightPixels x:r.x y:r.y+r.h-4 w:r.w palette:borderPalette];

    int x = 18;
    int y = 24;

    // text

    int textWidth = r.w - 18 - 18;
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
            _okRect.x = r.x+(r.w-70)/2;
            _okRect.y = r.y+r.h-22-16;
            _okRect.w = 70;
            _okRect.h = 22;
            Int4 innerRect = _okRect;
            innerRect.y -= 1;
            if ((_buttonDown == 'o') && (_buttonHover == 'o')) {
[Definitions drawInBitmap:bitmap left:defaultButtonLeftPixels middle:defaultButtonDownMiddlePixels right:defaultButtonRightPixels x:_okRect.x y:_okRect.y w:_okRect.w palette:buttonPalette];
                [bitmap setColor:@"white"];
                [bitmap drawBitmapText:@"OK" centeredInRect:innerRect];
            } else {
[Definitions drawInBitmap:bitmap left:defaultButtonLeftPixels middle:defaultButtonMiddlePixels right:defaultButtonRightPixels x:_okRect.x y:_okRect.y w:_okRect.w palette:buttonPalette];
                [bitmap setColor:@"black"];
                [bitmap drawBitmapText:@"OK" centeredInRect:innerRect];
            }
        } else {
            id text = @"Please wait...";
            int textWidth = [bitmap bitmapWidthForText:text];
            [bitmap setColor:@"#000000"];
            Int4 textRect = [Definitions rectWithX:r.x y:r.h-22-16 w:r.w h:22];
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
    id str = [event valueForKey:@"keyString"];
    if ([str isEqual:@"return"] || [str isEqual:@"shift-return"]) {
        if (_eof) {
            id x11dict = [event valueForKey:@"x11dict"];
            [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
        }
    }
}
@end

