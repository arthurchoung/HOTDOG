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
    int _closingIteration;
    int _mouseX;
    int _mouseY;
    id _array;
    id _selectedObject;
    id _contextualObject;
    int _scrollY;

    int _pixelScaling;
    id _scaledFont;

    int _unmapInsteadOfClose;
    id _title;
}
@end

@implementation AquaMenu

- (void)dealloc
{
NSLog(@"dealloc Menu %@", self);
    [super dealloc];
}
- (id)init
{
    self = [super init];
    if (self) {
        int scaling = [[Definitions valueForEnvironmentVariable:@"HOTDOG_SCALING"] intValue];
        if (scaling < 1) {
            scaling = 1;
        }
        _pixelScaling = scaling;

        id obj;
        obj = [Definitions scaleFont:scaling
                        :[Definitions arrayOfCStringsForWinSystemFont]
                        :[Definitions arrayOfWidthsForWinSystemFont]
                        :[Definitions arrayOfHeightsForWinSystemFont]
                        :[Definitions arrayOfXSpacingsForWinSystemFont]];
        [self setValue:obj forKey:@"scaledFont"];
    }
    return self;
}

- (void)useFixedWidthFont
{
    id obj = [Definitions scaleFont:_pixelScaling
                    :[Definitions arrayOfCStringsForAtariSTFont]
                    :[Definitions arrayOfWidthsForAtariSTFont]
                    :[Definitions arrayOfHeightsForAtariSTFont]
                    :[Definitions arrayOfXSpacingsForAtariSTFont]];
    [self setValue:obj forKey:@"scaledFont"];
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
            if (_contextualObject) {
                text = [_contextualObject str:stringFormat];
            } else {
                text = [elt str:stringFormat];
            }
        }
        if (![text length]) {
            text = [elt valueForKey:@"displayName"];
        }
        if ([text length]) {
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
        return highestWidth + 30*_pixelScaling + highestRightWidth + 26*_pixelScaling;
    }
    if (highestWidth) {
        return highestWidth + 30*_pixelScaling;
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

- (BOOL)shouldAnimate
{
    if (_closingIteration > 0) {
        return YES;
    }
    return NO;
}

- (void)beginIteration:(id)event rect:(Int4)r
{
NSLog(@"AquaMenu beginIteration %d", _closingIteration);
    if (_closingIteration < 1) {
        return;
    }
    _closingIteration--;
    id x11dict = [event valueForKey:@"x11dict"];
    if (_closingIteration < 2) {
        _closingIteration = 0;
        id message = [_selectedObject valueForKey:@"messageForClick"];
        if (message) {
            id context = _contextualObject;
            if (!context) {
                context = _selectedObject;
            }
            [context evaluateMessage:message];
        }
        if (_unmapInsteadOfClose) {
            id windowManager = [@"windowManager" valueForKey];
            id window = [x11dict valueForKey:@"window"];
            if (window) {
                [windowManager XUnmapWindow:[window unsignedLongValue]];
            }
        } else {
            [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
        }
    }
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)outerRect
{
    if (_scaledFont) {
        [bitmap useFont:[[_scaledFont nth:0] bytes]
                    :[[_scaledFont nth:1] bytes]
                    :[[_scaledFont nth:2] bytes]
                    :[[_scaledFont nth:3] bytes]];
    }

//FIXME pixelScaling
    Int4 origRect = outerRect;
outerRect.y -= _scrollY;
    Int4 r = outerRect;
    r.x += 1;
    r.y += 1;
    r.w -= 2;
    r.h -= 2;
    [bitmap setColor:@"#cacaca"];
    [bitmap fillRect:outerRect];
//    [bitmap setColor:@"green"];
//    [bitmap fillRect:r];
    [Definitions drawMenuHorizontalStripesInBitmap:bitmap rect:origRect];

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
            if (_contextualObject) {
                text = [_contextualObject str:stringFormat];
            } else {
                text = [elt str:stringFormat];
            }
        }
        if (![text length]) {
            text = [elt valueForKey:@"displayName"];
        }
        id rightText = [elt valueForKey:@"hotKey"];
        id messageForClick = [elt valueForKey:@"messageForClick"];
        if ([messageForClick length] && [Definitions isX:_mouseX y:_mouseY insideRect:origRect] && [Definitions isX:_mouseX y:_mouseY insideRect:cellRect]) {
            if ([text length]) {
                if (_closingIteration > 0) {
                    if ((_closingIteration/15) % 2 == 1) {
                        [Definitions drawHorizontalStripesInBitmap:bitmap rect:cellRect colors:@"#3165b5" :@"#3063b0"];
                    }
                } else {
                    [Definitions drawHorizontalStripesInBitmap:bitmap rect:cellRect colors:@"#3165b5" :@"#3063b0"];
                }
                [bitmap setColorIntR:255 g:255 b:255 a:255];
                [bitmap drawBitmapText:text x:cellRect.x+20*_pixelScaling y:cellRect.y+4*_pixelScaling];
                if ([rightText length]) {
                    int w = [bitmap bitmapWidthForText:rightText];
                    [bitmap drawBitmapText:rightText x:cellRect.x+cellRect.w-w-10*_pixelScaling y:cellRect.y+4*_pixelScaling];
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
                    [bitmap drawBitmapText:text x:cellRect.x+20*_pixelScaling y:cellRect.y+4*_pixelScaling];
                    if ([rightText length]) {
                        int w = [bitmap bitmapWidthForText:rightText];
                        [bitmap drawBitmapText:rightText x:cellRect.x+cellRect.w-w-10*_pixelScaling y:cellRect.y+4*_pixelScaling];
                    }
                } else {
                    [bitmap setColor:@"black"];
                    [bitmap fillRect:cellRect];
                    [bitmap setColorIntR:255 g:255 b:255 a:255];
                    [bitmap drawBitmapText:text x:cellRect.x+20*_pixelScaling y:cellRect.y+4*_pixelScaling];
                }
            } else {
                [bitmap setColor:@"#8c8c8c"];
                [bitmap drawHorizontalLineAtX:cellRect.x x:cellRect.x+cellRect.w y:cellRect.y+cellRect.h/2];
            }
        }
    }
}
- (void)handleKeyDown:(id)event
{
NSLog(@"AquaMenu handleKeyDown");
    if (_closingIteration > 0) {
        return;
    }
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
NSLog(@"AquaMenu handleScrollWheel");
    if (_closingIteration > 0) {
        return;
    }
    int dy = [event intValueForKey:@"scrollingDeltaY"];
NSLog(@"dy %d", dy);
    _scrollY += dy;
}

- (void)handleMouseMoved:(id)event
{
//NSLog(@"AquaMenu handleMouseMoved");
    if (_closingIteration > 0) {
        return;
    }
    _mouseX = [event intValueForKey:@"mouseX"];
    _mouseY = [event intValueForKey:@"mouseY"];
}

- (void)handleMouseUp:(id)event
{
NSLog(@"AquaMenu handleMouseUp");
    if (_closingIteration > 0) {
        return;
    }
    int mouseRootY = [event intValueForKey:@"mouseRootY"];
    if (mouseRootY == -1) {
        [self setValue:nil forKey:@"selectedObject"];
    }
    if (_selectedObject) {
        _closingIteration = 120;//90
    } else {
        if (_unmapInsteadOfClose) {
            id windowManager = [@"windowManager" valueForKey];
            id x11dict = [event valueForKey:@"x11dict"];
            id window = [x11dict valueForKey:@"window"];
            if (window) {
                [windowManager XUnmapWindow:[window unsignedLongValue]];
            }
        } else { 
            id x11dict = [event valueForKey:@"x11dict"];
            [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
        }
    }
}
- (void)handleRightMouseUp:(id)event
{
    [self handleMouseUp:event];
}
@end

