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

@implementation Definitions(jfoiwejfklsdjfklsdjlkfjsdlkfj)
+ (void)enterMacColorMode
{
    [Definitions enterMacColorMode:1];
}
+ (void)enterMacColorMode:(int)scaling
{
    if (scaling < 1) {
        scaling = 1;
    }
    [Definitions setValue:nsfmt(@"%d", scaling) forEnvironmentVariable:@"HOTDOG_SCALING"];

    id windowManager = [@"windowManager" valueForKey];
    [windowManager setFocusDict:nil];
    [windowManager unparentAllWindows];

    [Definitions setValue:@"maccolor" forEnvironmentVariable:@"HOTDOG_MODE"];

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
    [windowManager reparentAllWindows:@"MacColorWindow"];
    [[windowManager valueForKey:@"menuBar"] setValue:@"1" forKey:@"shouldCloseWindow"];
    int h = 20*scaling;
    [windowManager setValue:nsfmt(@"%d", h) forKey:@"menuBarHeight"];
    id menuBar = [windowManager openWindowForObject:[@"MacMenuBar" asInstance] x:0 y:0 w:[windowManager intValueForKey:@"rootWindowWidth"] h:h];
    [windowManager setValue:menuBar forKey:@"menuBar"];
    [windowManager setFocusDict:nil];
    [@"hotdog-setupWindowManagerMode.sh" runCommandInBackground];
}
@end

static char *titleBarPalette =
"b #000000\n"
". #333366\n"
"X #606060\n"
"o #777777\n"
"O #a0a0a0\n"
"+ #a4a4a4\n"
"@ #a3a3d7\n"
"# #ccccff\n"
"$ #eeeeee\n"
"% #ffffff\n"
"- #9292b6\n"
"g #555555\n"
;
static char *titleBarButtonDownPixels =
"bbbbbbbbbbbbb\n"
"#############\n"
"$$$$$$$$$$$$$\n"
"$$$$$$$$$$$$$\n"
"$bbbbbbbbbbb$\n"
"$b----b----b$\n"
"$b-b--b--b-b$\n"
"$b--b-b-b--b$\n"
"$b---------b$\n"
"$bbbb---bbbb$\n"
"$b---------b$\n"
"$b--b-b-b--b$\n"
"$b-b--b--b-b$\n"
"$b----b----b$\n"
"$bbbbbbbbbbb$\n"
"$$$$$$$$$$$$$\n"
"$$$$$$$$$$$$$\n"
"@@@@@@@@@@@@@\n"
"bbbbbbbbbbbbb\n"
;
static char *titleBarCloseButtonPixels =
"bbbbbbbbbbbbb\n"
"#############\n"
"$$$$$$$$$$$$$\n"
"$$$$$$$$$$$$$\n"
"$...........$\n"
"$.##########$\n"
"$.#+++++++.#$\n"
"$.#+++++++.#$\n"
"$.#+++++++.#$\n"
"$.#+++++++.#$\n"
"$.#+++++++.#$\n"
"$.#+++++++.#$\n"
"$.#+++++++.#$\n"
"$.#........#$\n"
"$.##########$\n"
"$$$$$$$$$$$$$\n"
"$$$$$$$$$$$$$\n"
"@@@@@@@@@@@@@\n"
"bbbbbbbbbbbbb\n"
;
static char *titleBarMaximizeButtonPixels =
"bbbbbbbbbbbbb\n"
"#############\n"
"$$$$$$$$$$$$$\n"
"$$$$$$$$$$$$$\n"
"$...........$\n"
"$.##########$\n"
"$.#++++.++.#$\n"
"$.#++++.++.#$\n"
"$.#++++.++.#$\n"
"$.#++++.++.#$\n"
"$.#.....++.#$\n"
"$.#+++++++.#$\n"
"$.#+++++++.#$\n"
"$.#........#$\n"
"$.##########$\n"
"$$$$$$$$$$$$$\n"
"$$$$$$$$$$$$$\n"
"@@@@@@@@@@@@@\n"
"bbbbbbbbbbbbb\n"
;
static char *inactiveTitleBarLeftPixels =
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
;
static char *activeTitleBarLeftPixels =
"bb\n"
"b#\n"
"b#\n"
"b#\n"
"b#\n"
"b#\n"
"b#\n"
"b#\n"
"b#\n"
"b#\n"
"b#\n"
"b#\n"
"b#\n"
"b#\n"
"b#\n"
"b#\n"
"b#\n"
"b@\n"
"bb\n"
;
static char *inactiveTitleBarMiddlePixels =
"g\n"
"$\n"
"$\n"
"$\n"
"$\n"
"$\n"
"$\n"
"$\n"
"$\n"
"$\n"
"$\n"
"$\n"
"$\n"
"$\n"
"$\n"
"$\n"
"$\n"
"$\n"
"g\n"
;
static char *activeTitleBarMiddlePixels =
"b\n"
"#\n"
"$\n"
"$\n"
"o\n"
"$\n"
"o\n"
"$\n"
"o\n"
"$\n"
"o\n"
"$\n"
"o\n"
"$\n"
"o\n"
"$\n"
"$\n"
"@\n"
"b\n"
;
static char *inactiveTitleBarRightPixels =
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
"g\n"
;
static char *activeTitleBarRightPixels =
"bb\n"
"@b\n"
"@b\n"
"@b\n"
"@b\n"
"@b\n"
"@b\n"
"@b\n"
"@b\n"
"@b\n"
"@b\n"
"@b\n"
"@b\n"
"@b\n"
"@b\n"
"@b\n"
"@b\n"
"@b\n"
"bb\n"
;
static char *resizeButtonPixels =
"bbbbbbbbbbbbbbbb\n"
"b--------------b\n"
"b--------------b\n"
"b--......------b\n"
"b--.=====....--b\n"
"b--.=%%%.====--b\n"
"b--.=%%%.###.--b\n"
"b--.=%%%.###.--b\n"
"b--.=....###.--b\n"
"b---.=######.--b\n"
"b---.=######.--b\n"
"b---.=######.--b\n"
"b---.=.......--b\n"
"b--------------b\n"
"b--------------b\n"
"bbbbbbbbbbbbbbbb\n"
;


