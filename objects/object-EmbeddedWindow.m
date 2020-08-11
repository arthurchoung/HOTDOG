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

@interface EmbeddedWindow : IvarObject
{
    unsigned long _window;
    int _width;
    int _height;
}
@end
@implementation EmbeddedWindow
- (void)dealloc
{
NSLog(@"EmbeddedWindow dealloc");
    if (_window) {
        id windowManager = [@"windowManager" valueForKey];
        id x11dict = [windowManager dictForObjectWindowClassName:@"NavigationInterface"];
        [x11dict setValue:nil forKey:@"embeddedWindow"];
        [windowManager XDestroyWindow:_window];
        _window = 0;
    }
    [super dealloc];
}
- (id)init
{
    self = [super init];
    if (self) {
        id windowManager = [@"windowManager" valueForKey];
        id x11dict = [windowManager dictForObjectWindowClassName:@"NavigationInterface"];
NSLog(@"x11dict %@", x11dict);
        _window = [windowManager openEmbeddedWindowForObjectWindow:x11dict];
NSLog(@"window %lu", _window);
    }
    return self;
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
NSLog(@"EmbeddedWindow drawInBitmap %d %d %d %d", r.x, r.y, r.w, r.h);
    BOOL needsResize = NO;
    if (_width != r.w) {
        _width = r.w;
        needsResize = YES;
    }
    if (_height != r.h) {
        _height = r.h;
        needsResize = YES;
    }
    if (needsResize) {
        id windowManager = [@"windowManager" valueForKey];
        int x = 0;
        int y = [Definitions navigationBarHeight];
        int w = _width;
        int h = _height;
        [windowManager XMoveResizeWindow:_window :x :y :w :h];
    }
}
@end

