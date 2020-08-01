/*

 PEEOS

 Copyright (c) 2020 Arthur Choung. All rights reserved.

 Email: arthur -at- peeos.org

 This file is part of PEEOS.

 PEEOS is free software: you can redistribute it and/or modify it
 under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <https://www.gnu.org/licenses/>.

 */

#import "PEEOS.h"

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

@implementation Definitions(jfkdlsjfklsdjklfjsdfklsdjfs)

+ (void)testAddMacWindow
{
    id windowManager = [@"windowManager" valueForKey];
    id obj = [@"MacWindow" asInstance];
    int w = 200;
    int h = 100;
    [windowManager openWindowForObject:obj x:100 y:200 w:w h:h];
}
@end

@implementation Definitions(fjkdlsjfiowejfklsdjfklsdkljf)
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
+ (void)drawActiveScrollBarInBitmap:(id)bitmap rect:(Int4)r pct:(double)pct
{
    char *palette = [Definitions cStringForActiveScrollBarPalette];

    char *left = [Definitions cStringForActiveScrollBarLeftArrow];
    char *middle = [Definitions cStringForActiveScrollBarMiddle];
    char *right = [Definitions cStringForActiveScrollBarRightArrow];
    char *knob = [Definitions cStringForActiveScrollBarKnob];

    int widthForLeft = [Definitions widthForCString:left];
    int widthForMiddle = [Definitions widthForCString:middle];
    int widthForRight = [Definitions widthForCString:right];
    int widthForKnob = [Definitions widthForCString:knob];

    int heightForMiddle = [Definitions heightForCString:middle];
    int heightForKnob = [Definitions heightForCString:knob];
    int middleYOffset = (r.h - heightForMiddle)/2.0;
    int knobYOffset = (r.h - heightForKnob)/2.0;

    [bitmap drawCString:left palette:palette x:r.x y:r.y+middleYOffset];
    int x;
    for (x=widthForLeft; x<r.w-widthForRight; x+=widthForMiddle) {
        [bitmap drawCString:middle palette:palette x:r.x+x y:r.y+middleYOffset];
    }
    [bitmap drawCString:right palette:palette x:r.x+r.w-widthForRight y:r.y+middleYOffset];
    int knobX = widthForLeft + (int)(r.w-widthForLeft-widthForRight-widthForKnob) * pct;
    [bitmap drawCString:knob palette:palette x:r.x+knobX y:r.y+knobYOffset];
}
+ (void)drawInactiveHorizontalScrollBarInBitmap:(id)bitmap rect:(Int4)r
{
    char *palette = [Definitions cStringForInactiveHorizontalScrollBarPalette];

    char *left = [Definitions cStringForInactiveHorizontalScrollBarLeftArrow];
    char *middle = [Definitions cStringForInactiveHorizontalScrollBarMiddle];
    char *right = [Definitions cStringForInactiveHorizontalScrollBarRightArrow];

    int widthForLeft = [Definitions widthForCString:left];
    int widthForMiddle = [Definitions widthForCString:middle];
    int widthForRight = [Definitions widthForCString:right];

    int heightForMiddle = [Definitions heightForCString:middle];
    int middleYOffset = (r.h - heightForMiddle)/2.0;

    [bitmap drawCString:left palette:palette x:r.x y:r.y+middleYOffset];
    int x;
    for (x=widthForLeft; x<r.w-widthForRight; x+=widthForMiddle) {
        [bitmap drawCString:middle palette:palette x:r.x+x y:r.y+middleYOffset];
    }
    [bitmap drawCString:right palette:palette x:r.x+r.w-widthForRight y:r.y+middleYOffset];
}
+ (void)drawInactiveVerticalScrollBarInBitmap:(id)bitmap rect:(Int4)r
{
    char *palette = [Definitions cStringForInactiveVerticalScrollBarPalette];

    char *top = [Definitions cStringForInactiveVerticalScrollBarUpArrow];
    char *middle = [Definitions cStringForInactiveVerticalScrollBarMiddle];
    char *bottom = [Definitions cStringForInactiveVerticalScrollBarDownArrow];
//    char *knob = [Definitions cStringForInactiveVerticalScrollBarKnob];

    int heightForTop = [Definitions heightForCString:top];
    int heightForMiddle = [Definitions heightForCString:middle];
    int heightForBottom = [Definitions heightForCString:bottom];
//    int heightForKnob = [Definitions heightForCString:knob];

    int widthForMiddle = [Definitions widthForCString:middle];
//    int widthForKnob = [Definitions widthForCString:knob];
    int middleXOffset = (r.w - widthForMiddle)/2;
//    int knobXOffset = (r.w - widthForKnob)/2;

    [bitmap drawCString:top palette:palette x:r.x+middleXOffset y:r.y];
    for (int y=r.y+heightForTop; y<r.y+r.h-heightForBottom; y+=heightForMiddle) {
        [bitmap drawCString:middle palette:palette x:r.x+middleXOffset y:y];
    }
    [bitmap drawCString:bottom palette:palette x:r.x+middleXOffset y:r.y+r.h-heightForBottom];
//    int knobX = widthForLeft + (int)(r.w-widthForLeft-widthForRight-widthForKnob) * pct;
//    [bitmap drawCString:knob palette:palette x:r.x+knobX y:r.y+r.h-1-knobYOffset];
}
+ (void)drawResizeButtonInBitmap:(id)bitmap x:(int)x y:(int)y
{
    char *palette = [Definitions cStringForActiveScrollBarPalette];

    char *button = [Definitions cStringForResizeButton];
    [bitmap drawCString:button palette:palette x:x y:y];
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
+ (char *)cStringForInactiveVerticalScrollBarPalette
{
    return
"b #000000\n"
"X #777777\n"
". #eeeeee\n"
;
}
+ (char *)cStringForInactiveVerticalScrollBarUpArrow
{
    return
"bbbbbbbbbbbbbbbb\n"
"b..............b\n"
"b..............b\n"
"b......XX......b\n"
"b.....X..X.....b\n"
"b....X....X....b\n"
"b...X......X...b\n"
"b..X........X..b\n"
"b.XXXX....XXXX.b\n"
"b....X....X....b\n"
"b....X....X....b\n"
"b....X....X....b\n"
"b....XXXXXX....b\n"
"b..............b\n"
"b..............b\n"
"bXXXXXXXXXXXXXXb\n"
;
}
+ (char *)cStringForInactiveVerticalScrollBarMiddle
{
    return
"b..............b\n"
;
}
+ (char *)cStringForInactiveVerticalScrollBarDownArrow
{
    return
"bXXXXXXXXXXXXXXb\n"
"b..............b\n"
"b..............b\n"
"b....XXXXXX....b\n"
"b....X....X....b\n"
"b....X....X....b\n"
"b....X....X....b\n"
"b.XXXX....XXXX.b\n"
"b..X........X..b\n"
"b...X......X...b\n"
"b....X....X....b\n"
"b.....X..X.....b\n"
"b......XX......b\n"
"b..............b\n"
"b..............b\n"
"bbbbbbbbbbbbbbbb\n"
;
}
+ (char *)cStringForActiveScrollBarPalette
{
    return
"b #000000\n"
". #333366\n"
"X #555555\n"
"o #606060\n"
"O #777777\n"
"+ #666699\n"
"@ #a0a0a0\n"
"# #a4a4a4\n"
"$ #aaaaaa\n"
"% #bbbbbb\n"
"& #a3a3d7\n"
"* #dddddd\n"
"= #ccccff\n"
"- #eeeeee\n"
"; #ffffff\n"
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

+ (char *)cStringForActiveScrollBarLeftArrow
{
    return
"bbbbbbbbbbbbbbbb\n"
"b;;;;;;;;;;;;;Ob\n"
"b;******.*****Ob\n"
"b;*****..*****Ob\n"
"b;****.&.*****Ob\n"
"b;***.&&.....*Ob\n"
"b;**.&&&&&&&.*Ob\n"
"b;*.&&&&&&&&.*Ob\n"
"b;**.&&&&&&&.*Ob\n"
"b;***.&&.....*Ob\n"
"b;****.&.*****Ob\n"
"b;*****..*****Ob\n"
"b;******.*****Ob\n"
"b;************Ob\n"
"bOOOOOOOOOOOOOOb\n"
"bbbbbbbbbbbbbbbb\n"
;
}
+ (char *)cStringForActiveScrollBarMiddle
{
    return
"bbbb\n"
"*O**\n"
"***O\n"
"*O**\n"
"***O\n"
"*O**\n"
"***O\n"
"*O**\n"
"***O\n"
"*O**\n"
"***O\n"
"*O**\n"
"***O\n"
"*O**\n"
"***O\n"
"bbbb\n"
;
}

+ (char *)cStringForActiveScrollBarRightArrow
{
    return
"bbbbbbbbbbbbbbbb\n"
"b;;;;;;;;;;;;;Ob\n"
"b;*****.******Ob\n"
"b;*****..*****Ob\n"
"b;*****.&.****Ob\n"
"b;*.....&&.***Ob\n"
"b;*.&&&&&&&.**Ob\n"
"b;*.&&&&&&&&.*Ob\n"
"b;*.&&&&&&&.**Ob\n"
"b;*.....&&.***Ob\n"
"b;*****.&.****Ob\n"
"b;*****..*****Ob\n"
"b;*****.******Ob\n"
"b;************Ob\n"
"bOOOOOOOOOOOOOOb\n"
"bbbbbbbbbbbbbbbb\n"
;
}

+ (char *)cStringForActiveScrollBarKnob
{
    return
"bbbbbbbbbbbbbbbb\n"
"X==============.\n"
"X=$$$$$$$$$$$$$.\n"
"X=$$$$$$$$$$$$$.\n"
"X=$$$$$$$$$$$$$.\n"
"X=$&=+=+=+=+=$$.\n"
"X=$&=+=+=+=+=$$.\n"
"X=$&=+=+=+=+=$$.\n"
"X=$&=+=+=+=+=$$.\n"
"X=$&=+=+=+=+=$$.\n"
"X=$&=+=+=+=+=$$.\n"
"X=$$$$$$$$$$$$$.\n"
"X=$$$$$$$$$$$$$.\n"
"X=$$$$$$$$$$$$$.\n"
"X...............\n"
"bbbbbbbbbbbbbbbb\n"
;
}

+ (char *)cStringForInactiveHorizontalScrollBarPalette
{
    return
"b #000000\n"
"X #777777\n"
". #eeeeee\n"
;
}

+ (char *)cStringForInactiveHorizontalScrollBarLeftArrow
{
    return
"bbbbbbbbbbbbbbbb\n"
"b..............X\n"
"b......X.......X\n"
"b.....XX.......X\n"
"b....X.X.......X\n"
"b...X..XXXXX...X\n"
"b..X.......X...X\n"
"b.X........X...X\n"
"b.X........X...X\n"
"b..X.......X...X\n"
"b...X..XXXXX...X\n"
"b....X.X.......X\n"
"b.....XX.......X\n"
"b......X.......X\n"
"b..............X\n"
"bbbbbbbbbbbbbbbb\n"
;
}
+ (char *)cStringForInactiveHorizontalScrollBarMiddle
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
;
}
+ (char *)cStringForInactiveHorizontalScrollBarRightArrow
{
    return
"bbbbbbbbbbbbbbbb\n"
"X..............b\n"
"X.......X......b\n"
"X.......XX.....b\n"
"X.......X.X....b\n"
"X...XXXXX..X...b\n"
"X...X.......X..b\n"
"X...X........X.b\n"
"X...X........X.b\n"
"X...X.......X..b\n"
"X...XXXXX..X...b\n"
"X.......X.X....b\n"
"X.......XX.....b\n"
"X.......X......b\n"
"X..............b\n"
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


@interface MacWindow : IvarObject
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
    Int4 _closeButtonRect;
    Int4 _maximizeButtonRect;
}
@end
@implementation MacWindow
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

- (void)moveChildWindowBackAndForthForWine:(id)dict
{
    unsigned long childWindow = [dict unsignedLongValueForKey:@"childWindow"];
    if (!childWindow) {
        return;
    }
    int w = [dict intValueForKey:@"w"]-_leftBorder-_rightBorder;
    int h = [dict intValueForKey:@"h"]-_topBorder-_bottomBorder;
    id windowManager = [@"windowManager" valueForKey];
    [windowManager XMoveResizeWindow:childWindow :_leftBorder-1 :_topBorder :w :h];
    [windowManager XMoveResizeWindow:childWindow :_leftBorder :_topBorder :w :h];
}
- (void)moveToMonitor:(int)monitorNumber
{
    id monitors = [Definitions monitorConfig];
    id monitor = [monitors nth:monitorNumber];
    if (!monitor) {
        return;
    }
    id windowManager = [@"windowManager" valueForKey];
    id dict = [windowManager valueForKey:@"focusDict"];
    if (!dict) {
        return;
    }
    int menuBarHeight = [windowManager intValueForKey:@"menuBarHeight"];
    int monitorX = [monitor intValueForKey:@"x"];
    int monitorWidth = [monitor intValueForKey:@"width"];
    int monitorHeight = [monitor intValueForKey:@"height"];
    int newX = monitorX;
    int newY = menuBarHeight-1;
    int newW = monitorWidth;
    int newH = monitorHeight-(menuBarHeight-1);
    [dict setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];
    [dict setValue:nsfmt(@"%d %d", newW, newH) forKey:@"resizeWindow"];
}
- (void)maximizeTopHalf
{
    id windowManager = [@"windowManager" valueForKey];
    id dict = [windowManager valueForKey:@"focusDict"];
    if (!dict) {
        return;
    }
    int rootWindowWidth = [windowManager intValueForKey:@"rootWindowWidth"];
    int rootWindowHeight = [windowManager intValueForKey:@"rootWindowHeight"];
    int menuBarHeight = [windowManager intValueForKey:@"menuBarHeight"];
    int oldX = [dict intValueForKey:@"x"];
    int oldY = [dict intValueForKey:@"y"];
    id monitor = [Definitions monitorForX:oldX y:oldY];
    int monitorX = [monitor intValueForKey:@"x"];
    int monitorWidth = rootWindowWidth;
    int monitorHeight = rootWindowHeight;
    if (monitor) {
        monitorWidth = [monitor intValueForKey:@"width"];
        monitorHeight = [monitor intValueForKey:@"height"];
    }
    int newX = monitorX;
    int newY = menuBarHeight-1;
    int newW = monitorWidth;
    int newH = (monitorHeight-(menuBarHeight-1))/2;
    [dict setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];
    [dict setValue:nsfmt(@"%d %d", newW, newH) forKey:@"resizeWindow"];
}
- (void)maximizeHeight
{
    id windowManager = [@"windowManager" valueForKey];
    id dict = [windowManager valueForKey:@"focusDict"];
    if (!dict) {
        return;
    }
    int rootWindowHeight = [windowManager intValueForKey:@"rootWindowHeight"];
    int menuBarHeight = [windowManager intValueForKey:@"menuBarHeight"];
    int oldX = [dict intValueForKey:@"x"];
    int oldY = [dict intValueForKey:@"y"];
    int oldW = [dict intValueForKey:@"w"];
    id monitor = [Definitions monitorForX:oldX y:oldY];
    int monitorHeight = rootWindowHeight;
    if (monitor) {
        monitorHeight = [monitor intValueForKey:@"height"];
    }
    int newY = menuBarHeight-1;
    int newH = monitorHeight-(menuBarHeight-1);
    [dict setValue:nsfmt(@"%d %d", oldX, newY) forKey:@"moveWindow"];
    [dict setValue:nsfmt(@"%d %d", oldW, newH) forKey:@"resizeWindow"];
}
- (void)handleMaximizeWindow:(id)event
{
    id dict = [event valueForKey:@"x11dict"];
    int mouseRootX = [event intValueForKey:@"mouseRootX"];
    int mouseRootY = [event intValueForKey:@"mouseRootY"];
    unsigned long win = [dict unsignedLongValueForKey:@"window"];
    id windowManager = [event valueForKey:@"windowManager"];
    int rootWindowWidth = [windowManager intValueForKey:@"rootWindowWidth"];
    int rootWindowHeight = [windowManager intValueForKey:@"rootWindowHeight"];
    int menuBarHeight = [windowManager intValueForKey:@"menuBarHeight"];
    if ([dict valueForKey:@"revertMaximize"]) {
        id revert = [dict valueForKey:@"revertMaximize"];
        id tokens = [revert split:@" "];
        int newX = [[tokens nth:0] intValue];
        int newY = [[tokens nth:1] intValue];
        int newW = [[tokens nth:2] intValue];
        int newH = [[tokens nth:3] intValue];
        [dict setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];
        [dict setValue:nsfmt(@"%d %d", newW, newH) forKey:@"resizeWindow"];
        [dict setValue:nil forKey:@"revertMaximize"];
    } else {
        id attrs = [windowManager XGetWindowAttributes:win];
        [dict setValue:attrs forKey:@"revertMaximize"];
        id monitor = [Definitions monitorForX:mouseRootX y:mouseRootY];
        int monitorX = [monitor intValueForKey:@"x"];
        int monitorWidth = rootWindowWidth;
        int monitorHeight = rootWindowHeight;
        if (monitor) {
            monitorWidth = [monitor intValueForKey:@"width"];
            monitorHeight = [monitor intValueForKey:@"height"];
        }
        int newX = monitorX;
        int newY = menuBarHeight-1;
        int newW = monitorWidth;
        int newH = monitorHeight-(menuBarHeight-1);
        [dict setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];
        [dict setValue:nsfmt(@"%d %d", newW, newH) forKey:@"resizeWindow"];
    }
}
- (void)handleCloseWindow:(id)event
{
    id x11dict = [event valueForKey:@"x11dict"];
    if (!x11dict) {
        return;
    }
    id windowManager = [event valueForKey:@"windowManager"];
    id childWindow = [x11dict valueForKey:@"childWindow"];
    if (childWindow) {
        int didSendCloseEvent = [x11dict intValueForKey:@"didSendCloseEvent"];
        if (didSendCloseEvent) {
            [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
        } else {
            [windowManager sendCloseEventToWindow:[childWindow unsignedLongValue]];
            [x11dict setValue:@"1" forKey:@"didSendCloseEvent"];
        }
    } else {
        [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
    }
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
    int infoBarHeight = 0;
    [bitmap setColor:@"white"];
    [bitmap fillRect:r];
    [Definitions drawInactiveHorizontalScrollBarInBitmap:bitmap rect:[Definitions rectWithX:r.x y:r.y+r.h-16 w:r.w-15 h:16]];
    [Definitions drawInactiveVerticalScrollBarInBitmap:bitmap rect:[Definitions rectWithX:r.x+r.w-16 y:r.y+titleBarHeight+infoBarHeight-2 w:16 h:r.h-titleBarHeight-infoBarHeight-15+2]];
    [Definitions drawResizeButtonInBitmap:bitmap x:r.x+r.w-16 y:r.y+r.h-16];
    if (infoBarHeight) {
        [bitmap setColor:@"black"];
        [bitmap drawLineX:r.x y:r.y+r.h-1-40 x:r.x+r.w-1 y:r.y+r.h-1-40];
        [bitmap drawLineX:r.x y:r.y+r.h-1-38 x:r.x+r.w-1 y:r.y+r.h-1-38];
        [bitmap useGenevaFont];
        [bitmap setColorIntR:0 g:0 b:0 a:255];
        [bitmap drawBitmapText:@"16 items        3,622K in disk           6,453K available" x:20 y:r.y+r.h-1-20];
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

    if (hasFocus) {
        [bitmap setColor:@"black"];
    } else {
        [bitmap setColor:@"#555555ff"];
    }
    [bitmap drawVerticalLineX:rr.x y:rr.y y:rr.y+rr.h-1];
    [bitmap drawVerticalLineX:rr.x+rr.w-1 y:rr.y y:rr.y+rr.h-1];
    [bitmap drawVerticalLineX:rr.x+rr.w-2 y:rr.y y:rr.y+rr.h-1];
    [bitmap drawHorizontalLineX:rr.x x:rr.x+rr.w-1 y:rr.y];
    [bitmap drawHorizontalLineX:rr.x x:rr.x+rr.w-1 y:rr.y+rr.h-1];
    [bitmap drawHorizontalLineX:rr.x x:rr.x+rr.w-2 y:rr.y+rr.h-2];

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
    [windowManager setInputFocus:x11dict];
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
    if ((_buttonDown == 'c') && (_buttonHover == 'c')) {
        [self handleCloseWindow:event];
    }
    if ((_buttonDown == 'm') && (_buttonHover == 'm')) {
        [self handleMaximizeWindow:event];
    }
    if (_buttonDown == 't') {
        /* this was added for Wine */
        id dict = [event valueForKey:@"x11dict"];
        [self moveChildWindowBackAndForthForWine:dict];
    }

    _buttonDown = 0;
}
- (void)handleDragAndDrop:(id)drag :(id)drop
{
    id windowManager = [@"windowManager" valueForKey];
    if ([drag valueForKey:@"parentWindow"]) {
        return;
    }
    int dragX = [drag intValueForKey:@"x"];
    int dragY = [drag intValueForKey:@"y"];
    int dropX = [drop intValueForKey:@"x"];
    int dropY = [drop intValueForKey:@"y"];
    int x = dragX-dropX;
    int y = dragY-dropY;
    [drag setValue:[drop valueForKey:@"window"] forKey:@"parentWindow"];
    [drag setValue:nsfmt(@"%d", x) forKey:@"x"];
    [drag setValue:nsfmt(@"%d", y) forKey:@"y"];
    [windowManager XReparentWindow:[drag unsignedLongValueForKey:@"window"] :[drop unsignedLongValueForKey:@"window"] :x :y];
}
@end

