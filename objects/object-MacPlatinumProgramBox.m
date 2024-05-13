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

static char *topBorderPalette =
"b #000000\n"
"o #BBBBBB\n"
"+ #ffffff\n"
;
static char *topBorderLeftPixels =
"bb\n"
"bo\n"
"bo\n"
;
static char *topBorderMiddlePixels =
"b\n"
"o\n"
"+\n"
;
static char *topBorderRightPixels =
"bbb \n"
"oob \n"
"o.bb\n"
;

static char *leftBorderPalette =
"b #000000\n"
". #BBBBBB\n"
"o #ffffff\n"
;

static char *leftBorderPixels =
"b.o\n"
;
static char *rightBorderPalette =
"b #000000\n"
". #555555\n"
"X #999999\n"
;
static char *rightBorderPixels =
"X.bb\n"
;

static char *bottomBorderPalette =
"b #000000\n"
". #555555\n"
"X #777777\n"
"o #888888\n"
"O #999999\n"
"+ #BBBBBB\n"
"@ #cccccc\n"
"# #DDDDDD\n"
"$ #ffffff\n"
;

static char *bottomBorderLeftPixels =
"b++\n"
"b+.\n"
"bbb\n"
"  b\n"
;
static char *bottomBorderMiddlePixels =
"O\n"
".\n"
"b\n"
"b\n"
;
static char *bottomBorderRightPixels =
"O.bb\n"
"..bb\n"
"bbbb\n"
"bbbb\n"
;

static char *okButtonPalette = 
"b #000000\n"
". #0E0E0E\n"
"X #1D1D1D\n"
"o #222222\n"
"O #2C2C2C\n"
"+ #3A3A3A\n"
"@ #494949\n"
"# #585858\n"
"$ #676767\n"
"% #757575\n"
"& #777777\n"
"* #848484\n"
"= #888888\n"
"- #939393\n"
"; #AAAAAA\n"
": #b0b0b0\n"
"> #BBBBBB\n"
", #bfbfbf\n"
"< #cccccc\n"
"1 #CECECE\n"
"2 #DDDDDD\n"
"3 #ffffff\n"
;
static char *okButtonPixels =
"   obbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbo   \n"
"  b222222222222222222222222222222222222222222222222222222222<b  \n"
" b22;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;>b \n"
"o22;&obbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbo&;;=o\n"
"b2;&b>2222222222222222222222222222222222222222222222222222>b&;&b\n"
"b2;o>333333333333333333333333333333333333333333333333333332>o;&b\n"
"b2;b233222222222222222222222222222222222222222222222222222;&b;&b\n"
"b2;b232222222222222222222222222222222222222222222222222222;&b;&b\n"
"b2;b2322222222222bbbbX-22222222222222222222222222222222222;&b;&b\n"
"b2;b2322222222222bb2,Xb-2222222222222222222222222222222222;&b;&b\n"
"b2;b2322222222222bb22-bO21@bb@122bb-.b*221#bb@122222222222;&b;&b\n"
"b2;b2322222222222bb222bb2#b**b#22bb%,bb22$b%-b@22222222222;&b;&b\n"
"b2;b2322222222222bb222bb2bb22bb22bb,2bb22bb22bb22222222222;&b;&b\n"
"b2;b2322222222222bb222bb2bb22bb22bb22bb22bbbbbb22222222222;&b;&b\n"
"b2;b2322222222222bb22:bX2bb22bb22bb22bb22bb222222222222222;&b;&b\n"
"b2;b2322222222222bb21+b*2@b--b@22bb22bb22#b$22222222222222;&b;&b\n"
"b2;b2322222222222bbbb.$221@bb@122bb22bb221#bbbb22222222222;&b;&b\n"
"b2;b232222222222222222222222222222222222222222222222222222;&b;&b\n"
"b2;b232222222222222222222222222222222222222222222222222222;&b;&b\n"
"b2;b23222222222222222222222222222222222222222222222222222;;&b;&b\n"
"b2;o>2;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;&&o;&b\n"
"b2;&b>&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&b&;&b\n"
"o<;;&obbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbo&;=&o\n"
" b>;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;=&b \n"
"  b=&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&b  \n"
"   obbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbo   \n"
;
static char *okButtonLeftPixels =
"   obbb\n"
"  b2222\n"
" b22;;;\n"
"o22;&ob\n"
"b2;&b>2\n"
"b2;o>33\n"
"b2;b233\n"
"b2;b232\n"
"b2;b232\n"
"b2;b232\n"
"b2;b232\n"
"b2;b232\n"
"b2;b232\n"
"b2;b232\n"
"b2;b232\n"
"b2;b232\n"
"b2;b232\n"
"b2;b232\n"
"b2;b232\n"
"b2;b232\n"
"b2;o>2;\n"
"b2;&b>&\n"
"o<;;&ob\n"
" b>;;;;\n"
"  b=&&&\n"
"   obbb\n"
;
static char *okButtonMiddlePixels =
"b\n"
"2\n"
";\n"
"b\n"
"2\n"
"3\n"
"2\n"
"2\n"
"2\n"
"2\n"
"2\n"
"2\n"
"2\n"
"2\n"
"2\n"
"2\n"
"2\n"
"2\n"
"2\n"
"2\n"
";\n"
"&\n"
"b\n"
";\n"
"&\n"
"b\n"
;
static char *okButtonRightPixels =
"bbbo   \n"
"222<b  \n"
";;;;>b \n"
"bo&;;=o\n"
"2>b&;&b\n"
"32>o;&b\n"
"2;&b;&b\n"
"2;&b;&b\n"
"2;&b;&b\n"
"2;&b;&b\n"
"2;&b;&b\n"
"2;&b;&b\n"
"2;&b;&b\n"
"2;&b;&b\n"
"2;&b;&b\n"
"2;&b;&b\n"
"2;&b;&b\n"
"2;&b;&b\n"
"2;&b;&b\n"
";;&b;&b\n"
";&&o;&b\n"
"&&b&;&b\n"
"bo&;=&o\n"
";;;=&b \n"
"&&&&b  \n"
"bbbo   \n"
;

