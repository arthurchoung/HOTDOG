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
    id windowManager = [@"windowManager" valueForKey];
    [windowManager setFocusDict:nil];
    [windowManager unparentAllWindows];

    [Definitions setValue:@"atarist" forEnvironmentVariable:@"HOTDOG_MODE"];

    [windowManager setBackgroundForCString:"x\n" palette:"x #00ee00\n"];
    id rootWindowObject = [@"MacRootWindow" asInstance];
    [windowManager setValue:rootWindowObject forKey:@"rootWindowObject"];
    [windowManager reparentAllWindows:@"AtariSTWindow"];
    [[windowManager valueForKey:@"menuBar"] setValue:@"1" forKey:@"shouldCloseWindow"];
    [windowManager setValue:@"20" forKey:@"menuBarHeight"];
    id menuBar = [windowManager openWindowForObject:[@"AtariSTMenuBar" asInstance] x:0 y:0 w:[windowManager intValueForKey:@"rootWindowWidth"] h:[windowManager intValueForKey:@"menuBarHeight"]];
    [windowManager setValue:menuBar forKey:@"menuBar"];
    [windowManager setFocusDict:nil];
    [@"hotdog-setupWindowManagerMode.sh" runCommandInBackground];
}
@end
@implementation Definitions(fjkdlsjfiowejfklsdjfklsdjfieiikljf)
+ (char *)cStringForAtariSTInactiveTitleBarLeft
{
    return
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
;
}
+ (char *)cStringForAtariSTInactiveTitleBarMiddle
{
    return
"..\n"
"..\n"
"XX\n"
"XX\n"
"XX\n"
"XX\n"
"XX\n"
"XX\n"
"XX\n"
"XX\n"
"XX\n"
"XX\n"
"XX\n"
"XX\n"
"XX\n"
"XX\n"
"XX\n"
"XX\n"
"XX\n"
"XX\n"
"..\n"
"..\n"
;
}
+ (char *)cStringForAtariSTInactiveTitleBarRight
{
    return
"..    \n"
"..    \n"
"......\n"
"......\n"
"......\n"
"......\n"
"......\n"
"......\n"
"......\n"
"......\n"
"......\n"
"......\n"
"......\n"
"......\n"
"......\n"
"......\n"
"......\n"
"......\n"
"......\n"
"......\n"
"......\n"
"......\n"
;
}
+ (char *)cStringForAtariSTInactiveBottomBorderLeft
{
    return
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"..\n"
"  \n"
"  \n"
"  \n"
"  \n"
;
}
+ (char *)cStringForAtariSTInactiveBottomBorderMiddle
{
    return
".\n"
".\n"
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
".\n"
".\n"
".\n"
".\n"
".\n"
;
}
+ (char *)cStringForAtariSTInactiveBottomBorderRight
{
    return
"............................\n"
"............................\n"
"..XXXXXXXXXXXXXXXXXXXX......\n"
"..XXXXXXXXXXXXXXXXXXXX......\n"
"..XXXXXXXXXXXXXXXXXXXX......\n"
"..XXXXXXXXXXXXXXXXXXXX......\n"
"..XXXXXXXXXXXXXXXXXXXX......\n"
"..XXXXXXXXXXXXXXXXXXXX......\n"
"..XXXXXXXXXXXXXXXXXXXX......\n"
"..XXXXXXXXXXXXXXXXXXXX......\n"
"..XXXXXXXXXXXXXXXXXXXX......\n"
"..XXXXXXXXXXXXXXXXXXXX......\n"
"..XXXXXXXXXXXXXXXXXXXX......\n"
"..XXXXXXXXXXXXXXXXXXXX......\n"
"..XXXXXXXXXXXXXXXXXXXX......\n"
"..XXXXXXXXXXXXXXXXXXXX......\n"
"..XXXXXXXXXXXXXXXXXXXX......\n"
"..XXXXXXXXXXXXXXXXXXXX......\n"
"..XXXXXXXXXXXXXXXXXXXX......\n"
"..XXXXXXXXXXXXXXXXXXXX......\n"
"............................\n"
"............................\n"
"............................\n"
"............................\n"
"............................\n"
"............................\n"
;
}

