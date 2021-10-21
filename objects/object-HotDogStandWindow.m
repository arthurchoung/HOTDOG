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

@implementation Definitions(jfovcnvieiwejfklsdjfklsdjlkfjsdlkfj)
+ (void)enterHotDogStandMode
{
    id windowManager = [@"windowManager" valueForKey];
    [windowManager unparentAllWindows];

    [Definitions setValue:@"hotdogstand" forEnvironmentVariable:@"HOTDOG_MODE"];
    [windowManager setBackgroundForCString:"b\n" palette:"b #ffff00\n"];
    id rootWindowObject = [@"MacRootWindow" asInstance];
    [windowManager setValue:rootWindowObject forKey:@"rootWindowObject"];
    [windowManager reparentAllWindows:@"HotDogStandWindow"];
    [[windowManager valueForKey:@"menuBar"] setValue:@"1" forKey:@"shouldCloseWindow"];
    id menuBar = [windowManager openWindowForObject:[@"HotDogStandMenuBar" asInstance] x:0 y:0 w:[windowManager intValueForKey:@"rootWindowWidth"] h:[windowManager intValueForKey:@"menuBarHeight"]];
    [windowManager setValue:menuBar forKey:@"menuBar"];
    [windowManager setFocusDict:nil];
    [@"hotdog-setupWindowManagerMode.sh" runCommandInBackground];
}
@end
@implementation Definitions(fjkencinidlsjfiowejfklsdjfklsdkljf)

+ (char *)cStringForHotDogStandHasFocusPalette
{
    return
"b #000000\n"
". #ff0000\n"
"X #ffff00\n"
"o #868a8e\n"
"O #c3c7cb\n"
"+ #ffffff\n"
"t #000000\n"
;
}
+ (char *)cStringForHotDogStandActiveTitleBarLeft
{
    return
"bbbbbbbbbbbbbbbbbbbbbbb\n"
"b.....................b\n"
"b.....................b\n"
"b..bbbbbbbbbbbbbbbbbbbb\n"
"b..bOOOOOOOOOOOOOOOOOOb\n"
"b..bOOOOOOOOOOOOOOOOOOb\n"
"b..bOOOOOOOOOOOOOOOOOOb\n"
"b..bOOOOOOOOOOOOOOOOOOb\n"
"b..bOOOOOOOOOOOOOOOOOOb\n"
"b..bOOOOOOOOOOOOOOOOOOb\n"
"b..bOOOOOOOOOOOOOOOOOOb\n"
"b..bOObbbbbbbbbbbbbOOOb\n"
"b..bOOb+++++++++++boOOb\n"
"b..bOObbbbbbbbbbbbboOOb\n"
"b..bOOOoooooooooooooOOb\n"
"b..bOOOOOOOOOOOOOOOOOOb\n"
"b..bOOOOOOOOOOOOOOOOOOb\n"
"b..bOOOOOOOOOOOOOOOOOOb\n"
"b..bOOOOOOOOOOOOOOOOOOb\n"
"b..bOOOOOOOOOOOOOOOOOOb\n"
"b..bOOOOOOOOOOOOOOOOOOb\n"
"b..bOOOOOOOOOOOOOOOOOOb\n"
"bbbbbbbbbbbbbbbbbbbbbbb\n"
;
}
+ (char *)cStringForHotDogStandActiveTitleBarMiddle
{
    return
"b\n"
".\n"
".\n"
"b\n"
"t\n"
"t\n"
"t\n"
"t\n"
"t\n"
"t\n"
"t\n"
"t\n"
"t\n"
"t\n"
"t\n"
"t\n"
"t\n"
"t\n"
"t\n"
"t\n"
"t\n"
"t\n"
"b\n"
;
}
+ (char *)cStringForHotDogStandActiveTitleBarRight
{
    return
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"...................b.....................b\n"
"...................b.....................b\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb..b\n"
"b+++++++++++++++++ob+++++++++++++++++ob..b\n"
"b+OOOOOOOOOOOOOOOoob+OOOOOOOOOOOOOOOoob..b\n"
"b+OOOOOOOOOOOOOOOoob+OOOOOOOOOOOOOOOoob..b\n"
"b+OOOOOOOOOOOOOOOoob+OOOOOOOOOOOOOOOoob..b\n"
"b+OOOOOOOOOOOOOOOoob+OOOOOOOOOOOOOOOoob..b\n"
"b+OOOOOOOOOOOOOOOoob+OOOOOOOOOOOOOOOoob..b\n"
"b+OOOOOOOOOOOOOOOoob+OOOOOOObOOOOOOOoob..b\n"
"b+OOOObbbbbbbOOOOoob+OOOOOObbbOOOOOOoob..b\n"
"b+OOOOObbbbbOOOOOoob+OOOOObbbbbOOOOOoob..b\n"
"b+OOOOOObbbOOOOOOoob+OOOObbbbbbbOOOOoob..b\n"
"b+OOOOOOObOOOOOOOoob+OOOOOOOOOOOOOOOoob..b\n"
"b+OOOOOOOOOOOOOOOoob+OOOOOOOOOOOOOOOoob..b\n"
"b+OOOOOOOOOOOOOOOoob+OOOOOOOOOOOOOOOoob..b\n"
"b+OOOOOOOOOOOOOOOoob+OOOOOOOOOOOOOOOoob..b\n"
"b+OOOOOOOOOOOOOOOoob+OOOOOOOOOOOOOOOoob..b\n"
"b+OOOOOOOOOOOOOOOoob+OOOOOOOOOOOOOOOoob..b\n"
"b+ooooooooooooooooob+ooooooooooooooooob..b\n"
"booooooooooooooooooboooooooooooooooooob..b\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
;
}
+ (char *)cStringForHotDogStandLeftBorderMiddle
{
    return
"b..b\n"
;
}
+ (char *)cStringForHotDogStandLeftBorderBottom
{
    return
"bbbb\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
;
}

