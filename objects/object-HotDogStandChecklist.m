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



static char *checkboxPixels =
"ooooooooooooo\n"
"o           o\n"
"o           o\n"
"o           o\n"
"o           o\n"
"o           o\n"
"o           o\n"
"o           o\n"
"o           o\n"
"o           o\n"
"o           o\n"
"o           o\n"
"ooooooooooooo\n"
;
static char *checkboxDownPixels =
"ooooooooooooo\n"
"ooooooooooooo\n"
"oo         oo\n"
"oo         oo\n"
"oo         oo\n"
"oo         oo\n"
"oo         oo\n"
"oo         oo\n"
"oo         oo\n"
"oo         oo\n"
"oo         oo\n"
"ooooooooooooo\n"
"ooooooooooooo\n"
;
static char *checkboxSelectedPixels =
"ooooooooooooo\n"
"oo         oo\n"
"o o       o o\n"
"o  o     o  o\n"
"o   o   o   o\n"
"o    o o    o\n"
"o     o     o\n"
"o    o o    o\n"
"o   o   o   o\n"
"o  o     o  o\n"
"o o       o o\n"
"oo         oo\n"
"ooooooooooooo\n"
;
static char *checkboxSelectedDownPixels =
"ooooooooooooo\n"
"ooooooooooooo\n"
"ooo       ooo\n"
"oo o     o oo\n"
"oo  o   o  oo\n"
"oo   o o   oo\n"
"oo    o    oo\n"
"oo   o o   oo\n"
"oo  o   o  oo\n"
"oo o     o oo\n"
"ooo       ooo\n"
"ooooooooooooo\n"
"ooooooooooooo\n"
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

static char *buttonPixels =
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

static char *buttonLeftPixels =
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
static char *buttonMiddlePixels =
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
static char *buttonRightPixels =
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


static char *textTopBorderLeftPixels =
" O\n"
"O \n"
;

static char *textTopBorderMiddlePixels =
"XO\n"
"  \n"
;

static char *textTopBorderRightPixels =
".\n"
"O\n"
;

static char *textSideBorderPixels =
"X\n"
"O\n"
;

static char *textBottomBorderLeftPixels =
" O\n"
;

static char *textBottomBorderMiddlePixels =
"XO\n"
;

static char *textBottomBorderRightPixels =
".\n"
;



#define MAX_CHECKBOXES 20

@implementation Definitions(fjewmfnkdslnfsdjflfjdskfjksldjfkkfjdksjffjdsk)
+ (id)HotDogStandChecklist
{
    id lines = [Definitions linesFromStandardInput];
    id obj = [@"HotDogStandChecklist" asInstance];
    [obj setValue:@"jfkdlsjflkdsjfkljdsklf" forKey:@"text"];
    [obj setValue:lines forKey:@"array"];
    [obj setValue:@"OK" forKey:@"okText"];
    [obj setValue:@"Cancel" forKey:@"cancelText"];
    [obj setValue:@"1" forKey:@"dialogMode"];
    return obj;
}
@end