+ (char *)cStringForAtariSTActiveTitleBarLeft
{
    return
"..........................\n"
"..........................\n"
"..XXXXXXXXXXXXXXXXXXXX....\n"
"..XXXXXXXXXXXXXXXXXXXX....\n"
"..XXXXXX........XXXXXX....\n"
"..XXXXXX........XXXXXX....\n"
"..XX..XXXX....XXXX..XX....\n"
"..XX..XXXX....XXXX..XX....\n"
"..XX....XXXXXXXX....XX....\n"
"..XX....XXXXXXXX....XX....\n"
"..XX......XXXX......XX....\n"
"..XX......XXXX......XX....\n"
"..XX....XXXXXXXX....XX....\n"
"..XX....XXXXXXXX....XX....\n"
"..XX..XXXX....XXXX..XX....\n"
"..XX..XXXX....XXXX..XX....\n"
"..XXXXXX........XXXXXX....\n"
"..XXXXXX........XXXXXX....\n"
"..XXXXXXXXXXXXXXXXXXXX....\n"
"..XXXXXXXXXXXXXXXXXXXX....\n"
"..........................\n"
"..........................\n"
;
}
+ (char *)cStringForAtariSTActiveTitleBarMiddle
{
    return
"....\n"
"....\n"
"..XX\n"
"..XX\n"
"XXXX\n"
"XXXX\n"
"..XX\n"
"..XX\n"
"XXXX\n"
"XXXX\n"
"..XX\n"
"..XX\n"
"XXXX\n"
"XXXX\n"
"..XX\n"
"..XX\n"
"XXXX\n"
"XXXX\n"
"..XX\n"
"..XX\n"
"....\n"
"....\n"
;
}
+ (char *)cStringForAtariSTActiveTitleBarRight
{
    return
"..........................    \n"
"..........................    \n"
"....XXXXXXXXXXXXXXXXXXXX......\n"
"....XXXXXXXXXXXXXXXXXXXX......\n"
"....XX......XXXX......XX......\n"
"....XX......XXXX......XX......\n"
"....XX....XXXXXXXX....XX......\n"
"....XX....XXXXXXXX....XX......\n"
"....XX..XXXX....XXXX..XX......\n"
"....XX..XXXX....XXXX..XX......\n"
"....XXXXXX........XXXXXX......\n"
"....XXXXXX........XXXXXX......\n"
"....XX..XXXX....XXXX..XX......\n"
"....XX..XXXX....XXXX..XX......\n"
"....XX....XXXXXXXX....XX......\n"
"....XX....XXXXXXXX....XX......\n"
"....XX......XXXX......XX......\n"
"....XX......XXXX......XX......\n"
"....XXXXXXXXXXXXXXXXXXXX......\n"
"....XXXXXXXXXXXXXXXXXXXX......\n"
"..............................\n"
"..............................\n"
;
}
+ (char *)cStringForAtariSTLeftBorderMiddle
{
    return
"..\n"
;
}

