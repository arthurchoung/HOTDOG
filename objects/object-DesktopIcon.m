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

@implementation NSString(fekwlfmkdlsmfklsd)
- (id)iconFromFile
{
    id data = [self dataFromFile];
    if (![data length]) {
        return nil;
    }
    [data appendBytes:"\n\n" length:2];
    id icon = [@"DesktopIcon" asInstance];
    id fileDict = nsdict();
    [icon setValue:fileDict forKey:@"fileDict"];

    for(;;) {
        id lines = [data readGroupOfLines];
        if (!lines) {
            break;
        }
        id tokens = [lines split:@"\n" maxTokens:2];
        id key = [tokens nth:0];
        id val = [[tokens nth:1] chomp];
        if ([key length]) {
            [fileDict setValue:val forKey:key];
        }
    }
    return icon;
}
@end



@interface DesktopIcon : IvarObject
{
    BOOL _buttonDown;
    int _buttonDownX;
    int _buttonDownY;
    int _buttonDownRootX;
    int _buttonDownRootY;

    int _backgroundClock;

    id _fileDict;
    id _dragObject;
    id _state;
    id _bitmap;
    id _userObject;
}
@end
@implementation DesktopIcon

- (void)handleBackgroundUpdate:(id)event
{
    if (_backgroundClock > 0) {
        _backgroundClock--;
        id messageKey = nsfmt(@"backgroundClockMessage%d", _backgroundClock);
        id message = [_fileDict valueForKey:messageKey];
        if (message) {
            id x11dict = [event valueForKey:@"x11dict"];
            [x11dict evaluateMessage:message];
            [x11dict setValue:@"1" forKey:@"needsRedraw"];
        }
    }
}
- (int)preferredWidth
{
    id pixels = [self currentPixels];
    int len = [[[pixels split:@"\n"] nth:0] length];
    if (!len) {
        return 200;
    }
    return len;
}
- (int)preferredHeight
{
    id pixels = [self currentPixels];
    int len = [[pixels split:@"\n"] count];
    if (!len) {
        return 200;
    }
    return len;
}
- (void)setBackgroundClock:(int)val
{
    if (val > 0) {
        _backgroundClock = val;
    } else {
        _backgroundClock = 0;
    }
}
- (void)setState:(id)state
{
    if ([self isValidState:state]) {
        [self setValue:state forKey:@"state"];
    }
}
- (id)currentState
{
    if (!_state) {
        return @"";
    }
    return _state;
}
- (id)pixelsForState:(id)state
{
    id pixelsKey = @"pixels";
    if ([state length]) {
        pixelsKey = nsfmt(@"%@Pixels", state);
    }
    id pixels = [_fileDict valueForKey:pixelsKey];
    return pixels;
}
- (id)currentPixels
{
    id state = [self currentState];
    return [self pixelsForState:state];
}
- (id)paletteForState:(id)state
{
    id paletteKey = @"palette";
    if ([state length]) {
        paletteKey = nsfmt(@"%@Palette", state);
    }
    id palette = [_fileDict valueForKey:paletteKey];
    return palette;
}
- (id)currentPalette
{
    id state = [self currentState];
    return [self paletteForState:state];
}
- (BOOL)isValidState:(id)state
{
    if ([self pixelsForState:state] && [self paletteForState:state]) {
        return YES;
    }
    return NO;
}
- (void)drawInBitmap:(id)bitmap x:(int)x y:(int)y
{
    Int4 r;
    r.x = x;
    r.y = y;
    r.w = [self preferredWidth];
    r.h = [self preferredHeight];
    [self drawInBitmap:bitmap rect:r];
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [self drawInBitmap:bitmap rect:r context:nil];
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r context:(id)context
{
    id state = [self currentState];
    id pixels = [self currentPixels];
    id palette = [self currentPalette];
    if (!pixels || !palette) {
        return;
    }
    if ([context valueForKey:@"selectedTimestamp"]) {
        id highlightedPaletteKey = @"highlightedPalette";
        if ([state length]) {
            highlightedPaletteKey = nsfmt(@"%@HighlightedPalette", state);
        }
        id highlightedPalette = [_fileDict valueForKey:highlightedPaletteKey];
        if (highlightedPalette) {
            palette = highlightedPalette;
        }
    }
    [bitmap drawCString:[pixels UTF8String] palette:[palette UTF8String] x:r.x y:r.y];
    id drawMessage = [_fileDict valueForKey:@"drawMessage"];
    if ([drawMessage length]) {
        [self setValue:bitmap forKey:@"bitmap"];
        [context evaluateMessage:drawMessage];
        [self setValue:nil forKey:@"bitmap"];
    }
}
- (void)handleMouseDown:(id)event
{
NSLog(@"CommandOutputBitmap handleMouseDown");
    id windowManager = [event valueForKey:@"windowManager"];
    id x11dict = [event valueForKey:@"x11dict"];
    [windowManager setFocusDict:nil];
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

    unsigned long underneathWindow = [windowManager topMostWindowUnderneathWindow:window x:mouseRootX y:mouseRootY];
    if (underneathWindow) {
        id underneathDict = [windowManager dictForObjectWindow:underneathWindow];
        id object = [underneathDict valueForKey:@"object"];
        id dragAndDropMessage = [[object valueForKey:@"fileDict"] valueForKey:@"dragAndDropMessage"];
        if ([dragAndDropMessage length]) {
            [object setValue:x11dict forKey:@"dragObject"];
            id result = [underneathDict evaluateMessage:dragAndDropMessage];
            [object setValue:nil forKey:@"dragObject"];
            if (!result) {
                id beforeDragX = [x11dict valueForKey:@"beforeDragX"];
                id beforeDragY = [x11dict valueForKey:@"beforeDragY"];
                [x11dict setValue:nsfmt(@"%@ %@", beforeDragX, beforeDragY) forKey:@"moveWindow"];
            }
        }
    }

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
                    id doubleClickMessage = [_fileDict valueForKey:@"doubleClickMessage"];
                    if ([doubleClickMessage length]) {
                        [x11dict evaluateMessage:doubleClickMessage];
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
                for (int i=0; i<[objectWindows count]; i++) {
                    id elt = [objectWindows nth:i];
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

- (void)handleRightMouseDown:(id)event
{
    id windowManager = [event valueForKey:@"windowManager"];
    int mouseRootX = [event intValueForKey:@"mouseRootX"];
    int mouseRootY = [event intValueForKey:@"mouseRootY"];

    id x11dict = [event valueForKey:@"x11dict"];
    id obj = [x11dict valueForKey:@"object"];
    id fileDict = [obj valueForKey:@"fileDict"];
    id menuCSV = [fileDict valueForKey:@"menuCSV"];
    id menu = [[menuCSV parseCSVFromString] asMenu];
    [menu setValue:x11dict forKey:@"contextualObject"];
    int w = [menu preferredWidth];
    int h = [menu preferredHeight];
    id dict = [windowManager openWindowForObject:menu x:mouseRootX y:mouseRootY w:w+3 h:h+3];
    [windowManager setValue:dict forKey:@"buttonDownDict"];
    [windowManager setValue:@"3" forKey:@"buttonDownWhich"];
}
@end
