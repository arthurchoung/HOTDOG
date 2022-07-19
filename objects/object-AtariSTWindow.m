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

@implementation Definitions(jfoiwejfklsdjfklsdjlkfjsdejwfjkdlkfj)
+ (void)enterAtariSTMode
{
    [Definitions enterAtariSTMode:1];
}
+ (void)enterAtariSTMode:(int)scaling
{
    if (scaling < 1) {
        scaling = 1;
    }
    [Definitions setValue:nsfmt(@"%d", scaling) forEnvironmentVariable:@"HOTDOG_SCALING"];

    id windowManager = [@"windowManager" valueForKey];
    [windowManager setFocusDict:nil];
    [windowManager unparentAllWindows];

    [Definitions setValue:@"atarist" forEnvironmentVariable:@"HOTDOG_MODE"];

    [windowManager setBackgroundForCString:"x\n" palette:"x #00ee00\n"];
    id rootWindowObject = [@"MacRootWindow" asInstance];
    [windowManager setValue:rootWindowObject forKey:@"rootWindowObject"];
    [windowManager reparentAllWindows:@"AtariSTWindow"];
    [[windowManager valueForKey:@"menuBar"] setValue:@"1" forKey:@"shouldCloseWindow"];
    int h = 19*scaling;
    [windowManager setValue:nsfmt(@"%d", h) forKey:@"menuBarHeight"];
    id menuBar = [windowManager openWindowForObject:[@"AtariSTMenuBar" asInstance] x:0 y:0 w:[windowManager intValueForKey:@"rootWindowWidth"] h:h];
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
"b\n"
"b\n"
"b\n"
"b\n"
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
".\n"
".\n"
".\n"
"b\n"
"b\n"
"b\n"
;
static char *inactiveBottomBorderRightPixels =
"bbbbbbbbbbbbbbbbbbbbb\n"
"b.................bbb\n"
"b.................bbb\n"
"b.................bbb\n"
"b.................bbb\n"
"b.................bbb\n"
"b.................bbb\n"
"b.................bbb\n"
"b.................bbb\n"
"b.................bbb\n"
"b.................bbb\n"
"b.................bbb\n"
"b.................bbb\n"
"b.................bbb\n"
"b.................bbb\n"
"b.................bbb\n"
"b.................bbb\n"
"b.................bbb\n"
"bbbbbbbbbbbbbbbbbbbbb\n"
"bbbbbbbbbbbbbbbbbbbbb\n"
"bbbbbbbbbbbbbbbbbbbbb\n"
;

static char *activeTitleBarLeftPixels =
"bbbbbbbbbbbbbbbbbbbb\n"
"b.................bb\n"
"b.................bb\n"
"b.................bb\n"
"b......bbbbb......bb\n"
"b.......bbb.......bb\n"
"b.....b.bbb.b.....bb\n"
"b.....b..b..b.....bb\n"
"b.....bb.b.bb.....bb\n"
"b.....bb...bb.....bb\n"
"b.....bb.b.bb.....bb\n"
"b.....b..b..b.....bb\n"
"b.....b.bbb.b.....bb\n"
"b.......bbb.......bb\n"
"b......bbbbb......bb\n"
"b.................bb\n"
"b.................bb\n"
"b.................bb\n"
"bbbbbbbbbbbbbbbbbbbb\n"
;
static char *activeTitleBarMiddlePixels =
"bb\n"
".b\n"
"..\n"
".b\n"
"..\n"
".b\n"
"..\n"
".b\n"
"..\n"
".b\n"
"..\n"
".b\n"
"..\n"
".b\n"
"..\n"
".b\n"
"..\n"
".b\n"
"bb\n"
;
static char *activeTitleBarRightPixels =
"bbbbbbbbbbbbbbbbbbbbb \n"
"bb.................bbb\n"
"bb.................bbb\n"
"bb.................bbb\n"
"bb.....bbb.bbb.....bbb\n"
"bb.....bb...bb.....bbb\n"
"bb.....bb.b.bb.....bbb\n"
"bb.....b..b..b.....bbb\n"
"bb.....b.bbb.b.....bbb\n"
"bb.......bbb.......bbb\n"
"bb.....b.bbb.b.....bbb\n"
"bb.....b..b..b.....bbb\n"
"bb.....bb.b.bb.....bbb\n"
"bb.....bb...bb.....bbb\n"
"bb.....bbb.bbb.....bbb\n"
"bb.................bbb\n"
"bb.................bbb\n"
"bb.................bbb\n"
"bbbbbbbbbbbbbbbbbbbbbb\n"
;
static char *leftBorderMiddlePixels =
"b\n"
;

static char *bottomBorderLeftPixels =
"bbbbbbbbbbbbbbbbbbb\n"
"b.................b\n"
"b.................b\n"
"b.................b\n"
"b.........bb......b\n"
"b........bbb......b\n"
"b.......bb.b......b\n"
"b......bb..bbb....b\n"
"b.....bb.....b....b\n"
"b.....bb.....b....b\n"
"b......bb..bbb....b\n"
"b.......bb.b......b\n"
"b........bbb......b\n"
"b.........bb......b\n"
"b.................b\n"
"b.................b\n"
"b.................b\n"
"b.................b\n"
"bbbbbbbbbbbbbbbbbbb\n"
"bbbbbbbbbbbbbbbbbbb\n"
" bbbbbbbbbbbbbbbbbb\n"
;
static char *bottomBorderMiddlePixels =
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
"b\n"
"b\n"
;
static char *bottomBorderRightPixels =
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"b.................b.................bbb\n"
"b.................b.................bbb\n"
"b.................b.................bbb\n"
"b.......bb........b.....bbbbbbb.....bbb\n"
"b.......bbb.......b.....bbbbbbb.....bbb\n"
"b.......b.bb......b.....bbbbbbb.....bbb\n"
"b.....bbb..bb.....b.....bbbbbb......bbb\n"
"b.....b.....bb....b.....bbbbbb......bbb\n"
"b.....b.....bb....b.....bbbbb.......bbb\n"
"b.....bbb..bb.....b.....bbbbb.b.....bbb\n"
"b.......b.bb......b.....bbbb..b.....bbb\n"
"b.......bbb.......b.....bbbb.bb.....bbb\n"
"b.......bb........b.....bbb..bb.....bbb\n"
"b.................b.....bbb.bbb.....bbb\n"
"b.................b.................bbb\n"
"b.................b.................bbb\n"
"b.................b.................bbb\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
;


static char *rightBorderTopPixels =
"b.................bbb\n"
"b.................bbb\n"
"b.................bbb\n"
"b.................bbb\n"
"b........bb.......bbb\n"
"b.......bbbb......bbb\n"
"b......bb..bb.....bbb\n"
"b.....bb....bb....bbb\n"
"b.....b......b....bbb\n"
"b.....bbb..bbb....bbb\n"
"b.......b..b......bbb\n"
"b.......b..b......bbb\n"
"b.......b..b......bbb\n"
"b.......bbbb......bbb\n"
"b.................bbb\n"
"b.................bbb\n"
"b.................bbb\n"
"bbbbbbbbbbbbbbbbbbbbb\n"
;
static char *rightBorderMiddlePixels =
"b.................bbb\n"
;
static char *rightBorderBottomPixels =
"bbbbbbbbbbbbbbbbbbbbb\n"
"b.................bbb\n"
"b.................bbb\n"
"b.................bbb\n"
"b.................bbb\n"
"b.......bbbb......bbb\n"
"b.......b..b......bbb\n"
"b.......b..b......bbb\n"
"b.......b..b......bbb\n"
"b.....bbb..bbb....bbb\n"
"b.....b......b....bbb\n"
"b.....bb....bb....bbb\n"
"b......bb..bb.....bbb\n"
"b.......bbbb......bbb\n"
"b........bb.......bbb\n"
"b.................bbb\n"
"b.................bbb\n"
"b.................bbb\n"
;

static char *inactiveRightBorderMiddlePixels =
"b.................bbb\n"
;



static char *closeButtonPixels =
".................\n"
".................\n"
".................\n"
"......bbbbb......\n"
".......bbb.......\n"
".....b.bbb.b.....\n"
".....b..b..b.....\n"
".....bb.b.bb.....\n"
".....bb...bb.....\n"
".....bb.b.bb.....\n"
".....b..b..b.....\n"
".....b.bbb.b.....\n"
".......bbb.......\n"
"......bbbbb......\n"
".................\n"
".................\n"
".................\n"
;




static char *maximizeButtonPixels =
".................\n"
".................\n"
".................\n"
".....bbb.bbb.....\n"
".....bb...bb.....\n"
".....bb.b.bb.....\n"
".....b..b..b.....\n"
".....b.bbb.b.....\n"
".......bbb.......\n"
".....b.bbb.b.....\n"
".....b..b..b.....\n"
".....bb.b.bb.....\n"
".....bb...bb.....\n"
".....bbb.bbb.....\n"
".................\n"
".................\n"
".................\n"
;



@interface AtariSTWindow : IvarObject
{
    int _leftBorder;
    int _rightBorder;
    int _topBorder;
    int _bottomBorder;
    int _hasShadow;

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
    int _scaledTitleBarLeftWidth;
    id _scaledActiveTitleBarMiddlePixels;
    int _scaledTitleBarHeight;
    id _scaledActiveTitleBarRightPixels;
    int _scaledTitleBarRightWidth;
    id _scaledLeftBorderMiddlePixels;
    id _scaledBottomBorderLeftPixels;
    id _scaledBottomBorderMiddlePixels;
    id _scaledBottomBorderRightPixels;
    id _scaledRightBorderTopPixels;
    id _scaledRightBorderMiddlePixels;
    id _scaledRightBorderBottomPixels;
    id _scaledInactiveRightBorderMiddlePixels;
    id _scaledCloseButtonPixels;
    id _scaledMaximizeButtonPixels;
}
@end
@implementation AtariSTWindow
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

    _leftBorder = 1*_pixelScaling;
    _rightBorder = 21*_pixelScaling;
    _topBorder = 19*_pixelScaling;
    _bottomBorder = 21*_pixelScaling;
    _hasShadow = 1;

    id obj;
    obj = [Definitions scaleFont:scaling
                    :[Definitions arrayOfCStringsForAtariSTFont]
                    :[Definitions arrayOfWidthsForAtariSTFont]
                    :[Definitions arrayOfHeightsForAtariSTFont]
                    :[Definitions arrayOfXSpacingsForAtariSTFont]];
    [self setValue:obj forKey:@"scaledFont"];

    obj = [nsfmt(@"%s", inactiveTitleBarLeftPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledInactiveTitleBarLeftPixels"];

    obj = [nsfmt(@"%s", inactiveTitleBarMiddlePixels) asXYScaledPixels:scaling];
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
    _scaledTitleBarLeftWidth = [Definitions widthForCString:[obj UTF8String]];

    obj = [nsfmt(@"%s", activeTitleBarMiddlePixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledActiveTitleBarMiddlePixels"];
    _scaledTitleBarHeight = [Definitions heightForCString:[obj UTF8String]];

    obj = [nsfmt(@"%s", activeTitleBarRightPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledActiveTitleBarRightPixels"];
    _scaledTitleBarRightWidth = [Definitions widthForCString:[obj UTF8String]];

    obj = [nsfmt(@"%s", leftBorderMiddlePixels) asXScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledLeftBorderMiddlePixels"];

    obj = [nsfmt(@"%s", bottomBorderLeftPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledBottomBorderLeftPixels"];

    obj = [nsfmt(@"%s", bottomBorderMiddlePixels) asYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledBottomBorderMiddlePixels"];

    obj = [nsfmt(@"%s", bottomBorderRightPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledBottomBorderRightPixels"];

    obj = [nsfmt(@"%s", rightBorderTopPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledRightBorderTopPixels"];

    obj = [nsfmt(@"%s", rightBorderMiddlePixels) asXScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledRightBorderMiddlePixels"];

    obj = [nsfmt(@"%s", rightBorderBottomPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledRightBorderBottomPixels"];

    obj = [nsfmt(@"%s", inactiveRightBorderMiddlePixels) asXScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledInactiveRightBorderMiddlePixels"];

    obj = [nsfmt(@"%s", closeButtonPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledCloseButtonPixels"];

    obj = [nsfmt(@"%s", maximizeButtonPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledMaximizeButtonPixels"];
}

- (void)calculateRects:(Int4)r
{
    _titleBarRect = [Definitions rectWithX:r.x y:r.y w:r.w h:_scaledTitleBarHeight];
    _titleBarTextRect = _titleBarRect;
    _titleBarTextRect.x = _scaledTitleBarLeftWidth+4*_pixelScaling;
    _titleBarTextRect.w -= _scaledTitleBarLeftWidth+_scaledTitleBarRightWidth+4*_pixelScaling*2;

    _leftBorderRect = r;
    _leftBorderRect.y += _scaledTitleBarHeight;
    _leftBorderRect.h -= _scaledTitleBarHeight;
    _leftBorderRect.h -= _bottomBorder;
    _leftBorderRect.w = _leftBorder;

    _rightBorderRect = r;
    _rightBorderRect.x += r.w-_rightBorder;
    _rightBorderRect.y += _scaledTitleBarHeight;
    _rightBorderRect.h -= _scaledTitleBarHeight;
    _rightBorderRect.h -= _bottomBorder;
    _rightBorderRect.w = _rightBorder;

    _bottomBorderRect = _titleBarRect;
    _bottomBorderRect.y += r.h-_bottomBorder;
    _bottomBorderRect.h = _bottomBorder;

    _closeButtonRect = _titleBarRect;
    _closeButtonRect.x += 1*_pixelScaling;
    _closeButtonRect.y += 1*_pixelScaling;
    _closeButtonRect.w = 17*_pixelScaling;
    _closeButtonRect.h = 17*_pixelScaling;

    _maximizeButtonRect = _titleBarRect;
    _maximizeButtonRect.x = _maximizeButtonRect.x+_maximizeButtonRect.w-(3+17)*_pixelScaling;
    _maximizeButtonRect.y += 1*_pixelScaling;
    _maximizeButtonRect.w = 17*_pixelScaling;
    _maximizeButtonRect.h = 17*_pixelScaling;
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

    char *palette = "b #000000\n. #eeeeee\n";
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
                [bitmap setColor:@"#eeeeee"];
                [bitmap fillRect:[Definitions rectWithX:backX y:_titleBarTextRect.y+2*_pixelScaling w:backWidth h:16*_pixelScaling]];
                [bitmap setColorIntR:0 g:0 b:0 a:255];
                [bitmap drawBitmapText:text x:textX y:_titleBarTextRect.y+2*_pixelScaling];
            } else {
                [bitmap setColorIntR:0 g:0 b:0 a:255];
                [bitmap drawBitmapText:text x:textX y:_titleBarTextRect.y+2*_pixelScaling];
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
            char *reversePalette = ". #000000\nb #ffffff\n";
            char *closeButton = [_scaledCloseButtonPixels UTF8String];
            [bitmap drawCString:closeButton palette:reversePalette x:_closeButtonRect.x y:_closeButtonRect.y];
        }
        if ((_buttonDown == 'm') && (_buttonHover == 'm')) {
            char *reversePalette = ". #000000\nb #ffffff\n";
            char *maximizeButton = [_scaledMaximizeButtonPixels UTF8String];
            [bitmap drawCString:maximizeButton palette:reversePalette x:_maximizeButtonRect.x y:_maximizeButtonRect.y];
        }
        if ((_buttonDown == 't') || (_buttonDown == 'r')) {
//FIXME pixelScaling
            char *black = "b #000000\n";
            char *white = "b #ffffff\n";
            for (int i=4; i<r.w; i+=2) {
                int j = 0;
                int x = r.x+i;
                int y = r.y+j;
                if ((i/2+j/2) % 2 == 0) {
                    [bitmap drawCString:"bb\nbb\n" palette:white x:x y:y];
                }
            }
            for (int i=0; i<r.w-6; i+=2) {
                int j = r.h-6;
                int x = r.x+i;
                int y = r.y+j;
                if ((i/2+j/2) % 2 == 0) {
                    [bitmap drawCString:"bb\nbb\n" palette:white x:x y:y];
                }
            }
            for (int j=4; j<r.h; j+=2) {
                int i = 0;
                int x = r.x+i;
                int y = r.y+j;
                if ((i/2+j/2) % 2 == 0) {
                    [bitmap drawCString:"bb\nbb\n" palette:white x:x y:y];
                }
            }
            for (int j=0; j<r.h-6; j+=2) {
                int i = r.w-6;
                int x = r.x+i;
                int y = r.y+j;
                if ((i/2+j/2) % 2 == 0) {
                    [bitmap drawCString:"bb\nbb\n" palette:white x:x y:y];
                }
            }
        }
        if (_buttonDown == 'r') {
//FIXME pixelScaling
            char *black = "b #000000\n";
            char *white = "b #ffffff\n";
            for (int i=4; i<r.w-28; i+=2) {
                int j = 0;
                int x = r.x+i;
                int y = r.y+j;
                if ((i/2+j/2) % 2 == 0) {
                    [bitmap drawCString:"bb\nbb\n" palette:white x:x y:y+20];
                }
            }
            for (int i=0; i<r.w-28; i+=2) {
                int j = r.h-6;
                int x = r.x+i;
                int y = r.y+j;
                if ((i/2+j/2) % 2 == 0) {
                    [bitmap drawCString:"bb\nbb\n" palette:white x:x y:y-20];
                }
            }
            for (int j=22; j<r.h-28; j+=2) {
                int i = r.w-6;
                int x = r.x+i;
                int y = r.y+j;
                if ((i/2+j/2) % 2 == 0) {
                    [bitmap drawCString:"bb\nbb\n" palette:white x:x-22 y:y];
                }
            }
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
    if (mouseX >= viewWidth-28*_pixelScaling) {
        if (mouseY >= viewHeight-26*_pixelScaling) {
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