static char *scrollBarLeftArrowBlackAndWhitePixels =
"bbbbbbbbbbbbbbbb\n"
"b......b.......b\n"
"b.....bb.......b\n"
"b....b.b.......b\n"
"b...b..bbbbb...b\n"
"b..b.......b...b\n"
"b.b........b...b\n"
"bb.........b...b\n"
"b.b........b...b\n"
"b..b.......b...b\n"
"b...b..bbbbb...b\n"
"b....b.b.......b\n"
"b.....bb.......b\n"
"b......b.......b\n"
"b..............b\n"
"bbbbbbbbbbbbbbbb\n"
;
static char *scrollBarRightArrowBlackAndWhitePixels =
"bbbbbbbbbbbbbbbb\n"
"b.......b......b\n"
"b.......bb.....b\n"
"b.......b.b....b\n"
"b...bbbbb..b...b\n"
"b...b.......b..b\n"
"b...b........b.b\n"
"b...b.........bb\n"
"b...b........b.b\n"
"b...b.......b..b\n"
"b...bbbbb..b...b\n"
"b.......b.b....b\n"
"b.......bb.....b\n"
"b.......b......b\n"
"b..............b\n"
"bbbbbbbbbbbbbbbb\n"
;
static char *scrollBarMiddleBlackAndWhitePixels =
"bbbb\n"
"...b\n"
".b..\n"
"...b\n"
".b..\n"
"...b\n"
".b..\n"
"...b\n"
".b..\n"
"...b\n"
".b..\n"
"...b\n"
".b..\n"
"...b\n"
".b..\n"
"bbbb\n"
;
static char *scrollBarKnobBlackAndWhitePixels =
"                \n"
"bbbbbbbbbbbbbbbb\n"
"b..............b\n"
"b..............b\n"
"b..............b\n"
"b..............b\n"
"b..............b\n"
"b..............b\n"
"b..............b\n"
"b..............b\n"
"b..............b\n"
"b..............b\n"
"b..............b\n"
"b..............b\n"
"bbbbbbbbbbbbbbbb\n"
"                \n"
;

