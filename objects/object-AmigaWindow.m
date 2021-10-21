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
+ (void)testAddAmigaWindow
{
    id windowManager = [@"windowManager" valueForKey];
    id obj = [@"AmigaWindow" asInstance];
    int w = 200;
    int h = 100;
    [windowManager openWindowForObject:obj x:100 y:200 w:w h:h];
}
+ (void)enterAmigaMode
{
    id windowManager = [@"windowManager" valueForKey];
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
    [[windowManager valueForKey:@"menuBar"] setValue:@"1" forKey:@"shouldCloseWindow"];
    id menuBar = [windowManager openWindowForObject:[@"AmigaMenuBar" asInstance] x:0 y:0 w:[windowManager intValueForKey:@"rootWindowWidth"] h:[windowManager intValueForKey:@"menuBarHeight"]];
    [windowManager setValue:menuBar forKey:@"menuBar"];
    [windowManager setFocusDict:nil];
    [@"hotdog-setupWindowManagerMode.sh" runCommandInBackground];
}
@end
@implementation Definitions(fjkdlsjfiowejfklsdjfklsdkljfvjjidfj)

+ (char *)cStringForAmigaPalette
{
    return
"b #000000\n"
". #000022\n"
"* #ff8800\n"
"X #0055aa\n"
"o #ffffff\n"
;
}
+ (char *)cStringForAmigaHighlightedPalette
{
    return
"b #000000\n"
"o #000022\n"
"X #ff8800\n"
"* #0055aa\n"
". #ffffff\n"
;
}
+ (char *)cStringForAmigaTitleBarTextBackground
{
    return
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
}
+ (char *)cStringForAmigaTitleBarCloseButton
{
    return
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
}
+ (char *)cStringForAmigaTitleBarLowerButton
{
    return
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
}
+ (char *)cStringForAmigaTitleBarRaiseButton
{
    return
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
}
+ (char *)cStringForAmigaTitleBarLeft
{
    return
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
}
+ (char *)cStringForAmigaTitleBarMiddle
{
    return
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
}
+ (char *)cStringForInactiveAmigaTitleBar
{
    return
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
}
+ (char *)cStringForAmigaTitleBarRight
{
    return
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
}
+ (char *)cStringForAmigaBottomBorder
{
    return
"o\n"
"o\n"
;
}
+ (char *)cStringForAmigaLeftBorder
{
    return
"oo\n"
"oo\n"
;
}
+ (void)drawAmigaBottomBorderInBitmap:(id)bitmap rect:(Int4)r
{
    char *palette = [Definitions cStringForAmigaPalette];

    char *middle = [Definitions cStringForAmigaBottomBorder];

    int widthForMiddle = [Definitions widthForCString:middle];

    int x;
    for (x=0; x<r.w; x+=widthForMiddle) {
        [bitmap drawCString:middle palette:palette x:r.x+x y:r.y];
    }
}
+ (void)drawAmigaLeftBorderInBitmap:(id)bitmap rect:(Int4)r
{
    char *palette = [Definitions cStringForAmigaPalette];

    char *middle = [Definitions cStringForAmigaLeftBorder];

    int heightForMiddle = [Definitions heightForCString:middle];

    int widthForMiddle = [Definitions widthForCString:middle];

    for (int y=r.y; y<r.y+r.h; y+=heightForMiddle) {
        [bitmap drawCString:middle palette:palette x:r.x y:y];
    }
}
+ (char *)cStringForAmigaRightBorder
{
    return
"oo\n"
"oo\n"
;
}
+ (void)drawAmigaRightBorderInBitmap:(id)bitmap rect:(Int4)r
{
    char *palette = [Definitions cStringForAmigaPalette];

    char *middle = [Definitions cStringForAmigaRightBorder];

    int heightForMiddle = [Definitions heightForCString:middle];

    int widthForMiddle = [Definitions widthForCString:middle];

    for (int y=r.y; y<r.y+r.h; y+=heightForMiddle) {
        [bitmap drawCString:middle palette:palette x:r.x y:y];
    }
}
+ (char *)cStringForAmigaResizeButton
{
    return
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
}
@end


