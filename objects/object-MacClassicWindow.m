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


@implementation Definitions(jfoiwcciiejfklsdjfklsdjlkfjsdlkfj)
+ (void)enterMacClassicMode
{
    [Definitions enterMacClassicMode:1];
}
+ (void)enterMacClassicMode:(int)scaling
{
    if (scaling < 1) {
        scaling = 1;
    }
    [Definitions setValue:nsfmt(@"%d", scaling) forEnvironmentVariable:@"HOTDOG_SCALING"];

    id windowManager = [@"windowManager" valueForKey];
    [windowManager setFocusDict:nil];
    [windowManager unparentAllWindows];

    [Definitions setValue:@"macclassic" forEnvironmentVariable:@"HOTDOG_MODE"];

    char *backgroundCString =
"ab\n"
"ba\n"
;
    char *backgroundPalette =
"a #606060\n"
"b #a0a0a0\n"
;
    [windowManager setBackgroundForCString:backgroundCString palette:backgroundPalette];
    id rootWindowObject = [@"MacRootWindow" asInstance];
    [windowManager setValue:rootWindowObject forKey:@"rootWindowObject"];
    [windowManager reparentAllWindows:@"MacClassicWindow"];
    [[windowManager valueForKey:@"menuBar"] setValue:@"1" forKey:@"shouldCloseWindow"];
    int h = 20*scaling;
    [windowManager setValue:nsfmt(@"%d", h) forKey:@"menuBarHeight"];
    id menuBar = [windowManager openWindowForObject:[@"MacMenuBar" asInstance] x:0 y:0 w:[windowManager intValueForKey:@"rootWindowWidth"] h:h];
    [windowManager setValue:menuBar forKey:@"menuBar"];
    [windowManager setFocusDict:nil];
    [@"hotdog-setupWindowManagerMode.sh" runCommandInBackground];
}
@end

static char *inactiveTitleBarLeftPixels =
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
static char *inactiveTitleBarMiddlePixels =
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
".\n"
"b\n"
;
static char *inactiveTitleBarRightPixels =
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
;
static char *inactiveBottomBorderLeftPixels =
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
static char *inactiveBottomBorderMiddlePixels =
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
"b\n"
"b\n"
;
static char *inactiveBottomBorderRightPixels =
"bbbbbbbbbbbbbbbbb\n"
"b..............bb\n"
"b..............bb\n"
"b..............bb\n"
"b..............bb\n"
"b..............bb\n"
"b..............bb\n"
"b..............bb\n"
"b..............bb\n"
"b..............bb\n"
"b..............bb\n"
"b..............bb\n"
"b..............bb\n"
"b..............bb\n"
"b..............bb\n"
"bbbbbbbbbbbbbbbbb\n"
"bbbbbbbbbbbbbbbbb\n"
;

static char *activeTitleBarLeftPixels =
"bbbbbbbbbbbbbbbbbbbbb\n"
"b....................\n"
"b....................\n"
"b....................\n"
"b.bbbbbb.bbbbbbbbbbb.\n"
"b........b.........b.\n"
"b.bbbbbb.b.........b.\n"
"b........b.........b.\n"
"b.bbbbbb.b.........b.\n"
"b........b.........b.\n"
"b.bbbbbb.b.........b.\n"
"b........b.........b.\n"
"b.bbbbbb.b.........b.\n"
"b........b.........b.\n"
"b.bbbbbb.bbbbbbbbbbb.\n"
"b....................\n"
"b....................\n"
"b....................\n"
"bbbbbbbbbbbbbbbbbbbbb\n"
;
static char *activeTitleBarMiddlePixels =
"b\n"
".\n"
".\n"
".\n"
"b\n"
".\n"
"b\n"
".\n"
"b\n"
".\n"
"b\n"
".\n"
"b\n"
".\n"
"b\n"
".\n"
".\n"
".\n"
"b\n"
;
static char *activeTitleBarRightPixels =
"bbbbbbbbbbbbbbbbbbbbb.\n"
"....................bb\n"
"....................bb\n"
"....................bb\n"
".bbbbbbbbbbb.bbbbbb.bb\n"
".b.....b...b........bb\n"
".b.....b...b.bbbbbb.bb\n"
".b.....b...b........bb\n"
".b.....b...b.bbbbbb.bb\n"
".b.....b...b........bb\n"
".bbbbbbb...b.bbbbbb.bb\n"
".b.........b........bb\n"
".b.........b.bbbbbb.bb\n"
".b.........b........bb\n"
".bbbbbbbbbbb.bbbbbb.bb\n"
"....................bb\n"
"....................bb\n"
"....................bb\n"
"bbbbbbbbbbbbbbbbbbbbbb\n"
;
static char *leftBorderMiddlePixels =
"b\n"
;