@interface HotDogStandChecklist : IvarObject
{
    int _dialogMode;
    id _text;
    id _array;
    BOOL _checked[MAX_CHECKBOXES];
    Int4 _rect[MAX_CHECKBOXES];
    char _down;
    char _hover;
    Int4 _okRect;
    Int4 _cancelRect;
    id _okText;
    id _cancelText;
    int _returnKey;
    int _spaceKey;
    char _focus;
}
@end
@implementation HotDogStandChecklist
- (id)init
{
    self = [super init];
    if (self) {
        _focus = 'o';
    }
    return self;
}
- (BOOL)getCheckedForIndex:(int)index
{
    if ((index >= 0) && (index < MAX_CHECKBOXES)) {
        return _checked[index];
    }
    return NO;
}
- (void)setChecked:(BOOL)checked forIndex:(int)index
{
    if ((index >= 0) && (index < MAX_CHECKBOXES)) {
        _checked[index] = checked;
    }
}
- (int)preferredWidth
{
    return 640;
}
- (int)preferredHeight
{
    id bitmap = [Definitions bitmapWithWidth:1 height:1];
    [bitmap useWinSystemFont];
    int lineHeight = [bitmap bitmapHeightForText:@"X"];
    int checkboxWidth = [Definitions widthForCString:checkboxPixels];
    int h = 24;
    int w = 640;
    {
        id text = [bitmap fitBitmapString:_text width:w-89-18];
        h += [bitmap bitmapHeightForText:text] + lineHeight;
    }
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        id text = [elt valueForKey:@"text"];
        if (!text) {
            text = elt;
        }
        text = [bitmap fitBitmapString:text width:w-checkboxWidth-10-lineHeight];
        h += [bitmap bitmapHeightForText:text] + lineHeight/2;
    }
    h += 21 + 28 + 21;
    return h;
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
    id checkboxPalette = nsfmt(@"o %@\n", [windowTextColor asRGBColor]);
    char *checkbox_palette = [checkboxPalette UTF8String];

    [bitmap useWinSystemFont];

    [bitmap setColor:windowBackgroundColor];
    [bitmap fillRect:r];

    char *palette = "b #000000\n. #ffffff\n";
    [bitmap drawCString:iconPixels palette:iconPalette x:28 y:28];

    int x = 89;
    int y = 24;

    int lineHeight = [bitmap bitmapHeightForText:@"X"];

    // text

    {
        int textWidth = r.w - x - 18;
        id text = [bitmap fitBitmapString:_text width:textWidth];
        int textHeight = [bitmap bitmapHeightForText:text];
        [bitmap setColor:windowTextColor];
        [bitmap drawBitmapText:text x:x y:y];
        y += textHeight + lineHeight;
    }

    // buttons

    int checkboxWidth = [Definitions widthForCString:checkboxPixels];
    int checkboxHeight = [Definitions heightForCString:checkboxPixels];
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        id text = [elt valueForKey:@"text"];
        if (!text) {
            text = elt;
        }
        _rect[i].x = x;
        _rect[i].y = y;
        text = [bitmap fitBitmapString:text width:r.w-checkboxWidth-10-(x-r.x)];
        int textWidth = [bitmap bitmapWidthForText:text];
        int textHeight = [bitmap bitmapHeightForText:text];
        _rect[i].w = checkboxWidth+10+textWidth;
        _rect[i].h = textHeight;
        char *pixels = checkboxPixels;
        char *palette = checkbox_palette;
        if (((_down==i+1) && (_hover==i+1)) || (_spaceKey && (_focus==i+1))) {
            if ([self getCheckedForIndex:i]) {
                pixels = checkboxSelectedDownPixels;
            } else {
                pixels = checkboxDownPixels;
            }
        } else {
            if ([self getCheckedForIndex:i]) {
                pixels = checkboxSelectedPixels;
            }
        }
        [bitmap drawCString:pixels palette:palette x:x y:y];
        [bitmap drawBitmapText:text x:x+checkboxWidth+10 y:y+1];
if (_focus == i+1) {
    [Definitions drawInBitmap:bitmap left:textTopBorderLeftPixels middle:textTopBorderMiddlePixels right:textTopBorderRightPixels x:_rect[i].x+checkboxWidth+10-2 y:_rect[i].y+1-3 w:textWidth+4 palette:buttonPalette];
    [Definitions drawInBitmap:bitmap top:textSideBorderPixels palette:buttonPalette middle:textSideBorderPixels palette:buttonPalette bottom:textSideBorderPixels palette:buttonPalette x:_rect[i].x+checkboxWidth+10-2 y:_rect[i].y+1-3+2 h:textHeight+2];
    [Definitions drawInBitmap:bitmap top:textSideBorderPixels palette:buttonPalette middle:textSideBorderPixels palette:buttonPalette bottom:textSideBorderPixels palette:buttonPalette x:_rect[i].x+_rect[i].w+2 y:_rect[i].y+1-3+2 h:textHeight+2];
NSLog(@"textHeight %d", textHeight);
    [Definitions drawInBitmap:bitmap left:textBottomBorderLeftPixels middle:textBottomBorderMiddlePixels right:textBottomBorderRightPixels x:_rect[i].x+checkboxWidth+10-2 y:_rect[i].y+1-3+textHeight+4 w:textWidth+4 palette:buttonPalette];
}
        y += textHeight + lineHeight/2;
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
NSLog(@"okButtonWidth %d okTextWidth %d", okButtonWidth, okTextWidth);

    int cancelTextWidth = [bitmap bitmapWidthForText:_cancelText];
    int cancelTextHeight = [bitmap bitmapHeightForText:_cancelText];
    int cancelButtonWidth = [Definitions widthForCString:buttonPixels];
    int cancelButtonHeight = [Definitions heightForCString:buttonPixels];
    if (cancelTextWidth > 44) {
        cancelButtonWidth = cancelTextWidth+14;
    }
    _cancelRect.w = cancelButtonWidth;
    _cancelRect.h = cancelButtonHeight;
