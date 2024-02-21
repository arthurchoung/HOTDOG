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

static char *iconPalette =
"b #000000\n"
"X #0000AA\n"
"o #ffffff\n"
;

static char *iconPixels =
"            bbbbbbbb            \n"
"         bbbXXXXXXXXbbb         \n"
"       bbXXXXXooooXXXXXbb       \n"
"      bXXXXXXooooooXXXXXXb      \n"
"     bXXXXXXooooooooXXXXXXb     \n"
"    bXXXXXXXooooooooXXXXXXXb    \n"
"   bXXXXXXXXooooooooXXXXXXXXb   \n"
"  bXXXXXXXXXXooooooXXXXXXXXXXb  \n"
"  bXXXXXXXXXXXooooXXXXXXXXXXXb  \n"
" bXXXXXXXXXXXXXXXXXXXXXXXXXXXXb \n"
" bXXXXXXXXXXXXXXXXXXXXXXXXXXXXb \n"
" bXXXXXXXXXoooooooooXXXXXXXXXXb \n"
"bXXXXXXXXXXoooooooooXXXXXXXXXXXb\n"
"bXXXXXXXXXXXXXooooooXXXXXXXXXXXb\n"
"bXXXXXXXXXXXXXooooooXXXXXXXXXXXb\n"
"bXXXXXXXXXXXXXooooooXXXXXXXXXXXb\n"
"bXXXXXXXXXXXXXooooooXXXXXXXXXXXb\n"
"bXXXXXXXXXXXXXooooooXXXXXXXXXXXb\n"
"bXXXXXXXXXXXXXooooooXXXXXXXXXXXb\n"
"bXXXXXXXXXXXXXooooooXXXXXXXXXXXb\n"
" bXXXXXXXXXXXXooooooXXXXXXXXXXb \n"
" bXXXXXXXXXXXXooooooXXXXXXXXXXb \n"
" bXXXXXXXXXXXXooooooXXXXXXXXXXb \n"
"  bXXXXXXXXXXXooooooXXXXXXXXXb  \n"
"  bXXXXXXXXXXXooooooXXXXXXXXXb  \n"
"   bXXXXXXXooooooooooooXXXXXb   \n"
"    bXXXXXXooooooooooooXXXXb    \n"
"     bXXXXXooooooooooooXXXb     \n"
"      bXXXXXXXXXXXXXXXXXXb      \n"
"       bbXXXXXXXXXXXXXXbb       \n"
"         bbbXXXXXXXXbbb         \n"
"            bbbbbbbb            \n"
;

static char *buttonPalette =
"b #000000\n"
"X #AA0055\n"
"O #868A8E\n"
". #C3C7CB\n"
"@ #ffffff\n"
"T #c3c7cb\n"
;

static char *focusButtonPixels =
" bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"bb@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Obb\n"
"bb@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@OObb\n"
"bb@@..................................................OObb\n"
"bb@@.............TUTUTUTUTUTUTUTUTUTUT................OObb\n"
"bb@@............T.....................T...............OObb\n"
"bb@@............U.....................U...............OObb\n"
"bb@@............T.....................T...............OObb\n"
"bb@@............U....TTTT....TT...TT..U...............OObb\n"
"bb@@............T...TT..TT...TT..TT...T...............OObb\n"
"bb@@............U..TT....TT..TT.TT....U...............OObb\n"
"bb@@............T..TT....TT..TTTT.....T...............OObb\n"
"bb@@............U..TT....TT..TTT......U...............OObb\n"
"bb@@............T..TT....TT..TTTT.....T...............OObb\n"
"bb@@............U..TT....TT..TT.TT....U...............OObb\n"
"bb@@............T..TT....TT..TT..TT...T...............OObb\n"
"bb@@............U...TT..TT...TT...TT..U...............OObb\n"
"bb@@............T....TTTT....TT....TT.T...............OObb\n"
"bb@@............U.....................U...............OObb\n"
"bb@@............T.....................T...............OObb\n"
"bb@@............U.....................U...............OObb\n"
"bb@@............T.....................T...............OObb\n"
"bb@@.............TUTUTUTUTUTUTUTUTUTUT................OObb\n"
"bb@OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOObb\n"
"bbOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOObb\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
" bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
;