+ (char *)cStringForAtariSTBottomBorderLeft
{
    return
"........................\n"
"........................\n"
"..XXXXXXXXXXXXXXXXXXXX..\n"
"..XXXXXXXXXXXXXXXXXXXX..\n"
"..XXXXXXXX....XXXXXXXX..\n"
"..XXXXXXXX....XXXXXXXX..\n"
"..XXXXXX......XXXXXXXX..\n"
"..XXXXXX......XXXXXXXX..\n"
"..XXXX....XX........XX..\n"
"..XXXX....XX........XX..\n"
"..XX....XXXXXXXXXX..XX..\n"
"..XX....XXXXXXXXXX..XX..\n"
"..XX....XXXXXXXXXX..XX..\n"
"..XX....XXXXXXXXXX..XX..\n"
"..XXXX....XX........XX..\n"
"..XXXX....XX........XX..\n"
"..XXXXXX......XXXXXXXX..\n"
"..XXXXXX......XXXXXXXX..\n"
"..XXXXXXXX....XXXXXXXX..\n"
"..XXXXXXXX....XXXXXXXX..\n"
"........................\n"
"........................\n"
"  ......................\n"
"  ......................\n"
"  ......................\n"
"  ......................\n"
;
}
+ (char *)cStringForAtariSTBottomBorderMiddle
{
    return
".\n"
".\n"
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
".\n"
".\n"
".\n"
".\n"
".\n"
;
}
+ (char *)cStringForAtariSTBottomBorderRight
{
    return
"..................................................\n"
"..................................................\n"
"..XXXXXXXXXXXXXXXXXXXX..XXXXXXXXXXXXXXXXXXXX......\n"
"..XXXXXXXXXXXXXXXXXXXX..XXXXXXXXXXXXXXXXXXXX......\n"
"..XXXXXXXX....XXXXXXXX..XX................XX......\n"
"..XXXXXXXX....XXXXXXXX..XX................XX......\n"
"..XXXXXXXX......XXXXXX..XX................XX......\n"
"..XXXXXXXX......XXXXXX..XX................XX......\n"
"..XX........XX....XXXX..XX..............XXXX......\n"
"..XX........XX....XXXX..XX..............XXXX......\n"
"..XX..XXXXXXXXXX....XX..XX............XXXXXX......\n"
"..XX..XXXXXXXXXX....XX..XX............XXXXXX......\n"
"..XX..XXXXXXXXXX....XX..XX..........XXXX..XX......\n"
"..XX..XXXXXXXXXX....XX..XX..........XXXX..XX......\n"
"..XX........XX....XXXX..XX........XXXX....XX......\n"
"..XX........XX....XXXX..XX........XXXX....XX......\n"
"..XXXXXXXX......XXXXXX..XX......XXXX......XX......\n"
"..XXXXXXXX......XXXXXX..XX......XXXX......XX......\n"
"..XXXXXXXX....XXXXXXXX..XXXXXXXXXXXXXXXXXXXX......\n"
"..XXXXXXXX....XXXXXXXX..XXXXXXXXXXXXXXXXXXXX......\n"
"..................................................\n"
"..................................................\n"
"..................................................\n"
"..................................................\n"
"..................................................\n"
"..................................................\n"
;
}


+ (char *)cStringForAtariSTRightBorderTop
{
    return
"..XXXXXXXXXXXXXXXXXXXX......\n"
"..XXXXXXXXXXXXXXXXXXXX......\n"
"..XXXXXXXX....XXXXXXXX......\n"
"..XXXXXXXX....XXXXXXXX......\n"
"..XXXXXX........XXXXXX......\n"
"..XXXXXX........XXXXXX......\n"
"..XXXX....XXXX....XXXX......\n"
"..XXXX....XXXX....XXXX......\n"
"..XX....XXXXXXXX....XX......\n"
"..XX....XXXXXXXX....XX......\n"
"..XX......XXXX......XX......\n"
"..XX......XXXX......XX......\n"
"..XXXXXX..XXXX..XXXXXX......\n"
"..XXXXXX..XXXX..XXXXXX......\n"
"..XXXXXX..XXXX..XXXXXX......\n"
"..XXXXXX..XXXX..XXXXXX......\n"
"..XXXXXX........XXXXXX......\n"
"..XXXXXX........XXXXXX......\n"
"............................\n"
"............................\n"
;
}
+ (char *)cStringForAtariSTRightBorderMiddle
{
    return
"..XXXXXXXXXXXXXXXXXXXX......\n"
;
}
+ (char *)cStringForAtariSTRightBorderBottom
{
    return
"............................\n"
"............................\n"
"..XXXXXXXXXXXXXXXXXXXX......\n"
"..XXXXXXXXXXXXXXXXXXXX......\n"
"..XXXXXX........XXXXXX......\n"
"..XXXXXX........XXXXXX......\n"
"..XXXXXX..XXXX..XXXXXX......\n"
"..XXXXXX..XXXX..XXXXXX......\n"
"..XXXXXX..XXXX..XXXXXX......\n"
"..XXXXXX..XXXX..XXXXXX......\n"
"..XX......XXXX......XX......\n"
"..XX......XXXX......XX......\n"
"..XX....XXXXXXXX....XX......\n"
"..XX....XXXXXXXX....XX......\n"
"..XXXX....XXXX....XXXX......\n"
"..XXXX....XXXX....XXXX......\n"
"..XXXXXX........XXXXXX......\n"
"..XXXXXX........XXXXXX......\n"
"..XXXXXXXX....XXXXXXXX......\n"
"..XXXXXXXX....XXXXXXXX......\n"
;
}