static char *resizePixels =
"bbbbbbbbbbbbbbbb\n"
"b..............b\n"
"b..............b\n"
"b..bbbbbbb.....b\n"
"b..b.....b.....b\n"
"b..b.....bbbbb.b\n"
"b..b.....b...b.b\n"
"b..b.....b...b.b\n"
"b..b.....b...b.b\n"
"b..bbbbbbb...b.b\n"
"b....b.......b.b\n"
"b....b.......b.b\n"
"b....b.......b.b\n"
"b....bbbbbbbbb.b\n"
"b..............b\n"
"bbbbbbbbbbbbbbbb\n"
;

@implementation Definitions(fjkdeifjdclsjfiowejfklsdjfklsdkljf)
+ (char *)cStringForMacWindowSelectionHorizontal
{
    return 
"bw\n"
;
}
+ (char *)cStringForMacWindowSelectionVertical
{
    return 
"b\n"
"w\n"
;
}
@end


@interface MacColorWindow : IvarObject
{
    int _leftBorder;
    int _rightBorder;
    int _topBorder;
    int _bottomBorder;
    int _hasShadow;
    id _x11HasChildMask;

    char _buttonDown;
    char _buttonHover;
    int _buttonDownX;
    int _buttonDownY;
    int _buttonDownW;
    int _buttonDownH;
    Int4 _titleBarRect;
    Int4 _titleBarTextRect;
    Int4 _closeButtonRect;
    Int4 _maximizeButtonRect;

