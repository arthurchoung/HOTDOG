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

@interface TestScrollBar : IvarObject
{
    int _iteration;
    double _pct;
}
@end
@implementation TestScrollBar
- (BOOL)shouldAnimate
{
    return YES;
}
- (void)beginIteration:(id)event rect:(Int4)r
{
    _iteration++;
    _pct = (_iteration % 361) / 360.0;
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [Definitions drawInactiveVerticalScrollBarInBitmap:bitmap rect:r pct:_pct];
}
@end

@implementation Definitions(jfkdlsvmncmjfklsdjklfjsdfklsdjfs)

+ (void)testAddMacColorWindow
{
    id windowManager = [@"windowManager" valueForKey];
    id obj = [@"MacColorWindow" asInstance];
    int w = 200;
    int h = 100;
    [windowManager openWindowForObject:obj x:100 y:200 w:w h:h];
}
@end

@implementation Definitions(fjkdeifjdclsjfiowejfklsdjfklsdkljf)
+ (void)drawActiveTitleBarInBitmap:(id)bitmap rect:(Int4)r
{
    char *palette = [Definitions cStringForTitleBarPalette];
    char *left = [Definitions cStringForActiveTitleBarLeft];
    char *middle = [Definitions cStringForActiveTitleBarMiddle];
    char *right = [Definitions cStringForActiveTitleBarRight];
    [Definitions drawInBitmap:bitmap left:left middle:middle right:right x:r.x y:r.y w:r.w palette:palette];
}
+ (void)drawInactiveTitleBarInBitmap:(id)bitmap rect:(Int4)r
{
    char *palette = [Definitions cStringForTitleBarPalette];
    char *left = [Definitions cStringForInactiveTitleBarLeft];
    char *middle = [Definitions cStringForInactiveTitleBarMiddle];
    char *right = [Definitions cStringForInactiveTitleBarRight];
    [Definitions drawInBitmap:bitmap left:left middle:middle right:right x:r.x y:r.y w:r.w palette:palette];
}

+ (char *)cStringForTitleBarPalette
{
    return
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
}
+ (char *)cStringForTitleBarButtonDown
{
    return
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
}
+ (char *)cStringForTitleBarCloseButton
{
    return
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
}
+ (char *)cStringForTitleBarMaximizeButton
{
    return
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
}
+ (char *)cStringForInactiveTitleBarLeft
{
    return
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
}
+ (char *)cStringForActiveTitleBarLeft
{
    return
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
}
+ (char *)cStringForInactiveTitleBarMiddle
{
    return
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
}
+ (char *)cStringForActiveTitleBarMiddle
{
    return
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
}
+ (char *)cStringForInactiveTitleBarRight
{
    return
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
}
+ (char *)cStringForActiveTitleBarRight
{
    return
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
}
+ (char *)cStringForResizeButton
{
    return
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
}


+ (char *)cStringForScrollBarLeftArrowBlackAndWhite
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
;
}
+ (char *)cStringForScrollBarRightArrowBlackAndWhite
{
    return
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
}
+ (char *)cStringForScrollBarMiddleBlackAndWhite
{
    return
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
}
+ (char *)cStringForScrollBarKnobBlackAndWhite
{
    return
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
}

+ (char *)cStringForResize
{
    return
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
}
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
}
@end
@implementation MacColorWindow
- (id)init
{
    self = [super init];
    if (self) {
        _leftBorder = 1;
        _rightBorder = 1+1;//16+1;
        _topBorder = 19;
        _bottomBorder = 1+1;//16+1;
        _hasShadow = 1;
        [self setValue:@"maccolor" forKey:@"x11HasChildMask"];
    }
    return self;
}

