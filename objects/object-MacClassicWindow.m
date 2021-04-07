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
    id windowManager = [@"windowManager" valueForKey];
    [windowManager unparentAllWindows];
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
    id menuBar = [windowManager openWindowForObject:[@"MacMenuBar" asInstance] x:0 y:0 w:[windowManager intValueForKey:@"rootWindowWidth"] h:[windowManager intValueForKey:@"menuBarHeight"]];
    [windowManager setValue:menuBar forKey:@"menuBar"];
    [windowManager setFocusDict:nil];
}
@end
@implementation Definitions(fjkdlemdisjfiowejfklsdjfklsdkljf)
+ (char *)cStringForMacClassicInactiveTitleBarLeft
{
    return
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
}
+ (char *)cStringForMacClassicInactiveTitleBarMiddle
{
    return
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
}
+ (char *)cStringForMacClassicInactiveTitleBarRight
{
    return
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
}
+ (char *)cStringForMacClassicInactiveBottomBorderLeft
{
    return
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
}
+ (char *)cStringForMacClassicInactiveBottomBorderMiddle
{
    return
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
}
+ (char *)cStringForMacClassicInactiveBottomBorderRight
{
    return
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
}

+ (char *)cStringForMacClassicActiveTitleBarLeft
{
    return
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
}
+ (char *)cStringForMacClassicActiveTitleBarMiddle
{
    return
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
}
+ (char *)cStringForMacClassicActiveTitleBarRight
{
    return
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
}
+ (char *)cStringForMacClassicLeftBorderMiddle
{
    return
"b\n"
;
}

+ (char *)cStringForMacClassicBottomBorderLeft
{
    return
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
".bbbbbbbbbbbbbbb\n"
;
}
+ (char *)cStringForMacClassicBottomBorderMiddle
{
    return
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
}
+ (char *)cStringForMacClassicBottomBorderRight
{
    return
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"b.......b......b..............bb\n"
"b.......bb.....b..............bb\n"
"b.......b.b....b..bbbbbbb.....bb\n"
"b...bbbbb..b...b..b.....b.....bb\n"
"b...b.......b..b..b.....bbbbb.bb\n"
"b...b........b.b..b.....b...b.bb\n"
"b...b.........bb..b.....b...b.bb\n"
"b...b........b.b..b.....b...b.bb\n"
"b...b.......b..b..bbbbbbb...b.bb\n"
"b...bbbbb..b...b....b.......b.bb\n"
"b.......b.b....b....b.......b.bb\n"
"b.......bb.....b....b.......b.bb\n"
"b.......b......b....bbbbbbbbb.bb\n"
"b..............b..............bb\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
;
}


+ (char *)cStringForMacClassicRightBorderTop
{
    return
"b..............bb\n"
"b......b.......bb\n"
"b.....b.b......bb\n"
"b....b...b.....bb\n"
"b...b.....b....bb\n"
"b..b.......b...bb\n"
"b.b.........b..bb\n"
"bbbbb.....bbbb.bb\n"
"b...b.....b....bb\n"
"b...b.....b....bb\n"
"b...b.....b....bb\n"
"b...bbbbbbb....bb\n"
"b..............bb\n"
"b..............bb\n"
"bbbbbbbbbbbbbbbbb\n"
;
}
+ (char *)cStringForMacClassicRightBorderMiddle
{
    return
"b..............bb\n"
;
}
+ (char *)cStringForMacClassicRightBorderBottom
{
    return
"bbbbbbbbbbbbbbbbb\n"
"b..............bb\n"
"b..............bb\n"
"b...bbbbbbb....bb\n"
"b...b.....b....bb\n"
"b...b.....b....bb\n"
"b...b.....b....bb\n"
"bbbbb.....bbbb.bb\n"
"b.b.........b..bb\n"
"b..b.......b...bb\n"
"b...b.....b....bb\n"
"b....b...b.....bb\n"
"b.....b.b......bb\n"
"b......b.......bb\n"
"b..............bb\n"
;
}

+ (char *)cStringForMacClassicInactiveRightBorderMiddle
{
    return
"b..............bb\n"
;
}



+ (char *)cStringForMacClassicCloseButtonDown
{
    return
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
}

