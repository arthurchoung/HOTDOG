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

static char *checkbox_pixels =
"bbbbbbbbbbbb\n"
"b          b\n"
"b          b\n"
"b          b\n"
"b          b\n"
"b          b\n"
"b          b\n"
"b          b\n"
"b          b\n"
"b          b\n"
"b          b\n"
"bbbbbbbbbbbb\n"
;
static char *checkbox_selected_pixels =
"bbbbbbbbbbbb\n"
"bb        bb\n"
"b b      b b\n"
"b  b    b  b\n"
"b   b  b   b\n"
"b    bb    b\n"
"b    bb    b\n"
"b   b  b   b\n"
"b  b    b  b\n"
"b b      b b\n"
"bb        bb\n"
"bbbbbbbbbbbb\n"
;
static char *checkbox_down_pixels =
"bbbbbbbbbbbb\n"
"bbbbbbbbbbbb\n"
"bb        bb\n"
"bb        bb\n"
"bb        bb\n"
"bb        bb\n"
"bb        bb\n"
"bb        bb\n"
"bb        bb\n"
"bb        bb\n"
"bbbbbbbbbbbb\n"
"bbbbbbbbbbbb\n"
;

#define MAX_CHECKBOXES 20

@implementation Definitions(fjewmfnkdslnfsdjflfjdskfjksldjfkkfjdksfjksd)
+ (id)AtariSTChecklist
{
    id lines = [Definitions linesFromStandardInput];
    id obj = [@"AtariSTChecklist" asInstance];
    [obj setValue:@"jfkdlsjflkdsjfkljdsklf" forKey:@"text"];
    [obj setValue:lines forKey:@"array"];
    [obj setValue:@"OK" forKey:@"okText"];
    [obj setValue:@"Cancel" forKey:@"cancelText"];
    [obj setValue:@"1" forKey:@"dialogMode"];
    return obj;
}
@end

