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

@implementation Definitions(jfovcnvieiwejfklsdjfklsdjlkfjsdlkfjjfkdjsfksjfjdksfjksd)
+ (void)enterOpenStepMode
{
    [Definitions enterOpenStepMode:1];
}
+ (void)enterOpenStepMode:(int)scaling
{
    if (scaling < 1) {
        scaling = 1;
    }
    [Definitions setValue:nsfmt(@"%d", scaling) forEnvironmentVariable:@"HOTDOG_SCALING"];

    id windowManager = [@"windowManager" valueForKey];
    [windowManager setFocusDict:nil];
    [windowManager unparentAllWindows];

    [Definitions setValue:@"openstep" forEnvironmentVariable:@"HOTDOG_MODE"];
    [windowManager setBackgroundForCString:"b\n" palette:"b #555577\n"];
    id rootWindowObject = [@"MacRootWindow" asInstance];
    [windowManager setValue:rootWindowObject forKey:@"rootWindowObject"];
    [windowManager reparentAllWindows:@"OpenStepWindow"];
    [[windowManager valueForKey:@"menuBar"] setValue:@"1" forKey:@"shouldCloseWindow"];
    int h = 20*scaling;
    [windowManager setValue:nsfmt(@"%d", h) forKey:@"menuBarHeight"];
    id menuBarObject = [@"HotDogStandMenuBar" asInstance];
    [menuBarObject setValue:@"1" forKey:@"hideWin31Buttons"];
    id menuBar = [windowManager openWindowForObject:menuBarObject x:0 y:0 w:[windowManager intValueForKey:@"rootWindowWidth"] h:h];
    [windowManager setValue:menuBar forKey:@"menuBar"];
    [windowManager setFocusDict:nil];
    [@"hotdog-setupWindowManagerMode.sh" runCommandInBackground];
}
@end


