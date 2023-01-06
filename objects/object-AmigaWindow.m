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

@implementation Definitions(ifjeowjfkldsjfkldsjkflsjdlkfjdifieqf)
+ (void)enterAmigaMode
{
    [Definitions enterAmigaMode:1];
}
+ (void)enterAmigaMode:(int)scaling
{
    if (scaling < 1) {
        scaling = 1;
    }
    [Definitions setValue:nsfmt(@"%d", scaling) forEnvironmentVariable:@"HOTDOG_SCALING"];

    id windowManager = [@"windowManager" valueForKey];
    [windowManager setFocusDict:nil];
    [windowManager unparentAllWindows];

    [Definitions setValue:@"amiga" forEnvironmentVariable:@"HOTDOG_MODE"];

    char *backgroundCString =
"a\n"
;
    char *backgroundPalette =
"a #0055aa\n"
;
/*
    char *backgroundCString =
"a\n"
"b\n"
;
    char *backgroundPalette =
"a #0055aa\n"
"b #000000\n"
;
*/
    [windowManager setBackgroundForCString:backgroundCString palette:backgroundPalette];

    id rootWindowObject = [@"MacRootWindow" asInstance];
    [windowManager setValue:rootWindowObject forKey:@"rootWindowObject"];
    [windowManager reparentAllWindows:@"AmigaWindow"];
    id oldMenuBar = [windowManager valueForKey:@"menuBar"];
    [oldMenuBar setValue:@"1" forKey:@"shouldCloseWindow"];
    int h = 20*scaling;
    [windowManager setValue:nsfmt(@"%d", h) forKey:@"menuBarHeight"];
    id menuBar = [windowManager openWindowForObject:[@"AmigaMenuBar" asInstance] x:0 y:0 w:[windowManager intValueForKey:@"rootWindowWidth"] h:h];
    [windowManager setValue:menuBar forKey:@"menuBar"];
    [windowManager setFocusDict:nil];
    [@"hotdog-setupWindowManagerMode.sh" runCommandInBackground];
}
@end