@end

@interface MacClassicWindow : IvarObject
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
}
@end
@implementation MacClassicWindow
- (id)init
{
    self = [super init];
    if (self) {
        _leftBorder = 1;
        _rightBorder = 16+1;
        _topBorder = 19;
        _bottomBorder = 16+1;
        _hasShadow = 1;
    }
    return self;
}

- (void)calculateRects:(Int4)r
{
    char *titleBarLeft = [Definitions cStringForMacClassicActiveTitleBarLeft];
    char *titleBarMiddle = [Definitions cStringForMacClassicActiveTitleBarMiddle];
    char *titleBarRight = [Definitions cStringForMacClassicActiveTitleBarRight];
    int titleBarLeftWidth = [Definitions widthForCString:titleBarLeft];
    int titleBarHeight = [Definitions heightForCString:titleBarMiddle];

    _titleBarRect = [Definitions rectWithX:r.x y:r.y w:r.w h:titleBarHeight];
    _titleBarTextRect = _titleBarRect;
    _titleBarTextRect.x = titleBarLeftWidth+4;
    _titleBarTextRect.w -= titleBarLeftWidth+4;

    _leftBorderRect = r;
    _leftBorderRect.y += titleBarHeight;
    _leftBorderRect.h -= titleBarHeight;
    _leftBorderRect.h -= _bottomBorder;
    _leftBorderRect.w = _leftBorder;

    _rightBorderRect = r;
    _rightBorderRect.x += r.w-_rightBorder;
    _rightBorderRect.y += titleBarHeight;
    _rightBorderRect.h -= titleBarHeight;
    _rightBorderRect.h -= _bottomBorder;
    _rightBorderRect.w = _rightBorder;

    _bottomBorderRect = _titleBarRect;
    _bottomBorderRect.y += r.h-_bottomBorder;
    _bottomBorderRect.h = _bottomBorder;

    _closeButtonRect = _titleBarRect;
    _closeButtonRect.x += 9;
    _closeButtonRect.y += 4;
    _closeButtonRect.w = 11;
    _closeButtonRect.h = 11;

    _maximizeButtonRect = _titleBarRect;
    _maximizeButtonRect.x = _maximizeButtonRect.x+_maximizeButtonRect.w-21;
    _maximizeButtonRect.y += 4;
    _maximizeButtonRect.w = 11;
    _maximizeButtonRect.h = 11;
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [self drawInBitmap:bitmap rect:r context:nil];
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r context:(id)context
{
    char *palette = "b #000000\n";
    int hasFocus = [context intValueForKey:@"hasFocus"];

    [self calculateRects:r];
    [bitmap setColor:@"white"];
    [bitmap fillRect:r];
    [bitmap setColor:@"black"];
    [bitmap drawHorizontalLineX:r.x x:r.x+r.w-1 y:r.y+r.h-1];
    [bitmap drawVerticalLineX:r.x+r.w-1 y:r.y y:r.y+r.h-1];
    if (hasFocus) {
        char *left = [Definitions cStringForMacClassicActiveTitleBarLeft];
        char *middle = [Definitions cStringForMacClassicActiveTitleBarMiddle];
        char *right = [Definitions cStringForMacClassicActiveTitleBarRight];
        [Definitions drawInBitmap:bitmap left:left palette:palette middle:middle palette:palette right:right palette:palette x:_titleBarRect.x y:_titleBarRect.y w:_titleBarRect.w];
    } else {
        char *left = [Definitions cStringForMacClassicInactiveTitleBarLeft];
        char *middle = [Definitions cStringForMacClassicInactiveTitleBarMiddle];
        char *right = [Definitions cStringForMacClassicInactiveTitleBarRight];
        [Definitions drawInBitmap:bitmap left:left palette:palette middle:middle palette:palette right:right palette:palette x:_titleBarRect.x y:_titleBarRect.y w:_titleBarRect.w];
    }
    if (_titleBarTextRect.w > 0) {
        id text = [context valueForKey:@"name"];
        if (!text) {
            text = @"(no title)";
        }

        text = [bitmap fitBitmapString:text width:_titleBarTextRect.w-14];
        if (text) {
            int textWidth = [Definitions bitmapWidthForText:text];
            int backWidth = textWidth + 14;
            int backX = _titleBarTextRect.x + ((_titleBarTextRect.w - backWidth) / 2);
            int textX = backX + 7;
            if (hasFocus) {
                [bitmap setColor:@"white"];
                [bitmap fillRect:[Definitions rectWithX:backX y:_titleBarTextRect.y+2 w:backWidth h:16]];
                [bitmap setColorIntR:0 g:0 b:0 a:255];
                [bitmap drawBitmapText:text x:textX y:_titleBarTextRect.y+4];
            } else {
                [bitmap setColorIntR:0 g:0 b:0 a:255];
                [bitmap drawBitmapText:text x:textX y:_titleBarTextRect.y+4];
            }
        }
    }

    {
        char *middle = [Definitions cStringForMacClassicLeftBorderMiddle];
        [Definitions drawInBitmap:bitmap top:middle palette:palette middle:middle palette:palette bottom:middle palette:palette x:_leftBorderRect.x y:_leftBorderRect.y h:_leftBorderRect.h];
    }
    if (hasFocus) {
        char *top = [Definitions cStringForMacClassicRightBorderTop];
        char *middle = [Definitions cStringForMacClassicRightBorderMiddle];
        char *bottom = [Definitions cStringForMacClassicRightBorderBottom];
        [Definitions drawInBitmap:bitmap top:top palette:palette middle:middle palette:palette bottom:bottom palette:palette x:_rightBorderRect.x y:_rightBorderRect.y h:_rightBorderRect.h];
    } else {
        char *top = [Definitions cStringForMacClassicInactiveRightBorderMiddle];
        char *middle = top;
        char *bottom = top;
        [Definitions drawInBitmap:bitmap top:middle palette:palette middle:middle palette:palette bottom:bottom palette:palette x:_rightBorderRect.x y:_rightBorderRect.y h:_rightBorderRect.h];
    }

    if (hasFocus) {
        Int4 r = _bottomBorderRect;
        char *left = [Definitions cStringForMacClassicBottomBorderLeft];
        char *middle = [Definitions cStringForMacClassicBottomBorderMiddle];
        char *right = [Definitions cStringForMacClassicBottomBorderRight];
        [Definitions drawInBitmap:bitmap left:left middle:middle right:right x:r.x y:r.y w:r.w palette:palette];
    } else {
        Int4 r = _bottomBorderRect;
        char *left = [Definitions cStringForMacClassicInactiveBottomBorderLeft];
        char *middle = [Definitions cStringForMacClassicInactiveBottomBorderMiddle];
        char *right = [Definitions cStringForMacClassicInactiveBottomBorderRight];
        [Definitions drawInBitmap:bitmap left:left middle:middle right:right x:r.x y:r.y w:r.w palette:palette];
    }

    if (hasFocus) {
        if ((_buttonDown == 'c') && (_buttonHover == 'c')) {
            char *closeButtonDown = [Definitions cStringForMacClassicCloseButtonDown];
            [bitmap drawCString:closeButtonDown palette:palette x:_closeButtonRect.x y:_closeButtonRect.y];
        }
        if ((_buttonDown == 'm') && (_buttonHover == 'm')) {
            char *maximizePalette = "b #000000\n. #ffffff\n";
            char *maximizeButtonDown = [Definitions cStringForMacClassicCloseButtonDown];
            [bitmap drawCString:maximizeButtonDown palette:maximizePalette x:_maximizeButtonRect.x y:_maximizeButtonRect.y];
        }
        if (_buttonDown == 't') {
            char *palette = "b #000000\nw #ffffff\n";
            char *h = [Definitions cStringForMacWindowSelectionHorizontal];
            char *v = [Definitions cStringForMacWindowSelectionVertical];
            [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x y:r.y w:r.w palette:palette];
            [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x y:r.y+1 h:r.h+1-2];
            [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x+r.w-1 y:r.y+1 h:r.h+1-2];
            [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x y:r.y+r.h-1 w:r.w palette:palette];
        }
        if (_buttonDown == 'r') {
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
    if (mouseX >= viewWidth-17) {
        if (mouseY >= viewHeight-17) {
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