+ (char *)cStringForAtariSTInactiveRightBorderMiddle
{
    return
"..XXXXXXXXXXXXXXXXXXXX......\n"
;
}



+ (char *)cStringForAtariSTCloseButton
{
    return
"XXXXXXXXXXXXXXXXXXXX\n"
"XXXXXXXXXXXXXXXXXXXX\n"
"XXXXXX........XXXXXX\n"
"XXXXXX........XXXXXX\n"
"XX..XXXX....XXXX..XX\n"
"XX..XXXX....XXXX..XX\n"
"XX....XXXXXXXX....XX\n"
"XX....XXXXXXXX....XX\n"
"XX......XXXX......XX\n"
"XX......XXXX......XX\n"
"XX....XXXXXXXX....XX\n"
"XX....XXXXXXXX....XX\n"
"XX..XXXX....XXXX..XX\n"
"XX..XXXX....XXXX..XX\n"
"XXXXXX........XXXXXX\n"
"XXXXXX........XXXXXX\n"
"XXXXXXXXXXXXXXXXXXXX\n"
"XXXXXXXXXXXXXXXXXXXX\n"
;
}

@end

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
}
@end
@implementation AtariSTWindow
- (id)init
{
    self = [super init];
    if (self) {
        _leftBorder = 2;
        _rightBorder = 28;
        _topBorder = 22;
        _bottomBorder = 26;
        _hasShadow = -1;
    }
    return self;
}

