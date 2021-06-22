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

@interface SelectionBox : IvarObject
{
    int _buttonDownRootX;
    int _buttonDownRootY;
}
@end
@implementation SelectionBox
- (int)preferredWidth
{
    return 1;
}
- (int)preferredHeight
{
    return 1;
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    if ((r.w < 1) || (r.h < 1)) {
        return;
    }
    [bitmap setColor:@"black"];
    [bitmap drawLineAtX:r.x y:r.y x:r.x+r.w-1 y:r.y];
    [bitmap drawLineAtX:r.x y:r.y+r.h-1 x:r.x+r.w-1 y:r.y+r.h-1];
    [bitmap drawLineAtX:r.x y:r.y x:r.x y:r.y+r.h-1];
    [bitmap drawLineAtX:r.x+r.w-1 y:r.y x:r.x+r.w-1 y:r.y+r.h-1];
}
- (void)handleMouseDown:(id)event
{
NSLog(@"SelectionBox handleMouseDown");
    id windowManager = [event valueForKey:@"windowManager"];
    id objectWindows = [windowManager valueForKey:@"objectWindows"];
    [windowManager setFocusDict:nil];
    for (int i=0; i<[objectWindows count]; i++) {
        id dict = [objectWindows nth:i];
        if ([dict intValueForKey:@"isIcon"]) {
            if ([dict valueForKey:@"selectedTimestamp"]) {
                [dict setValue:nil forKey:@"selectedTimestamp"];
                [dict setValue:@"1" forKey:@"needsRedraw"];
            }
        }
    }
    id x11dict = [event valueForKey:@"x11dict"];
    [x11dict setValue:@"1" forKey:@"transparent"];
    _buttonDownRootX = [event intValueForKey:@"mouseRootX"];
    _buttonDownRootY = [event intValueForKey:@"mouseRootY"];
}
- (void)handleMouseMoved:(id)event
{
NSLog(@"SelectionBox handleMouseMoved");
    int mouseRootX = [event intValueForKey:@"mouseRootX"];
    int mouseRootY = [event intValueForKey:@"mouseRootY"];
    int newX = _buttonDownRootX;
    int newY = _buttonDownRootY;
    int newWidth = mouseRootX - _buttonDownRootX;
    int newHeight = mouseRootY - _buttonDownRootY;
    if (newWidth == 0) {
        newWidth = 1;
    } else if (newWidth < 0) {
        newX = mouseRootX;
        newWidth *= -1;
        newWidth++;
    }
    if (newHeight == 0) {
        newHeight = 1;
    } else if (newHeight < 0) {
        newY = mouseRootY;
        newHeight *= -1;
        newHeight++;
    }
    id x11dict = [event valueForKey:@"x11dict"];
    [x11dict setValue:nsfmt(@"%d", newX) forKey:@"x"];
    [x11dict setValue:nsfmt(@"%d", newY) forKey:@"y"];
    [x11dict setValue:nsfmt(@"%d", newWidth) forKey:@"w"];
    [x11dict setValue:nsfmt(@"%d", newHeight) forKey:@"h"];
    [x11dict setValue:@"1" forKey:@"needsRedraw"];
    id windowManager = [event valueForKey:@"windowManager"];
    [x11dict setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];
    [x11dict setValue:nsfmt(@"%d %d", newWidth, newHeight) forKey:@"resizeWindow"];
    Int4 r = [Definitions rectWithX:newX y:newY w:newWidth h:newHeight];
    id objectWindows = [windowManager valueForKey:@"objectWindows"];
    for (int i=0; i<[objectWindows count]; i++) {
        id dict = [objectWindows nth:i];
        if (![dict intValueForKey:@"isIcon"]) {
            continue;
        }
        int x = [dict intValueForKey:@"x"];
        int y = [dict intValueForKey:@"y"];
        int w = [dict intValueForKey:@"w"];
        int h = [dict intValueForKey:@"h"];
        Int4 r2 = [Definitions rectWithX:x y:y w:w h:h];
        if ([Definitions doesRect:r intersectRect:r2]) {
            if (![dict valueForKey:@"selectedTimestamp"]) {
                [dict setValue:@"1" forKey:@"selectedTimestamp"];
                [dict setValue:@"1" forKey:@"needsRedraw"];
            }
        } else {
            if ([dict valueForKey:@"selectedTimestamp"]) {
                [dict setValue:nil forKey:@"selectedTimestamp"];
                [dict setValue:@"1" forKey:@"needsRedraw"];
            }
        }
    }
}
- (void)handleMouseUp:(id)event
{
    id x11dict = [event valueForKey:@"x11dict"];
    [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
}
@end

