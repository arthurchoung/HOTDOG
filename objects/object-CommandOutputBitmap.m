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

#include <sys/time.h>

@implementation Definitions(fjkdlsfjlksdjdskfldsjkfljkf)
+ (id)CommandOutputBitmap:(id)cmd
{
    id process = [cmd runCommandAndReturnProcess];
    id obj = [@"CommandOutputBitmap" asInstance];
    [obj setValue:process forKey:@"fileDescriptor"];
    return obj;
}
@end

@interface CommandOutputBitmap : IvarObject
{
    id _fileDescriptor;
    id _firstLine;
    id _pixels;
    id _palette;
    id _highlightedPalette;
    id _messageForDoubleClick;
    id _messageForDragAndDrop;

    BOOL _buttonDown;
    int _buttonDownX;
    int _buttonDownY;
    int _buttonDownRootX;
    int _buttonDownRootY;
}
@end
@implementation CommandOutputBitmap
- (int)fileDescriptor
{
    if (_fileDescriptor) {
        return [_fileDescriptor fileDescriptor];
    }
    return -1;
}
- (void)handleData:(id)data
{
    for(;;) {
        if (!_firstLine) {
            id line = [data readLine];
            if (!line) {
                break;
            }
            line = [line chomp];
            if (![line length]) {
                continue;
            }
            [self setValue:line forKey:@"firstLine"];
        } else {
            id lines = [data readGroupOfLines];
            if (!lines) {
                break;
            }
            id arr = @[ @"pixels", @"palette", @"highlightedPalette", @"messageForDoubleClick", @"messageForDragAndDrop" ];
            if ([arr containsObject:_firstLine]) {
                [self setValue:lines forKey:_firstLine];
                [self setValue:nil forKey:@"firstLine"];
            }
        }
    }
}
- (void)handleFileDescriptor
{
    if (_fileDescriptor) {
        [_fileDescriptor handleFileDescriptor];
        [self handleData:[_fileDescriptor valueForKey:@"data"]];
    }
}
- (int)preferredWidth
{
    int len = [[[_pixels split:@"\n"] nth:0] length];
    if (!len) {
        return 200;
    }
    return len;
}
- (int)preferredHeight
{
    int len = [[_pixels split:@"\n"] count];
    if (!len) {
        return 200;
    }
    return len;
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [self drawInBitmap:bitmap rect:r context:nil];
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r context:(id)context
{
    if ([context valueForKey:@"selectedTimestamp"]) {
        [self drawHighlightedInBitmap:bitmap rect:r];
        return;
    }
    if (!_pixels || !_palette) {
        return;
    }
    [bitmap drawCString:[_pixels UTF8String] palette:[_palette UTF8String] x:r.x y:r.y];
}
- (void)drawHighlightedInBitmap:(id)bitmap rect:(Int4)r
{
    if (!_pixels) {
        return;
    }

    if (!_highlightedPalette) {
        [self drawInBitmap:bitmap rect:r];
        return;
    }

    [bitmap drawCString:[_pixels UTF8String] palette:[_highlightedPalette UTF8String] x:r.x y:r.y];
}
- (void)handleMouseDown:(id)event
{
NSLog(@"CommandOutputBitmap handleMouseDown");
    id windowManager = [event valueForKey:@"windowManager"];
    id x11dict = [event valueForKey:@"x11dict"];
    [windowManager setInputFocus:nil];
    _buttonDown = YES;
    _buttonDownX = [event intValueForKey:@"mouseX"];
    _buttonDownY = [event intValueForKey:@"mouseY"];
    _buttonDownRootX = [event intValueForKey:@"mouseRootX"];
    _buttonDownRootY = [event intValueForKey:@"mouseRootY"];
    [windowManager raiseObjectWindow:x11dict];
    [x11dict setValue:[x11dict valueForKey:@"x"] forKey:@"beforeDragX"];
    [x11dict setValue:[x11dict valueForKey:@"y"] forKey:@"beforeDragY"];
}
- (void)handleMouseMoved:(id)event
{
    if (!_buttonDown) {
        return;
    }
    id windowManager = [event valueForKey:@"windowManager"];
    int menuBarHeight = [windowManager intValueForKey:@"menuBarHeight"];
    int mouseRootX = [event intValueForKey:@"mouseRootX"];
    int mouseRootY = [event intValueForKey:@"mouseRootY"];
    id x11dict = [event valueForKey:@"x11dict"];

    int newX = mouseRootX - _buttonDownX;
    if (newX < -1) {
        newX = -1;
    }
    int newY = mouseRootY - _buttonDownY;
    if (newY < 0) {
        newY = 0;
    }
    id monitor = [Definitions monitorForX:newX y:newY];
    int maxY = [monitor intValueForKey:@"height"] - 19;
    if (newY < menuBarHeight) {
        newY = menuBarHeight;
    }
    if (newY > maxY) {
        newY = maxY;
    }
    [x11dict setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];
}
- (void)handleMouseUp:(id)event
{
    if (!_buttonDown) {
        return;
    }
    _buttonDown = NO;
    int mouseRootX = [event intValueForKey:@"mouseRootX"];
    int mouseRootY = [event intValueForKey:@"mouseRootY"];
    id windowManager = [event valueForKey:@"windowManager"];
    id x11dict = [event valueForKey:@"x11dict"];
    unsigned long window = [x11dict unsignedLongValueForKey:@"window"];
    [x11dict setValue:@"1" forKey:@"needsRedraw"];
/*
    unsigned long underneathWindow = [windowManager topMostWindowUnderneathWindow:window x:mouseRootX y:mouseRootY];
    if (underneathWindow) {
        id underneathDict = [windowManager dictForObjectWindow:underneathWindow];
        id object = [underneathDict valueForKey:@"object"];
[nsfmt(@"drag and drop underneathDict %@ x11dict %@", underneathDict, x11dict) showAlert];
        if ([object respondsToSelector:@selector(handleDragAndDrop::)]) {
            [object handleDragAndDrop:x11dict :underneathDict];
        } else {
            id messageForDragAndDrop = [object valueForKey:@"messageForDragAndDrop"];
            if (messageForDragAndDrop) {
                [@{} evaluateMessage:messageForDragAndDrop];
            }
        }
    }
*/
    id xNumber = [x11dict valueForKey:@"x"];
    id yNumber = [x11dict valueForKey:@"y"];
    id beforeDragXNumber = [x11dict valueForKey:@"beforeDragX"];
    id beforeDragYNumber = [x11dict valueForKey:@"beforeDragY"];
    if ([xNumber isEqual:beforeDragXNumber]) {
        if ([yNumber isEqual:beforeDragYNumber]) {
            struct timeval tv;
            gettimeofday(&tv, NULL);
            id timestamp = nsfmt(@"%ld.%06ld", tv.tv_sec, tv.tv_usec);

            id selectedTimestamp = [x11dict valueForKey:@"selectedTimestamp"];
            if (selectedTimestamp) {
                if ([timestamp doubleValue]-[selectedTimestamp doubleValue] <= 0.3) {
                    if ([_messageForDoubleClick length]) {
                        [@{} evaluateMessage:_messageForDoubleClick];
                    } else {
                        [@"doubleClick" showAlert];
                    }
                }
            }
            if (0/*e->state & ShiftMask*/) {
                selectedTimestamp = (selectedTimestamp) ? nil : timestamp;
                [x11dict setValue:selectedTimestamp forKey:@"selectedTimestamp"];
                [x11dict setValue:@"1" forKey:@"needsRedraw"];
            } else {
                id objectWindows = [windowManager valueForKey:@"objectWindows"];
                for (id elt in objectWindows) {
                    if (![elt intValueForKey:@"isIcon"]) {
                        continue;
                    }
                    if ([elt valueForKey:@"selectedTimestamp"]) {
                        [elt setValue:nil forKey:@"selectedTimestamp"];
                        [elt setValue:@"1" forKey:@"needsRedraw"];
                    }
                }
                selectedTimestamp = timestamp;
                [x11dict setValue:selectedTimestamp forKey:@"selectedTimestamp"];
                [x11dict setValue:@"1" forKey:@"needsRedraw"];
            }
        }
    }
}
@end
