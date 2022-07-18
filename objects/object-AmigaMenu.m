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

@interface AmigaMenu : IvarObject
{
    int _hasShadow;
    int _mouseX;
    int _mouseY;
    id _array;
    id _selectedObject;
    id _contextualObject;
    int _scrollY;

    int _pixelScaling;
    id _scaledFont;
}
@end

@implementation AmigaMenu

- (id)init
{
    self = [super init];
    if (self) {
        _hasShadow = 0;

        int scaling = [[Definitions valueForEnvironmentVariable:@"HOTDOG_SCALING"] intValue];
        if (scaling < 1) {
            scaling = 1;
        }
        _pixelScaling = scaling;

        id obj;
        obj = [Definitions scaleFont:scaling
                        :[Definitions arrayOfCStringsForTopazFont]
                        :[Definitions arrayOfWidthsForTopazFont]
                        :[Definitions arrayOfHeightsForTopazFont]
                        :[Definitions arrayOfXSpacingsForTopazFont]];
        [self setValue:obj forKey:@"scaledFont"];
    }
    return self;
}
- (int)preferredWidth
{
    id bitmap = [Definitions bitmapWithWidth:1 height:1];
    if (_scaledFont) {
        [bitmap useFont:[[_scaledFont nth:0] bytes]
                    :[[_scaledFont nth:1] bytes]
                    :[[_scaledFont nth:2] bytes]
                    :[[_scaledFont nth:3] bytes]];
    }

    int highestWidth = 0;
    int highestRightWidth = 0;
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        id text = nil;
        id stringFormat = [elt valueForKey:@"stringFormat"];
        if (stringFormat) {
            text = [self str:stringFormat];
        }
        if (!text) {
            text = [elt valueForKey:@"displayName"];
        }
        if (text) {
            int w = [bitmap bitmapWidthForText:text];
            if (w > highestWidth) {
                highestWidth = w;
            }
        }
        id hotKey = [elt valueForKey:@"hotKey"];
        if (hotKey) {
            int w = [bitmap bitmapWidthForText:hotKey];
            if (w > highestRightWidth) {
                highestRightWidth = w;
            }
        }
    }
    if (highestWidth && highestRightWidth) {
        return highestWidth + 8*_pixelScaling + highestRightWidth + 26*_pixelScaling;
    }
    if (highestWidth) {
        return highestWidth + 8*_pixelScaling;
    }
    return 1;
}
- (int)preferredHeight
{
    int h = [_array count]*20*_pixelScaling;
    if (h) {
        return h;
    }
    return 1;
}

- (void)beginIteration:(id)event rect:(Int4)r
{
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)outerRect
{
    if (_scaledFont) {
        [bitmap useFont:[[_scaledFont nth:0] bytes]
                    :[[_scaledFont nth:1] bytes]
                    :[[_scaledFont nth:2] bytes]
                    :[[_scaledFont nth:3] bytes]];
    }

    Int4 origRect = outerRect;
    outerRect.y -= _scrollY;
    Int4 r = outerRect;
    r.x += 1;
    r.y += 1;
    r.w -= 2;
    r.h -= 2;
    [bitmap setColorIntR:0x00 g:0x55 b:0xaa a:0xff];
    [bitmap fillRect:origRect];
    [bitmap setColor:@"white"];
    for (int i=0; i<r.h; i++) {
        [bitmap drawHorizontalLineAtX:r.x x:r.x+r.w-1 y:r.y+i];
    }

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
        Int4 r2 = cellRect;
        r2.x += 2;
        r2.w -= 4;
        id messageForClick = [elt valueForKey:@"messageForClick"];
        if ([messageForClick length] && [Definitions isX:_mouseX y:_mouseY insideRect:origRect] && [Definitions isX:_mouseX y:_mouseY insideRect:cellRect]) {
            if ([text length]) {
                [bitmap setColor:@"black"];
                [bitmap fillRect:r2];
                [bitmap setColorIntR:0xff g:0x88 b:0x00 a:0xff];
                [bitmap drawBitmapText:text x:r2.x+4*_pixelScaling y:r2.y+4*_pixelScaling];
                if ([rightText length]) {
                    int w = [bitmap bitmapWidthForText:rightText];
                    [bitmap drawBitmapText:rightText x:cellRect.x+cellRect.w-w-4*_pixelScaling y:cellRect.y+4*_pixelScaling];
                }
            } else {
                [bitmap setColorIntR:0x00 g:0x55 b:0xaa a:0xff];
                [bitmap drawHorizontalDashedLineAtX:r2.x x:r2.x+r2.w y:r2.y+r2.h/2 dashLength:1];
            }
            [self setValue:elt forKey:@"selectedObject"];
        } else {
            if ([text length]) {
                if ([messageForClick length]) {
                    [bitmap setColorIntR:0x00 g:0x55 b:0xaa a:0xff];
                    [bitmap drawBitmapText:text x:r2.x+4*_pixelScaling y:r2.y+4*_pixelScaling];
                    if ([rightText length]) {
                        int w = [bitmap bitmapWidthForText:rightText];
                        [bitmap drawBitmapText:rightText x:cellRect.x+cellRect.w-w-4*_pixelScaling y:cellRect.y+4*_pixelScaling];
                    }
                } else {
                    [bitmap setColor:@"black"];
                    [bitmap fillRect:r2];
                    [bitmap setColorIntR:0xff g:0x88 b:0x00 a:0xff];
                    [bitmap drawBitmapText:text x:r2.x+4*_pixelScaling y:r2.y+4*_pixelScaling];
                }
            } else {
                [bitmap setColorIntR:0x00 g:0x55 b:0xaa a:0xff];
                [bitmap drawHorizontalDashedLineAtX:r2.x x:r2.x+r2.w y:r2.y+r2.h/2 dashLength:1];
            }
        }
    }
}
- (void)handleKeyDown:(id)event
{
NSLog(@"AmigaMenu handleKeyDown");
    id keyString = [event valueForKey:@"keyString"];
NSLog(@"keyString %@", keyString);
    if ([keyString isEqual:@"up"]) {
        _scrollY -= 20;
    } else if ([keyString isEqual:@"down"]) {
        _scrollY += 20;
    }
}
- (void)handleScrollWheel:(id)event
{
NSLog(@"AmigaMenu handleScrollWheel");
    int dy = [event intValueForKey:@"scrollingDeltaY"];
NSLog(@"dy %d", dy);
    _scrollY += dy;
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
            id context = _contextualObject;
            if (!context) {
                context = [Definitions namespace];
            }
            [context  evaluateMessage:message];
        }
    }
}
- (void)handleRightMouseUp:(id)event
{
    [self handleMouseUp:event];
}
@end