- (void)calculateRects:(Int4)r
{
    char *titleBarMiddle = [Definitions cStringForActiveTitleBarMiddle];
    int titleBarHeight = [Definitions heightForCString:titleBarMiddle];
    char *closeButton = [Definitions cStringForTitleBarCloseButton];
    int closeButtonWidth = [Definitions widthForCString:closeButton];
    char *maximizeButton = [Definitions cStringForTitleBarMaximizeButton];
    int maximizeButtonWidth = [Definitions widthForCString:maximizeButton];

    _titleBarRect = [Definitions rectWithX:r.x y:r.y w:r.w h:titleBarHeight];
    _closeButtonRect = [Definitions rectWithX:8 y:r.y w:closeButtonWidth h:titleBarHeight];
    _maximizeButtonRect = [Definitions rectWithX:r.x+r.w-8-13 y:r.y w:maximizeButtonWidth h:titleBarHeight];
    _titleBarTextRect = _titleBarRect;
    _titleBarTextRect.x = _closeButtonRect.x*2+_closeButtonRect.w;
    _titleBarTextRect.w -= _titleBarTextRect.x*2;
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [self drawInBitmap:bitmap rect:r context:nil];
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r context:(id)context
{
    int hasFocus = [context intValueForKey:@"hasFocus"];

    Int4 rr = r;
    r.w -= 1;
    r.h -= 1;
    [self calculateRects:r];
    char *palette = [Definitions cStringForTitleBarPalette];
    int titleBarHeight = 20;
    [bitmap setColor:@"white"];
    [bitmap fillRect:r];

    if (hasFocus) {
        [bitmap drawCString:[Definitions cStringForResizeButton] palette:[Definitions cStringForActiveScrollBarPalette] x:r.x+r.w-16 y:r.y+r.h-16];
    } else {
        [bitmap drawCString:[Definitions cStringForResizeButton] palette:"b #000000\n" x:r.x+r.w-16 y:r.y+r.h-16];
    }



    if (hasFocus) {
        [Definitions drawActiveTitleBarInBitmap:bitmap rect:_titleBarRect];
        if ((_buttonDown == 'c') && (_buttonHover == 'c')) {
            [bitmap drawCString:[Definitions cStringForTitleBarButtonDown] palette:palette x:_closeButtonRect.x y:_closeButtonRect.y];
        } else {
            [bitmap drawCString:[Definitions cStringForTitleBarCloseButton] palette:palette x:_closeButtonRect.x y:_closeButtonRect.y];
        }
        if ((_buttonDown == 'm') && (_buttonHover == 'm')) {
            [bitmap drawCString:[Definitions cStringForTitleBarButtonDown] palette:palette x:_maximizeButtonRect.x y:_maximizeButtonRect.y];
        } else {
            [bitmap drawCString:[Definitions cStringForTitleBarMaximizeButton] palette:palette x:_maximizeButtonRect.x y:_maximizeButtonRect.y];
        }
    } else {
        [Definitions drawInactiveTitleBarInBitmap:bitmap rect:_titleBarRect];
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
                [bitmap setColor:@"#eeeeeeff"];
                [bitmap fillRect:[Definitions rectWithX:backX y:_titleBarTextRect.y+2 w:backWidth h:15]];
                [bitmap setColorIntR:0 g:0 b:0 a:255];
                [bitmap drawBitmapText:text x:textX y:_titleBarTextRect.y+4];
            } else {
                [bitmap setColorIntR:0x88 g:0x88 b:0x88 a:255];
                [bitmap drawBitmapText:text x:textX y:_titleBarTextRect.y+4];
            }
        }
    }

    [bitmap setColor:@"black"];
    [bitmap drawVerticalLineAtX:rr.x+rr.w-1 y:rr.y y:rr.y+rr.h-1];
    [bitmap drawHorizontalLineAtX:rr.x x:rr.x+rr.w-1 y:rr.y+rr.h-1];
    if (!hasFocus) {
        [bitmap setColor:@"#555555ff"];
    }
    [bitmap drawVerticalLineAtX:rr.x y:rr.y y:rr.y+rr.h-1];
    [bitmap drawVerticalLineAtX:rr.x+rr.w-2 y:rr.y y:rr.y+rr.h-2];
    [bitmap drawHorizontalLineAtX:rr.x x:rr.x+rr.w-1 y:rr.y];
    [bitmap drawHorizontalLineAtX:rr.x x:rr.x+rr.w-2 y:rr.y+rr.h-2];

    if (_buttonDown == 't') {
        char *palette = "b #000000\nw #ffffff\n";
        char *h = [Definitions cStringForMacWindowSelectionHorizontal];
        char *v = [Definitions cStringForMacWindowSelectionVertical];
        [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x y:r.y w:r.w+1 palette:palette];
        [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x y:r.y+1 h:r.h+1-2];
        [Definitions drawInBitmap:bitmap top:v palette:palette middle:v palette:palette bottom:v palette:palette x:r.x+r.w+1-1 y:r.y+1 h:r.h+1-2];
        [Definitions drawInBitmap:bitmap left:h middle:h right:h x:r.x y:r.y+r.h+1-1 w:r.w+1 palette:palette];
    }
    if (_buttonDown == 'r') {
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
    if (mouseX >= viewWidth-16) {
        if (mouseY >= viewHeight-16) {
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