+ (char *)cStringForHotDogStandBottomBorderLeft
{
    return
"b..bbbbbbbbbbbbbbbbbbbb\n"
"b.....................b\n"
"b.....................b\n"
"bbbbbbbbbbbbbbbbbbbbbbb\n"
;
}
+ (char *)cStringForHotDogStandBottomBorderMiddle
{
    return
"b\n"
".\n"
".\n"
"b\n"
;
}
+ (char *)cStringForHotDogStandBottomBorderRight
{
    return
"bbbbbbbbbbbbbbbbbbbb..b\n"
"b.....................b\n"
"b.....................b\n"
"bbbbbbbbbbbbbbbbbbbbbbb\n"
;
}


+ (char *)cStringForHotDogStandRightBorderMiddle
{
    return
"b..b\n"
;
}
+ (char *)cStringForHotDogStandRightBorderBottom
{
    return
"bbbb\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
"b..b\n"
;
}


+ (char *)cStringForHotDogStandMinimizeButtonDown
{
    return
"oooooooooooooooooo\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOObbbbbbbOOOOO\n"
"oOOOOOObbbbbOOOOOO\n"
"oOOOOOOObbbOOOOOOO\n"
"oOOOOOOOObOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
;
}

+ (char *)cStringForHotDogStandMaximizeButtonDown
{
    return
"oooooooooooooooooo\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOObOOOOOOOO\n"
"oOOOOOOObbbOOOOOOO\n"
"oOOOOOObbbbbOOOOOO\n"
"oOOOOObbbbbbbOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
;
}

+ (char *)cStringForHotDogStandCloseButtonDown
{
    return
"oooooooooooooooooo\n"
"oooooooooooooooooo\n"
"oooooooooooooooooo\n"
"oooooooooooooooooo\n"
"oooooooooooooooooo\n"
"oooooooooooooooooo\n"
"oooooooooooooooooo\n"
"oo+++++++++++++ooo\n"
"oo+bbbbbbbbbbb+Ooo\n"
"oo+++++++++++++Ooo\n"
"oooOOOOOOOOOOOOOoo\n"
"oooooooooooooooooo\n"
"oooooooooooooooooo\n"
"oooooooooooooooooo\n"
"oooooooooooooooooo\n"
"oooooooooooooooooo\n"
"oooooooooooooooooo\n"
"oooooooooooooooooo\n"
;
}
+ (char *)cStringForHotDogStandSmallCloseButton
{
    return
"OOOOOOOOOOOOOOOOOO\n"
"OOOOOOOOOOOOOOOOOO\n"
"OOOOOOOOOOOOOOOOOO\n"
"OOOOOOOOOOOOOOOOOO\n"
"OOOOOOOOOOOOOOOOOO\n"
"OOOOOOOOOOOOOOOOOO\n"
"OOOOOOOOOOOOOOOOOO\n"
"OOOOOObbbbbbbOOOOO\n"
"OOOOOOb+++++boOOOO\n"
"OOOOOObbbbbbboOOOO\n"
"OOOOOOOoooooooOOOO\n"
"OOOOOOOOOOOOOOOOOO\n"
"OOOOOOOOOOOOOOOOOO\n"
"OOOOOOOOOOOOOOOOOO\n"
"OOOOOOOOOOOOOOOOOO\n"
"OOOOOOOOOOOOOOOOOO\n"
"OOOOOOOOOOOOOOOOOO\n"
"OOOOOOOOOOOOOOOOOO\n"
;
}