static char *okButtonDownPalette =
"b #000000\n"
". #222222\n"
"X #444444\n"
"o #555555\n"
"O #666666\n"
"+ #777777\n"
"@ #888888\n"
"# #999999\n"
"$ #AAAAAA\n"
"% #BBBBBB\n"
"& #cccccc\n"
"* #DDDDDD\n"
"= #EEEEEE\n"
"- #ffffff\n"
;

static char *okButtonDownPixels =
"   .bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb.   \n"
"  b*******************************************************************&b  \n"
" b**$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$%b \n"
".**$+.bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb.+$$@.\n"
"b*$+bXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXb+$+b\n"
"b*$.XXooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooO+.$+b\n"
"b*$bXooOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO+@b$+b\n"
"b*$bXoOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO+@b$+b\n"
"b*$bXoOOOOOOO@*---OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO@-OOOOOOOO+@b$+b\n"
"b*$bXoOOOOOO@--+O&OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO=-OOOOOOOO+@b$+b\n"
"b*$bXoOOOOOO*-#OOOO+&--&+OO--#--$OO--#--$OO+&--&+OOO&---O-----OOOOOO+@b$+b\n"
"b*$bXoOOOOOO--+OOOO&-$$-&OO--$+--OO--$+--OO%-$#-&OO%-%O&OO--OOOOOOOO+@b$+b\n"
"b*$bXoOOOOOO--OOOOO--OO--OO--+O--OO--+O--OO--OO--OO--OOOOO--OOOOOOOO+@b$+b\n"
"b*$bXoOOOOOO--OOOOO--OO--OO--OO--OO--OO--OO------OO--OOOOO--OOOOOOOO+@b$+b\n"
"b*$bXoOOOOOO*-#OOOO--OO--OO--OO--OO--OO--OO--OOOOOO--OOOOO--OOOOOOOO+@b$+b\n"
"b*$bXoOOOOOO@-=+OOO&-##-&OO--OO--OO--OO--OO&-%OOOOO&-#OOOO--@OOOOOOO+@b$+b\n"
"b*$bXoOOOOOOO@*---O+&--&+OO--OO--OO--OO--OO+&----OO+&---OO@---OOOOOO+@b$+b\n"
"b*$bXoOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO+@b$+b\n"
"b*$bXoOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO+@b$+b\n"
"b*$bXoOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO++@b$+b\n"
"b*$.XO++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++@@.$+b\n"
"b*$+b+@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@b+$+b\n"
".&$$+.bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb.+$@+.\n"
" b%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$@+b \n"
"  b@+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++b  \n"
"   .bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb.   \n"
;
static char *okButtonDownLeftPixels =
"   .bbb\n"
"  b****\n"
" b**$$$\n"
".**$+.b\n"
"b*$+bXX\n"
"b*$.XXo\n"
"b*$bXoo\n"
"b*$bXoO\n"
"b*$bXoO\n"
"b*$bXoO\n"
"b*$bXoO\n"
"b*$bXoO\n"
"b*$bXoO\n"
"b*$bXoO\n"
"b*$bXoO\n"
"b*$bXoO\n"
"b*$bXoO\n"
"b*$bXoO\n"
"b*$bXoO\n"
"b*$bXoO\n"
"b*$.XO+\n"
"b*$+b+@\n"
".&$$+.b\n"
" b%$$$$\n"
"  b@+++\n"
"   .bbb\n"
;
static char *okButtonDownMiddlePixels =
"b\n"
"*\n"
"$\n"
"b\n"
"X\n"
"o\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"O\n"
"+\n"
"@\n"
"b\n"
"$\n"
"+\n"
"b\n"
;
static char *okButtonDownRightPixels =
"bbb.   \n"
"***&b  \n"
"$$$$%b \n"
"b.+$$@.\n"
"XXb+$+b\n"
"oO+.$+b\n"
"O+@b$+b\n"
"O+@b$+b\n"
"O+@b$+b\n"
"O+@b$+b\n"
"O+@b$+b\n"
"O+@b$+b\n"
"O+@b$+b\n"
"O+@b$+b\n"
"O+@b$+b\n"
"O+@b$+b\n"
"O+@b$+b\n"
"O+@b$+b\n"
"O+@b$+b\n"
"++@b$+b\n"
"+@@.$+b\n"
"@@b+$+b\n"
"b.+$@+.\n"
"$$$@+b \n"
"++++b  \n"
"bbb.   \n"
;