    // setPixelScale:
    int _pixelScaling;
    id _scaledFont;
    id _scaledTitleBarButtonDownPixels;
    id _scaledTitleBarCloseButtonPixels;
    int _scaledTitleBarCloseButtonWidth;
    id _scaledTitleBarMaximizeButtonPixels;
    int _scaledTitleBarMaximizeButtonWidth;
    id _scaledInactiveTitleBarLeftPixels;
    id _scaledActiveTitleBarLeftPixels;
    id _scaledInactiveTitleBarMiddlePixels;
    id _scaledActiveTitleBarMiddlePixels;
    id _scaledInactiveTitleBarRightPixels;
    id _scaledActiveTitleBarRightPixels;
    int _scaledActiveTitleBarHeight;
    id _scaledResizeButtonPixels;
}
@end
@implementation MacColorWindow
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
    _rightBorder = 1*_pixelScaling+1;//16+1;
    _topBorder = 19*_pixelScaling;
    _bottomBorder = 1*_pixelScaling+1;//16+1;
    _hasShadow = 1;
    [self setValue:@"maccolor" forKey:@"x11HasChildMask"];

    id obj;
    obj = [Definitions scaleFont:scaling
                    :[Definitions arrayOfCStringsForChicagoFont]
                    :[Definitions arrayOfWidthsForChicagoFont]
                    :[Definitions arrayOfHeightsForChicagoFont]
                    :[Definitions arrayOfXSpacingsForChicagoFont]];
    [self setValue:obj forKey:@"scaledFont"];

    obj = [nsfmt(@"%s", titleBarButtonDownPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledTitleBarButtonDownPixels"];

    obj = [nsfmt(@"%s", titleBarCloseButtonPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledTitleBarCloseButtonPixels"];
    _scaledTitleBarCloseButtonWidth = [Definitions widthForCString:[obj UTF8String]];

    obj = [nsfmt(@"%s", titleBarMaximizeButtonPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledTitleBarMaximizeButtonPixels"];
    _scaledTitleBarMaximizeButtonWidth = [Definitions widthForCString:[obj UTF8String]];

    obj = [nsfmt(@"%s", inactiveTitleBarLeftPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledInactiveTitleBarLeftPixels"];

    obj = [nsfmt(@"%s", activeTitleBarLeftPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledActiveTitleBarLeftPixels"];

    obj = [nsfmt(@"%s", inactiveTitleBarMiddlePixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledInactiveTitleBarMiddlePixels"];

    obj = [nsfmt(@"%s", activeTitleBarMiddlePixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledActiveTitleBarMiddlePixels"];
    _scaledActiveTitleBarHeight = [Definitions heightForCString:[obj UTF8String]];

    obj = [nsfmt(@"%s", inactiveTitleBarRightPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledInactiveTitleBarRightPixels"];

    obj = [nsfmt(@"%s", activeTitleBarRightPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledActiveTitleBarRightPixels"];

    obj = [nsfmt(@"%s", resizeButtonPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledResizeButtonPixels"];
}

- (void)calculateRects:(Int4)r
{
    _titleBarRect = [Definitions rectWithX:r.x y:r.y w:r.w h:_scaledActiveTitleBarHeight];
    _closeButtonRect = [Definitions rectWithX:8*_pixelScaling y:r.y w:_scaledTitleBarCloseButtonWidth h:_scaledActiveTitleBarHeight];
    _maximizeButtonRect = [Definitions rectWithX:r.x+r.w-(8+13)*_pixelScaling y:r.y w:_scaledTitleBarMaximizeButtonWidth h:_scaledActiveTitleBarHeight];
    _titleBarTextRect = _titleBarRect;
    _titleBarTextRect.x = (8+8)*_pixelScaling+_scaledTitleBarCloseButtonWidth*2;
    _titleBarTextRect.w -= _titleBarTextRect.x*2;
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

    int hasFocus = [context intValueForKey:@"hasFocus"];

    Int4 rr = r;
    r.w -= 1;
    r.h -= 1;
    [self calculateRects:r];
    char *palette = titleBarPalette;
    int titleBarHeight = 20*_pixelScaling;
    [bitmap setColor:@"white"];
    [bitmap fillRect:r];

    if (hasFocus) {
        [bitmap drawCString:[_scaledResizeButtonPixels UTF8String] palette:[Definitions cStringForActiveScrollBarPalette] x:r.x+r.w-16*_pixelScaling y:r.y+r.h-16*_pixelScaling];
    } else {
        [bitmap drawCString:[_scaledResizeButtonPixels UTF8String] palette:"b #000000\n" x:r.x+r.w-16*_pixelScaling y:r.y+r.h-16*_pixelScaling];
    }



    if (hasFocus) {
        char *left = [_scaledActiveTitleBarLeftPixels UTF8String];
        char *middle = [_scaledActiveTitleBarMiddlePixels UTF8String];
        char *right = [_scaledActiveTitleBarRightPixels UTF8String];
        [Definitions drawInBitmap:bitmap left:left middle:middle right:right x:_titleBarRect.x y:_titleBarRect.y w:_titleBarRect.w palette:palette];
        if ((_buttonDown == 'c') && (_buttonHover == 'c')) {
            [bitmap drawCString:[_scaledTitleBarButtonDownPixels UTF8String] palette:palette x:_closeButtonRect.x y:_closeButtonRect.y];
        } else {
            [bitmap drawCString:[_scaledTitleBarCloseButtonPixels UTF8String] palette:palette x:_closeButtonRect.x y:_closeButtonRect.y];
        }
        if ((_buttonDown == 'm') && (_buttonHover == 'm')) {
            [bitmap drawCString:[_scaledTitleBarButtonDownPixels UTF8String] palette:palette x:_maximizeButtonRect.x y:_maximizeButtonRect.y];
        } else {
            [bitmap drawCString:[_scaledTitleBarMaximizeButtonPixels UTF8String] palette:palette x:_maximizeButtonRect.x y:_maximizeButtonRect.y];
        }
    } else {
        char *left = [_scaledInactiveTitleBarLeftPixels UTF8String];
        char *middle = [_scaledInactiveTitleBarMiddlePixels UTF8String];
        char *right = [_scaledInactiveTitleBarRightPixels UTF8String];
        [Definitions drawInBitmap:bitmap left:left middle:middle right:right x:_titleBarRect.x y:_titleBarRect.y w:_titleBarRect.w palette:palette];
    }
    if (_titleBarTextRect.w > 0) {
        id text = [context valueForKey:@"name"];
        if (!text) {
            text = @"(no title)";
        }

        text = [bitmap fitBitmapString:text width:_titleBarTextRect.w-14*_pixelScaling];
        if (text) {
            int textWidth = [bitmap bitmapWidthForText:text];
            int backWidth = textWidth + 14*_pixelScaling;
            int backX = _titleBarTextRect.x + ((_titleBarTextRect.w - backWidth) / 2);
            int textX = backX + 7*_pixelScaling;
            if (hasFocus) {
                [bitmap setColor:@"#eeeeeeff"];
                [bitmap fillRect:[Definitions rectWithX:backX y:_titleBarTextRect.y+2*_pixelScaling w:backWidth h:15*_pixelScaling]];
                [bitmap setColorIntR:0 g:0 b:0 a:255];
                [bitmap drawBitmapText:text x:textX y:_titleBarTextRect.y+4*_pixelScaling];
            } else {
                [bitmap setColorIntR:0x88 g:0x88 b:0x88 a:255];
                [bitmap drawBitmapText:text x:textX y:_titleBarTextRect.y+4*_pixelScaling];
            }
        }
    }

    [bitmap setColor:@"black"];
    [bitmap drawVerticalLineAtX:rr.x+rr.w-1 y:rr.y y:rr.y+rr.h-1];
    [bitmap drawHorizontalLineAtX:rr.x x:rr.x+rr.w-1 y:rr.y+rr.h-1];
    if (!hasFocus) {
        [bitmap setColor:@"#555555ff"];
    }
    for (int i=0; i<_pixelScaling; i++) {
        [bitmap drawVerticalLineAtX:rr.x+i y:rr.y y:rr.y+rr.h-1];
        [bitmap drawVerticalLineAtX:rr.x+rr.w-2-i y:rr.y y:rr.y+rr.h-2];
        [bitmap drawHorizontalLineAtX:rr.x x:rr.x+rr.w-1 y:rr.y+i];
        [bitmap drawHorizontalLineAtX:rr.x x:rr.x+rr.w-2 y:rr.y+rr.h-2-i];
    }

    if (_buttonDown == 't') {
//FIXME pixelScaling
        char *palette = "b #000000\nw #ffffff\n";
        char *h = [Definitions cStringForMacWindowSelectionHorizontal];
        char *v = [Definitions cStringForMacWindowSelectionVertical];
        [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x y:r.y w:r.w+1 palette:palette];
        [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x y:r.y+1 h:r.h+1-2];
        [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x+r.w+1-1 y:r.y+1 h:r.h+1-2];
        [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x y:r.y+r.h+1-1 w:r.w+1 palette:palette];
    }
    if (_buttonDown == 'r') {
//FIXME pixelScaling
        char *palette = "b #000000\nw #ffffff\n";
        char *h = [Definitions cStringForMacWindowSelectionHorizontal];
        char *v = [Definitions cStringForMacWindowSelectionVertical];
        [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x y:r.y w:r.w palette:palette];
        [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x y:r.y+18 w:r.w palette:palette];
        [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x y:r.y+1 h:r.h-2];
        [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x+r.w-1 y:r.y+1 h:r.h-2];
        [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x+r.w-1-15 y:r.y+1+18 h:r.h-2-18];
        [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x y:r.y+r.h-1 w:r.w palette:palette];
        [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x y:r.y+r.h-1-15 w:r.w palette:palette];
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
    if (mouseX >= viewWidth-16*_pixelScaling) {
        if (mouseY >= viewHeight-16*_pixelScaling) {
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
        if (newY < menuBarHeight-1) {
            newY = menuBarHeight-1;
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