- (void)calculateRects:(Int4)r
{
    char *titleBarLeft = [Definitions cStringForAtariSTActiveTitleBarLeft];
    char *titleBarMiddle = [Definitions cStringForAtariSTActiveTitleBarMiddle];
    char *titleBarRight = [Definitions cStringForAtariSTActiveTitleBarRight];
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
    _closeButtonRect.x += 2;
    _closeButtonRect.y += 2;
    _closeButtonRect.w = 20;
    _closeButtonRect.h = 18;

    _maximizeButtonRect = _titleBarRect;
    _maximizeButtonRect.x = _maximizeButtonRect.x+_maximizeButtonRect.w-6-20;
    _maximizeButtonRect.y += 2;
    _maximizeButtonRect.w = 20;
    _maximizeButtonRect.h = 18;
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [self drawInBitmap:bitmap rect:r context:nil];
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r context:(id)context
{
    [bitmap useAtariSTFont];
    char *palette = ". #000000\nX #eeeeee\n";
    int hasFocus = [context intValueForKey:@"hasFocus"];

    [self calculateRects:r];
    [bitmap setColor:@"white"];
    [bitmap fillRect:r];
    [bitmap setColor:@"black"];
    [bitmap drawHorizontalLineAtX:r.x x:r.x+r.w-1 y:r.y+r.h-1];
    [bitmap drawVerticalLineAtX:r.x+r.w-1 y:r.y y:r.y+r.h-1];
    if (hasFocus) {
        char *left = [Definitions cStringForAtariSTActiveTitleBarLeft];
        char *middle = [Definitions cStringForAtariSTActiveTitleBarMiddle];
        char *right = [Definitions cStringForAtariSTActiveTitleBarRight];
        [Definitions drawInBitmap:bitmap left:left palette:palette middle:middle palette:palette right:right palette:palette x:_titleBarRect.x y:_titleBarRect.y w:_titleBarRect.w];
    } else {
        char *left = [Definitions cStringForAtariSTInactiveTitleBarLeft];
        char *middle = [Definitions cStringForAtariSTInactiveTitleBarMiddle];
        char *right = [Definitions cStringForAtariSTInactiveTitleBarRight];
        [Definitions drawInBitmap:bitmap left:left palette:palette middle:middle palette:palette right:right palette:palette x:_titleBarRect.x y:_titleBarRect.y w:_titleBarRect.w];
    }
    if (_titleBarTextRect.w > 0) {
        id text = [context valueForKey:@"name"];
        if (!text) {
            text = @"(no title)";
        }

        text = [bitmap fitBitmapString:text width:_titleBarTextRect.w-14];
        if (text) {
            int textWidth = [bitmap bitmapWidthForText:text];
            int backWidth = textWidth + 14;
            int backX = _titleBarTextRect.x + ((_titleBarTextRect.w - backWidth) / 2);
            int textX = backX + 7;
            if (hasFocus) {
                [bitmap setColor:@"white"];
                [bitmap fillRect:[Definitions rectWithX:backX y:_titleBarTextRect.y+4 w:backWidth h:16]];
                [bitmap setColorIntR:0 g:0 b:0 a:255];
                [bitmap drawBitmapText:text x:textX y:_titleBarTextRect.y+4];
            } else {
                [bitmap setColorIntR:0 g:0 b:0 a:255];
                [bitmap drawBitmapText:text x:textX y:_titleBarTextRect.y+4];
            }
        }
    }

    {
        char *middle = [Definitions cStringForAtariSTLeftBorderMiddle];
        [Definitions drawInBitmap:bitmap top:middle palette:palette middle:middle palette:palette bottom:middle palette:palette x:_leftBorderRect.x y:_leftBorderRect.y h:_leftBorderRect.h];
    }
    if (hasFocus) {
        char *top = [Definitions cStringForAtariSTRightBorderTop];
        char *middle = [Definitions cStringForAtariSTRightBorderMiddle];
        char *bottom = [Definitions cStringForAtariSTRightBorderBottom];
        [Definitions drawInBitmap:bitmap top:top palette:palette middle:middle palette:palette bottom:bottom palette:palette x:_rightBorderRect.x y:_rightBorderRect.y h:_rightBorderRect.h];
    } else {
        char *top = [Definitions cStringForAtariSTInactiveRightBorderMiddle];
        char *middle = top;
        char *bottom = top;
        [Definitions drawInBitmap:bitmap top:middle palette:palette middle:middle palette:palette bottom:bottom palette:palette x:_rightBorderRect.x y:_rightBorderRect.y h:_rightBorderRect.h];
    }

    if (hasFocus) {
        Int4 r = _bottomBorderRect;
        char *left = [Definitions cStringForAtariSTBottomBorderLeft];
        char *middle = [Definitions cStringForAtariSTBottomBorderMiddle];
        char *right = [Definitions cStringForAtariSTBottomBorderRight];
        [Definitions drawInBitmap:bitmap left:left middle:middle right:right x:r.x y:r.y w:r.w palette:palette];
    } else {
        Int4 r = _bottomBorderRect;
        char *left = [Definitions cStringForAtariSTInactiveBottomBorderLeft];
        char *middle = [Definitions cStringForAtariSTInactiveBottomBorderMiddle];
        char *right = [Definitions cStringForAtariSTInactiveBottomBorderRight];
        [Definitions drawInBitmap:bitmap left:left middle:middle right:right x:r.x y:r.y w:r.w palette:palette];
    }

    if (hasFocus) {
        if ((_buttonDown == 'c') && (_buttonHover == 'c')) {
            char *reversePalette = "X #000000\n. #ffffff\n";
            char *closeButton = [Definitions cStringForAtariSTCloseButton];
            [bitmap drawCString:closeButton palette:reversePalette x:_closeButtonRect.x y:_closeButtonRect.y];
        }
        if ((_buttonDown == 'm') && (_buttonHover == 'm')) {
            char *reversePalette = "X #000000\n. #ffffff\n";
            char *maximizeButton = [Definitions cStringForAtariSTCloseButton];
            [bitmap drawCString:maximizeButton palette:reversePalette x:_maximizeButtonRect.x y:_maximizeButtonRect.y];
        }
        if ((_buttonDown == 't') || (_buttonDown == 'r')) {
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
    if (mouseX >= viewWidth-28) {
        if (mouseY >= viewHeight-26) {
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