static char *buttonDownPixels =
" bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"bbOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOObb\n"
"bbO.....................................................bb\n"
"bbO.....................................................bb\n"
"bbO.....................................................bb\n"
"bbO...............TUTUTUTUTUTUTUTUTUTUT.................bb\n"
"bbO..............T.....................T................bb\n"
"bbO..............U.....................U................bb\n"
"bbO..............T.....................T................bb\n"
"bbO..............U....TTTT....TT...TT..U................bb\n"
"bbO..............T...TT..TT...TT..TT...T................bb\n"
"bbO..............U..TT....TT..TT.TT....U................bb\n"
"bbO..............T..TT....TT..TTTT.....T................bb\n"
"bbO..............U..TT....TT..TTT......U................bb\n"
"bbO..............T..TT....TT..TTTT.....T................bb\n"
"bbO..............U..TT....TT..TT.TT....U................bb\n"
"bbO..............T..TT....TT..TT..TT...T................bb\n"
"bbO..............U...TT..TT...TT...TT..U................bb\n"
"bbO..............T....TTTT....TT....TT.T................bb\n"
"bbO..............U.....................U................bb\n"
"bbO..............T.....................T................bb\n"
"bbO..............U.....................U................bb\n"
"bbO..............T.....................T................bb\n"
"bbO...............TUTUTUTUTUTUTUTUTUTUT.................bb\n"
"bbO.....................................................bb\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
" bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
;
static char *normalButtonPixels =
" bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
"b@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Ob\n"
"b@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@OOb\n"
"b@@....................................................OOb\n"
"b@@....................................................OOb\n"
"b@@....................................................OOb\n"
"b@@....................................................OOb\n"
"b@@....................................................OOb\n"
"b@@....................................................OOb\n"
"b@@......TTTT..................................TT......OOb\n"
"b@@.....TT..TT.................................TT......OOb\n"
"b@@....TT....T.................................TT......OOb\n"
"b@@....TT........TTTT...TTTTT....TTTT...TTTT...TT......OOb\n"
"b@@....TT.......TT..TT..TT..TT..TT..TT.TT..TT..TT......OOb\n"
"b@@....TT.........TTTT..TT..TT..TT.....TTTTTT..TT......OOb\n"
"b@@....TT........TT.TT..TT..TT..TT.....TT......TT......OOb\n"
"b@@....TT....T..TT..TT..TT..TT..TT.....TT......TT......OOb\n"
"b@@.....TT..TT..TT..TT..TT..TT..TT..TT.TT..TT..TT......OOb\n"
"b@@......TTTT....TTTTT..TT..TT...TTTT...TTTT...TT......OOb\n"
"b@@....................................................OOb\n"
"b@@....................................................OOb\n"
"b@@....................................................OOb\n"
"b@@....................................................OOb\n"
"b@@....................................................OOb\n"
"b@@....................................................OOb\n"
"b@OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOb\n"
"bOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOb\n"
" bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
;

static char *focusButtonLeftPixels =
" bbb\n"
"bbbb\n"
"bb@@\n"
"bb@@\n"
"bb@@\n"
"bb@@\n"
"bb@@\n"
"bb@@\n"
"bb@@\n"
"bb@@\n"
"bb@@\n"
"bb@@\n"
"bb@@\n"
"bb@@\n"
"bb@@\n"
"bb@@\n"
"bb@@\n"
"bb@@\n"
"bb@@\n"
"bb@@\n"
"bb@@\n"
"bb@@\n"
"bb@@\n"
"bb@@\n"
"bb@O\n"
"bbOO\n"
"bbbb\n"
" bbb\n"
;

static char *focusButtonMiddlePixels =
"b\n"
"b\n"
"@\n"
"@\n"
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
".\n"
".\n"
".\n"
".\n"
"O\n"
"O\n"
"b\n"
"b\n"
;

static char *focusButtonRightPixels =
"bbb \n"
"bbbb\n"
"@Obb\n"
"OObb\n"
"OObb\n"
"OObb\n"
"OObb\n"
"OObb\n"
"OObb\n"
"OObb\n"
"OObb\n"
"OObb\n"
"OObb\n"
"OObb\n"
"OObb\n"
"OObb\n"
"OObb\n"
"OObb\n"
"OObb\n"
"OObb\n"
"OObb\n"
"OObb\n"
"OObb\n"
"OObb\n"
"OObb\n"
"OObb\n"
"bbbb\n"
"bbb \n"
;