@interface AmigaWindow : IvarObject
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
    Int4 _closeButtonRect;
    Int4 _lowerButtonRect;
    Int4 _raiseButtonRect;
    Int4 _titleTextRect;
}
@end
@implementation AmigaWindow
- (id)init
{
    self = [super init];
    if (self) {
        _topBorder = 20;
        _leftBorder = 2;
        _rightBorder = 2;
        _bottomBorder = 2;
        [self setValue:@"amiga" forKey:@"x11HasChildMask"];
    }
    return self;
}
- (void)calculateRects:(Int4)r
{
    char *titleBarMiddle = [Definitions cStringForAmigaTitleBarMiddle];
    int titleBarHeight = [Definitions heightForCString:titleBarMiddle];
    char *closeButton = [Definitions cStringForAmigaTitleBarCloseButton];
    int closeButtonWidth = [Definitions widthForCString:closeButton];
    char *lowerButton = [Definitions cStringForAmigaTitleBarLowerButton];
    int lowerButtonWidth = [Definitions widthForCString:lowerButton];
    char *raiseButton = [Definitions cStringForAmigaTitleBarRaiseButton];
    int raiseButtonWidth = [Definitions widthForCString:raiseButton];

    _titleBarRect = [Definitions rectWithX:r.x y:r.y w:r.w h:titleBarHeight];
    _closeButtonRect = [Definitions rectWithX:r.x+4 y:r.y w:closeButtonWidth h:titleBarHeight];
    _lowerButtonRect = [Definitions rectWithX:r.x+r.w-3-lowerButtonWidth-raiseButtonWidth+2 y:r.y w:lowerButtonWidth h:titleBarHeight];
    _raiseButtonRect = [Definitions rectWithX:r.x+r.w-3-raiseButtonWidth y:r.y w:raiseButtonWidth h:titleBarHeight];
    _titleTextRect.x = r.x+4+closeButtonWidth+2;
    _titleTextRect.y = r.y+2;
    _titleTextRect.w = _lowerButtonRect.x - _titleTextRect.x - 2;
    _titleTextRect.h = titleBarHeight;
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r context:(id)context
{
    [self calculateRects:r];
    char *palette = [Definitions cStringForAmigaPalette];
    char *highlightedPalette = [Definitions cStringForAmigaHighlightedPalette];
    char *titleBarLeft = [Definitions cStringForAmigaTitleBarLeft];
    char *titleBarMiddle = [Definitions cStringForAmigaTitleBarMiddle];
    char *titleBarRight = [Definitions cStringForAmigaTitleBarRight];
    char *inactiveTitleBar = [Definitions cStringForInactiveAmigaTitleBar];
    int titleBarHeight = [Definitions heightForCString:titleBarMiddle];
    char *bottomBorder = [Definitions cStringForAmigaBottomBorder];
    int bottomBorderHeight = [Definitions heightForCString:bottomBorder];
    char *leftBorder = [Definitions cStringForAmigaLeftBorder];
    int leftBorderWidth = [Definitions widthForCString:leftBorder];
    char *rightBorder = [Definitions cStringForAmigaRightBorder];
    int rightBorderWidth = [Definitions widthForCString:rightBorder];
    char *resizeButton = [Definitions cStringForAmigaResizeButton];
    int resizeButtonWidth = [Definitions widthForCString:resizeButton];
    int resizeButtonHeight = [Definitions heightForCString:resizeButton];
    [bitmap setColor:@"#0055aa"];
    for (int i=0; i<r.h; i+=2) {
        [bitmap drawHorizontalLineAtX:r.x x:r.x+r.w-1 y:r.y+i];
    }
    [bitmap setColor:@"#000000"];
    for (int i=1; i<r.h; i+=2) {
        [bitmap drawHorizontalLineAtX:r.x x:r.x+r.w-1 y:r.y+i];
    }
    [Definitions drawAmigaRightBorderInBitmap:bitmap rect:[Definitions rectWithX:r.x+r.w-rightBorderWidth y:r.y+titleBarHeight w:rightBorderWidth h:r.h-titleBarHeight-bottomBorderHeight]];
    [Definitions drawAmigaLeftBorderInBitmap:bitmap rect:[Definitions rectWithX:r.x y:r.y+titleBarHeight w:leftBorderWidth h:r.h-titleBarHeight-bottomBorderHeight]];
    [Definitions drawAmigaBottomBorderInBitmap:bitmap rect:[Definitions rectWithX:r.x y:r.y+r.h-bottomBorderHeight w:r.w-resizeButtonWidth h:bottomBorderHeight]];
    [Definitions drawInBitmap:bitmap left:titleBarLeft middle:titleBarMiddle right:titleBarRight x:_titleBarRect.x y:_titleBarRect.y w:_titleBarRect.w palette:palette];

    [bitmap drawCString:[Definitions cStringForAmigaTitleBarCloseButton] palette:((_buttonDown=='c' && _buttonHover=='c') ? highlightedPalette : palette) x:_closeButtonRect.x y:_closeButtonRect.y];
    [bitmap drawCString:[Definitions cStringForAmigaTitleBarLowerButton] palette:palette x:_lowerButtonRect.x y:_lowerButtonRect.y];
    [bitmap drawCString:[Definitions cStringForAmigaTitleBarRaiseButton] palette:palette x:_raiseButtonRect.x y:_raiseButtonRect.y];
    if (_buttonDown == _buttonHover) {
        if (_buttonDown == 'l') {
            [bitmap drawCString:[Definitions cStringForAmigaTitleBarLowerButton] palette:highlightedPalette x:_lowerButtonRect.x y:_lowerButtonRect.y];
        } else if (_buttonDown == 'r') {
            [bitmap drawCString:[Definitions cStringForAmigaTitleBarRaiseButton] palette:highlightedPalette x:_raiseButtonRect.x y:_raiseButtonRect.y];
        }
    }
    [bitmap drawCString:[Definitions cStringForAmigaResizeButton] palette:((_buttonDown=='s') ? highlightedPalette : palette) x:r.x+r.w-resizeButtonWidth y:r.y+r.h-resizeButtonHeight];

    [bitmap useTopazFont];
    id text = [context valueForKey:@"name"];
    if (!text) {
        text = @"(no title)";
    }
    int textWidth = [bitmap bitmapWidthForText:text];
    char *textBackgroundCString = [Definitions cStringForAmigaTitleBarTextBackground];
    [Definitions drawInBitmap:bitmap left:textBackgroundCString middle:textBackgroundCString right:textBackgroundCString x:_titleTextRect.x y:_titleBarRect.y w:textWidth+3 palette:palette];
    [bitmap setColorIntR:0x00 g:0x55 b:0xaa a:0xff];
    [bitmap drawBitmapText:text x:_titleTextRect.x y:_titleTextRect.y];

    if (![context intValueForKey:@"hasFocus"]) {
        Int4 rr = _titleBarRect;
        [Definitions drawInBitmap:bitmap left:inactiveTitleBar middle:inactiveTitleBar right:inactiveTitleBar x:_titleTextRect.x y:_titleBarRect.y w:_titleTextRect.w palette:palette];
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
    if (mouseX >= viewWidth-16) {
        if (mouseY >= viewHeight-16) {
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

/*
+ (char *)cStringForAmigaTitleBarTextBackground
{
    return
"o\n"
"b\n"
"o\n"
"b\n"
"o\n"
"b\n"
"o\n"
"b\n"
"o\n"
"b\n"
"o\n"
"b\n"
"o\n"
"b\n"
"o\n"
"b\n"
"o\n"
"b\n"
"o\n"
"b\n"
;
}
+ (char *)cStringForAmigaTitleBarCloseButton
{
    return
"XXooooooooooooooooooooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbb\n"
"XXooXXXXXXXXXXXXXXXXooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbb\n"
"XXooXXooooooooooooXXooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbb\n"
"XXooXXooooooooooooXXooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbb\n"
"XXooXXoooo....ooooXXooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbb\n"
"XXooXXoooo....ooooXXooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbb\n"
"XXooXXooooooooooooXXooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbb\n"
"XXooXXooooooooooooXXooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbb\n"
"XXooXXXXXXXXXXXXXXXXooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbb\n"
"XXooooooooooooooooooooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbb\n"
;
}
+ (char *)cStringForAmigaTitleBarLowerButton
{
    return
"XXooooooooooooooooooooooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"XXooXXXXXXXXXXXXXXooooooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"XXooXXooooooooooXXooooooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"XXooXXoo..............ooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"XXooXXoo..............ooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"XXooXXoo..............ooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"XXooXXXX..............ooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"XXoooooo..............ooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"XXoooooo..............ooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"XXooooooooooooooooooooooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbb\n"
;
}
+ (char *)cStringForAmigaTitleBarRaiseButton
{
    return
"XXooooooooooooooooooooooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"XXoo..............ooooooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"XXoo....XXXXXXXXXXXXXXooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"XXoo....XXooooooooooXXooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"XXoo....XXooooooooooXXooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"XXoo....XXooooooooooXXooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"XXoo....XXooooooooooXXooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"XXooooooXXooooooooooXXooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"XXooooooXXXXXXXXXXXXXXooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"XXooooooooooooooooooooooXX\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbb\n"
;
}
+ (char *)cStringForAmigaTitleBarLeft
{
    return
"oooooooooooooooooooooooooooooo\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"oooooooooooooooooooooooooooooo\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"oooooooooooooooooooooooooooooo\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"oooooooooooooooooooooooooooooo\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"oooooooooooooooooooooooooooooo\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"oooooooooooooooooooooooooooooo\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"oooooooooooooooooooooooooooooo\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"oooooooooooooooooooooooooooooo\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"oooooooooooooooooooooooooooooo\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"oooooooooooooooooooooooooooooo\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
;
}
+ (char *)cStringForAmigaTitleBarMiddle
{
    return
"o\n"
"b\n"
"o\n"
"b\n"
"X\n"
"b\n"
"X\n"
"b\n"
"o\n"
"b\n"
"o\n"
"b\n"
"X\n"
"b\n"
"X\n"
"b\n"
"o\n"
"b\n"
"o\n"
"b\n"
;
}
+ (char *)cStringForInactiveAmigaTitleBar
{
    return
"    \n"
"    \n"
"    \n"
"    \n"
"o   \n"
"b   \n"
"  o \n"
"  b \n"
"    \n"
"    \n"
"    \n"
"    \n"
"o   \n"
"b   \n"
"  o \n"
"  b \n"
"    \n"
"    \n"
"    \n"
"    \n"
;
}
+ (char *)cStringForAmigaTitleBarRight
{
    return
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"oooooooooooooooooooooooooooooooooooooooooooooooooooooooo\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
;
}
+ (char *)cStringForAmigaBottomBorder
{
    return
"o\n"
"b\n"
;
}
+ (char *)cStringForAmigaLeftBorder
{
    return
"oo\n"
"bb\n"
;
}
+ (char *)cStringForAmigaRightBorder
{
    return
"oo\n"
"bb\n"
;
}
+ (char *)cStringForAmigaResizeButton
{
    return
"oooooooooooooooo\n"
"bbbbbbbbbbbbbbbb\n"
"ooXXXXXXoooooooo\n"
"bbbbbbbbbbbbbbbb\n"
"ooXXooXXoooooooo\n"
"bbbbbbbbbbbbbbbb\n"
"ooXXXXXXXXXXXXoo\n"
"bbbbbbbbbbbbbbbb\n"
"ooooooXXooooXXoo\n"
"bbbbbbbbbbbbbbbb\n"
"ooooooXXooooXXoo\n"
"bbbbbbbbbbbbbbbb\n"
"ooooooXXooooXXoo\n"
"bbbbbbbbbbbbbbbb\n"
"ooooooXXXXXXXXoo\n"
"bbbbbbbbbbbbbbbb\n"
"oooooooooooooooo\n"
"bbbbbbbbbbbbbbbb\n"
;
}
*/
