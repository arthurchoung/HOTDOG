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

@implementation Definitions(mnfklewnfklsdjklfjskdlfj)
+ (id)MailMessage:(id)text :(id)arr
{
    id obj = [@"MailMessage" asInstance];
    [obj setValue:text forKey:@"marginText"];
    [obj setValue:arr forKey:@"array"];
    [obj setValue:@"30" forKey:@"cellHeight"];
    [obj setValue:@"NSArray|addObject:'remoulade-open.pl'|addObject:(selectedObject|path)|addObject:(selectedObject|part)|addObject:(selectedObject|mimeType)|runCommandInBackground" forKey:@"defaultMessageForClick"];
    return obj;
}
@end

@interface MailMessage : IvarObject
{
    id _currentDirectory;
    id _headerFormat;
    id _defaultMessageForClick;
    id _defaultStringFormat;
    id _message;
    id _observer;
    id _dict;
    id _array;
    int _objectOffsetY;
    id _buttonHover;
    id _buttonDown;
    int _index;
    int _viewWidth;
    int _viewHeight;
    int _cellHeight;
    id _selectedObject;
    id _sortMessage;
    id _rightButtonDown;
    id _searchText;
    Int4 _rect;
    time_t _currentDirectoryTimestamp;
    id _marginText;
    int _marginHeight;
}
@end

@implementation MailMessage

- (void)beginIteration:(id)event rect:(Int4)r
{
    if (_currentDirectoryTimestamp) {
        time_t timestamp = [@"." fileModificationTimestamp];
        if (timestamp != _currentDirectoryTimestamp) {
            _currentDirectoryTimestamp = timestamp;
            [self updateFromCurrentDirectory];
        }
    }
}

- (void)updateObjectOffsetY:(int)delta
{
    NSLog(@"viewHeight %d", _viewHeight);
    if (!_viewHeight) {
        return;
    }
    int cellHeight = _cellHeight;
    int numberOfCells = ceil((double)_viewHeight / (double)cellHeight);

    _objectOffsetY+delta;
    if (_objectOffsetY < 0) {
        _objectOffsetY = 0;
    }
    
    id arr = [self valueForKey:@"array"];
    int count = [arr count];
    if (_objectOffsetY > (count-1)*cellHeight) {
        _objectOffsetY = (count-1)*cellHeight;
    }
}

- (void)handlePageUp
{
    int cellHeight = _cellHeight;
    int numberOfCells = ceil(_viewHeight / cellHeight);
    [self updateObjectOffsetY:(numberOfCells-1)*cellHeight];
}
- (void)handlePageDown
{
    int cellHeight = _cellHeight;
    int numberOfCells = ceil(_viewHeight / cellHeight);
    [self updateObjectOffsetY:-(numberOfCells-1)*cellHeight];
}
- (void)handleMoveUp
{
    [self updateObjectOffsetY:_cellHeight];
}
- (void)handleMoveDown
{
    [self updateObjectOffsetY:-_cellHeight];
}
- (void)handleTouchesBegan:(id)event
{
    [event setValue:[event valueForKey:@"touchX"] forKey:@"mouseX"];
    [event setValue:[event valueForKey:@"touchY"] forKey:@"mouseY"];
    [self handleMouseDown:event];
}
- (void)handleTouchesEnded:(id)event
{
    [event setValue:[event valueForKey:@"touchX"] forKey:@"mouseX"];
    [event setValue:[event valueForKey:@"touchY"] forKey:@"mouseY"];
    [self handleMouseUp:event];
}
- (void)handleTouchesMoved:(id)event
{
    [event setValue:[event valueForKey:@"touchX"] forKey:@"mouseX"];
    [event setValue:[event valueForKey:@"touchY"] forKey:@"mouseY"];
    [self handleMouseMoved:event];
}
- (void)handleTouchesCancelled:(id)event
{
    [self handleTouchesEnded:event];
}


- (id)buttonForMousePosEvent:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];

    if (mouseX < _rect.x) {
        return nil;
    }
    if (mouseX >= _rect.x+_rect.w) {
        return nil;
    }
    if (mouseY < _rect.y) {
        return nil;
    }
    if (mouseY >= _rect.y+_rect.h) {
        return nil;
    }
    
    int cellHeight = _cellHeight;
    int y = _objectOffsetY - _marginHeight + mouseY - _rect.y;
    if (y < 0) {
        return nil;
    }
    int n = y / cellHeight;
    
    return nsfmt(@"%d", n);
}

- (void)handleScrollTouch:(id)event
{
    [self handleScrollWheel:event];
}

- (void)handleScrollWheel:(id)event
{
    _objectOffsetY -= [event intValueForKey:@"deltaY"];
    if (_objectOffsetY < 0) {
        _objectOffsetY = 0;
    }
    
    int cellHeight = _cellHeight;
    int numberOfCells = ceil([event intValueForKey:@"viewHeight"] / cellHeight);
    id arr = [self valueForKey:@"array"];
    int count = [arr count];
    if (_objectOffsetY > (count-1)*cellHeight+_marginHeight) {
        _objectOffsetY = (count-1)*cellHeight+_marginHeight;
    }
    [self handleMouseMoved:event];
}

- (void)handleMouseDown:(id)event
{
    [self setValue:[self buttonForMousePosEvent:event] forKey:@"buttonDown"];
}

