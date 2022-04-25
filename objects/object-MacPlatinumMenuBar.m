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


@implementation Definitions(jfoiwernfjejfklsdjfklsdjlkfjsdlkfj)
+ (void)enterMacPlatinumMode
{
    char *cstr = [Definitions cStringForMacPlatinumBackground];
    char *palette = [Definitions cStringForMacPlatinumBackgroundPalette];

    id windowManager = [@"windowManager" valueForKey];
    [windowManager setFocusDict:nil];
    [windowManager unparentAllWindows];

    [Definitions setValue:@"macplatinum" forEnvironmentVariable:@"HOTDOG_MODE"];

    [windowManager setBackgroundForCString:cstr palette:palette];
    id rootWindowObject = [@"MacRootWindow" asInstance];
    [windowManager setValue:rootWindowObject forKey:@"rootWindowObject"];
    [windowManager reparentAllWindows:@"MacPlatinumWindow"];
    [[windowManager valueForKey:@"menuBar"] setValue:@"1" forKey:@"shouldCloseWindow"];
    [windowManager setValue:@"20" forKey:@"menuBarHeight"];
    id menuBar = [windowManager openWindowForObject:[@"MacPlatinumMenuBar" asInstance] x:0 y:0 w:[windowManager intValueForKey:@"rootWindowWidth"] h:[windowManager intValueForKey:@"menuBarHeight"]];
    [windowManager setValue:menuBar forKey:@"menuBar"];
    [windowManager setFocusDict:nil];
    [@"hotdog-setupWindowManagerMode.sh" runCommandInBackground];
}
@end

@implementation Definitions(fjkieifjdlesjkfljskdlfjklsdjfklsd)
+ (char *)cStringForMacPlatinumMenuBarPalette
{
    return
"b #000000\n"
". #555555\n"
"X #63639C\n"
"o #999999\n"
"O #AAAAAA\n"
"+ #DDDDDD\n"
"@ #FFFFFF\n"
;
}
+ (char *)cStringForMacPlatinumMenuBarLeft
{
    return
"bbbbb.O+\n"
"bbb.O@@@\n"
"bb.+@+++\n"
"b.+@++++\n"
"bO@+++++\n"
".@++++++\n"
"O@++++++\n"
"+@++++++\n"
"@+++++++\n"
"@+++++++\n"
"@+++++++\n"
"@+++++++\n"
"@+++++++\n"
"@+++++++\n"
"@+++++++\n"
"@+++++++\n"
"@+++++++\n"
"@+++++++\n"
"+ooooooo\n"
"bbbbbbbb\n"
;
}
+ (char *)cStringForMacPlatinumMenuBarMiddle
{
    return
"@\n"
"+\n"
"+\n"
"+\n"
"+\n"
"+\n"
"+\n"
"+\n"
"+\n"
"+\n"
"+\n"
"+\n"
"+\n"
"+\n"
"+\n"
"+\n"
"+\n"
"+\n"
"o\n"
"b\n"
;
}
+ (char *)cStringForMacPlatinumMenuBarRightPalette
{
    return
"b #000000\n"
". #222222\n"
"X #555555\n"
"o #777777\n"
"O #63639C\n"
"+ #888888\n"
"@ #999999\n"
"# #AAAAAA\n"
"$ #BBBBBB\n"
"% #CCCCCC\n"
"& #DDDDDD\n"
"* #FFFFFF\n"
;
}
+ (char *)cStringForMacPlatinumMenuBarRight
{
    return
"&#X.bbbb\n"
"&%$+Xbbb\n"
"&&&$+Xbb\n"
"&&&&$+Xb\n"
"&&&&&$+.\n"
"&&&&&&#X\n"
"&&&&&&$o\n"
"&&&&&&%+\n"
"&&&&&&&@\n"
"&&&&&&&@\n"
"&&&&&&&@\n"
"&&&&&&&@\n"
"&&&&&&&@\n"
"&&&&&&&@\n"
"&&&&&&&@\n"
"&&&&&&&@\n"
"&&&&&&&@\n"
"&&&&&&&@\n"
"@@@@@@@@\n"
"bbbbbbbb\n"
;
}
@end

@interface MacPlatinumMenuBar : IvarObject
{
    id _configPath;
    time_t _configTimestamp;
    int _closingIteration;
    BOOL _buttonDown;
    id _selectedDict;
    id _menuDict;
    id _array;
}
@end

@implementation MacPlatinumMenuBar

- (void)flashIndex:(int)index duration:(int)duration
{
    if (_closingIteration > 0) {
        return;
    }
    if (_selectedDict) {
        return;
    }

    id dict = [_array nth:index];
    if (dict) {
        [self setValue:dict forKey:@"selectedDict"];
        _closingIteration = duration;
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        id configPath = [Definitions configDir:@"Config/menuBar.csv"];
        [self setValue:configPath forKey:@"configPath"];
    }
    return self;
}