static char *_palette =
"  #000000\n"
". #555555\n"
"X #aaaaaa\n"
"o #ffffff\n"
;
static char *activeTitleBarLeftPixels =
"                   \n"
" XXXXXXXXXXXXXXXXXX\n"
" X                 \n"
" X                 \n"
" X  oooooooooooooo.\n"
" X  oXXXXXXXXXXXX. \n"
" X  oX          X. \n"
" X  oX          X. \n"
" X  oX          X. \n"
" X  oX XXXXXXXX X. \n"
" X  oX XXXXXXXX X. \n"
" X  oX XXXXXXXX X. \n"
" X  oX XXXXXXXX X. \n"
" X  oX XXXXXXXX X. \n"
" X  oX XXXXXXXX X. \n"
" X  oX          X. \n"
" X  oXXXXXXXXXXXX. \n"
" X  o............. \n"
" X  .              \n"
" X                 \n"
" X                 \n"
" X.................\n"
"                   \n"
;
static char *activeTitleBarMiddlePixels =
" \n"
"X\n"
" \n"
" \n"
" \n"
" \n"
" \n"
" \n"
" \n"
" \n"
" \n"
" \n"
" \n"
" \n"
" \n"
" \n"
" \n"
" \n"
" \n"
" \n"
" \n"
".\n"
" \n"
;
static char *activeTitleBarRightPixels =
"                   \n"
"XXXXXXXXXXXXXXXXXX \n"
"                 . \n"
"                 . \n"
"oooooooooooooo   . \n"
"oXXXXXXXXXXXX.   . \n"
"oX .XXXXXX. X.   . \n"
"oX. .XXXX. .X.   . \n"
"oXX. .XX. .XX.   . \n"
"oXXX. .. .XXX.   . \n"
"oXXXX.  .XXXX.   . \n"
"oXXXX.  .XXXX.   . \n"
"oXXX. .. .XXX.   . \n"
"oXX. .XX. .XX.   . \n"
"oX. .XXXX. .X.   . \n"
"oX .XXXXXX. X.   . \n"
"oXXXXXXXXXXXX.   . \n"
"o.............   . \n"
"                 . \n"
"                 . \n"
"                 . \n"
".................. \n"
"                   \n"
;
static char *inactiveTitleBarLeftPixels =
"                   \n"
" XXXXXXXXXXXXXXXXXX\n"
" XXXXXXXXXXXXXXXXXX\n"
" XXXXXXXXXXXXXXXXXX\n"
" XXXoooooooooooooo.\n"
" XXXoXXXXXXXXXXXX. \n"
" XXXoX          X. \n"
" XXXoX          X. \n"
" XXXoX          X. \n"
" XXXoX XXXXXXXX X. \n"
" XXXoX XXXXXXXX X. \n"
" XXXoX XXXXXXXX X. \n"
" XXXoX XXXXXXXX X. \n"
" XXXoX XXXXXXXX X. \n"
" XXXoX XXXXXXXX X. \n"
" XXXoX          X. \n"
" XXXoXXXXXXXXXXXX. \n"
" XXXo............. \n"
" XXX.              \n"
" XXXXXXXXXXXXXXXXXX\n"
" XXXXXXXXXXXXXXXXXX\n"
" X.................\n"
"                   \n"
;
static char *inactiveTitleBarMiddlePixels =
" \n"
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
".\n"
" \n"
;
static char *inactiveTitleBarRightPixels =
"                   \n"
"XXXXXXXXXXXXXXXXXX \n"
"XXXXXXXXXXXXXXXXX. \n"
"XXXXXXXXXXXXXXXXX. \n"
"oooooooooooooo XX. \n"
"oXXXXXXXXXXXX. XX. \n"
"oX .XXXXXX. X. XX. \n"
"oX. .XXXX. .X. XX. \n"
"oXX. .XX. .XX. XX. \n"
"oXXX. .. .XXX. XX. \n"
"oXXXX.  .XXXX. XX. \n"
"oXXXX.  .XXXX. XX. \n"
"oXXX. .. .XXX. XX. \n"
"oXX. .XX. .XX. XX. \n"
"oX. .XXXX. .X. XX. \n"
"oX .XXXXXX. X. XX. \n"
"oXXXXXXXXXXXX. XX. \n"
"o............. XX. \n"
"               XX. \n"
"XXXXXXXXXXXXXXXXX. \n"
"XXXXXXXXXXXXXXXXX. \n"
".................. \n"
"                   \n"
;
static char *leftBorderMiddlePixels =
" \n"
;
static char *bottomBorderLeftPixels =
" ..............................\n"
" oooooooooooooooooooooooooooooo\n"
" XXXXXXXXXXXXXXXXXXXXXXXXXXXX.o\n"
" XXXXXXXXXXXXXXXXXXXXXXXXXXXX.o\n"
" XXXXXXXXXXXXXXXXXXXXXXXXXXXX.o\n"
" XXXXXXXXXXXXXXXXXXXXXXXXXXXX.o\n"
" XXXXXXXXXXXXXXXXXXXXXXXXXXXX.o\n"
" XXXXXXXXXXXXXXXXXXXXXXXXXXXX.o\n"
"                               \n"
;
static char *bottomBorderMiddlePixels =
".\n"
"o\n"
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
"X\n"
" \n"
;
static char *bottomBorderRightPixels =
".............................. \n"
"oooooooooooooooooooooooooooooo \n"
".oXXXXXXXXXXXXXXXXXXXXXXXXXXXX \n"
".oXXXXXXXXXXXXXXXXXXXXXXXXXXXX \n"
".oXXXXXXXXXXXXXXXXXXXXXXXXXXXX \n"
".oXXXXXXXXXXXXXXXXXXXXXXXXXXXX \n"
".oXXXXXXXXXXXXXXXXXXXXXXXXXXXX \n"
".oXXXXXXXXXXXXXXXXXXXXXXXXXXXX \n"
"                               \n"
;
static char *rightBorderMiddlePixels =
" \n"
;
static char *iconifyButtonDownPixels =
"ooooooooooooooX\n"
"oooooooooooooX \n"
"oo..........oX \n"
"oo..........oX \n"
"oo..........oX \n"
"oo.oooooooo.oX \n"
"oo.oooooooo.oX \n"
"oo.oooooooo.oX \n"
"oo.oooooooo.oX \n"
"oo.oooooooo.oX \n"
"oo.oooooooo.oX \n"
"oo..........oX \n"
"oooooooooooooX \n"
"oXXXXXXXXXXXXX \n"
"X              \n"
;
static char *closeButtonDownPixels =
"oooooooooooooo \n"
"oooooooooooooX \n"
"oo.XooooooX.oX \n"
"ooX.XooooX.XoX \n"
"oooX.XooX.XooX \n"
"ooooX.XX.XoooX \n"
"oooooX..XooooX \n"
"oooooX..XooooX \n"
"ooooX.XX.XoooX \n"
"oooX.XooX.XooX \n"
"ooX.XooooX.XoX \n"
"oo.XooooooX.oX \n"
"oooooooooooooX \n"
"oXXXXXXXXXXXXX \n"
"               \n"
;