static char *amigaPalette =
"b #000000\n"
". #000022\n"
"* #ff8800\n"
"X #0055aa\n"
"o #ffffff\n"
;
static char *amigaHighlightedPalette =
"b #000000\n"
"o #000022\n"
"X #ff8800\n"
"* #0055aa\n"
". #ffffff\n"
;
static char *titleBarTextBackgroundPixels =
"o\n"
"o\n"
"o\n"
"o\n"
"o\n"
"o\n"
"o\n"
"o\n"
"o\n"
"o\n"
"o\n"
"o\n"
"o\n"
"o\n"
"o\n"
"o\n"
"o\n"
"o\n"
"o\n"
"o\n"
;
static char *titleBarCloseButtonPixels =
"XXooooooooooooooooooooXX\n"
"XXooooooooooooooooooooXX\n"
"XXooXXXXXXXXXXXXXXXXooXX\n"
"XXooXXXXXXXXXXXXXXXXooXX\n"
"XXooXXooooooooooooXXooXX\n"
"XXooXXooooooooooooXXooXX\n"
"XXooXXooooooooooooXXooXX\n"
"XXooXXooooooooooooXXooXX\n"
"XXooXXoooo....ooooXXooXX\n"
"XXooXXoooo....ooooXXooXX\n"
"XXooXXoooo....ooooXXooXX\n"
"XXooXXoooo....ooooXXooXX\n"
"XXooXXooooooooooooXXooXX\n"
"XXooXXooooooooooooXXooXX\n"
"XXooXXooooooooooooXXooXX\n"
"XXooXXooooooooooooXXooXX\n"
"XXooXXXXXXXXXXXXXXXXooXX\n"
"XXooXXXXXXXXXXXXXXXXooXX\n"
"XXooooooooooooooooooooXX\n"
"XXooooooooooooooooooooXX\n"
;
static char *titleBarLowerButtonPixels =
"XXooooooooooooooooooooooXX\n"
"XXooooooooooooooooooooooXX\n"
"XXooXXXXXXXXXXXXXXooooooXX\n"
"XXooXXXXXXXXXXXXXXooooooXX\n"
"XXooXXooooooooooXXooooooXX\n"
"XXooXXooooooooooXXooooooXX\n"
"XXooXXoo..............ooXX\n"
"XXooXXoo..............ooXX\n"
"XXooXXoo..............ooXX\n"
"XXooXXoo..............ooXX\n"
"XXooXXoo..............ooXX\n"
"XXooXXoo..............ooXX\n"
"XXooXXXX..............ooXX\n"
"XXooXXXX..............ooXX\n"
"XXoooooo..............ooXX\n"
"XXoooooo..............ooXX\n"
"XXoooooo..............ooXX\n"
"XXoooooo..............ooXX\n"
"XXooooooooooooooooooooooXX\n"
"XXooooooooooooooooooooooXX\n"
;
static char *titleBarRaiseButtonPixels =
"XXooooooooooooooooooooooXX\n"
"XXooooooooooooooooooooooXX\n"
"XXoo..............ooooooXX\n"
"XXoo..............ooooooXX\n"
"XXoo....XXXXXXXXXXXXXXooXX\n"
"XXoo....XXXXXXXXXXXXXXooXX\n"
"XXoo....XXooooooooooXXooXX\n"
"XXoo....XXooooooooooXXooXX\n"
"XXoo....XXooooooooooXXooXX\n"
"XXoo....XXooooooooooXXooXX\n"
"XXoo....XXooooooooooXXooXX\n"
"XXoo....XXooooooooooXXooXX\n"
"XXoo....XXooooooooooXXooXX\n"
"XXoo....XXooooooooooXXooXX\n"
"XXooooooXXooooooooooXXooXX\n"
"XXooooooXXooooooooooXXooXX\n"
"XXooooooXXXXXXXXXXXXXXooXX\n"
"XXooooooXXXXXXXXXXXXXXooXX\n"
"XXooooooooooooooooooooooXX\n"
"XXooooooooooooooooooooooXX\n"
;
static char *titleBarLeftPixels =
"oooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooo\n"
;
static char *titleBarMiddlePixels =
"o\n"
"o\n"
"o\n"
"o\n"
"X\n"
"X\n"
"X\n"
"X\n"
"o\n"
"o\n"
"o\n"
"o\n"
"X\n"
"X\n"
"X\n"
"X\n"
"o\n"
"o\n"
"o\n"
"o\n"
;
static char *inactiveAmigaTitleBarPixels =
"    \n"
"    \n"
"    \n"
"    \n"
"o   \n"
"o   \n"
"  o \n"
"  o \n"
"    \n"
"    \n"
"    \n"
"    \n"
"o   \n"
"o   \n"
"  o \n"
"  o \n"
"    \n"
"    \n"
"    \n"
"    \n"
;
static char *titleBarRightPixels =
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
;
static char *bottomBorderPixels =
"o\n"
"o\n"
;
static char *leftBorderPixels =
"oo\n"
"oo\n"
;
static char *rightBorderPixels =
"oo\n"
"oo\n"
;
static char *resizeButtonPixels =
"oooooooooooooooo\n"
"oooooooooooooooo\n"
"ooXXXXXXoooooooo\n"
"ooXXXXXXoooooooo\n"
"ooXXooXXoooooooo\n"
"ooXXooXXoooooooo\n"
"ooXXXXXXXXXXXXoo\n"
"ooXXXXXXXXXXXXoo\n"
"ooooooXXooooXXoo\n"
"ooooooXXooooXXoo\n"
"ooooooXXooooXXoo\n"
"ooooooXXooooXXoo\n"
"ooooooXXooooXXoo\n"
"ooooooXXooooXXoo\n"
"ooooooXXXXXXXXoo\n"
"ooooooXXXXXXXXoo\n"
"oooooooooooooooo\n"
"oooooooooooooooo\n"
;
@implementation Definitions(fdsjfklsdklfjklsdjfklsjdklfj)
+ (char *)cStringForAmigaResizeButtonPixels
{
    return resizeButtonPixels;
}
+ (char *)cStringForAmigaCloseButtonPixels
{
    return titleBarCloseButtonPixels;
}
+ (char *)cStringForAmigaLowerButtonPixels
{
    return titleBarLowerButtonPixels;
}
+ (char *)cStringForAmigaRaiseButtonPixels
{
    return titleBarRaiseButtonPixels;
}
+ (char *)cStringForAmigaTextBackgroundPixels
{
    return titleBarTextBackgroundPixels;
}
+ (char *)cStringForAmigaInactiveTitleBarPixels
{
    return inactiveAmigaTitleBarPixels;
}
+ (char *)cStringForAmigaTitleBarRightPixels
{
    return titleBarRightPixels;
}
+ (char *)cStringForAmigaTitleBarMiddlePixels
{
    return titleBarMiddlePixels;
}
+ (char *)cStringForAmigaTitleBarLeftPixels
{
    return titleBarLeftPixels;
}
@end



