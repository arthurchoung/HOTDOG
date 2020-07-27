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

@implementation Definitions(jfewjfsdjflksdjfkljsdklf)
+ (void)enterExposeMode
{
    id windowManager = [@"windowManager" valueForKey];
    id oldRootWindowObject = [windowManager valueForKey:@"rootWindowObject"];

    id rootObject = [@"ExposeRootWindow" asInstance];
    [rootObject setValue:oldRootWindowObject forKey:@"oldRootWindowObject"];
    [windowManager setInputFocus:nil];
    [rootObject unmapIrrelevantWindows];
    [windowManager setValue:rootObject forKey:@"rootWindowObject"];
    id obj = [@"ExposeWindow" asInstance];
    id dict = [windowManager openWindowForObject:obj x:0 y:0 w:1 h:1];
    [dict setValue:@"1" forKey:@"transparent"];
    [windowManager unmapObjectWindow:dict];
    [rootObject tileWindows];
}
+ (void)exitExposeMode
{
    id windowManager = [@"windowManager" valueForKey];
    id rootObject = [windowManager valueForKey:@"rootWindowObject"];
    id oldRootWindowObject = [rootObject valueForKey:@"oldRootWindowObject"];
    [windowManager setValue:oldRootWindowObject forKey:@"rootWindowObject"];
    id dict = [windowManager dictForObjectWindowClassName:@"ExposeWindow"];
    [dict setValue:@"1" forKey:@"shouldCloseWindow"];
    [rootObject revertWindowPositions];
    [rootObject mapIrrelevantWindows];
}
@end

