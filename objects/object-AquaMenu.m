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

@implementation Definitions(jfelwmfkldsmfklmdsklfjiew)
+ (void)drawMenuHorizontalStripesInBitmap:(id)bitmap rect:(Int4)r
{
    [Definitions drawHorizontalStripesInBitmap:bitmap rect:r colors:@"#e5e7ea" :@"#e9ebee"];
}
@end

@interface AquaMenu : IvarObject
{
    int _hasShadow;
    int _closingIteration;
    int _mouseX;
    int _mouseY;
    id _array;
    id _selectedObject;
    id _contextualObject;
}
@end

@implementation AquaMenu

- (void)dealloc
{
NSLog(@"dealloc Menu %@", self);
    [super dealloc];
}

- (int)preferredWidth
{
    int highestWidth = 0;
    int highestRightWidth = 0;
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
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
        return highestWidth + 30 + highestRightWidth + 26;
    }
    if (highestWidth) {
        return highestWidth + 30;
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
            id context = _contextualObject;
            if (!context) {
                context = [Definitions namespace];
            }
            [context evaluateMessage:message];
        }
        [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
    }
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)outerRect
{
[bitmap useWinSystemFont];
    Int4 r = outerRect;
    r.x += 1;
    r.y += 1;
    r.w -= 2;
    r.h -= 2;
    [bitmap setColor:@"#cacaca"];
    [bitmap fillRect:outerRect];
//    [bitmap setColor:@"green"];
//    [bitmap fillRect:r];
    [Definitions drawMenuHorizontalStripesInBitmap:bitmap rect:r];

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
                if (_closingIteration > 0) {
                    if ((_closingIteration/20) % 2 == 1) {
                        [Definitions drawHorizontalStripesInBitmap:bitmap rect:cellRect colors:@"#3165b5" :@"#3063b0"];
                    }
                } else {
                    [Definitions drawHorizontalStripesInBitmap:bitmap rect:cellRect colors:@"#3165b5" :@"#3063b0"];
                }
                [bitmap setColorIntR:255 g:255 b:255 a:255];
                [bitmap drawBitmapText:text x:cellRect.x+20 y:cellRect.y+4];
                if ([rightText length]) {
                    int w = [bitmap bitmapWidthForText:rightText];
                    [bitmap drawBitmapText:rightText x:cellRect.x+cellRect.w-10-w y:cellRect.y+4];
                }
            } else {
                [bitmap setColor:@"#8c8c8c"];
                [bitmap drawHorizontalLineAtX:cellRect.x x:cellRect.x+cellRect.w y:cellRect.y+cellRect.h/2];
            }
            [self setValue:elt forKey:@"selectedObject"];
        } else {
            if ([text length]) {
                if ([messageForClick length]) {
                    [bitmap setColor:@"black"];
                    [bitmap drawBitmapText:text x:cellRect.x+20 y:cellRect.y+4];
                    if ([rightText length]) {
                        int w = [bitmap bitmapWidthForText:rightText];
                        [bitmap drawBitmapText:rightText x:cellRect.x+cellRect.w-10-w y:cellRect.y+4];
                    }
                } else {
                    [bitmap setColor:@"black"];
                    [bitmap fillRect:cellRect];
                    [bitmap setColorIntR:255 g:255 b:255 a:255];
                    [bitmap drawBitmapText:text x:cellRect.x+20 y:cellRect.y+4];
                }
            } else {
                [bitmap setColor:@"#8c8c8c"];
                [bitmap drawHorizontalLineAtX:cellRect.x x:cellRect.x+cellRect.w y:cellRect.y+cellRect.h/2];
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
        _closingIteration = 1;
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