- (void)updateMenuBar
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
NSLog(@"DEALLOC MacMenuBar");
    [super dealloc];
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
    if (_closingIteration > 0) {
        _closingIteration--;
        id x11dict = [event valueForKey:@"x11dict"];
        if (_closingIteration == 0) {
            _buttonDown = NO;
            [self setValue:nil forKey:@"menuDict"];
            [self setValue:nil forKey:@"selectedDict"];
        }
        return;
    }
    time_t timestamp = [_configPath fileModificationTimestamp];
    if (timestamp != _configTimestamp) {
        [self setValue:nil forKey:@"array"];
        _configTimestamp = timestamp;
        [self updateMenuBar];
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
- (id)dictForX:(int)x
{
    id monitor = [Definitions monitorForX:x y:0];
    int monitorX = [monitor intValueForKey:@"x"];
    int monitorWidth = [monitor intValueForKey:@"width"];
    if ((x < monitorX) || (x >= monitorX+monitorWidth)) {
        return nil;
    }
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        int eltX = [elt intValueForKey:@"x"];
        int x1 = (eltX < 0) ? eltX+monitorX+monitorWidth : eltX+monitorX;
        int w1 = [elt intValueForKey:@"width"];
        if ((x >= x1) && (x < x1+w1)) {
            return elt;
        }
    }
    return nil;
}
- (void)handleScrollWheel:(id)event
{
    if (!_buttonDown) {
        return;
    }

    if (_menuDict) {
        id windowManager = [event valueForKey:@"windowManager"];
        id object = [_menuDict valueForKey:@"object"];
        if ([object respondsToSelector:@selector(handleScrollWheel:)]) {
            int mouseRootX = [event intValueForKey:@"mouseRootX"];
            int mouseRootY = [event intValueForKey:@"mouseRootY"];
            int x = [_menuDict intValueForKey:@"x"];
            int y = [_menuDict intValueForKey:@"y"];
            int w = [_menuDict intValueForKey:@"w"];
            int h = [_menuDict intValueForKey:@"h"];
            id newEvent = [windowManager generateEventDictRootX:mouseRootX rootY:mouseRootY x:mouseRootX-x y:mouseRootY-y w:w h:h x11dict:_menuDict];
            [newEvent setValue:[event valueForKey:@"deltaX"] forKey:@"deltaX"];
            [newEvent setValue:[event valueForKey:@"deltaY"] forKey:@"deltaY"];
            [newEvent setValue:[event valueForKey:@"scrollingDeltaX"] forKey:@"scrollingDeltaX"];
            [newEvent setValue:[event valueForKey:@"scrollingDeltaY"] forKey:@"scrollingDeltaY"];
            [object handleScrollWheel:newEvent];
            [_menuDict setValue:@"1" forKey:@"needsRedraw"];
        }
    }
}
- (void)handleKeyDown:(id)event
{
    if (!_buttonDown) {
        return;
    }

    if (_menuDict) {
        id windowManager = [event valueForKey:@"windowManager"];
        id object = [_menuDict valueForKey:@"object"];
        if ([object respondsToSelector:@selector(handleKeyDown:)]) {
            [object handleKeyDown:event];
            [_menuDict setValue:@"1" forKey:@"needsRedraw"];
        }
    }
}
- (void)handleMouseDown:(id)event
{
    if (_buttonDown) {
        return;
    }
    int mouseRootX = [event intValueForKey:@"mouseRootX"];
    id windowManager = [event valueForKey:@"windowManager"];
    int menuBarHeight = [windowManager intValueForKey:@"menuBarHeight"];
    int mouseRootY = [event intValueForKey:@"mouseRootY"];
    if (mouseRootY >= menuBarHeight) {
        return;
    }
    _buttonDown = YES;
    id dict = [self dictForX:mouseRootX];
    [self openRootMenu:dict x:mouseRootX];
}
- (void)handleMouseUp:(id)event
{
NSLog(@"MacMenuBar handleMouseUp event %@", event);
    if (!_buttonDown) {
        return;
    }

    if (_menuDict) {
        id windowManager = [event valueForKey:@"windowManager"];
        id object = [_menuDict valueForKey:@"object"];
        if ([object respondsToSelector:@selector(handleMouseUp:)]) {
            int mouseRootX = [event intValueForKey:@"mouseRootX"];
            int mouseRootY = [event intValueForKey:@"mouseRootY"];
            int x = [_menuDict intValueForKey:@"x"];
            int y = [_menuDict intValueForKey:@"y"];
            int w = [_menuDict intValueForKey:@"w"];
            int h = [_menuDict intValueForKey:@"h"];
            id newEvent = [windowManager generateEventDictRootX:mouseRootX rootY:mouseRootY x:mouseRootX-x y:mouseRootY-y w:w h:h x11dict:_menuDict];
            [object handleMouseUp:newEvent];
            [_menuDict setValue:@"1" forKey:@"needsRedraw"];
            int closingIteration = [object intValueForKey:@"closingIteration"];
            if (closingIteration) {
                _closingIteration = closingIteration;
                return;
            }
        }
        [self setValue:nil forKey:@"menuDict"];
    }
    _buttonDown = NO;
    [self setValue:nil forKey:@"selectedDict"];
}