@interface ExposeRootWindow : IvarObject
{
    id _oldRootWindowObject;
}
@end
@implementation ExposeRootWindow
- (void)unmapIrrelevantWindows
{
    id windowManager = [@"windowManager" valueForKey];
    id reparentClass = [[windowManager valueForKey:@"reparentClassName"] asClass];
    id objectWindows = [windowManager valueForKey:@"objectWindows"];
    for (id dict in objectWindows) {
        if (![dict valueForKey:@"window"]) {
            continue;
        }
        id object = [dict valueForKey:@"object"];
        if ([object isKindOfClass:reparentClass]) {
            continue;
        }
        if ([dict intValueForKey:@"isUnmapped"]) {
            continue;
        }
        [dict setValue:@"1" forKey:@"exposeIrrelevant"];
        [windowManager unmapObjectWindow:dict];
    }
}
- (void)mapIrrelevantWindows
{
    id windowManager = [@"windowManager" valueForKey];
    id objectWindows = [windowManager valueForKey:@"objectWindows"];
    for (id dict in objectWindows) {
        if (![dict valueForKey:@"window"]) {
            continue;
        }
        id object = [dict valueForKey:@"object"];
        if (![dict valueForKey:@"exposeIrrelevant"]) {
            continue;
        }
        [dict setValue:nil forKey:@"exposeIrrelevant"];
        [windowManager mapObjectWindow:dict];
    }
}
- (void)tileWindows
{
    id windowManager = [@"windowManager" valueForKey];
    id reparentClass = [[windowManager valueForKey:@"reparentClassName"] asClass];
    id monitors = [Definitions monitorConfig];
    id objectWindows = [windowManager valueForKey:@"objectWindows"];
    id arr = nsarr();
    for (int i=0; i<[monitors count]; i++) {
        [arr addObject:nsarr()];
    }
    for (id dict in objectWindows) {
        if (![dict valueForKey:@"window"]) {
            continue;
        }
        id object = [dict valueForKey:@"object"];
        if (![object isKindOfClass:reparentClass]) {
            continue;
        }
        int x = [dict intValueForKey:@"x"];
        int y = [dict intValueForKey:@"y"];
        int w = [dict intValueForKey:@"w"];
        int h = [dict intValueForKey:@"h"];
        int centerX = x + w/2;
        int centerY = y + h/2;
        int monitorIndex = [Definitions monitorIndexForX:centerX y:centerY];
        [[arr nth:monitorIndex] addObject:dict];
    }
    for (int i=0; i<[arr count]; i++) {
        id elt = [arr nth:i];
        [self tileWindows:elt monitor:[monitors nth:i]];
    }
}
- (void)tileWindows:(id)windows monitor:(id)monitor
{
    int count = [windows count];
    if (count < 1) {
        return;
    }
    double squareRoot = ceil(sqrt((double)count));
    int nrows = squareRoot;
    int ncols = squareRoot;
    int monitorX = [monitor intValueForKey:@"x"];
    int monitorY = [monitor intValueForKey:@"y"];
    int monitorWidth = [monitor intValueForKey:@"width"];
    int monitorHeight = [monitor intValueForKey:@"height"];
    int cellWidth = monitorWidth / ncols;
    int cellHeight = monitorHeight / nrows;
    for (int i=0; i<count; i++) {
        id dict = [windows nth:i];
        id origWNumber = [dict valueForKey:@"w"];
        id origHNumber = [dict valueForKey:@"h"];
        int origW = [origWNumber intValue];
        int origH = [origHNumber intValue];
        [dict setValue:[dict valueForKey:@"x"] forKey:@"origX"];
        [dict setValue:[dict valueForKey:@"y"] forKey:@"origY"];
        [dict setValue:origWNumber forKey:@"origW"];
        [dict setValue:origHNumber forKey:@"origH"];
        int row = i/ncols;
        int col = i%ncols; 
        int x = monitorX + cellWidth*col + 5;
        int y = cellHeight*row + 5;
        int w = cellWidth - 10;
        int h = cellHeight - 10;
        Int2 proportionalSize = [Definitions proportionalSizeForWidth:w height:h origWidth:origW origHeight:origH];
        Int4 r = [Definitions centerRectX:0 y:0 w:proportionalSize.w h:proportionalSize.h inW:w h:h];
        [dict setValue:nsfmt(@"%d %d", x+r.x, y+r.y) forKey:@"moveWindow"];
        [dict setValue:nsfmt(@"%d %d", r.w, r.h) forKey:@"resizeWindow"];
    }
}
- (void)revertWindowPositions
{
    id windowManager = [@"windowManager" valueForKey];
    id reparentClass = [[windowManager valueForKey:@"reparentClassName"] asClass];
    id objectWindows = [windowManager valueForKey:@"objectWindows"];
    for (id dict in objectWindows) {
        if (![dict valueForKey:@"window"]) {
            continue;
        }
        id object = [dict valueForKey:@"object"];
        if (![object isKindOfClass:reparentClass]) {
            continue;
        }
        int x = [dict intValueForKey:@"origX"];
        int y = [dict intValueForKey:@"origY"];
        int w = [dict intValueForKey:@"origW"];
        int h = [dict intValueForKey:@"origH"];
        [dict setValue:nsfmt(@"%d %d", x, y) forKey:@"moveWindow"];
        [dict setValue:nsfmt(@"%d %d", w, h) forKey:@"resizeWindow"];
    }
}
- (void)handleDidSetInputFocusEvent:(id)event
{
    [Definitions exitExposeMode];
}
- (void)handleEnterWindowEvent:(id)event
{
    id windowManager = [@"windowManager" valueForKey];
    id reparentClass = [[windowManager valueForKey:@"reparentClassName"] asClass];
    id x11dict = [event valueForKey:@"x11dict"];
    if (!x11dict) {
        return;
    }
    id object = [x11dict valueForKey:@"object"];
    if (![object isKindOfClass:reparentClass]) {
        return;
    }
    int x = [x11dict intValueForKey:@"x"];
    int y = [x11dict intValueForKey:@"y"];
    int w = [x11dict intValueForKey:@"w"];
    int h = [x11dict intValueForKey:@"h"];
    id dict = [windowManager dictForObjectWindowClassName:@"ExposeWindow"];
    [dict setValue:x11dict forKey:@"underneathObjectWindow"];
    [windowManager moveResizeObjectWindow:dict x:x y:y w:w h:h];
    [windowManager mapObjectWindow:dict];
}
- (void)handleMouseDown:(id)event
{
    [Definitions exitExposeMode];
}
- (void)handleMouseMoved:(id)event
{
    id windowManager = [event valueForKey:@"windowManager"];
    id dict = [windowManager dictForObjectWindowClassName:@"ExposeWindow"];
    [dict setValue:nil forKey:@"underneathObjectWindow"];
    [windowManager unmapObjectWindow:dict];
}
@end


@interface ExposeWindow : IvarObject
@end
@implementation ExposeWindow
- (void)drawInBitmap:(id)bitmap rect:(Int4)r context:(id)context
{
    [bitmap setColor:@"blue"];
    Int4 bottom = r;
    bottom.h = 5;
    [bitmap fillRect:bottom];
    Int4 top = r;
    top.h = 5;
    top.y = r.y+r.h-5;
    [bitmap fillRect:top];
    Int4 left = r;
    left.w = 5;
    [bitmap fillRect:left];
    Int4 right = r;
    right.w = 5;
    right.x = r.x+r.w-5;
    [bitmap fillRect:right];
}
@end


