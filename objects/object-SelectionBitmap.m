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

@implementation Definitions(fmkelwmfkldsmkf)
+ (id)selectedBitmapForSelectedItemsInArray:(id)array buttonDownElt:(id)buttonDownElt offsetX:(int)offsetX y:(int)offsetY mouseRootX:(int)mouseRootX y:(int)mouseRootY windowManager:(id)windowManager
{
    int selectedCount = 0;
    int minX = 0;
    int minY = 0;
    int maxX = 0;
    int maxY = 0;
    for (int i=0; i<[array count]; i++) {
        id elt = [array nth:i];
        if (![elt intValueForKey:@"isSelected"]) {
            continue;
        }
        int x = [elt intValueForKey:@"x"];
        int y = [elt intValueForKey:@"y"];
        int w = [elt intValueForKey:@"w"];
        int h = [elt intValueForKey:@"h"];
        if (!selectedCount) {
            minX = x;
            minY = y;
            maxX = x+w-1;
            maxY = y+h-1;
        } else {
            if (x < minX) {
                minX = x;
            }
            if (y < minY) {
                minY = y;
            }
            if (x+w-1 > maxX) {
                maxX = x+w-1;
            }
            if (y+h-1 > maxY) {
                maxY = y+h-1;
            }
        }
        selectedCount++;
    }
    if (!selectedCount) {
        return nil;
    }

    int selectionWidth = maxX - minX + 1;
    int selectionHeight = maxY - minY + 1;

    id bitmap = [Definitions bitmapWithWidth:selectionWidth height:selectionHeight];
    id context = nsdict();
    [context setValue:@"1" forKey:@"isSelected"];
    for (int i=0; i<[array count]; i++) {
        id elt = [array nth:i];
        if (![elt intValueForKey:@"isSelected"]) {
            continue;
        }
        int x = [elt intValueForKey:@"x"];
        int y = [elt intValueForKey:@"y"];
        int w = [elt intValueForKey:@"w"];
        int h = [elt intValueForKey:@"h"];
        id object = [elt valueForKey:@"object"];
        Int4 r;
        r.x = x - minX;
        r.y = y - minY;
        r.w = w;
        r.h = h;
        if ([object respondsToSelector:@selector(drawInBitmap:rect:context:)]) {
            [object drawInBitmap:bitmap rect:r context:context];
        }
    }

    int x = [buttonDownElt intValueForKey:@"x"] + offsetX - minX;
    int y = [buttonDownElt intValueForKey:@"y"] + offsetY - minY;
    int buttonDownOffsetX = x;
    int buttonDownOffsetY = y;

    id selectionBitmap = [@"SelectionBitmap" asInstance];
    [selectionBitmap setValue:bitmap forKey:@"bitmap"];

    id newx11dict = [windowManager openWindowForObject:selectionBitmap x:mouseRootX - buttonDownOffsetX y:mouseRootY - buttonDownOffsetY w:selectionWidth h:selectionHeight overrideRedirect:YES];
    [newx11dict setValue:nsfmt(@"%d", buttonDownOffsetX) forKey:@"buttonDownOffsetX"];
    [newx11dict setValue:nsfmt(@"%d", buttonDownOffsetY) forKey:@"buttonDownOffsetY"];

    return newx11dict;
}
@end

@interface SelectionBitmap : IvarObject
{
    id _bitmap;
}
@end
@implementation SelectionBitmap
- (int)preferredWidth
{
    if (_bitmap) {
        return [_bitmap bitmapWidth];
    }
    return 1;
}
- (int)preferredHeight
{
    if (_bitmap) {
        return [_bitmap bitmapHeight];
    }
    return 1;
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)r context:(id)context
{
    [bitmap drawBitmap:_bitmap x:r.x y:r.y];

    id windowManager = [@"windowManager" valueForKey];
    unsigned long win = [[context valueForKey:@"window"] unsignedLongValue];
    if (win) {
        [windowManager addMaskToWindow:win bitmap:bitmap];
    }
}

@end