@interface OpenStepWindow : IvarObject
{
    int _leftBorder;
    int _rightBorder;
    int _topBorder;
    int _bottomBorder;

    char _buttonDown;
    char _buttonHover;
    int _buttonDownX;
    int _buttonDownY;
    int _buttonDownW;
    int _buttonDownH;
    Int4 _titleBarRect;
    Int4 _titleBarTextRect;
    Int4 _leftBorderRect;
    Int4 _rightBorderRect;
    Int4 _topBorderRect;
    Int4 _bottomBorderRect;
    Int4 _iconifyButtonRect;
    Int4 _closeButtonRect;
    Int4 _resizeButtonRect;

    // setPixelScale:
    int _pixelScaling;
    id _scaledFont;
    id _scaledActiveTitleBarLeftPixels;
    int _scaledActiveTitleBarLeftWidth;
    id _scaledActiveTitleBarMiddlePixels;
    int _scaledActiveTitleBarHeight;
    id _scaledActiveTitleBarRightPixels;
    int _scaledActiveTitleBarRightWidth;
    id _scaledInactiveTitleBarLeftPixels;
    id _scaledInactiveTitleBarMiddlePixels;
    id _scaledInactiveTitleBarRightPixels;
    id _scaledLeftBorderMiddlePixels;
    id _scaledBottomBorderLeftPixels;
    id _scaledBottomBorderMiddlePixels;
    id _scaledBottomBorderRightPixels;
    id _scaledRightBorderMiddlePixels;
    id _scaledIconifyButtonDownPixels;
    id _scaledCloseButtonDownPixels;
}
@end
@implementation OpenStepWindow
- (id)init
{
    self = [super init];
    if (self) {
        int scaling = [[Definitions valueForEnvironmentVariable:@"HOTDOG_SCALING"] intValue];
        if (scaling < 1) {
            scaling = 1;
        }
        [self setPixelScaling:scaling];
    }
    return self;
}
- (void)setPixelScaling:(int)scaling
{
    _pixelScaling = scaling;

    _leftBorder = 1*scaling;
    _rightBorder = 1*scaling;
    _topBorder = 23*scaling;
    _bottomBorder = 9*scaling;

    id obj;
    obj = [Definitions scaleFont:scaling
                    :[Definitions arrayOfCStringsForWinSystemFont]
                    :[Definitions arrayOfWidthsForWinSystemFont]
                    :[Definitions arrayOfHeightsForWinSystemFont]
                    :[Definitions arrayOfXSpacingsForWinSystemFont]];
    [self setValue:obj forKey:@"scaledFont"];

    obj = [nsfmt(@"%s", activeTitleBarLeftPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledActiveTitleBarLeftPixels"];
    _scaledActiveTitleBarLeftWidth = [Definitions widthForCString:[obj UTF8String]];

    obj = [nsfmt(@"%s", activeTitleBarMiddlePixels) asYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledActiveTitleBarMiddlePixels"];
    _scaledActiveTitleBarHeight = [Definitions heightForCString:[obj UTF8String]];

    obj = [nsfmt(@"%s", activeTitleBarRightPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledActiveTitleBarRightPixels"];
    _scaledActiveTitleBarRightWidth = [Definitions widthForCString:[obj UTF8String]];

    obj = [nsfmt(@"%s", inactiveTitleBarLeftPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledInactiveTitleBarLeftPixels"];

    obj = [nsfmt(@"%s", inactiveTitleBarMiddlePixels) asYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledInactiveTitleBarMiddlePixels"];

    obj = [nsfmt(@"%s", inactiveTitleBarRightPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledInactiveTitleBarRightPixels"];

    obj = [nsfmt(@"%s", leftBorderMiddlePixels) asXScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledLeftBorderMiddlePixels"];

    obj = [nsfmt(@"%s", bottomBorderLeftPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledBottomBorderLeftPixels"];

    obj = [nsfmt(@"%s", bottomBorderMiddlePixels) asYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledBottomBorderMiddlePixels"];

    obj = [nsfmt(@"%s", bottomBorderRightPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledBottomBorderRightPixels"];

    obj = [nsfmt(@"%s", rightBorderMiddlePixels) asXScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledRightBorderMiddlePixels"];

    obj = [nsfmt(@"%s", iconifyButtonDownPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledIconifyButtonDownPixels"];

    obj = [nsfmt(@"%s", closeButtonDownPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledCloseButtonDownPixels"];
}

- (void)calculateRects:(Int4)r
{
    _titleBarRect = [Definitions rectWithX:r.x y:r.y w:r.w h:_scaledActiveTitleBarHeight];
    _titleBarTextRect = _titleBarRect;
    _titleBarTextRect.x = _scaledActiveTitleBarLeftWidth+4*_pixelScaling;
    _titleBarTextRect.w -= _scaledActiveTitleBarLeftWidth+4*_pixelScaling;
    _titleBarTextRect.w -= _scaledActiveTitleBarRightWidth+4*_pixelScaling;

    _leftBorderRect = r;
    _leftBorderRect.y += _scaledActiveTitleBarHeight;
    _leftBorderRect.h -= _scaledActiveTitleBarHeight;
    _leftBorderRect.h -= _bottomBorder;
    _leftBorderRect.w = _leftBorder;

    _rightBorderRect = r;
    _rightBorderRect.x += r.w-_rightBorder;
    _rightBorderRect.y += _scaledActiveTitleBarHeight;
    _rightBorderRect.h -= _scaledActiveTitleBarHeight;
    _rightBorderRect.h -= _bottomBorder;
    _rightBorderRect.w = _rightBorder;

    _topBorderRect = _titleBarRect;
    _topBorderRect.h = 4*_pixelScaling;

    _bottomBorderRect = _titleBarRect;
    _bottomBorderRect.y += r.h-_bottomBorder;
    _bottomBorderRect.h = _bottomBorder;

    _iconifyButtonRect = _titleBarRect;
    _iconifyButtonRect.x += 4*_pixelScaling;
    _iconifyButtonRect.y += 4*_pixelScaling;
    _iconifyButtonRect.w = 15*_pixelScaling;
    _iconifyButtonRect.h = 15*_pixelScaling;

    _closeButtonRect = _titleBarRect;
    _closeButtonRect.x = _closeButtonRect.x+_closeButtonRect.w-(4+15)*_pixelScaling;
    _closeButtonRect.y += 4*_pixelScaling;
    _closeButtonRect.w = 15*_pixelScaling;
    _closeButtonRect.h = 15*_pixelScaling;
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [self drawInBitmap:bitmap rect:r context:nil];
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r context:(id)context
{
    if (_scaledFont) {
        [bitmap useFont:[[_scaledFont nth:0] bytes]
                    :[[_scaledFont nth:1] bytes]
                    :[[_scaledFont nth:2] bytes]
                    :[[_scaledFont nth:3] bytes]];
    }

    char *palette = _palette;
    int hasFocus = [context intValueForKey:@"hasFocus"];

    [self calculateRects:r];
    [bitmap setColor:@"white"];
    [bitmap fillRect:r];
    [bitmap setColor:@"black"];
    [bitmap drawHorizontalLineAtX:r.x x:r.x+r.w-1 y:r.y+r.h-1];
    [bitmap drawVerticalLineAtX:r.x+r.w-1 y:r.y y:r.y+r.h-1];
    if (hasFocus) {
        char *left = [_scaledActiveTitleBarLeftPixels UTF8String];
        char *middle = [_scaledActiveTitleBarMiddlePixels UTF8String];
        char *right = [_scaledActiveTitleBarRightPixels UTF8String];
        [Definitions drawInBitmap:bitmap left:left palette:palette middle:middle palette:palette right:right palette:palette x:_titleBarRect.x y:_titleBarRect.y w:_titleBarRect.w];
    } else {
        char *left = [_scaledInactiveTitleBarLeftPixels UTF8String];
        char *middle = [_scaledInactiveTitleBarMiddlePixels UTF8String];
        char *right = [_scaledInactiveTitleBarRightPixels UTF8String];
        [Definitions drawInBitmap:bitmap left:left palette:palette middle:middle palette:palette right:right palette:palette x:_titleBarRect.x y:_titleBarRect.y w:_titleBarRect.w];
    }
    if (_titleBarTextRect.w > 0) {
        id text = [context valueForKey:@"name"];
        if (!text) {
            text = @"(no title)";
        }

        text = [[[bitmap fitBitmapString:text width:_titleBarTextRect.w-14*_pixelScaling] split:@"\n"] nth:0];
        if (text) {
            int textWidth = [bitmap bitmapWidthForText:text];
            int backWidth = textWidth + 14*_pixelScaling;
            int backX = _titleBarTextRect.x + ((_titleBarTextRect.w - backWidth) / 2);
            int textX = backX + 7*_pixelScaling;
            if (hasFocus) {
                [bitmap setColor:@"white"];
                [bitmap drawBitmapText:text x:textX y:_titleBarTextRect.y+5*_pixelScaling];
            } else {
                [bitmap setColor:@"black"];
                [bitmap drawBitmapText:text x:textX y:_titleBarTextRect.y+5*_pixelScaling];
            }
        }
    }

    {
        char *middle = [_scaledLeftBorderMiddlePixels UTF8String];
        [Definitions drawInBitmap:bitmap top:middle palette:palette middle:middle palette:palette bottom:middle palette:palette x:_leftBorderRect.x y:_leftBorderRect.y h:_leftBorderRect.h];
    }
    {
        char *middle = [_scaledRightBorderMiddlePixels UTF8String];
        [Definitions drawInBitmap:bitmap top:middle palette:palette middle:middle palette:palette bottom:middle palette:palette x:_rightBorderRect.x y:_rightBorderRect.y h:_rightBorderRect.h];
    }

    {
        Int4 r = _bottomBorderRect;
        char *left = [_scaledBottomBorderLeftPixels UTF8String];
        char *middle = [_scaledBottomBorderMiddlePixels UTF8String];
        char *right = [_scaledBottomBorderRightPixels UTF8String];
        [Definitions drawInBitmap:bitmap left:left middle:middle right:right x:r.x y:r.y w:r.w palette:palette];
    }

    if (hasFocus) {
        if ((_buttonDown == 'i') && (_buttonHover == 'i')) {
            char *iconifyButtonDown = [_scaledIconifyButtonDownPixels UTF8String];
            [bitmap drawCString:iconifyButtonDown palette:palette x:_iconifyButtonRect.x y:_iconifyButtonRect.y];
        }
        if ((_buttonDown == 'c') && (_buttonHover == 'c')) {
            char *closeButtonDown = [_scaledCloseButtonDownPixels UTF8String];
            [bitmap drawCString:closeButtonDown palette:palette x:_closeButtonRect.x y:_closeButtonRect.y];
        }
    }

}
- (char)borderForX:(int)x y:(int)y w:(int)w h:(int)h
{
    if ((y >= 0) && (y < 4*_pixelScaling)) {
        if ((x >= 0) && (x < 31*_pixelScaling)) {
            return '7';
        } else if ((x >= w-31*_pixelScaling) && (x < w)) {
            return '9';
        } else {
            return '8';
        }
    } else if ((y >= h-9*_pixelScaling) && (y < h)) {
        if ((x >= 0) && (x < 31*_pixelScaling)) {
            return '1';
        } else if ((x >= w-31*_pixelScaling) && (x < w)) {
            return '3';
        } else {
            return '2';
        }
    } else if ((x >= 0) && (x < 4*_pixelScaling)) {
        if ((y >= 0) && (y < 9*_pixelScaling)) {
            return '7';
        } else if ((y >= h-9*_pixelScaling) && (y < h)) {
            return '1';
        } else {
            return '4';
        }
    } else if ((x >= w-4*_pixelScaling) && (x < w)) {
        if ((y >= 0) && (y < 9*_pixelScaling)) {
            return '9';
        } else if ((y >= h-9*_pixelScaling) && (y < h)) {
            return '3';
        } else {
            return '6';
        }
    }
    return 0;
}
- (void)handleMouseDown:(id)event
{
    id windowManager = [event valueForKey:@"windowManager"];
    id x11dict = [event valueForKey:@"x11dict"];
    [windowManager setFocusDict:x11dict];
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    int viewWidth = [event intValueForKey:@"viewWidth"];
    int viewHeight = [event intValueForKey:@"viewHeight"];
    if ([Definitions isX:mouseX y:mouseY insideRect:_iconifyButtonRect]) {
        _buttonDown = 'i';
        _buttonHover = 'i';
        _buttonDownX = mouseX;
        _buttonDownY = mouseY;
        _buttonDownW = viewWidth;
        _buttonDownH = viewHeight;
        return;
    }
    if ([Definitions isX:mouseX y:mouseY insideRect:_closeButtonRect]) {
        _buttonDown = 'c';
        _buttonHover = 'c';
        _buttonDownX = mouseX;
        _buttonDownY = mouseY;
        _buttonDownW = viewWidth;
        _buttonDownH = viewHeight;
        return;
    }
    int border = [self borderForX:mouseX y:mouseY w:viewWidth h:viewHeight];
    if (border) {
        if ((border == '1') || (border == '2') || (border == '3')) {
            _buttonDown = border;
            _buttonDownX = mouseX;
            _buttonDownY = mouseY;
            _buttonDownW = viewWidth;
            _buttonDownH = viewHeight;
            return;
        }
    }
    if ([Definitions isX:mouseX y:mouseY insideRect:_titleBarRect]) {
        _buttonDown = 't';
        _buttonDownX = mouseX;
        _buttonDownY = mouseY;
        _buttonDownW = viewWidth;
        _buttonDownH = viewHeight;
        return;
    }
}
- (void)handleMouseMoved:(id)event
{
    if (_buttonDown == 'i') {
        int mouseX = [event intValueForKey:@"mouseX"];
        int mouseY = [event intValueForKey:@"mouseY"];
        if ([Definitions isX:mouseX y:mouseY insideRect:_iconifyButtonRect]) {
            _buttonHover = 'i';
        } else {
            _buttonHover = 0;
        }
        return;
    }
    if (_buttonDown == 'c') {
        int mouseX = [event intValueForKey:@"mouseX"];
        int mouseY = [event intValueForKey:@"mouseY"];
        if ([Definitions isX:mouseX y:mouseY insideRect:_closeButtonRect]) {
            _buttonHover = 'c';
        } else {
            _buttonHover = 0;
        }
        return;
    }

    if (_buttonDown == 't') {
        id windowManager = [event valueForKey:@"windowManager"];
        int menuBarHeight = [windowManager intValueForKey:@"menuBarHeight"];
        int mouseRootX = [event intValueForKey:@"mouseRootX"];
        int mouseRootY = [event intValueForKey:@"mouseRootY"];
        int viewHeight = [event intValueForKey:@"viewHeight"];

        id dict = [event valueForKey:@"x11dict"];

        int newX = mouseRootX - _buttonDownX;
        int newY = mouseRootY - _buttonDownY;

        if (newX < 0) {
            newX = 0;
        }
        if (newY < menuBarHeight) {
            newY = menuBarHeight;
        }

        [dict setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];

        return;
    }

    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    int mouseRootX = [event intValueForKey:@"mouseRootX"];
    int mouseRootY = [event intValueForKey:@"mouseRootY"];
    id x11dict = [event valueForKey:@"x11dict"];
    int x = [x11dict intValueForKey:@"x"];
    int y = [x11dict intValueForKey:@"y"];
    int w = [x11dict intValueForKey:@"w"];
    int h = [x11dict intValueForKey:@"h"];
    id windowManager = [event valueForKey:@"windowManager"];
    if (!_buttonDown) {
        int border = [self borderForX:mouseX y:mouseY w:w h:h];
        if ((border == '1') || (border == '2') || (border == '3')) {
            [windowManager setX11Cursor:border];
        } else {
            [windowManager setX11Cursor:'5'];
        }
        return;
    }

    if (_buttonDown == '4') {
        if (mouseY < 0) {
            _buttonDown = '7';
            [windowManager setX11Cursor:_buttonDown];
        } else if (mouseY > h) {
            _buttonDown = '1';
            [windowManager setX11Cursor:_buttonDown];
        } else {
            int newX = mouseRootX;
            int newWidth = x+w - mouseRootX;
            if (newWidth < _leftBorder+_rightBorder) {
                newWidth = _leftBorder+_rightBorder;
            }
            [x11dict setValue:nsfmt(@"%d %d", newX, y) forKey:@"moveWindow"];
            [x11dict setValue:nsfmt(@"%d %d", newWidth, h) forKey:@"resizeWindow"];
            return;
        }
    }
    if (_buttonDown == '6') {
        if (mouseY < 0) {
            _buttonDown = '9';
            [windowManager setX11Cursor:_buttonDown];
        } else if (mouseY > h) {
            _buttonDown = '3';
            [windowManager setX11Cursor:_buttonDown];
        } else {
            int newWidth = mouseX;
            if (newWidth < _leftBorder+_rightBorder) {
                newWidth = _leftBorder+_rightBorder;
            }
            [x11dict setValue:nsfmt(@"%d %d", newWidth, h) forKey:@"resizeWindow"];
            return;
        }
    }
    if (_buttonDown == '2') {
        if (mouseX < 0) {
            _buttonDown = '1';
            [windowManager setX11Cursor:_buttonDown];
        } else if (mouseX > w) {
            _buttonDown = '3';
            [windowManager setX11Cursor:_buttonDown];
        } else {
            int newHeight = mouseY;
            if (newHeight < _topBorder+_bottomBorder) {
                newHeight = _topBorder+_bottomBorder;
            }
            [x11dict setValue:nsfmt(@"%d %d", w, newHeight) forKey:@"resizeWindow"];
            return;
        }
    }
    if (_buttonDown == '8') {
        if (mouseX < 0) {
            _buttonDown = '7';
            [windowManager setX11Cursor:_buttonDown];
        } else if (mouseX > w) {
            _buttonDown = '9';
            [windowManager setX11Cursor:_buttonDown];
        } else {
            int newY = mouseRootY;
            int newHeight = y+h - mouseRootY;
            if (newHeight < _topBorder+_bottomBorder) {
                newHeight = _topBorder+_bottomBorder;
            }
            [x11dict setValue:nsfmt(@"%d %d", x, newY) forKey:@"moveWindow"];
            [x11dict setValue:nsfmt(@"%d %d", w, newHeight) forKey:@"resizeWindow"];
            return;
        }
    }
    if (_buttonDown == '1') {
        int newX = mouseRootX;
        int newWidth = x+w - mouseRootX;
        int newHeight = mouseY;
        if (newWidth < _leftBorder+_rightBorder) {
            newWidth = _leftBorder+_rightBorder;
        }
        if (newHeight < _topBorder+_bottomBorder) {
            newHeight = _topBorder+_bottomBorder;
        }
        [x11dict setValue:nsfmt(@"%d %d", newX, y) forKey:@"moveWindow"];
        [x11dict setValue:nsfmt(@"%d %d", newWidth, newHeight) forKey:@"resizeWindow"];
        return;
    }
    if (_buttonDown == '3') {
        int newWidth = mouseX;
        int newHeight = mouseY;
        if (newWidth < _leftBorder+_rightBorder) {
            newWidth = _leftBorder+_rightBorder;
        }
        if (newHeight < _topBorder+_bottomBorder) {
            newHeight = _topBorder+_bottomBorder;
        }
        [x11dict setValue:nsfmt(@"%d %d", newWidth, newHeight) forKey:@"resizeWindow"];
        return;
    }
    if (_buttonDown == '7') {
        int newX = mouseRootX;
        int newY = mouseRootY;
        int newWidth = x+w - mouseRootX;
        int newHeight = y+h - mouseRootY;
        if (newWidth < _leftBorder+_rightBorder) {
            newWidth = _leftBorder+_rightBorder;
        }
        if (newHeight < _topBorder+_bottomBorder) {
            newHeight = _topBorder+_bottomBorder;
        }
        [x11dict setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];
        [x11dict setValue:nsfmt(@"%d %d", newWidth, newHeight) forKey:@"resizeWindow"];
        return;
    }
    if (_buttonDown == '9') {
        int newY = mouseRootY;
        int newWidth = mouseX;
        int newHeight = y+h - mouseRootY;
        if (newWidth < _leftBorder+_rightBorder) {
            newWidth = _leftBorder+_rightBorder;
        }
        if (newHeight < _topBorder+_bottomBorder) {
            newHeight = _topBorder+_bottomBorder;
        }
        [x11dict setValue:nsfmt(@"%d %d", x, newY) forKey:@"moveWindow"];
        [x11dict setValue:nsfmt(@"%d %d", newWidth, newHeight) forKey:@"resizeWindow"];
        return;
    }
}
- (void)handleMouseUp:(id)event
{
    id dict = [event valueForKey:@"x11dict"];
    if ((_buttonDown == 'c') && (_buttonHover == 'c')) {
        [dict x11CloseWindow];
    }
    if ((_buttonDown == 'i') && (_buttonHover == 'i')) {
        [dict x11ToggleMaximizeWindow];
    }
    if (_buttonDown == 't') {
        /* this was added for Wine */
        [dict x11MoveChildWindowBackAndForthForWine];
    }

    _buttonDown = 0;
}
@end