static char *bottomBorderLeftPixels =
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
".\n"
;
static char *bottomBorderMiddlePixels =
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
"b\n"
"b\n"
;
static char *bottomBorderRightPixels =
"bbbbbbbbbbbbbbbbb\n"
"b..............bb\n"
"b..............bb\n"
"b..bbbbbbb.....bb\n"
"b..b.....b.....bb\n"
"b..b.....bbbbb.bb\n"
"b..b.....b...b.bb\n"
"b..b.....b...b.bb\n"
"b..b.....b...b.bb\n"
"b..bbbbbbb...b.bb\n"
"b....b.......b.bb\n"
"b....b.......b.bb\n"
"b....b.......b.bb\n"
"b....bbbbbbbbb.bb\n"
"b..............bb\n"
"bbbbbbbbbbbbbbbbb\n"
"bbbbbbbbbbbbbbbbb\n"
;

static char *rightBorderTopPixels = "";

static char *rightBorderMiddlePixels =
"bb\n"
;

static char *rightBorderBottomPixels = "";

static char *inactiveRightBorderMiddlePixels =
"bb\n"
;

static char *closeButtonDownPixels =
"bbbbbbbbbbb\n"
"b....b....b\n"
"b.b..b..b.b\n"
"b..b.b.b..b\n"
"b.........b\n"
"bbbb...bbbb\n"
"b.........b\n"
"b..b.b.b..b\n"
"b.b..b..b.b\n"
"b....b....b\n"
"bbbbbbbbbbb\n"
;

@implementation Definitions(fjeklwjfklsmdklfmiewmoofmkdsf)
+ (char *)cStringForMacClassicActiveTitleBarLeftPixels
{
    return activeTitleBarLeftPixels;
}
+ (char *)cStringForMacClassicActiveTitleBarMiddlePixels
{
    return activeTitleBarMiddlePixels;
}
+ (char *)cStringForMacClassicActiveTitleBarRightPixels
{
    return activeTitleBarRightPixels;
}
+ (char *)cStringForMacClassicInactiveTitleBarLeftPixels
{
    return inactiveTitleBarLeftPixels;
}
+ (char *)cStringForMacClassicInactiveTitleBarMiddlePixels
{
    return inactiveTitleBarMiddlePixels;
}
+ (char *)cStringForMacClassicInactiveTitleBarRightPixels
{
    return inactiveTitleBarRightPixels;
}
+ (char *)cStringForMacClassicResizeButtonPixels
{
    return bottomBorderRightPixels;
}
+ (char *)cStringForMacClassicInactiveResizeButtonPixels
{
    return inactiveBottomBorderRightPixels;
}
+ (char *)cStringForMacClassicCloseButtonDownPixels
{
    return closeButtonDownPixels;
}
@end


@interface MacClassicWindow : IvarObject
{
    int _leftBorder;
    int _rightBorder;
    int _topBorder;
    int _bottomBorder;
    id _x11HasChildMask;

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
    Int4 _bottomBorderRect;
    Int4 _closeButtonRect;
    Int4 _maximizeButtonRect;
    Int4 _resizeButtonRect;