+ (char *)cStringForHotDogStandSmallCloseButtonDown
{
    return
"oooooooooooooooooo\n"
"oooooooooooooooooo\n"
"oooooooooooooooooo\n"
"oooooooooooooooooo\n"
"oooooooooooooooooo\n"
"oooooooooooooooooo\n"
"oooooooooooooooooo\n"
"oooooo+++++++ooooo\n"
"oooooo+bbbbb+Ooooo\n"
"oooooo+++++++Ooooo\n"
"oooooooOOOOOOOoooo\n"
"oooooooooooooooooo\n"
"oooooooooooooooooo\n"
"oooooooooooooooooo\n"
"oooooooooooooooooo\n"
"oooooooooooooooooo\n"
"oooooooooooooooooo\n"
"oooooooooooooooooo\n"
;
}

+ (char *)cStringForHotDogStandRevertButton
{
    return
"+++++++++++++++++o\n"
"+OOOOOOOOOOOOOOOoo\n"
"+OOOOOOOOOOOOOOOoo\n"
"+OOOOOOOOOOOOOOOoo\n"
"+OOOOOOObOOOOOOOoo\n"
"+OOOOOObbbOOOOOOoo\n"
"+OOOOObbbbbOOOOOoo\n"
"+OOOObbbbbbbOOOOoo\n"
"+OOOOOOOOOOOOOOOoo\n"
"+OOOOOOOOOOOOOOOoo\n"
"+OOOObbbbbbbOOOOoo\n"
"+OOOOObbbbbOOOOOoo\n"
"+OOOOOObbbOOOOOOoo\n"
"+OOOOOOObOOOOOOOoo\n"
"+OOOOOOOOOOOOOOOoo\n"
"+OOOOOOOOOOOOOOOoo\n"
"+ooooooooooooooooo\n"
"oooooooooooooooooo\n"
;
}

+ (char *)cStringForHotDogStandRevertButtonDown
{
    return
"oooooooooooooooooo\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOObOOOOOOOO\n"
"oOOOOOOObbbOOOOOOO\n"
"oOOOOOObbbbbOOOOOO\n"
"oOOOOObbbbbbbOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOObbbbbbbOOOOO\n"
"oOOOOOObbbbbOOOOOO\n"
"oOOOOOOObbbOOOOOOO\n"
"oOOOOOOOObOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
"oOOOOOOOOOOOOOOOOO\n"
;
}




@end

@interface HotDogStandWindow : IvarObject
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
    Int4 _topBorderRect;
    Int4 _bottomBorderRect;
    Int4 _closeButtonRect;
    Int4 _minimizeButtonRect;
    Int4 _maximizeButtonRect;
    Int4 _resizeButtonRect;
}
@end
@implementation HotDogStandWindow
- (id)init
{
    self = [super init];
    if (self) {
        _leftBorder = 4;
        _rightBorder = 4;
        _topBorder = 23;
        _bottomBorder = 4;
        _hasShadow = 0;
    }
    return self;
}