@interface AmigaWindow : IvarObject
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
    Int4 _closeButtonRect;
    Int4 _lowerButtonRect;
    Int4 _raiseButtonRect;
    Int4 _titleTextRect;

    // setPixelScale:
    int _pixelScaling;
    id _scaledFont;
    id _scaledTitleBarLeftPixels;
    id _scaledTitleBarMiddlePixels;
    id _scaledTitleBarRightPixels;
    int _scaledTitleBarHeight;
    id _scaledCloseButtonPixels;
    int _scaledCloseButtonWidth;
    id _scaledLowerButtonPixels;
    int _scaledLowerButtonWidth;
    id _scaledRaiseButtonPixels;
    int _scaledRaiseButtonWidth;
    id _scaledLeftBorderPixels;
    int _scaledLeftBorderWidth;
    id _scaledBottomBorderPixels;
    int _scaledBottomBorderHeight;
    id _scaledRightBorderPixels;
    int _scaledRightBorderWidth;
    id _scaledResizeButtonPixels;
    int _scaledResizeButtonWidth;
    int _scaledResizeButtonHeight;
    id _scaledInactiveTitleBarPixels;
    id _scaledTextBackgroundPixels;
}
@end
@implementation AmigaWindow
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

    _topBorder = 20*scaling;
    _leftBorder = 2*scaling;
    _rightBorder = 2*scaling;
    _bottomBorder = 2*scaling;

    [self setValue:nsfmt(@"bottomRightCorner w:%d h:%d", 14*scaling, 16*scaling) forKey:@"x11HasChildMask"];

    id obj;
    obj = [Definitions scaleFont:scaling
                    :[Definitions arrayOfCStringsForTopazFont]
                    :[Definitions arrayOfWidthsForTopazFont]
                    :[Definitions arrayOfHeightsForTopazFont]
                    :[Definitions arrayOfXSpacingsForTopazFont]];
    [self setValue:obj forKey:@"scaledFont"];

    obj = [nsfmt(@"%s", titleBarLeftPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledTitleBarLeftPixels"];

    obj = [nsfmt(@"%s", titleBarMiddlePixels) asYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledTitleBarMiddlePixels"];
    _scaledTitleBarHeight = [Definitions heightForCString:[obj UTF8String]];

    obj = [nsfmt(@"%s", titleBarRightPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledTitleBarRightPixels"];

    obj = [nsfmt(@"%s", titleBarCloseButtonPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledCloseButtonPixels"];
    _scaledCloseButtonWidth = [Definitions widthForCString:[obj UTF8String]];

    obj = [nsfmt(@"%s", titleBarLowerButtonPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledLowerButtonPixels"];
    _scaledLowerButtonWidth = [Definitions widthForCString:[obj UTF8String]];

    obj = [nsfmt(@"%s", titleBarRaiseButtonPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledRaiseButtonPixels"];
    _scaledRaiseButtonWidth = [Definitions widthForCString:[obj UTF8String]];

    obj = [nsfmt(@"%s", leftBorderPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledLeftBorderPixels"];
    _scaledLeftBorderWidth = [Definitions widthForCString:[obj UTF8String]];

    obj = [nsfmt(@"%s", bottomBorderPixels) asYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledBottomBorderPixels"];
    _scaledBottomBorderHeight = [Definitions heightForCString:[obj UTF8String]];

    obj = [nsfmt(@"%s", rightBorderPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledRightBorderPixels"];
    _scaledRightBorderWidth = [Definitions widthForCString:[obj UTF8String]];

    obj = [nsfmt(@"%s", resizeButtonPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledResizeButtonPixels"];
    _scaledResizeButtonWidth = [Definitions widthForCString:[obj UTF8String]];
    _scaledResizeButtonHeight = [Definitions heightForCString:[obj UTF8String]];

    obj = [nsfmt(@"%s", inactiveAmigaTitleBarPixels) asXYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledInactiveTitleBarPixels"];

    obj = [nsfmt(@"%s", titleBarTextBackgroundPixels) asYScaledPixels:scaling];
    [self setValue:obj forKey:@"scaledTextBackgroundPixels"];
}

- (void)calculateRects:(Int4)r
{
    _titleBarRect = [Definitions rectWithX:r.x y:r.y w:r.w h:_scaledTitleBarHeight];
    _closeButtonRect = [Definitions rectWithX:r.x+4*_pixelScaling y:r.y w:_scaledCloseButtonWidth h:_scaledTitleBarHeight];
    _lowerButtonRect = [Definitions rectWithX:r.x+r.w-3*_pixelScaling-_scaledLowerButtonWidth-_scaledRaiseButtonWidth+2*_pixelScaling y:r.y w:_scaledLowerButtonWidth h:_scaledTitleBarHeight];
    _raiseButtonRect = [Definitions rectWithX:r.x+r.w-3*_pixelScaling-_scaledRaiseButtonWidth y:r.y w:_scaledRaiseButtonWidth h:_scaledTitleBarHeight];
    _titleTextRect.x = r.x+4*_pixelScaling+_scaledCloseButtonWidth+2*_pixelScaling;
    _titleTextRect.y = r.y+2*_pixelScaling;
    _titleTextRect.w = _lowerButtonRect.x - _titleTextRect.x - 2*_pixelScaling;
    _titleTextRect.h = _scaledTitleBarHeight;
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r context:(id)context
{
    [self calculateRects:r];
    char *palette = amigaPalette;
    char *highlightedPalette = amigaHighlightedPalette;
/*
    [bitmap setColor:@"#0055aa"];
    for (int i=0; i<r.h; i+=2) {
        [bitmap drawHorizontalLineAtX:r.x x:r.x+r.w-1 y:r.y+i];
    }
    [bitmap setColor:@"#000000"];
    for (int i=1; i<r.h; i+=2) {
        [bitmap drawHorizontalLineAtX:r.x x:r.x+r.w-1 y:r.y+i];
    }
*/
{
    Int4 r1;
    r1.x = r.x+r.w-_scaledRightBorderWidth;
    r1.y = r.y+_scaledTitleBarHeight;
    r1.w = _scaledRightBorderWidth;
    r1.h = r.h-_scaledTitleBarHeight-_scaledBottomBorderHeight;
    int heightForMiddle = [Definitions heightForCString:[_scaledRightBorderPixels UTF8String]];
    int widthForMiddle = [Definitions widthForCString:[_scaledRightBorderPixels UTF8String]];
    for (int y=r1.y; y<r1.y+r1.h; y+=heightForMiddle) {
        [bitmap drawCString:[_scaledRightBorderPixels UTF8String] palette:palette x:r1.x y:y];
    }
}
{
    Int4 r1;
    r1.x = r.x;
    r1.y = r.y+_scaledTitleBarHeight;
    r1.w = _scaledLeftBorderWidth;
    r1.h = r.h-_scaledTitleBarHeight-_scaledBottomBorderHeight;
    int heightForMiddle = [Definitions heightForCString:[_scaledLeftBorderPixels UTF8String]];
    int widthForMiddle = [Definitions widthForCString:[_scaledLeftBorderPixels UTF8String]];
    for (int y=r1.y; y<r1.y+r1.h; y+=heightForMiddle) {
        [bitmap drawCString:[_scaledLeftBorderPixels UTF8String] palette:palette x:r1.x y:y];
    }
}
{
    Int4 r1;
    r1.x = r.x;
    r1.y = r.y+r.h-_scaledBottomBorderHeight;
    r1.w = r.w-_scaledResizeButtonWidth;
    r1.h = _scaledBottomBorderHeight;
    int widthForMiddle = [Definitions widthForCString:[_scaledBottomBorderPixels UTF8String]];
    int x;
    for (x=0; x<r.w; x+=widthForMiddle) {
        [bitmap drawCString:[_scaledBottomBorderPixels UTF8String] palette:palette x:r1.x+x y:r1.y];
    }
}



    [Definitions drawInBitmap:bitmap left:[_scaledTitleBarLeftPixels UTF8String] middle:[_scaledTitleBarMiddlePixels UTF8String] right:[_scaledTitleBarRightPixels UTF8String] x:_titleBarRect.x y:_titleBarRect.y w:_titleBarRect.w palette:palette];

    [bitmap drawCString:[_scaledCloseButtonPixels UTF8String] palette:((_buttonDown=='c' && _buttonHover=='c') ? highlightedPalette : palette) x:_closeButtonRect.x y:_closeButtonRect.y];
    [bitmap drawCString:[_scaledLowerButtonPixels UTF8String] palette:palette x:_lowerButtonRect.x y:_lowerButtonRect.y];
    [bitmap drawCString:[_scaledRaiseButtonPixels UTF8String] palette:palette x:_raiseButtonRect.x y:_raiseButtonRect.y];
    if (_buttonDown == _buttonHover) {
        if (_buttonDown == 'l') {
            [bitmap drawCString:[_scaledLowerButtonPixels UTF8String] palette:highlightedPalette x:_lowerButtonRect.x y:_lowerButtonRect.y];
        } else if (_buttonDown == 'r') {
            [bitmap drawCString:[_scaledRaiseButtonPixels UTF8String] palette:highlightedPalette x:_raiseButtonRect.x y:_raiseButtonRect.y];
        }
    }
    [bitmap drawCString:[_scaledResizeButtonPixels UTF8String] palette:((_buttonDown=='s') ? highlightedPalette : palette) x:r.x+r.w-_scaledResizeButtonWidth y:r.y+r.h-_scaledResizeButtonHeight];

    if (_scaledFont) {
        [bitmap useFont:[[_scaledFont nth:0] bytes]
                    :[[_scaledFont nth:1] bytes]
                    :[[_scaledFont nth:2] bytes]
                    :[[_scaledFont nth:3] bytes]];
    }
    id text = [context valueForKey:@"name"];
    if (!text) {
        text = @"(no title)";
    }

    text = [[[bitmap fitBitmapString:text width:_titleTextRect.w-14*_pixelScaling] split:@"\n"] nth:0];

    int textWidth = [bitmap bitmapWidthForText:text];
    [Definitions drawInBitmap:bitmap left:[_scaledTextBackgroundPixels UTF8String] middle:[_scaledTextBackgroundPixels UTF8String] right:[_scaledTextBackgroundPixels UTF8String] x:_titleTextRect.x y:_titleBarRect.y w:textWidth+3*_pixelScaling palette:palette];
    [bitmap setColorIntR:0x00 g:0x55 b:0xaa a:0xff];
    [bitmap drawBitmapText:text x:_titleTextRect.x y:_titleTextRect.y];

    if (![context intValueForKey:@"hasFocus"]) {
        Int4 rr = _titleBarRect;
        [Definitions drawInBitmap:bitmap left:[_scaledInactiveTitleBarPixels UTF8String] middle:[_scaledInactiveTitleBarPixels UTF8String] right:[_scaledInactiveTitleBarPixels UTF8String] x:_titleTextRect.x y:_titleBarRect.y w:_titleTextRect.w palette:palette];
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
            _buttonDown = 's';
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
    if ([Definitions isX:mouseX y:mouseY insideRect:_lowerButtonRect]) {
        _buttonDown = 'l';
        _buttonHover = 'l';
        _buttonDownX = mouseX;
        _buttonDownY = mouseY;
        _buttonDownW = viewWidth;
        _buttonDownH = viewHeight;
        return;
    }
    if ([Definitions isX:mouseX y:mouseY insideRect:_raiseButtonRect]) {
        _buttonDown = 'r';
        _buttonHover = 'r';
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
    if (_buttonDown == 'l') {
        int mouseX = [event intValueForKey:@"mouseX"];
        int mouseY = [event intValueForKey:@"mouseY"];
        if ([Definitions isX:mouseX y:mouseY insideRect:_lowerButtonRect]) {
            _buttonHover = _buttonDown;
        } else {
            _buttonHover = 0;
        }
        return;
    }
    if (_buttonDown == 'r') {
        int mouseX = [event intValueForKey:@"mouseX"];
        int mouseY = [event intValueForKey:@"mouseY"];
        if ([Definitions isX:mouseX y:mouseY insideRect:_raiseButtonRect]) {
            _buttonHover = _buttonDown;
        } else {
            _buttonHover = 0;
        }
        return;
    }

    if (_buttonDown == 't') {
        int mouseRootX = [event intValueForKey:@"mouseRootX"];
        int mouseRootY = [event intValueForKey:@"mouseRootY"];
        int viewHeight = [event intValueForKey:@"viewHeight"];

        id dict = [event valueForKey:@"x11dict"];

        int newX = mouseRootX - _buttonDownX;
        int newY = mouseRootY - _buttonDownY;

        [dict setValue:nsfmt(@"%d", newX) forKey:@"x"];
        [dict setValue:nsfmt(@"%d", newY) forKey:@"y"];

        [dict setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];
        return;
    }

    if (_buttonDown == 's') {
        int mouseX = [event intValueForKey:@"mouseX"];
        int mouseY = [event intValueForKey:@"mouseY"];
        int viewWidth = [event intValueForKey:@"viewWidth"];
        int viewHeight = [event intValueForKey:@"viewHeight"];

        id dict = [event valueForKey:@"x11dict"];

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
    id x11dict = [event valueForKey:@"x11dict"];
    if (_buttonDown == _buttonHover) {
        if (_buttonDown == 'c') {
            [x11dict x11CloseWindow];
        }
        if (_buttonDown == 'l') {
            id windowManager = [event valueForKey:@"windowManager"];
            [windowManager lowerObjectWindow:x11dict];
        }
        if (_buttonDown == 'r') {
            id windowManager = [event valueForKey:@"windowManager"];
            [windowManager raiseObjectWindow:x11dict];
        }
    }
    if (_buttonDown == 't') {
        /* this was added for Wine */
        [x11dict x11MoveChildWindowBackAndForthForWine];
    }
    _buttonDown = _buttonHover = 0;
}
@end