- (void)handleMouseMoved:(id)event
{
    int mouseRootX = [event intValueForKey:@"mouseRootX"];
    if (!_buttonDown) {
        return;
    }
    id windowManager = [event valueForKey:@"windowManager"];
    int menuBarHeight = [windowManager intValueForKey:@"menuBarHeight"];
    int mouseRootY = [event intValueForKey:@"mouseRootY"];
    if (mouseRootY < menuBarHeight) {
        id dict = [self dictForX:mouseRootX];
        if (dict && (dict != _selectedDict)) {
            [_menuDict setValue:@"1" forKey:@"shouldCloseWindow"];
            [self setValue:nil forKey:@"menuDict"];
            [self setValue:nil forKey:@"selectedDict"];
            [self openRootMenu:dict x:mouseRootX];
            return;
        }
    }

    if (_menuDict) {
        id object = [_menuDict valueForKey:@"object"];
        if ([object respondsToSelector:@selector(handleMouseMoved:)]) {
            int x = [_menuDict intValueForKey:@"x"];
            int y = [_menuDict intValueForKey:@"y"];
            int w = [_menuDict intValueForKey:@"w"];
            int h = [_menuDict intValueForKey:@"h"];
            id newEvent = [windowManager generateEventDictRootX:mouseRootX rootY:mouseRootY x:mouseRootX-x y:mouseRootY-y w:w h:h x11dict:_menuDict];
            [object handleMouseMoved:newEvent];
            [_menuDict setValue:@"1" forKey:@"needsRedraw"];
        }
    }

}
- (void)openRootMenu:(id)dict x:(int)mouseRootX
{

    id messageForClick = [dict valueForKey:@"messageForClick"];
    if (!messageForClick) {
        return;
    }
    id obj = [messageForClick evaluateAsMessage];
    if (!obj) {
        return;
    }
    id monitor = [Definitions monitorForX:mouseRootX y:0];
    int monitorX = [monitor intValueForKey:@"x"];
    int monitorWidth = [monitor intValueForKey:@"width"];
    int x = [dict intValueForKey:@"x"];
    if (x < 0) {
        x += monitorX+monitorWidth;
    } else {
        x += monitorX;
    }
    int w = 200;
    if ([obj respondsToSelector:@selector(preferredWidth)]) {
        w = [obj preferredWidth];
    }
    int h = 200;
    if ([obj respondsToSelector:@selector(preferredHeight)]) {
        h = [obj preferredHeight];
    }
    id windowManager = [@"windowManager" valueForKey];
    id menuDict = [windowManager openWindowForObject:obj x:x y:20 w:w+3 h:h+3];
    [self setValue:menuDict forKey:@"menuDict"];
    [self setValue:dict forKey:@"selectedDict"];
    [windowManager XSetInputFocus:[menuDict unsignedLongValueForKey:@"window"]];
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    char *palette = [Definitions cStringForMacPlatinumMenuBarPalette];
    char *leftStr = [Definitions cStringForMacPlatinumMenuBarLeft];
    int leftWidth = [Definitions widthForCString:leftStr];
    char *middleStr = [Definitions cStringForMacPlatinumMenuBarMiddle];
    char *rightPalette = [Definitions cStringForMacPlatinumMenuBarRightPalette];
    char *rightStr = [Definitions cStringForMacPlatinumMenuBarRight];
    int rightWidth = [Definitions widthForCString:rightStr];

    {
        int emptyIndex = [_array count];

        int x = leftWidth;
        for (int i=0; i<[_array count]; i++) {
            id elt = [_array nth:i];
            id objectMessage = [elt valueForKey:@"objectMessage"];
            if ([objectMessage length] == 0) {
                emptyIndex = i;
                break;
            }
            id obj = [elt valueForKey:@"object"];
            if (!obj) {
                continue;
            }
            int leftPadding = [elt intValueForKey:@"leftPadding"];
            int rightPadding = [elt intValueForKey:@"rightPadding"];
            int w = 100;
            if ([obj respondsToSelector:@selector(preferredWidth)]) {
                w = [obj preferredWidth]+leftPadding+rightPadding;
            }
            [elt setValue:nsfmt(@"%d", x) forKey:@"x"];
            [elt setValue:nsfmt(@"%d", w) forKey:@"width"];
            x += w;
        }
        x = rightWidth;
        for (int i=[_array count]-1; i>emptyIndex; i--) {
            id elt = [_array nth:i];
            id obj = [elt valueForKey:@"object"];
            if (!obj) {
                continue;
            }
            int leftPadding = [elt intValueForKey:@"leftPadding"];
            int rightPadding = [elt intValueForKey:@"rightPadding"];
            int w = 100;
            if ([obj respondsToSelector:@selector(preferredWidth)]) {
                w = [obj preferredWidth]+leftPadding+rightPadding;
            }
            x += w;
            [elt setValue:nsfmt(@"%d", -x) forKey:@"x"];
            [elt setValue:nsfmt(@"%d", w) forKey:@"width"];
        }
    }

    id windowManager = [@"windowManager" valueForKey];
    int mouseRootX = [windowManager intValueForKey:@"mouseX"];
    id mouseMonitor = [Definitions monitorForX:mouseRootX y:0];

    id monitors = [Definitions monitorConfig];
    for (int monitorI=0; monitorI<[monitors count]; monitorI++) {
        id monitor = [monitors nth:monitorI];
        int monitorX = [monitor intValueForKey:@"x"];
        int monitorWidth = [monitor intValueForKey:@"width"];
        [Definitions drawInBitmap:bitmap left:leftStr palette:palette middle:middleStr palette:palette right:rightStr palette:rightPalette x:monitorX y:0 w:monitorWidth];
        if ([monitor intValueForKey:@"x"] != [mouseMonitor intValueForKey:@"x"]) {
            int monitorIndex = 0;
            id text = nsarr();
            int textHeight = [bitmap bitmapHeightForText:@"X"];
            for (int i=0; i<[monitors count]; i++) {
                id elt = [monitors nth:i];
                if ([elt intValueForKey:@"x"] == [mouseMonitor intValueForKey:@"x"]) {
                    [text addObject:nsfmt(@"This is monitor %d (%@). Pointer is on monitor %d (%@) x:%d y:%d", monitorI+1, [monitor valueForKey:@"output"], monitorIndex+1, [elt valueForKey:@"output"], mouseRootX, [windowManager intValueForKey:@"mouseY"])];
                }
                monitorIndex++;
            }
            [bitmap setColorIntR:0 g:0 b:0 a:255];
            [bitmap drawBitmapText:[text join:@""] x:monitorX+leftWidth*2 y:5];
        }
    }

    int mouseMonitorX = [mouseMonitor intValueForKey:@"x"];
    int mouseMonitorWidth = [mouseMonitor intValueForKey:@"width"];
    for (int i=0; i<[_array count]; i++) {
        id elt = [_array nth:i];
        Int4 r1 = r;
        int eltX = [elt intValueForKey:@"x"];
        if (eltX < 0) {
            r1.x = r.x+mouseMonitorX+mouseMonitorWidth+eltX;
            r1.w = [elt intValueForKey:@"width"];
        } else {
            r1.x = r.x+mouseMonitorX+eltX;
            r1.w = [elt intValueForKey:@"width"];
        }
/*
        if (isnan(r1.x)) {
            r1.x = 0.0;
        }
*/
        Int4 r2 = r1;
        r2.y += 1;
        r2.h -= 1;
        id obj = [elt valueForKey:@"object"];
        int leftPadding = [elt intValueForKey:@"leftPadding"];
        int rightPadding = [elt intValueForKey:@"rightPadding"];
        if ((_buttonDown || (_closingIteration > 0)) && (_selectedDict == elt)) {
            if ([obj respondsToSelector:@selector(drawHighlightedInBitmap:rect:)]) {
                [bitmap setColor:@"black"];
                [bitmap fillRect:r2];

                Int4 r3 = r2;
                r3.x += leftPadding;
                r3.w -= leftPadding+rightPadding;
                [obj drawHighlightedInBitmap:bitmap rect:r3];
            } else if ([obj respondsToSelector:@selector(drawInBitmap:rect:)]) {
                Int4 r3 = r2;
                r3.x += leftPadding;
                r3.w -= leftPadding+rightPadding;
                [bitmap setColor:@"black"];
                [obj drawInBitmap:bitmap rect:r3];
            } else {
            }
        } else {
            if ([obj respondsToSelector:@selector(drawInBitmap:rect:)]) {
                Int4 r3 = r2;
                r3.x += leftPadding;
                r3.w -= leftPadding+rightPadding;
                [bitmap setColor:@"black"];
                [obj drawInBitmap:bitmap rect:r3];
            } else {
            }
        }
    }
}
@end
