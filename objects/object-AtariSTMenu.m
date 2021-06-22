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

@interface AtariSTMenu : IvarObject
{
    int _hasShadow;
    int _mouseX;
    int _mouseY;
    id _array;
    id _selectedObject;
}
@end

@implementation AtariSTMenu

- (id)init
{
    self = [super init];
    if (self) {
        _hasShadow = 0;
    }
    return self;
}
- (int)preferredWidth
{
    id bitmap = [[[[@"Bitmap" asClass] alloc] initWithWidth:1 height:1] autorelease];
    [bitmap useAtariSTFont];
    int highestWidth = 0;
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        id displayName = [elt valueForKey:@"displayName"];
        if (displayName) {
            int w = [bitmap bitmapWidthForText:displayName];
            if (w > highestWidth) {
                highestWidth = w;
            }
        }
    }
    if (highestWidth) {
        return highestWidth + 8 + 18;
    }
    return 1;
}
- (int)preferredHeight
{
    int h = [_array count]*16;
    if (h) {
        return h;
    }
    return 1;
}

- (void)beginIteration:(id)event rect:(Int4)r
{
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [bitmap setColorIntR:0xff g:0xff b:0xff a:0xff];
    [bitmap fillRect:r];
    [bitmap setColorIntR:0x00 g:0x00 b:0x00 a:0xff];
    [bitmap drawHorizontalLineAtX:r.x x:r.x+r.w-1 y:r.y];
    [bitmap drawHorizontalLineAtX:r.x x:r.x+r.w-1 y:r.y+1];
    [bitmap drawHorizontalLineAtX:r.x x:r.x+r.w-1 y:r.y+r.h-1];
    [bitmap drawHorizontalLineAtX:r.x x:r.x+r.w-1 y:r.y+r.h-2];
    [bitmap drawVerticalLineAtX:r.x y:r.y y:r.y+r.h-1];
    [bitmap drawVerticalLineAtX:r.x+1 y:r.y y:r.y+r.h-1];
    [bitmap drawVerticalLineAtX:r.x+r.w-1 y:r.y y:r.y+r.h-1];
    [bitmap drawVerticalLineAtX:r.x+r.w-2 y:r.y y:r.y+r.h-1];

    r.x += 2;
    r.y += 2;
    r.w -= 4;
    r.h -= 4;

    [bitmap useAtariSTFont];

    [self setValue:nil forKey:@"selectedObject"];
    id arr = _array;
    int numberOfCells = [arr count];
    if (!numberOfCells) {
        return;
    }
    int cellHeight = 16;
    for (int i=0; i<numberOfCells; i++) {
        Int4 cellRect = [Definitions rectWithX:r.x y:r.y+i*cellHeight w:r.w h:cellHeight];
        id elt = [arr nth:i];
        id text = nil;
        id stringFormat = [elt valueForKey:@"stringFormat"];
        if ([stringFormat length]) {
            text = [self str:stringFormat];
        }
        if (!text) {
            text = [elt valueForKey:@"displayName"];
        }
        id messageForClick = [elt valueForKey:@"messageForClick"];
        if ([messageForClick length] && [Definitions isX:_mouseX y:_mouseY insideRect:cellRect]) {
            if ([text length]) {
                [bitmap setColor:@"black"];
                [bitmap fillRect:cellRect];
                [bitmap setColorIntR:0xff g:0xff b:0xff a:0xff];
                [bitmap drawBitmapText:text x:cellRect.x+4+18 y:cellRect.y];
            } else {
                [bitmap setColorIntR:0x00 g:0x00 b:0x00 a:0xff];
                [bitmap drawHorizontalDashedLineAtX:cellRect.x x:cellRect.x+cellRect.w y:cellRect.y+cellRect.h/2 dashLength:1];
            }
            [self setValue:elt forKey:@"selectedObject"];
        } else {
            if ([text length]) {
                if ([messageForClick length]) {
                    [bitmap setColorIntR:0x00 g:0x00 b:0x00 a:0xff];
                    [bitmap drawBitmapText:text x:cellRect.x+4+18 y:cellRect.y];
                } else {
                    [bitmap setColor:@"black"];
                    [bitmap fillRect:cellRect];
                    [bitmap setColorIntR:0xff g:0xff b:0xff a:0xff];
                    [bitmap drawBitmapText:text x:cellRect.x+4+18 y:cellRect.y];
                }
            } else {
                [bitmap setColorIntR:0x00 g:0x00 b:0x00 a:0xff];
                [bitmap drawHorizontalDashedLineAtX:cellRect.x x:cellRect.x+cellRect.w y:cellRect.y+cellRect.h/2 dashLength:1];
            }
        }
    }
}
- (void)handleMouseMoved:(id)event
{
NSLog(@"Menu handleMouseMoved");
    _mouseX = [event intValueForKey:@"mouseX"];
    _mouseY = [event intValueForKey:@"mouseY"];
}

- (void)handleMouseUp:(id)event
{
NSLog(@"Menu handleMouseUp");
    id x11dict = [event valueForKey:@"x11dict"];
    [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
    if (_selectedObject) {
        id message = [_selectedObject valueForKey:@"messageForClick"];
        if (message) {
            [[Definitions namespace]  evaluateMessage:message];
        }
    }
}
- (void)handleRightMouseUp:(id)event
{
    [self handleMouseUp:event];
}
@end