static char *buttonDownLeftPixels =
" bb\n"
"bbb\n"
"bbO\n"
"bbO\n"
"bbO\n"
"bbO\n"
"bbO\n"
"bbO\n"
"bbO\n"
"bbO\n"
"bbO\n"
"bbO\n"
"bbO\n"
"bbO\n"
"bbO\n"
"bbO\n"
"bbO\n"
"bbO\n"
"bbO\n"
"bbO\n"
"bbO\n"
"bbO\n"
"bbO\n"
"bbO\n"
"bbO\n"
"bbO\n"
"bbb\n"
" bb\n"
;

static char *buttonDownMiddlePixels =
"b\n"
"b\n"
"O\n"
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
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
"b\n"
"b\n"
;

static char *buttonDownRightPixels =
"b \n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"bb\n"
"b \n"
;

static char *normalButtonLeftPixels =
" bb\n"
"b@@\n"
"b@@\n"
"b@@\n"
"b@@\n"
"b@@\n"
"b@@\n"
"b@@\n"
"b@@\n"
"b@@\n"
"b@@\n"
"b@@\n"
"b@@\n"
"b@@\n"
"b@@\n"
"b@@\n"
"b@@\n"
"b@@\n"
"b@@\n"
"b@@\n"
"b@@\n"
"b@@\n"
"b@@\n"
"b@@\n"
"b@@\n"
"b@O\n"
"bOO\n"
" bb\n"
;
static char *normalButtonMiddlePixels =
"b\n"
"@\n"
"@\n"
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
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
"O\n"
"O\n"
"b\n"
;
static char *normalButtonRightPixels =
"bb \n"
"@Ob\n"
"OOb\n"
"OOb\n"
"OOb\n"
"OOb\n"
"OOb\n"
"OOb\n"
"OOb\n"
"OOb\n"
"OOb\n"
"OOb\n"
"OOb\n"
"OOb\n"
"OOb\n"
"OOb\n"
"OOb\n"
"OOb\n"
"OOb\n"
"OOb\n"
"OOb\n"
"OOb\n"
"OOb\n"
"OOb\n"
"OOb\n"
"OOb\n"
"OOb\n"
"bb \n"
;

static char *textBorderLeftPixels =
" O\n"
"O \n"
"X \n"
"O \n"
"X \n"
"O \n"
"X \n"
"O \n"
"X \n"
"O \n"
"X \n"
"O \n"
"X \n"
"O \n"
"X \n"
"O \n"
"X \n"
"O \n"
" O\n"
;

static char *textBorderMiddlePixels =
"XO\n"
"  \n"
"  \n"
"  \n"
"  \n"
"  \n"
"  \n"
"  \n"
"  \n"
"  \n"
"  \n"
"  \n"
"  \n"
"  \n"
"  \n"
"  \n"
"  \n"
"  \n"
"XO\n"
;

static char *textBorderRightPixels =
".\n"
"O\n"
"X\n"
"O\n"
"X\n"
"O\n"
"X\n"
"O\n"
"X\n"
"O\n"
"X\n"
"O\n"
"X\n"
"O\n"
"X\n"
"O\n"
"X\n"
"O\n"
".\n"
;



@implementation Definitions(fjekwlfmkldsmfkldsjflkfjdskfjksdfjsdkjfksd)
+ (id)testHotDogStandProgramBox
{
    id obj = [@"HotDogStandProgramBox" asInstance];
    [obj setValue:@"TITLE" forKey:@"text"];
    [obj setValue:@"OK" forKey:@"okText"];
    return obj;
}
@end

