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

@interface BackgroundAgents : IvarObject
{
    int _hasShadow;
    id _windowFrame;
    id _configPath;
    time_t _configTimestamp;
    id _array;
}
@end

@implementation BackgroundAgents

- (id)init
{
    self = [super init];
    if (self) {
        id windowFrame = [@"HotDogStandWindow" asInstance];
        [self setValue:windowFrame forKey:@"windowFrame"];
        _hasShadow = [windowFrame intValueForKey:@"hasShadow"];
        id configPath = [Definitions configDir:@"Config/backgroundAgents.csv"];
        [self setValue:configPath forKey:@"configPath"];
    }
    return self;
}

- (void)updateBackgroundAgents
{
    id arr = [_configPath parseCSVFile];
    if (!arr) {
        return;
    }
    [self setValue:arr forKey:@"array"];
    for (int i=0; i<[arr count]; i++) {
        id elt = [arr nth:i];
        id objectMessage = [elt valueForKey:@"objectMessage"];
        if ([objectMessage length]) {
            id obj = [objectMessage evaluateMessage];
            [elt setValue:obj forKey:@"object"];
        }
    }
}
- (void)dealloc
{
NSLog(@"DEALLOC BackgroundAgents");
    [super dealloc];
}

- (void)beginIteration:(id)event rect:(Int4)r
{
    time_t timestamp = [_configPath fileModificationTimestamp];
    if (timestamp != _configTimestamp) {
        [self setValue:nil forKey:@"array"];
        _configTimestamp = timestamp;
        [self updateBackgroundAgents];
    }
}

- (id)fileDescriptorObjects
{
    id results = nsarr();
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        id obj = [elt valueForKey:@"object"];
        if ([obj respondsToSelector:@selector(fileDescriptor)]) {
            [results addObject:obj];
        }
    }
    if ([results count]) {
        return results;
    }
    return nil;
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r context:(id)context
{
    [_windowFrame drawInBitmap:bitmap rect:r context:context];

    int topBorder = [_windowFrame intValueForKey:@"topBorder"];
    int bottomBorder = [_windowFrame intValueForKey:@"bottomBorder"];
    int leftBorder = [_windowFrame intValueForKey:@"leftBorder"];
    int rightBorder = [_windowFrame intValueForKey:@"rightBorder"];
    r.x += leftBorder;
    r.y += topBorder;
    r.w -= leftBorder;
    r.w -= rightBorder;
    r.h -= topBorder;
    r.h -= bottomBorder;

    int leftPadding = 4;
    int rowHeight = 20;

    int cursorY = r.y+4;
    id text = nsarr();
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        Int4 r1 = r;
        r1.y = cursorY;
        r1.h = rowHeight;
        [bitmap setColor:@"white"];
        [bitmap fillRect:r1];
        id obj = [elt valueForKey:@"object"];
        if ([obj respondsToSelector:@selector(drawInBitmap:rect:)]) {
            Int4 r2 = r1;
            r2.x += leftPadding;
            r2.w -= leftPadding*2;
            [bitmap setColor:@"black"];
            [obj drawInBitmap:bitmap rect:r2];
        }
        cursorY += rowHeight;
    }
    Int4 r1 = r;
    r1.y = cursorY;
    r1.h = r.h - (cursorY - r.y);
    [bitmap setColor:@"white"];
    [bitmap fillRect:r1];
}
- (void)handleMouseDown:(id)event
{
    [_windowFrame handleMouseDown:event];
}
- (void)handleMouseMoved:(id)event
{
    [_windowFrame handleMouseMoved:event];
}
- (void)handleMouseUp:(id)event
{
    [_windowFrame handleMouseUp:event];
}
@end