@implementation Definitions(fjekwlfmkldsmfkldsjflkfjdskfjksdfjkdsjfk)
+ (id)testMacPlatinumProgramBox
{
    id obj = [@"MacPlatinumProgramBox" asInstance];
    [obj setValue:@"TITLE" forKey:@"text"];
    [obj setValue:@"OK" forKey:@"okText"];
    return obj;
}
@end

@interface MacPlatinumProgramBox : IvarObject
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
    int _HOTDOGNOFRAME;
    int _buttonDownX;
    int _buttonDownY;
}
@end
@implementation MacPlatinumProgramBox
- (id)init
{
    self = [super init];
    if (self) {
        _HOTDOGNOFRAME = 1;
    }
    return self;
}
- (int *)x11WindowMaskPointsForWidth:(int)w height:(int)h
{
    static int points[9];
    points[0] = 9; // length of array including this number

    points[1] = 0; // lower left corner
    points[2] = h-1;

    points[3] = 1; // lower left corner
    points[4] = h-1;

    points[5] = w-1; // upper right corner
    points[6] = 0;

    points[7] = w-1; // upper right corner
    points[8] = 1;
    return points;
}
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
    [bitmap setColor:@"#dddddd"];
    [bitmap fillRect:r];
    [Definitions drawInBitmap:bitmap left:topBorderLeftPixels middle:topBorderMiddlePixels right:topBorderRightPixels x:r.x y:r.y w:r.w palette:topBorderPalette];
    [Definitions drawInBitmap:bitmap top:leftBorderPixels palette:leftBorderPalette middle:leftBorderPixels palette:leftBorderPalette bottom:leftBorderPixels palette:leftBorderPalette x:r.x y:r.y+3 h:r.h-3];
    [Definitions drawInBitmap:bitmap top:rightBorderPixels palette:rightBorderPalette middle:rightBorderPixels palette:rightBorderPalette bottom:rightBorderPixels palette:rightBorderPalette x:r.x+r.w-4 y:r.y+3 h:r.h-3];
    [Definitions drawInBitmap:bitmap left:bottomBorderLeftPixels middle:bottomBorderMiddlePixels right:bottomBorderRightPixels x:r.x y:r.y+r.h-4 w:r.w palette:bottomBorderPalette];

    {
        char *palette = "b #000000\n. #ffffff\n";
        [bitmap drawCString:[Definitions cStringForBitmapMessageIcon] palette:palette x:28 y:28];
    }

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
            _okRect = [Definitions rectWithX:r.w-88 y:r.h-21-28 w:70 h:26];
            Int4 innerRect = _okRect;