    // setPixelScale:
    int _pixelScaling;
    id _scaledFont;
    id _scaledInactiveTitleBarLeftPixels;
    id _scaledInactiveTitleBarMiddlePixels;
    id _scaledInactiveTitleBarRightPixels;
    id _scaledInactiveBottomBorderLeftPixels;
    id _scaledInactiveBottomBorderMiddlePixels;
    id _scaledInactiveBottomBorderRightPixels;
    id _scaledActiveTitleBarLeftPixels;
    int _scaledActiveTitleBarLeftWidth;
    id _scaledActiveTitleBarMiddlePixels;
    int _scaledActiveTitleBarHeight;
    id _scaledActiveTitleBarRightPixels;
    id _scaledLeftBorderMiddlePixels;
    id _scaledBottomBorderLeftPixels;
    id _scaledBottomBorderMiddlePixels;
    id _scaledBottomBorderRightPixels;
    id _scaledRightBorderTopPixels;
    id _scaledRightBorderMiddlePixels;
    id _scaledRightBorderBottomPixels;
    id _scaledInactiveRightBorderMiddlePixels;
    id _scaledCloseButtonDownPixels;
}
@end
@implementation MacClassicWindow
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
- (int *)x11WindowMaskPointsForWidth:(int)w height:(int)h
{
    static int points[5];
    points[0] = 5; // length of array including this number

    points[1] = 0; // lower left corner
    points[2] = h-1;

    points[3] = w-1; // upper right corner
    points[4] = 0;
    return points;
}
- (void)setPixelScaling:(int)scaling
{
    _pixelScaling = scaling;

    _leftBorder = 1*scaling;
    _rightBorder = 1*scaling+1;
    _topBorder = 19*scaling;
    _bottomBorder = 1*scaling+1;
    [self setValue:nsfmt(@"bottomRightCorner w:%d h:%d", 15*scaling, 15*scaling) forKey:@"x11HasChildMask"];

    id obj;
    obj = [Definitions scaleFont:scaling
                    :[Definitions arrayOfCStringsForChicagoFont]
                    :[Definitions arrayOfWidthsForChicagoFont]
                    :[Definitions arrayOfHeightsForChicagoFont]
                    :[Definitions arrayOfXSpacingsForChicagoFont]];
    [self setValue:obj forKey:@"scaledFont"];

    obj = [nsfmt(@"%s", inactiveTitleBarLeftPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledInactiveTitleBarLeftPixels"];

    obj = [nsfmt(@"%s", inactiveTitleBarMiddlePixels) asYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledInactiveTitleBarMiddlePixels"];

    obj = [nsfmt(@"%s", inactiveTitleBarRightPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledInactiveTitleBarRightPixels"];

    obj = [nsfmt(@"%s", inactiveBottomBorderLeftPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledInactiveBottomBorderLeftPixels"];

    obj = [nsfmt(@"%s", inactiveBottomBorderMiddlePixels) asYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledInactiveBottomBorderMiddlePixels"];

    obj = [nsfmt(@"%s", inactiveBottomBorderRightPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledInactiveBottomBorderRightPixels"];

    obj = [nsfmt(@"%s", activeTitleBarLeftPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledActiveTitleBarLeftPixels"];
    _scaledActiveTitleBarLeftWidth = [Definitions widthForCString:[obj UTF8String]];

    obj = [nsfmt(@"%s", activeTitleBarMiddlePixels) asYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledActiveTitleBarMiddlePixels"];
    _scaledActiveTitleBarHeight = [Definitions heightForCString:[obj UTF8String]];

    obj = [nsfmt(@"%s", activeTitleBarRightPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledActiveTitleBarRightPixels"];

    obj = [nsfmt(@"%s", leftBorderMiddlePixels) asXScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledLeftBorderMiddlePixels"];

    obj = [nsfmt(@"%s", bottomBorderLeftPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledBottomBorderLeftPixels"];

    obj = [nsfmt(@"%s", bottomBorderMiddlePixels) asYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledBottomBorderMiddlePixels"];

    obj = [nsfmt(@"%s", bottomBorderRightPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledBottomBorderRightPixels"];

    obj = nsfmt(@"%s", rightBorderTopPixels);
    [self setValue:obj forKey:@"scaledRightBorderTopPixels"];

    obj = [nsfmt(@"%s", rightBorderMiddlePixels) asXScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledRightBorderMiddlePixels"];

    obj = nsfmt(@"%s", rightBorderBottomPixels);
    [self setValue:obj forKey:@"scaledRightBorderBottomPixels"];

    obj = [nsfmt(@"%s", inactiveRightBorderMiddlePixels) asXScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledInactiveRightBorderMiddlePixels"];

    obj = [nsfmt(@"%s", closeButtonDownPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledCloseButtonDownPixels"];
}

- (void)calculateRects:(Int4)r
{
    _titleBarRect = [Definitions rectWithX:r.x y:r.y w:r.w h:_scaledActiveTitleBarHeight];
    _titleBarTextRect = _titleBarRect;
    _titleBarTextRect.x = _scaledActiveTitleBarLeftWidth+4*_pixelScaling;
    _titleBarTextRect.w -= (_scaledActiveTitleBarLeftWidth+4*_pixelScaling)*2;

    _leftBorderRect = r;
    _leftBorderRect.y += _scaledActiveTitleBarHeight;
    _leftBorderRect.h -= _scaledActiveTitleBarHeight;
    _leftBorderRect.h -= _bottomBorder+15*_pixelScaling;
    _leftBorderRect.w = _leftBorder;

    _rightBorderRect = r;
    _rightBorderRect.x += r.w-_rightBorder;
    _rightBorderRect.y += _scaledActiveTitleBarHeight;
    _rightBorderRect.h -= _scaledActiveTitleBarHeight;
    _rightBorderRect.h -= _bottomBorder+15*_pixelScaling;
    _rightBorderRect.w = _rightBorder;

    _bottomBorderRect = _titleBarRect;
    _bottomBorderRect.y += r.h-(_bottomBorder+15*_pixelScaling);
    _bottomBorderRect.h = _bottomBorder+15*_pixelScaling;

    _closeButtonRect = _titleBarRect;
    _closeButtonRect.x += 9*_pixelScaling;
    _closeButtonRect.y += 4*_pixelScaling;
    _closeButtonRect.w = 11*_pixelScaling;
    _closeButtonRect.h = 11*_pixelScaling;

    _maximizeButtonRect = _titleBarRect;
    _maximizeButtonRect.x = _maximizeButtonRect.x+_maximizeButtonRect.w-21*_pixelScaling;
    _maximizeButtonRect.y += 4*_pixelScaling;
    _maximizeButtonRect.w = 11*_pixelScaling;
    _maximizeButtonRect.h = 11*_pixelScaling;
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

    char *palette = "b #000000\n";
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
                [bitmap fillRect:[Definitions rectWithX:backX y:_titleBarTextRect.y+2*_pixelScaling w:backWidth h:16*_pixelScaling]];
                [bitmap setColorIntR:0 g:0 b:0 a:255];
                [bitmap drawBitmapText:text x:textX y:_titleBarTextRect.y+4*_pixelScaling];
            } else {
                [bitmap setColorIntR:0 g:0 b:0 a:255];
                [bitmap drawBitmapText:text x:textX y:_titleBarTextRect.y+4*_pixelScaling];
            }
        }
    }

    {
        char *middle = [_scaledLeftBorderMiddlePixels UTF8String];
        [Definitions drawInBitmap:bitmap top:middle palette:palette middle:middle palette:palette bottom:middle palette:palette x:_leftBorderRect.x y:_leftBorderRect.y h:_leftBorderRect.h];
    }
    if (hasFocus) {
        char *top = [_scaledRightBorderTopPixels UTF8String];
        char *middle = [_scaledRightBorderMiddlePixels UTF8String];
        char *bottom = [_scaledRightBorderBottomPixels UTF8String];
        [Definitions drawInBitmap:bitmap top:top palette:palette middle:middle palette:palette bottom:bottom palette:palette x:_rightBorderRect.x y:_rightBorderRect.y h:_rightBorderRect.h];
    } else {
        char *top = [_scaledInactiveRightBorderMiddlePixels UTF8String];
        char *middle = top;
        char *bottom = top;
        [Definitions drawInBitmap:bitmap top:middle palette:palette middle:middle palette:palette bottom:bottom palette:palette x:_rightBorderRect.x y:_rightBorderRect.y h:_rightBorderRect.h];
    }

    if (hasFocus) {
        Int4 r = _bottomBorderRect;
        char *left = [_scaledBottomBorderLeftPixels UTF8String];
        char *middle = [_scaledBottomBorderMiddlePixels UTF8String];
        char *right = [_scaledBottomBorderRightPixels UTF8String];
        [Definitions drawInBitmap:bitmap left:left middle:middle right:right x:r.x y:r.y w:r.w palette:palette];
    } else {
        Int4 r = _bottomBorderRect;
        char *left = [_scaledInactiveBottomBorderLeftPixels UTF8String];
        char *middle = [_scaledInactiveBottomBorderMiddlePixels UTF8String];
        char *right = [_scaledInactiveBottomBorderRightPixels UTF8String];
        [Definitions drawInBitmap:bitmap left:left middle:middle right:right x:r.x y:r.y w:r.w palette:palette];
    }

    if (hasFocus) {
        if ((_buttonDown == 'c') && (_buttonHover == 'c')) {
            char *closeButtonDown = [_scaledCloseButtonDownPixels UTF8String];
            [bitmap drawCString:closeButtonDown palette:palette x:_closeButtonRect.x y:_closeButtonRect.y];
        }
        if ((_buttonDown == 'm') && (_buttonHover == 'm')) {
            char *maximizePalette = "b #000000\n. #ffffff\n";
            char *maximizeButtonDown = [_scaledCloseButtonDownPixels UTF8String];
            [bitmap drawCString:maximizeButtonDown palette:maximizePalette x:_maximizeButtonRect.x y:_maximizeButtonRect.y];
        }
        if (_buttonDown == 't') {
// FIXME pixelScaling
            char *palette = "b #000000\nw #ffffff\n";
            char *h = [Definitions cStringForMacWindowSelectionHorizontal];
            char *v = [Definitions cStringForMacWindowSelectionVertical];
            [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x y:r.y w:r.w palette:palette];
            [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x y:r.y+1 h:r.h+1-2];
            [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x+r.w-1 y:r.y+1 h:r.h+1-2];
            [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x y:r.y+r.h-1 w:r.w palette:palette];
        }
        if (_buttonDown == 'r') {
// FIXME pixelScaling
            char *palette = "b #000000\nw #ffffff\n";
            char *h = [Definitions cStringForMacWindowSelectionHorizontal];
            char *v = [Definitions cStringForMacWindowSelectionVertical];
            [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x y:r.y w:r.w palette:palette];
            [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x y:r.y+18 w:r.w palette:palette];
            [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x y:r.y+1 h:r.h-2];
            [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x+r.w-2 y:r.y+1 h:r.h-2];
            [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x+r.w-2-15 y:r.y+1+18 h:r.h-2-18];
            [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x y:r.y+r.h-2 w:r.w palette:palette];
            [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x y:r.y+r.h-2-15 w:r.w palette:palette];
        }
    }

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
    if (mouseX >= viewWidth-17*_pixelScaling) {
        if (mouseY >= viewHeight-17*_pixelScaling) {
            _buttonDown = 'r';
            _buttonDownX = mouseX;
            _buttonDownY = mouseY;
            _buttonDownW = viewWidth;
            _buttonDownH = viewHeight;
            return;
        }
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
    if ([Definitions isX:mouseX y:mouseY insideRect:_maximizeButtonRect]) {
        _buttonDown = 'm';
        _buttonHover = 'm';
        _buttonDownX = mouseX;
        _buttonDownY = mouseY;
        _buttonDownW = viewWidth;
        _buttonDownH = viewHeight;
        return;
    }
    if ([Definitions isX:mouseX y:mouseY insideRect:_titleBarRect]
        || [Definitions isX:mouseX y:mouseY insideRect:_leftBorderRect]
        || [Definitions isX:mouseX y:mouseY insideRect:_rightBorderRect]
        || [Definitions isX:mouseX y:mouseY insideRect:_bottomBorderRect])
    {
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
    if (_buttonDown == 'm') {
        int mouseX = [event intValueForKey:@"mouseX"];
        int mouseY = [event intValueForKey:@"mouseY"];
        if ([Definitions isX:mouseX y:mouseY insideRect:_maximizeButtonRect]) {
            _buttonHover = 'm';
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

    if (_buttonDown == 'r') {
        int mouseX = [event intValueForKey:@"mouseX"];
        int mouseY = [event intValueForKey:@"mouseY"];
        int viewWidth = [event intValueForKey:@"viewWidth"];
        int viewHeight = [event intValueForKey:@"viewHeight"];

        id dict = [event valueForKey:@"x11dict"];

        id windowManager = [event valueForKey:@"windowManager"];
        int newWidth = mouseX + (_buttonDownW - _buttonDownX);
        if (newWidth < 100) {
            newWidth = 100;
        }
        int newHeight = mouseY + (_buttonDownH - _buttonDownY);
        if (newHeight < 100) {
            newHeight = 100;
        }
        [dict setValue:nsfmt(@"%d %d", newWidth, newHeight) forKey:@"resizeWindow"];
        return;
    }
}
- (void)handleMouseUp:(id)event
{
    id dict = [event valueForKey:@"x11dict"];
    if ((_buttonDown == 'c') && (_buttonHover == 'c')) {
        [dict x11CloseWindow];
    }
    if ((_buttonDown == 'm') && (_buttonHover == 'm')) {
        [dict x11ToggleMaximizeWindow];
    }
    if (_buttonDown == 't') {
        /* this was added for Wine */
        [dict x11MoveChildWindowBackAndForthForWine];
    }

    _buttonDown = 0;
}
@end