- (void)calculateRects:(Int4)r
{
    char *titleBarLeft = [Definitions cStringForHotDogStandActiveTitleBarLeft];
    char *titleBarMiddle = [Definitions cStringForHotDogStandActiveTitleBarMiddle];
    char *titleBarRight = [Definitions cStringForHotDogStandActiveTitleBarRight];
    int titleBarLeftWidth = [Definitions widthForCString:titleBarLeft];
    int titleBarRightWidth = [Definitions widthForCString:titleBarRight];
    int titleBarHeight = [Definitions heightForCString:titleBarMiddle];

    _titleBarRect = [Definitions rectWithX:r.x y:r.y w:r.w h:titleBarHeight];
    _titleBarTextRect = _titleBarRect;
    _titleBarTextRect.x = titleBarLeftWidth+4;
    _titleBarTextRect.w -= titleBarLeftWidth+4;
    _titleBarTextRect.w -= titleBarRightWidth+4;

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

    _topBorderRect = _titleBarRect;
    _topBorderRect.h = 4;

    _bottomBorderRect = _titleBarRect;
    _bottomBorderRect.y += r.h-_bottomBorder;
    _bottomBorderRect.h = _bottomBorder;

    _closeButtonRect = _titleBarRect;
    _closeButtonRect.x += 4;
    _closeButtonRect.y += 4;
    _closeButtonRect.w = 18;
    _closeButtonRect.h = 18;

    _minimizeButtonRect = _titleBarRect;
    _minimizeButtonRect.x = _minimizeButtonRect.x+_minimizeButtonRect.w-4-18-1-18;
    _minimizeButtonRect.y += 4;
    _minimizeButtonRect.w = 18;
    _minimizeButtonRect.h = 18;

    _maximizeButtonRect = _titleBarRect;
    _maximizeButtonRect.x = _maximizeButtonRect.x+_maximizeButtonRect.w-4-18;
    _maximizeButtonRect.y += 4;
    _maximizeButtonRect.w = 18;
    _maximizeButtonRect.h = 18;
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [self drawInBitmap:bitmap rect:r context:nil];
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r context:(id)context
{
    [bitmap useWinSystemFont];

    char *palette = [Definitions cStringForHotDogStandHasFocusPalette];
    int hasFocus = [context intValueForKey:@"hasFocus"];
    if (!hasFocus) {
        palette = 
"b #000000\n"
". #ff0000\n"
"X #ffff00\n"
"o #868a8e\n"
"O #c3c7cb\n"
"+ #ffffff\n"
"t #ff0000\n"
;
    }

    [self calculateRects:r];
    [bitmap setColor:@"white"];
    [bitmap fillRect:r];
    [bitmap setColor:@"black"];
    [bitmap drawHorizontalLineAtX:r.x x:r.x+r.w-1 y:r.y+r.h-1];
    [bitmap drawVerticalLineAtX:r.x+r.w-1 y:r.y y:r.y+r.h-1];
    {
        char *left = [Definitions cStringForHotDogStandActiveTitleBarLeft];
        char *middle = [Definitions cStringForHotDogStandActiveTitleBarMiddle];
        char *right = [Definitions cStringForHotDogStandActiveTitleBarRight];
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
                [bitmap drawBitmapText:text x:textX y:_titleBarTextRect.y+7];
            } else {
                [bitmap setColor:@"white"];
                [bitmap drawBitmapText:text x:textX y:_titleBarTextRect.y+7];
            }
        }
    }

    {
        char *middle = [Definitions cStringForHotDogStandLeftBorderMiddle];
        char *bottom = [Definitions cStringForHotDogStandLeftBorderBottom];
        [Definitions drawInBitmap:bitmap top:middle palette:palette middle:middle palette:palette bottom:bottom palette:palette x:_leftBorderRect.x y:_leftBorderRect.y h:_leftBorderRect.h];
    }
    {
        char *top = [Definitions cStringForHotDogStandRightBorderMiddle];
        char *middle = top;
        char *bottom = [Definitions cStringForHotDogStandRightBorderBottom];
        [Definitions drawInBitmap:bitmap top:top palette:palette middle:middle palette:palette bottom:bottom palette:palette x:_rightBorderRect.x y:_rightBorderRect.y h:_rightBorderRect.h];
    }

    {
        Int4 r = _bottomBorderRect;
        char *left = [Definitions cStringForHotDogStandBottomBorderLeft];
        char *middle = [Definitions cStringForHotDogStandBottomBorderMiddle];
        char *right = [Definitions cStringForHotDogStandBottomBorderRight];
        [Definitions drawInBitmap:bitmap left:left middle:middle right:right x:r.x y:r.y w:r.w palette:palette];
    }

    if (hasFocus) {
        if ((_buttonDown == 'c') && (_buttonHover == 'c')) {
            char *closeButtonDown = [Definitions cStringForHotDogStandCloseButtonDown];
            [bitmap drawCString:closeButtonDown palette:palette x:_closeButtonRect.x y:_closeButtonRect.y];
        }
        if ((_buttonDown == 'm') && (_buttonHover == 'm')) {
            char *minimizeButtonDown = [Definitions cStringForHotDogStandMinimizeButtonDown];
            [bitmap drawCString:minimizeButtonDown palette:palette x:_minimizeButtonRect.x y:_minimizeButtonRect.y];
        }
        if ((_buttonDown == 'M') && (_buttonHover == 'M')) {
            char *maximizeButtonDown = [Definitions cStringForHotDogStandMaximizeButtonDown];
            [bitmap drawCString:maximizeButtonDown palette:palette x:_maximizeButtonRect.x y:_maximizeButtonRect.y];
        }
        if (_buttonDown == 't') {
            char *black = "b #000000\n";
            char *white = "b #ffffff\n";
            char *gray  = "b #55aaaa\n";
            for (int i=0; i<r.w; i++) {
                int j = 0;
                int x = r.x+i;
                int y = r.y+j;
                if ((i+j) % 2 == 0) {
                    [bitmap drawCString:"b\n" palette:black x:x y:y];
                } else {
                    [bitmap drawCString:"b\n" palette:white x:x y:y];
                }
            }
            for (int i=0; i<r.w; i++) {
                int j = r.h-1;
                int x = r.x+i;
                int y = r.y+j;
                if ((i+j) % 2 == 0) {
                    [bitmap drawCString:"b\n" palette:black x:x y:y];
                } else {
                    [bitmap drawCString:"b\n" palette:white x:x y:y];
                }
            }
            for (int j=0; j<r.h; j++) {
                int i = 0;
                int x = r.x+i;
                int y = r.y+j;
                if ((i+j) % 2 == 0) {
                    [bitmap drawCString:"b\n" palette:black x:x y:y];
                } else {
                    [bitmap drawCString:"b\n" palette:white x:x y:y];
                }
            }
            for (int j=0; j<r.h; j++) {
                int i = r.w-1;
                int x = r.x+i;
                int y = r.y+j;
                if ((i+j) % 2 == 0) {
                    [bitmap drawCString:"b\n" palette:black x:x y:y];
                } else {
                    [bitmap drawCString:"b\n" palette:white x:x y:y];
                }
            }
            //
            for (int i=1; i<r.w-1; i++) {
                for (int j=1; j<=2; j++) {
                    int x = r.x+i;
                    int y = r.y+j;
                    if ((i+j) % 2 == 1) {
                        [bitmap drawCString:"b\n" palette:gray x:x y:y];
                    }
                }
                for (int j=r.h-3; j<=r.h-2; j++) {
                    int x = r.x+i;
                    int y = r.y+j;
                    if ((i+j) % 2 == 1) {
                        [bitmap drawCString:"b\n" palette:gray x:x y:y];
                    }
                }
            }
            for (int j=3; j<r.h-3; j++) {
                for (int i=1; i<=2; i++) {
                    int x = r.x+i;
                    int y = r.y+j;
                    if ((i+j) % 2 == 1) {
                        [bitmap drawCString:"b\n" palette:gray x:x y:y];
                    }
                }
                for (int i=r.w-3; i<=r.w-2; i++) {
                    int x = r.x+i;
                    int y = r.y+j;
                    if ((i+j) % 2 == 1) {
                        [bitmap drawCString:"b\n" palette:gray x:x y:y];
                    }
                }
            }
            //
            {
                int i = 22;
                for (int j=1; j<=2; j++) {
                    int x = r.x+i;
                    int y = r.y+j;
                    if ((i+j) % 2 == 0) {
                        [bitmap drawCString:"b\n" palette:black x:x y:y];
                    } else {
                        [bitmap drawCString:"b\n" palette:white x:x y:y];
                    }
                }
                for (int j=r.h-3; j<=r.h-2; j++) {
                    int x = r.x+i;
                    int y = r.y+j;
                    if ((i+j) % 2 == 0) {
                        [bitmap drawCString:"b\n" palette:black x:x y:y];
                    } else {
                        [bitmap drawCString:"b\n" palette:white x:x y:y];
                    }
                }
            }
            {
                int i = r.w-23;
                for (int j=1; j<=2; j++) {
                    int x = r.x+i;
                    int y = r.y+j;
                    if ((i+j) % 2 == 0) {
                        [bitmap drawCString:"b\n" palette:black x:x y:y];
                    } else {
                        [bitmap drawCString:"b\n" palette:white x:x y:y];
                    }
                }
                for (int j=r.h-3; j<=r.h-2; j++) {
                    int x = r.x+i;
                    int y = r.y+j;
                    if ((i+j) % 2 == 0) {
                        [bitmap drawCString:"b\n" palette:black x:x y:y];
                    } else {
                        [bitmap drawCString:"b\n" palette:white x:x y:y];
                    }
                }
            }
            {
                int j = 22;
                for (int i=1; i<=2; i++) {
                    int x = r.x+i;
                    int y = r.y+j;
                    if ((i+j) % 2 == 0) {
                        [bitmap drawCString:"b\n" palette:black x:x y:y];
                    } else {
                        [bitmap drawCString:"b\n" palette:white x:x y:y];
                    }
                }
                for (int i=r.w-3; i<=r.w-2; i++) {
                    int x = r.x+i;
                    int y = r.y+j;
                    if ((i+j) % 2 == 0) {
                        [bitmap drawCString:"b\n" palette:black x:x y:y];
                    } else {
                        [bitmap drawCString:"b\n" palette:white x:x y:y];
                    }
                }
            }
            {
                int j = r.h-23;
                for (int i=1; i<=2; i++) {
                    int x = r.x+i;
                    int y = r.y+j;
                    if ((i+j) % 2 == 0) {
                        [bitmap drawCString:"b\n" palette:black x:x y:y];
                    } else {
                        [bitmap drawCString:"b\n" palette:white x:x y:y];
                    }
                }
                for (int i=r.w-3; i<=r.w-2; i++) {
                    int x = r.x+i;
                    int y = r.y+j;
                    if ((i+j) % 2 == 0) {
                        [bitmap drawCString:"b\n" palette:black x:x y:y];
                    } else {
                        [bitmap drawCString:"b\n" palette:white x:x y:y];
                    }
                }
            }
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
- (char)borderForX:(int)x y:(int)y w:(int)w h:(int)h
{
    if ((y >= 0) && (y < 4)) {
        if ((x >= 0) && (x < 23)) {
            return '7';
        } else if ((x >= w-23) && (x < w)) {
            return '9';
        } else {
            return '8';
        }
    } else if ((y >= h-4) && (y < h)) {
        if ((x >= 0) && (x < 23)) {
            return '1';
        } else if ((x >= w-23) && (x < w)) {
            return '3';
        } else {
            return '2';
        }
    } else if ((x >= 0) && (x < 4)) {
        if ((y >= 0) && (y < 23)) {
            return '7';
        } else if ((y >= h-23) && (y < h)) {
            return '1';
        } else {
            return '4';
        }
    } else if ((x >= w-4) && (x < w)) {
        if ((y >= 0) && (y < 23)) {
            return '9';
        } else if ((y >= h-23) && (y < h)) {
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
    if ([Definitions isX:mouseX y:mouseY insideRect:_closeButtonRect]) {
        _buttonDown = 'c';
        _buttonHover = 'c';
        _buttonDownX = mouseX;
        _buttonDownY = mouseY;
        _buttonDownW = viewWidth;
        _buttonDownH = viewHeight;
        return;
    }
    if ([Definitions isX:mouseX y:mouseY insideRect:_minimizeButtonRect]) {
        _buttonDown = 'm';
        _buttonHover = 'm';
        _buttonDownX = mouseX;
        _buttonDownY = mouseY;
        _buttonDownW = viewWidth;
        _buttonDownH = viewHeight;
        return;
    }
    if ([Definitions isX:mouseX y:mouseY insideRect:_maximizeButtonRect]) {
        _buttonDown = 'M';
        _buttonHover = 'M';
        _buttonDownX = mouseX;
        _buttonDownY = mouseY;
        _buttonDownW = viewWidth;
        _buttonDownH = viewHeight;
        return;
    }
    int border = [self borderForX:mouseX y:mouseY w:viewWidth h:viewHeight];
    if (border) {
        _buttonDown = border;
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
        if ([Definitions isX:mouseX y:mouseY insideRect:_minimizeButtonRect]) {
            _buttonHover = 'm';
        } else {
            _buttonHover = 0;
        }
        return;
    }
    if (_buttonDown == 'M') {
        int mouseX = [event intValueForKey:@"mouseX"];
        int mouseY = [event intValueForKey:@"mouseY"];
        if ([Definitions isX:mouseX y:mouseY insideRect:_maximizeButtonRect]) {
            _buttonHover = 'M';
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
        if (border) {
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
    if ((_buttonDown == 'm') && (_buttonHover == 'm')) {
        [dict x11ToggleMaximizeWindow];
    }
    if ((_buttonDown == 'M') && (_buttonHover == 'M')) {
        [dict x11ToggleMaximizeWindow];
    }
    if (_buttonDown == 't') {
        /* this was added for Wine */
        [dict x11MoveChildWindowBackAndForthForWine];
    }

    _buttonDown = 0;
}
@end