@interface AtariSTChecklist : IvarObject
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
    int _HOTDOGNOFRAME;
    int _buttonDownX;
    int _buttonDownY;
}
@end
@implementation AtariSTChecklist
- (id)init
{
    self = [super init];
    if (self) {
        _HOTDOGNOFRAME = 1;
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
    [bitmap useAtariSTFont];
    int lineHeight = [bitmap bitmapHeightForText:@"X"];
    int checkboxWidth = [Definitions widthForCString:checkbox_pixels];
    int h = 24;
    int w = 640-18-18;
    {
        id text = [bitmap fitBitmapString:_text width:w];
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
    [bitmap useAtariSTFont];

    [bitmap setColor:@"white"];
    [bitmap fillRect:r];
    [Definitions drawInBitmap:bitmap left:topBorderLeftPixels middle:topBorderMiddlePixels right:topBorderRightPixels x:r.x y:r.y w:r.w palette:borderPalette];
    [Definitions drawInBitmap:bitmap top:leftBorderPixels palette:borderPalette middle:leftBorderPixels palette:borderPalette bottom:leftBorderPixels palette:borderPalette x:r.x y:r.y+4 h:r.h-8];
    [Definitions drawInBitmap:bitmap top:rightBorderPixels palette:borderPalette middle:rightBorderPixels palette:borderPalette bottom:rightBorderPixels palette:borderPalette x:r.x+r.w-4 y:r.y+4 h:r.h-8];
    [Definitions drawInBitmap:bitmap left:bottomBorderLeftPixels middle:bottomBorderMiddlePixels right:bottomBorderRightPixels x:r.x y:r.y+r.h-4 w:r.w palette:borderPalette];

    int x = 18;
    int y = 24;

    int lineHeight = [bitmap bitmapHeightForText:@"X"];

    // text

    {
        int textWidth = r.w - x - 18;
        id text = [bitmap fitBitmapString:_text width:textWidth];
        int textHeight = [bitmap bitmapHeightForText:text];
        [bitmap setColorIntR:0 g:0 b:0 a:255];
        [bitmap drawBitmapText:text x:x y:y];
        y += textHeight + lineHeight;
    }

    // buttons

    int checkboxWidth = [Definitions widthForCString:checkbox_pixels];
    int checkboxHeight = [Definitions heightForCString:checkbox_pixels];
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        id text = [elt valueForKey:@"text"];
        if (!text) {
            text = elt;
        }
        _rect[i].x = x;
        _rect[i].y = y;
        text = [bitmap fitBitmapString:text width:r.w-checkboxWidth-10-(x-r.x)-20];
        int textWidth = [bitmap bitmapWidthForText:text];
        int textHeight = [bitmap bitmapHeightForText:text];
        _rect[i].w = checkboxWidth+10+textWidth;
        _rect[i].h = textHeight;
        char *str = checkbox_pixels;
        if ((_down==i+1) && (_hover==i+1)) {
            str = checkbox_down_pixels;
        }
        [bitmap drawCString:str x:x y:y+3 c:'b' r:0 g:0 b:0 a:255];
        if ([self getCheckedForIndex:i]) {
            [bitmap drawCString:checkbox_selected_pixels x:x y:y+3 c:'b' r:0 g:0 b:0 a:255];
        }
        [bitmap drawBitmapText:text x:x+checkboxWidth+10 y:y+1];
        y += textHeight + lineHeight/2;
    }

    // metrics

    int okTextWidth = (_okText) ? [bitmap bitmapWidthForText:_okText] : 0;
    int okTextHeight = (_okText) ? [bitmap bitmapHeightForText:_okText] : 0;
    int okButtonWidth = 70;
    int okButtonHeight = 22;
    if (okTextWidth+14 > 70) {
        okButtonWidth = okTextWidth+14;
    }
    _okRect.w = okButtonWidth;
    _okRect.h = okButtonHeight;
NSLog(@"okButtonWidth %d okTextWidth %d", okButtonWidth, okTextWidth);

    int cancelTextWidth = [bitmap bitmapWidthForText:_cancelText];
    int cancelTextHeight = [bitmap bitmapHeightForText:_cancelText];
    int cancelButtonWidth = 70;
    int cancelButtonHeight = 22;
    if (cancelTextWidth+14 > 70) {
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
        _okRect.x = r.x+(r.w-_okRect.w-_cancelRect.w-18)/2;
        _okRect.y = r.y+r.h-okButtonHeight-16;
        _cancelRect.x = _okRect.x + _okRect.w + 18;
        _cancelRect.y = _okRect.y;
    } else if (_okText) {
        _okRect.x = r.x+(r.w-okButtonWidth)/2;
        _okRect.y = r.y+r.h-okButtonHeight-16;
    } else if (_cancelText) {
        _cancelRect.x = r.x+(r.w-cancelButtonWidth)/2;
        _cancelRect.y = r.y+r.h-cancelButtonHeight-16;
    }

    // ok button

    if (_okText) {
        BOOL okButtonDown = NO;        
        if ((_down == 'o') && (_hover == 'o')) {
            okButtonDown = YES;
        }
        if (okButtonDown) {
            int okTextX = _okRect.x+(_okRect.w-okTextWidth)/2;
            int okTextY = _okRect.y+(_okRect.h-okTextHeight)/2;
[Definitions drawInBitmap:bitmap left:defaultButtonLeftPixels middle:defaultButtonDownMiddlePixels right:defaultButtonRightPixels x:_okRect.x y:_okRect.y w:_okRect.w palette:buttonPalette];

            [bitmap setColor:@"white"];
            [bitmap drawBitmapText:_okText x:okTextX y:okTextY];
        } else {
            int okTextX = _okRect.x+(_okRect.w-okTextWidth)/2-1;
            int okTextY = _okRect.y+(_okRect.h-okTextHeight)/2;
[Definitions drawInBitmap:bitmap left:defaultButtonLeftPixels middle:defaultButtonMiddlePixels right:defaultButtonRightPixels x:_okRect.x y:_okRect.y w:_okRect.w palette:buttonPalette];

            [bitmap setColor:@"black"];
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
        }
        if (cancelButtonDown) {
            int cancelTextX = _cancelRect.x+(_cancelRect.w-cancelTextWidth)/2;
            int cancelTextY = _cancelRect.y+(_cancelRect.h-cancelTextHeight)/2;
[Definitions drawInBitmap:bitmap left:buttonLeftPixels middle:buttonDownMiddlePixels right:buttonRightPixels x:_cancelRect.x y:_cancelRect.y w:_cancelRect.w palette:buttonPalette];

            [bitmap setColor:@"white"];
            [bitmap drawBitmapText:_cancelText x:cancelTextX y:cancelTextY];
        } else {
            int cancelTextX = _cancelRect.x+(_cancelRect.w-cancelTextWidth)/2-1;
            int cancelTextY = _cancelRect.y+(_cancelRect.h-cancelTextHeight)/2;
[Definitions drawInBitmap:bitmap left:buttonLeftPixels middle:buttonMiddlePixels right:buttonRightPixels x:_cancelRect.x y:_cancelRect.y w:_cancelRect.w palette:buttonPalette];

            [bitmap setColor:@"black"];
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
    {
        id x11dict = [event valueForKey:@"x11dict"];
        unsigned long win = [[x11dict valueForKey:@"window"] unsignedLongValue];
        id windowManager = [@"windowManager" valueForKey];
        [windowManager XRaiseWindow:win];
    }

    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    if (_okText && [Definitions isX:mouseX y:mouseY insideRect:_okRect]) {
        _down = 'o';
        _hover = 'o';
        return;
    }
    if (_cancelText && [Definitions isX:mouseX y:mouseY insideRect:_cancelRect]) {
        _down = 'c';
        _hover = 'c';
        return;
    }
    for (int i=0; i<[_array count]; i++) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_rect[i]]) {
            _down = i+1;
            _hover = i+1;
            return;
        }
    }
    _down = 'b';
    _hover = 0;
    _buttonDownX = mouseX;
    _buttonDownY = mouseY;
}
- (void)handleMouseMoved:(id)event
{
    if (_down == 'b') {
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
    id str = [event valueForKey:@"keyString"];
    if ([str isEqual:@"return"] || [str isEqual:@"shift-return"]) {
        if (_dialogMode) {
            [self exitWithDialogMode];
        }
    }
}
- (void)exitWithDialogMode
{
    BOOL first = YES;
    FILE *fp = (_dialogMode == 1) ? stdout : stderr;
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

