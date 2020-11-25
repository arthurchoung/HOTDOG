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

@implementation NSArray(jfkdlsjflksdjkf)
- (id)asMenu
{
    id className = @"Menu";
    id windowManager = [@"windowManager" valueForKey];
    id windowClassName = [windowManager valueForKey:@"reparentClassName"];
    if ([windowClassName isEqual:@"AmigaWindow"]) {
        className = @"AmigaMenu";
    } else if ([windowClassName isEqual:@"HotDogStandWindow"]) {
        className = @"HotDogStandMenu";
    } else if ([windowClassName isEqual:@"AtariSTWindow"]) {
        className = @"AtariSTMenu";
    }
    id menu = [className asInstance];
    [menu setValue:self forKey:@"array"];
    [menu setValue:[@"windowManager" valueForKey] forKey:@"contextualObject"];
    return menu;
}
@end

@interface Menu : IvarObject
{
    int _hasShadow;
    int _closingIteration;
    int _mouseX;
    int _mouseY;
    id _array;
    id _selectedObject;
}
@end

@implementation Menu

- (void)dealloc
{
NSLog(@"dealloc Menu %@", self);
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        _hasShadow = 1;
    }
    return self;
}
- (int)preferredWidth
{
    int highestWidth = 0;
    int highestRightWidth = 0;
    for (id elt in _array) {
        id displayName = [elt valueForKey:@"displayName"];
        if (displayName) {
            int w = [Definitions bitmapWidthForText:displayName];
            if (w > highestWidth) {
                highestWidth = w;
            }
        }
        id hotKey = [elt valueForKey:@"hotKey"];
        if (hotKey) {
            int w = [Definitions bitmapWidthForText:hotKey];
            if (w > highestRightWidth) {
                highestRightWidth = w;
            }
        }
    }
    if (highestWidth && highestRightWidth) {
        return highestWidth + 8 + highestRightWidth + 26;
    }
    if (highestWidth) {
        return highestWidth + 8;
    }
    return 1;
}
- (int)preferredHeight
{
    int h = [_array count]*20;
    if (h) {
        return h;
    }
    return 1;
}

- (BOOL)shouldAnimate
{
    if (_closingIteration) {
        return YES;
    }
    return NO;
}

- (void)beginIteration:(id)event rect:(Int4)r
{
    if (_closingIteration < 1) {
        return;
    }
    _closingIteration--;
    id x11dict = [event valueForKey:@"x11dict"];
    if (_closingIteration == 0) {
        id message = [_selectedObject valueForKey:@"messageForClick"];
        if (message) {
            [x11dict evaluateMessage:message];
        }
        [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
    }
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)outerRect
{
    Int4 r = outerRect;
    r.x += 1;
    r.y += 1;
    r.w -= 3;
    r.h -= 3;
    [bitmap setColor:@"black"];
    [bitmap fillRect:outerRect];
    [bitmap setColor:@"white"];
    [bitmap fillRect:r];

    [self setValue:nil forKey:@"selectedObject"];
    id arr = _array;
    int numberOfCells = [arr count];
    if (!numberOfCells) {
        return;
    }
    int cellHeight = r.h / numberOfCells;
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
        id rightText = [elt valueForKey:@"hotKey"];
        id messageForClick = [elt valueForKey:@"messageForClick"];
        if ([messageForClick length] && [Definitions isX:_mouseX y:_mouseY insideRect:cellRect]) {
            if ([text length]) {
                if (_closingIteration) {
                    if ((_closingIteration/20) % 2 == 0) {
                        [bitmap setColor:@"black"];
                        [bitmap fillRect:cellRect];
                    }
                } else {
                    [bitmap setColor:@"blue"];
                    [bitmap fillRect:cellRect];
                }
                [bitmap setColorIntR:255 g:255 b:255 a:255];
                [bitmap drawBitmapText:text x:cellRect.x+4 y:cellRect.y+4];
                if ([rightText length]) {
                    int w = [bitmap bitmapWidthForText:rightText];
                    [bitmap drawBitmapText:rightText x:cellRect.x+cellRect.w-4-w y:cellRect.y+4];
                }
            } else {
                [bitmap setColor:@"black"];
                [bitmap drawHorizontalDashedLineX:cellRect.x x:cellRect.x+cellRect.w y:cellRect.y+cellRect.h/2 dashLength:1];
            }
            [self setValue:elt forKey:@"selectedObject"];
        } else {
            if ([text length]) {
                if ([messageForClick length]) {
                    [bitmap setColor:@"black"];
                    [bitmap drawBitmapText:text x:cellRect.x+4 y:cellRect.y+4];
                    if ([rightText length]) {
                        int w = [bitmap bitmapWidthForText:rightText];
                        [bitmap drawBitmapText:rightText x:cellRect.x+cellRect.w-4-w y:cellRect.y+4];
                    }
                } else {
                    [bitmap setColor:@"black"];
                    [bitmap fillRect:cellRect];
                    [bitmap setColorIntR:255 g:255 b:255 a:255];
                    [bitmap drawBitmapText:text x:cellRect.x+4 y:cellRect.y+4];
                }
            } else {
                [bitmap setColor:@"black"];
                [bitmap drawHorizontalDashedLineX:cellRect.x x:cellRect.x+cellRect.w y:cellRect.y+cellRect.h/2 dashLength:1];
            }
        }
    }
}
- (void)handleMouseMoved:(id)event
{
NSLog(@"Menu handleMouseMoved");
    if (_closingIteration) {
        return;
    }
    _mouseX = [event intValueForKey:@"mouseX"];
    _mouseY = [event intValueForKey:@"mouseY"];
}

- (void)handleMouseUp:(id)event
{
NSLog(@"Menu handleMouseUp");
    if (_closingIteration) {
        return;
    }
    if (_selectedObject) {
        _closingIteration = 90;
    } else {
        id x11dict = [event valueForKey:@"x11dict"];
        [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
    }
}
- (void)handleRightMouseUp:(id)event
{
    [self handleMouseUp:event];
}
@end