@interface HotDogStandProgramBox : IvarObject
{
    char _separator;
    BOOL _eof;
    id _text;
    id _line;
    Int4 _okRect;
    id _okText;
    char _buttonDown;
    char _buttonHover;
    int _dialogMode;
    id _partialLine;
    char _focus;
}
@end
@implementation HotDogStandProgramBox
- (id)init
{
    self = [super init];
    if (self) {
        _focus = 'o';
    }
    return self;
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
    id windowBackgroundColor = [Definitions valueForEnvironmentVariable:@"HOTDOG_WINDOWBACKGROUNDCOLOR"];
    if (!windowBackgroundColor) {
        windowBackgroundColor = @"red";
    }
    id windowTextColor = [Definitions valueForEnvironmentVariable:@"HOTDOG_WINDOWTEXTCOLOR"];
    if (!windowTextColor) {
        windowTextColor = @"white";
    }

    [bitmap useWinSystemFont];

    [bitmap setColor:windowBackgroundColor];
    [bitmap fillRect:r];

    char *palette = "b #000000\n. #ffffff\n";
    [bitmap drawCString:iconPixels palette:iconPalette x:28 y:28];

    int x = 89;
    int y = 24;

    // text

    int textWidth = r.w - 89 - 18;
    if (_text) {
        id text = [bitmap fitBitmapString:_text width:textWidth];
        int textHeight = [bitmap bitmapHeightForText:text];
        [bitmap setColor:windowTextColor];
        [bitmap drawBitmapText:text x:x y:y];
        y += textHeight + 16;
    }

    if (_line) {
        id text = [bitmap fitBitmapString:_line width:textWidth];
        [bitmap setColor:windowTextColor];
        [bitmap drawBitmapText:text x:x y:y];
        y += 32;
    }

    // metrics

    int okTextWidth = (_okText) ? [bitmap bitmapWidthForText:_okText] : 0;
    int okTextHeight = (_okText) ? [bitmap bitmapHeightForText:_okText] : 0;
    int okButtonWidth = [Definitions widthForCString:focusButtonPixels];
    int okButtonHeight = [Definitions heightForCString:focusButtonPixels];
    if (okTextWidth > 44) {
        okButtonWidth = okTextWidth+14;
    }
    _okRect.w = okButtonWidth;
    _okRect.h = okButtonHeight;
    _okRect.x = r.x+(r.w-okButtonWidth)/2;
    _okRect.y = r.y+r.h-okButtonHeight-11;
NSLog(@"okButtonWidth %d okTextWidth %d", okButtonWidth, okTextWidth);

    // ok button

    if (_okText) {
        if (_eof) {
            if ((_buttonDown == 'o') && (_buttonHover == 'o')) {
                int okTextX = _okRect.x+(_okRect.w-okTextWidth)/2;
                int okTextY = _okRect.y+(_okRect.h-okTextHeight)/2+2;
    [Definitions drawInBitmap:bitmap left:buttonDownLeftPixels middle:buttonDownMiddlePixels right:buttonDownRightPixels x:_okRect.x y:_okRect.y w:_okRect.w palette:buttonPalette];

                [bitmap setColorIntR:0 g:0 b:0 a:255];
                [bitmap drawBitmapText:_okText x:okTextX y:okTextY];
    [Definitions drawInBitmap:bitmap left:textBorderLeftPixels middle:textBorderMiddlePixels right:textBorderRightPixels x:okTextX-2 y:okTextY-3 w:okTextWidth+4 palette:buttonPalette];
            } else if (_focus == 'o') {
                int okTextX = _okRect.x+(_okRect.w-okTextWidth)/2-1;
                int okTextY = _okRect.y+(_okRect.h-okTextHeight)/2+1;
[Definitions drawInBitmap:bitmap left:focusButtonLeftPixels middle:focusButtonMiddlePixels right:focusButtonRightPixels x:_okRect.x y:_okRect.y w:_okRect.w palette:buttonPalette];

                [bitmap setColorIntR:0 g:0 b:0 a:255];
                [bitmap drawBitmapText:_okText x:okTextX y:okTextY];
[Definitions drawInBitmap:bitmap left:textBorderLeftPixels middle:textBorderMiddlePixels right:textBorderRightPixels x:okTextX-2 y:okTextY-3 w:okTextWidth+4 palette:buttonPalette];
            } else {
                int okTextX = _okRect.x+(_okRect.w-okTextWidth)/2-1;
                int okTextY = _okRect.y+(_okRect.h-okTextHeight)/2+1;
    [Definitions drawInBitmap:bitmap left:normalButtonLeftPixels middle:normalButtonMiddlePixels right:normalButtonRightPixels x:_okRect.x y:_okRect.y w:_okRect.w palette:buttonPalette];

                [bitmap setColorIntR:0 g:0 b:0 a:255];
                [bitmap drawBitmapText:_okText x:okTextX y:okTextY];
            }
        } else {
            id text = @"Please wait...";
            int textWidth = [bitmap bitmapWidthForText:text];
            [bitmap setColor:windowTextColor];
            Int4 textRect = _okRect;
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
    id str = [event valueForKey:@"keyString"];
    if ([str isEqual:@"return"] || [str isEqual:@"shift-return"]) {
        if (_eof) {
            if (_dialogMode) {
                exit(0);
            }
            id x11dict = [event valueForKey:@"x11dict"];
            [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
        }
    }
}
@end