- (void)handleRightMouseDown:(id)event
{
    [self setValue:[self buttonForMousePosEvent:event] forKey:@"rightButtonDown"];
}
- (void)handleMouseUp:(id)event
{
    id buttonDown = [self valueForKey:@"buttonDown"];
    id buttonHover = [self valueForKey:@"buttonHover"];
    [self setValue:nil forKey:@"buttonDown"];
    if ([buttonDown isEqual:buttonHover]) {
        if ([buttonDown isInt]) {
            NSLog(@"handleClick:%@", buttonDown);
            id arr = [self valueForKey:@"array"];
            id elt = [arr nth:[buttonDown intValue]];
            if (!elt) {
                return;
            }
            id messageForClick = [elt valueForKey:@"messageForClick"];
NSLog(@"messageForClick '%@'", messageForClick);
            if (!messageForClick) {
                messageForClick = _defaultMessageForClick;
            }
            if (messageForClick) {
                _index = [buttonDown intValue];
                [self setValue:elt forKey:@"selectedObject"];
                id result = [self evaluateMessage:messageForClick];
                if ([elt intValueForKey:@"drawChevron" default:0]) {
                    [result pushToMainInterface];
                }
                NSLog(@"result %@", result);
            }
        }
    }
}

- (void)handleRightMouseUp:(id)event
{
    id rightButtonDown = [self valueForKey:@"rightButtonDown"];
    id buttonHover = [self valueForKey:@"buttonHover"];
NSLog(@"rightMouseUp %@", rightButtonDown);
    [self setValue:nil forKey:@"rightButtonDown"];
    if ([rightButtonDown isEqual:buttonHover]) {
        NSLog(@"handleRightClick:%@", rightButtonDown);
        id arr = [self valueForKey:@"array"];
        if ([rightButtonDown isInt]) {
            id elt = [arr nth:[rightButtonDown intValue]];
            if (!elt) {
                return;
            }
            [self setValue:elt forKey:@"selectedObject"];
            id rightClickMenu = [[[Definitions configDir:@"Config/rightClickMenu.csv"] menuFromPath] asListInterface];
NSLog(@"rightClickMenu %@", rightClickMenu);
            [rightClickMenu pushToMainInterface];
        }
    }
}

- (void)handleMouseMoved:(id)event
{
    [self setValue:[self buttonForMousePosEvent:event] forKey:@"buttonHover"];
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [bitmap useWinSystemFont];
    _rect = r;
    _viewWidth = r.w;
    _viewHeight = r.h;
    [bitmap setColor:@"white"];
//[bitmap setColor:@"#b1b2ac"];
    [bitmap fillRect:r];
    [bitmap setColor:@"black"];
    if (_marginText) {
        id text = [bitmap fitBitmapString:_marginText width:r.w-8];
        _marginHeight = [bitmap bitmapHeightForText:text]+8;
        [bitmap drawBitmapText:text x:4 y:r.y+4-_objectOffsetY];
        [bitmap drawHorizontalLineAtX:r.x x:r.x+r.w y:r.y-_objectOffsetY+_marginHeight];
    }
r = [Definitions rectWithPadding:r w:-4 h:0];
    [self drawArray:[self valueForKey:@"array"] inBitmap:bitmap rect:r];
}

- (void)drawArray:(id)arr inBitmap:(id)bitmap rect:(Int4)rect
{
    id context = self;
    
    int numberOfElements = [arr count];

    int index = (_objectOffsetY-_marginHeight)/_cellHeight - 1;
    if (index < 0) {
        index = 0;
    }

    for (;;) {
        int cellY = index*_cellHeight + _marginHeight - _objectOffsetY;
        if (cellY >= rect.h) {
            break;
        }

        if (cellY + _cellHeight < 0) {
            goto next;
        }

        id elt = [arr nth:index];
        if (!elt) {
            goto next;
        }
        
        
        id style = @"";
        if ([[context valueForKey:@"buttonHover"] isInt]) {
            if ([context intValueForKey:@"buttonHover"] == index) {
                if ([[context valueForKey:@"buttonDown"] isInt]) {
                    if ([context intValueForKey:@"buttonDown"] == index) {
                        style = @"selected";
                    }
                } else if ([[context valueForKey:@"buttonDown"] isKindOfClass:[NSString class]]) {
                } else {
                    style = @"highlighted";
                }
            }
        }
        [bitmap setColorIntR:0 g:0 b:0 a:255];
        [context drawElement:elt inBitmap:bitmap rect:[Definitions rectWithX:rect.x y:rect.y+cellY w:rect.w h:_cellHeight] style:style];

next:
        index++;
    }
}
- (void)drawElement:(id)elt inBitmap:(id)bitmap rect:(Int4)r style:(id)style
{
    char *palette = "";
    id fgcolor = nil;
    id bgcolor = nil;
    if ([style isEqual:@"selected"]) {
        palette = ". #0000ff\nb #000000\n";
        fgcolor = @"white";
        bgcolor = @"blue";
    } else if ([style isEqual:@"highlighted"]) {
        palette = ". #000000\nb #000000\n";
        fgcolor = @"white";
        bgcolor = @"black";
    } else {
        palette = ". #ffffff\nb #000000\n";
        fgcolor = @"black";
        bgcolor = @"white";
    }

//    [bitmap setColor:bgcolor];
//    [bitmap fillRect:r];
    [Definitions drawButtonInBitmap:bitmap rect:r palette:palette];
    [bitmap setColor:fgcolor];
    [bitmap drawBitmapText:nsfmt(@"%@", elt) leftAlignedInRect:r];
}

@end