//            innerRect.y += 1;
            if ((_buttonDown == 'o') && (_buttonHover == 'o')) {
                [Definitions drawInBitmap:bitmap left:okButtonDownLeftPixels middle:okButtonDownMiddlePixels right:okButtonDownRightPixels x:_okRect.x y:_okRect.y w:_okRect.w palette:okButtonPalette];
                [bitmap setColorIntR:255 g:255 b:255 a:255];
                [bitmap drawBitmapText:_okText centeredInRect:innerRect];
            } else {
                [Definitions drawInBitmap:bitmap left:okButtonLeftPixels middle:okButtonMiddlePixels right:okButtonRightPixels x:_okRect.x y:_okRect.y w:_okRect.w palette:okButtonPalette];
                [bitmap setColorIntR:0 g:0 b:0 a:255];
                [bitmap drawBitmapText:_okText centeredInRect:innerRect];
            }
        } else {
            id text = @"Please wait...";
            int textWidth = [bitmap bitmapWidthForText:text];
            [bitmap setColor:@"#000000"];
            Int4 textRect = [Definitions rectWithX:r.w-18-textWidth y:r.h-21-28 w:70 h:26];
//            textRect.y += 1;
            [bitmap drawBitmapText:text centeredInRect:textRect];
        }
    }

}
- (void)handleMouseDown:(id)event
{
    {
        id x11dict = [event valueForKey:@"x11dict"];
        unsigned long win = [[x11dict valueForKey:@"window"] unsignedLongValue];
        id windowManager = [@"windowManager" valueForKey];
        [windowManager XRaiseWindow:win];
    }

    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    if (_okText && [Definitions isX:mouseX y:mouseY insideRect:_okRect]) {
        _buttonDown = 'o';
        _buttonHover = 'o';
    } else {
        _buttonDown = 'b';
        _buttonHover = 0;
        _buttonDownX = mouseX;
        _buttonDownY = mouseY;
    }
}
- (void)handleMouseMoved:(id)event
{
    if (_buttonDown == 'b') {
        int mouseRootX = [event intValueForKey:@"mouseRootX"];
        int mouseRootY = [event intValueForKey:@"mouseRootY"];

        id dict = [event valueForKey:@"x11dict"];

        int newX = mouseRootX - _buttonDownX;
        int newY = mouseRootY - _buttonDownY;

        [dict setValue:nsfmt(@"%d", newX) forKey:@"x"];
        [dict setValue:nsfmt(@"%d", newY) forKey:@"y"];

        [dict setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];
        return;
    }

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