NSLog(@"cancelButtonWidth %d cancelTextWidth %d", cancelButtonWidth, cancelTextWidth);

    if (_okText && _cancelText) {
        if (_okRect.w > _cancelRect.w) {
            _cancelRect.w = _okRect.w;
        } else if (_okRect.w < _cancelRect.w) {
            _okRect.w = _cancelRect.w;
        }
        _okRect.x = r.x+(r.w-_okRect.w-_cancelRect.w-16)/2;
        _okRect.y = r.y+r.h-okButtonHeight-11;
        _cancelRect.x = _okRect.x + _okRect.w + 16;
        _cancelRect.y = _okRect.y;
    } else if (_okText) {
        _okRect.x = r.x+(r.w-okButtonWidth)/2;
        _okRect.y = r.y+r.h-okButtonHeight-11;
    } else if (_cancelText) {
        _cancelRect.x = r.x+(r.w-cancelButtonWidth)/2;
        _cancelRect.y = r.y+r.h-cancelButtonHeight-11;
    }


    // ok button

    if (_okText) {
        BOOL okButtonDown = NO;        
        if ((_down == 'o') && (_hover == 'o')) {
            okButtonDown = YES;
        } else if (_returnKey && (_focus == 'o')) {
            okButtonDown = YES;
        }
        if (okButtonDown) {
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
[Definitions drawInBitmap:bitmap left:buttonLeftPixels middle:buttonMiddlePixels right:buttonRightPixels x:_okRect.x y:_okRect.y w:_okRect.w palette:buttonPalette];

            [bitmap setColorIntR:0 g:0 b:0 a:255];
            [bitmap drawBitmapText:_okText x:okTextX y:okTextY];
        }
    } else {
        _okRect.x = 0;
        _okRect.y = 0;
        _okRect.w = 0;
        _okRect.h = 0;
    }

    // cancel button

    if (_cancelText) {
        BOOL cancelButtonDown = NO;
        if ((_down == 'c') && (_hover == 'c')) {
            cancelButtonDown = YES;
        } else if (_returnKey && (_focus == 'c')) {
            cancelButtonDown = YES;
        }
        if (cancelButtonDown) {
            int cancelTextX = _cancelRect.x+(_cancelRect.w-cancelTextWidth)/2;
            int cancelTextY = _cancelRect.y+(_cancelRect.h-cancelTextHeight)/2+2;
[Definitions drawInBitmap:bitmap left:buttonDownLeftPixels middle:buttonDownMiddlePixels right:buttonDownRightPixels x:_cancelRect.x y:_cancelRect.y w:_cancelRect.w palette:buttonPalette];

            [bitmap setColorIntR:0 g:0 b:0 a:255];
            [bitmap drawBitmapText:_cancelText x:cancelTextX y:cancelTextY];
[Definitions drawInBitmap:bitmap left:textBorderLeftPixels middle:textBorderMiddlePixels right:textBorderRightPixels x:cancelTextX-2 y:cancelTextY-3 w:cancelTextWidth+4 palette:buttonPalette];
        } else if (_focus == 'c') {
            int cancelTextX = _cancelRect.x+(_cancelRect.w-cancelTextWidth)/2-1;
            int cancelTextY = _cancelRect.y+(_cancelRect.h-cancelTextHeight)/2+1;
[Definitions drawInBitmap:bitmap left:focusButtonLeftPixels middle:focusButtonMiddlePixels right:focusButtonRightPixels x:_cancelRect.x y:_cancelRect.y w:_cancelRect.w palette:buttonPalette];

            [bitmap setColorIntR:0 g:0 b:0 a:255];
            [bitmap drawBitmapText:_cancelText x:cancelTextX y:cancelTextY];
[Definitions drawInBitmap:bitmap left:textBorderLeftPixels middle:textBorderMiddlePixels right:textBorderRightPixels x:cancelTextX-2 y:cancelTextY-3 w:cancelTextWidth+4 palette:buttonPalette];
        } else {
            int cancelTextX = _cancelRect.x+(_cancelRect.w-cancelTextWidth)/2-1;
            int cancelTextY = _cancelRect.y+(_cancelRect.h-cancelTextHeight)/2+1;
[Definitions drawInBitmap:bitmap left:buttonLeftPixels middle:buttonMiddlePixels right:buttonRightPixels x:_cancelRect.x y:_cancelRect.y w:_cancelRect.w palette:buttonPalette];

            [bitmap setColorIntR:0 g:0 b:0 a:255];
            [bitmap drawBitmapText:_cancelText x:cancelTextX y:cancelTextY];
        }
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
        _down = 'o';
        _hover = 'o';
        _focus = 'o';
        return;
    }
    if (_cancelText && [Definitions isX:mouseX y:mouseY insideRect:_cancelRect]) {
        _down = 'c';
        _hover = 'c';
        _focus = 'c';
        return;
    }
    for (int i=0; i<[_array count]; i++) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_rect[i]]) {
            _down = i+1;
            _hover = i+1;
            return;
        }
    }
    _down = 0;
    _hover = 0;
}
- (void)handleMouseMoved:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    if (_okText && [Definitions isX:mouseX y:mouseY insideRect:_okRect]) {
        _hover = 'o';
        return;
    }
    if (_cancelText && [Definitions isX:mouseX y:mouseY insideRect:_cancelRect]) {
        _hover = 'c';
        return;
    }
    for (int i=0; i<[_array count]; i++) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_rect[i]]) {
            _hover = i+1;
            return;
        }
    }
    _hover = 0;
}
- (void)handleMouseUp:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    if (_down && (_down == _hover)) {
        if (_down == 'o') {
            if (_dialogMode) {
                [self exitWithDialogMode];
            }
        } else if (_down == 'c') {
            if (_dialogMode) {
                exit(1);
            }
        } else {
            if ([self getCheckedForIndex:_down-1]) {
                [self setChecked:NO forIndex:_down-1];
            } else {
                [self setChecked:YES forIndex:_down-1];
            }
        }
    }
    _down = 0;
}
- (void)handleKeyDown:(id)event
{
    _spaceKey = 0;

    id str = [event valueForKey:@"keyString"];
    if ([str isEqual:@"return"] || [str isEqual:@"shift-return"]) {
        if (_dialogMode) {
            [self exitWithDialogMode];
        }
    } else if ([str isEqual:@"tab"]) {
        if (_focus == 'o') {
            _focus = 'c';
        } else if (_focus == 'c') {
            int count = [_array count];
            if (count) {
                _focus = 1;
            } else {
                _focus = 'o';
            }
        } else {
            int count = [_array count];
            if (count) {
                _focus++;
                if (_focus > count) {
                    _focus = 'o';
                }
            } else {
                _focus = 'o';
            }
        }
    } else if ([str isEqual:@"shift-tab"]) {
        if (_focus == 'o') {
            int count = [_array count];
            if (count) {
                _focus = count;
            } else {
                _focus = 'c';
            }
        } else if (_focus == 'c') {
            _focus = 'o';
        } else {
            int count = [_array count];
            if (count) {
                _focus--;
                if (_focus < 1) {
                    _focus = 'c';
                }
            } else {
                _focus = 'c';
            }
        }
    } else if ([str isEqual:@"space"]) {
        _spaceKey = 1;
    }
}
- (void)handleKeyUp:(id)event
{
    _spaceKey = 0;

    id str = [event valueForKey:@"keyString"];
    if ([str isEqual:@"space"]) {
        int count = [_array count];
        if (count) {
            if ((_focus >= 1) && (_focus <= count)) {
                if ([self getCheckedForIndex:_focus-1]) {
                    [self setChecked:NO forIndex:_focus-1];
                } else {
                    [self setChecked:YES forIndex:_focus-1];
                }
            }
        }
    }
}
- (void)exitWithDialogMode
{
    BOOL first = YES;
    for (int i=0; i<[_array count]; i++) {
        if ([self getCheckedForIndex:i]) {
            id elt = [_array nth:i];
            id tag = [elt valueForKey:@"tag"];
            if (first) {
                first = NO;
            } else {
                if (_dialogMode == 1) {
                    NSOut(@" ");
                } else {
                    NSErr(@" ");
                }
            }
            if (_dialogMode == 1) {
                NSOut(@"%@", (tag) ? tag : elt);
            } else {
                NSErr(@"%@", (tag) ? tag : elt);
            }
        }
    }
    exit(0);
}
@end

