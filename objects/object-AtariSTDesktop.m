/*

 HOTDOG

 Copyright (c) 2020 Arthur Choung. All rights reserved.

 Email: arthur -at- hotdogpucko.com

 This file is part of HOTDOG.

 HOTDOG is free software: you can redistribute it and/or modify
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

static id _text = @"Close window to remove icons\nFIXME: This window should not be displayed";

static id deskMenuCSV =
@"hotKey,displayName,messageForClick\n"
@",\"Desktop Info...\",\"1\"\n"
@",,\n"
@",\"Quit AtariSTDesktop\",\"'desktopObject'|valueForKey|exit:0\"\n"
;

static id fileMenuCSV =
@"hotKey,displayName,messageForClick\n"
@",\"Open\",\"1\"\n"
@",\"Show Info...\",\"1\"\n"
@",,\n"
@",\"New Folder...\",\"1\"\n"
@",\"Close\",\"1\"\n"
@",\"Close Window\",\"1\"\n"
@",,\n"
@",\"Format...\",\"1\"\n"
;

static id viewMenuCSV =
@"hotKey,displayName,messageForClick\n"
@",\"Show as Icons\",\"1\"\n"
@",\"Show as Text\",\"1\"\n"
@",,\n"
@",\"Sort by Name\",\"1\"\n"
@",\"Sort by Date\",\"1\"\n"
@",\"Sort by Size\",\"1\"\n"
@",\"Sort by Type\",\"1\"\n"
;

static id optionsMenuCSV =
@"hotKey,displayName,messageForClick\n"
@",\"Install Disk Drive...\",\"1\"\n"
@",\"Install Application...\",\"1\"\n"
@",,\n"
@",\"Set Preferences...\",\"1\"\n"
@",\"Save Desktop\",\"1\"\n"
@",\"Print Screen\",\"1\"\n"
;

@implementation Definitions(fmekwlmfklsjfkdsjfdmfklsdmklfmlskdkf)
+ (void)openAtariSTDirForPath:(id)path
{
    id realPath = [path asRealPath];

    if ([realPath isDirectory]) {
        id windowManager = [@"windowManager" valueForKey];
        id object = [Definitions AtariSTDir:realPath];
        if (object) {
            id dict = [windowManager openUnmappedWindowForObject:object x:0 y:0 w:640 h:360 overrideRedirect:NO propertyName:"HOTDOGNOFRAME"];
            if (dict) {
                unsigned long win = [dict unsignedLongValueForKey:@"window"];
                if (win) {
                    id appMenuHead = [@"HOTDOGAPPMENUHEAD" valueForKey];
                    [windowManager XChangeProperty:win name:"HOTDOGAPPMENUHEAD" str:appMenuHead];
                    [windowManager XMapWindow:win];
                    [windowManager raiseObjectWindow:dict];
                }
            }
        }
    }
}
@end

@implementation Definitions(fmekwlmfklsdmfklsmdklfmksldfjdksjfkfjsdkfk)
+ (id)AtariSTDesktop
{
    id observercmd = nsarr();
    [observercmd addObject:@"hotdog-monitorMountChanges"];
    id observer = [observercmd runCommandAndReturnProcess];
    if (!observer) {
NSLog(@"unable to run observer command %@", observercmd);
exit(1);
    }

    id obj = [@"AtariSTDesktop" asInstance];
    [obj setValue:observer forKey:@"observer"];
    return obj;
}
@end

@interface AtariSTDesktop : IvarObject
{
    id _observer;
    time_t _timestamp;

    id _selectionBox;
    int _buttonDownRootX;
    int _buttonDownRootY;
}
@end
@implementation AtariSTDesktop
- (void)exit:(int)status
{
    [_observer sendSignal:SIGTERM];
    exit(status);
}
    
- (void)handleDestroyNotifyEvent:(id)event
{
NSLog(@"handleDestroyNotifyEvent:%@", event);
    [self exit:0];
}
- (id)appMenuArray
{
    id deskMenu = [[deskMenuCSV parseCSVFromString] asMenu];
    [deskMenu setValue:@"Desk" forKey:@"title"];
    [deskMenu setValue:@"1" forKey:@"unmapInsteadOfClose"];
    id fileMenu = [[fileMenuCSV parseCSVFromString] asMenu];
    [fileMenu setValue:@"File" forKey:@"title"];
    [fileMenu setValue:@"1" forKey:@"unmapInsteadOfClose"];
    id viewMenu = [[viewMenuCSV parseCSVFromString] asMenu];
    [viewMenu setValue:@"View" forKey:@"title"];
    [viewMenu setValue:@"1" forKey:@"unmapInsteadOfClose"];
    id optionsMenu = [[optionsMenuCSV parseCSVFromString] asMenu];
    [optionsMenu setValue:@"Options" forKey:@"title"];
    [optionsMenu setValue:@"1" forKey:@"unmapInsteadOfClose"];
    id results = nsarr();
    [results addObject:deskMenu];
    [results addObject:fileMenu];
    [results addObject:viewMenu];
    [results addObject:optionsMenu];
    return results;
}
- (int)fileDescriptor
{
    if (_observer) {
        return [_observer fileDescriptor];
    }
    return -1;
}
- (void)handleFileDescriptor
{
    if (_observer) {
        [_observer handleFileDescriptor];
        id data = [_observer valueForKey:@"data"];
        id lastLine = nil;
        for(;;) {
            id line = [data readLine];
//NSLog(@"line '%@'", line);
            if (!line) {
                break;
            }
            lastLine = line;
        }
        if (lastLine) {
            _timestamp = 0;
        }
        return;
    }
}

- (void)beginIteration:(id)event rect:(Int4)r
{
    if (!_timestamp) {
        _timestamp = 1;
        id windowManager = [event valueForKey:@"windowManager"];
NSLog(@"windowManager %@", windowManager);
        [self handleDesktopPath:windowManager];
    }
}

- (void)handleDesktopPath:(id)windowManager
{

    id objectWindows = [windowManager valueForKey:@"objectWindows"];

    id cmd = nsarr();
    [cmd addObject:@"hotdog-listBlockDevices.pl"];
    id lines = [[[cmd runCommandAndReturnOutput] asString] split:@"\n"];
    [lines addObject:@"builtin:AtariSTTrashIcon mountpoint:Trash"];

    for (int i=0; i<[objectWindows count]; i++) {
        id dict = [objectWindows nth:i];
        id filePath = [dict valueForKey:@"filePath"];
        if (!filePath) {
            continue;
        }
        if ([lines objectWithValue:filePath forKey:@"mountpoint"]) {
            continue;
        }
        [dict setValue:@"1" forKey:@"shouldCloseWindow"];
    }


    int monitorWidth = [windowManager intValueForKey:@"rootWindowWidth"];
    int monitorHeight = [windowManager intValueForKey:@"rootWindowHeight"];


    int maxWidth = 16;
    int cursorX = 10;
    int cursorY = 30;
    for (int i=0; i<[lines count]; i++) {
        id elt = [lines nth:i];
        id mountpoint = [elt valueForKey:@"mountpoint"];
        if (![mountpoint length]) {
            continue;
        }
        id dict = [objectWindows objectWithValue:mountpoint forKey:@"filePath"];
        if (!dict) {
            id obj = nil;
            id className = [elt valueForKey:@"builtin"];
            if ([className length]) {
                obj = [className asInstance];
                [obj setValue:@"1" forKey:@"builtin"];
            } else {
                obj = [@"AtariSTDiskIcon" asInstance];
            }
            [obj setValue:mountpoint forKey:@"path"];
            int w = 16;
            if ([obj respondsToSelector:@selector(preferredWidth)]) {
                int preferredWidth = [obj preferredWidth];
                if (preferredWidth) {
                    w = preferredWidth;
                }
            }
            int h = 16;
            if ([obj respondsToSelector:@selector(preferredHeight)]) {
                int preferredHeight = [obj preferredHeight];
                if (preferredHeight) {
                    h = preferredHeight;
                }
            }
            if (w > maxWidth) {
                maxWidth = w;
            }
            if (cursorY + h >= monitorHeight) {
                cursorY = 30;
                cursorX += maxWidth + 10;
                maxWidth = 16;
            }
            dict = [windowManager openUnmappedWindowForObject:obj x:cursorX y:cursorY w:w h:h overrideRedirect:NO propertyName:"HOTDOGNOFRAME"];
            cursorY += h+10;
            if (dict) {
                [dict setValue:mountpoint forKey:@"filePath"];
                unsigned long win = [dict unsignedLongValueForKey:@"window"];
                if (win) {
                    id appMenuHead = [@"HOTDOGAPPMENUHEAD" valueForKey];
                    [windowManager XChangeProperty:win name:"HOTDOGAPPMENUHEAD" str:appMenuHead];
                    [windowManager XMapWindow:win];
                    [windowManager raiseObjectWindow:dict];
                }
            }
        }
        [dict setValue:@"1" forKey:@"needsRedraw"];
    }
}
- (int)preferredWidth
{
    id bitmap = [Definitions bitmapWithWidth:1 height:1];
    int w = [bitmap bitmapWidthForText:_text];
    return w + 10;
}
- (int)preferredHeight
{
    id bitmap = [Definitions bitmapWithWidth:1 height:1];
    int h = [bitmap bitmapHeightForText:_text];
    return h + 10;
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [bitmap setColor:@"white"];
    [bitmap fillRect:r];
    [bitmap setColor:@"black"];
    [bitmap drawBitmapText:_text x:r.x+5 y:r.y+5];
}
- (void)handleMouseDown:(id)event
{
NSLog(@"Desktop handleMouseDown");
    id windowManager = [event valueForKey:@"windowManager"];
    int mouseRootX = [event intValueForKey:@"mouseRootX"];
    int mouseRootY = [event intValueForKey:@"mouseRootY"];
    int viewWidth = [event intValueForKey:@"viewWidth"];
    int viewHeight = [event intValueForKey:@"viewHeight"];
    id x11dict = [event valueForKey:@"x11dict"];

    id object = [@"SelectionBox" asInstance];
    int w = 1;
    int h = 1;
    if ([object respondsToSelector:@selector(preferredWidth)]) {
        w = [object preferredWidth];
    }
    if ([object respondsToSelector:@selector(preferredHeight)]) {
        h = [object preferredHeight];
    }
    id dict = [windowManager openWindowForObject:object x:mouseRootX y:mouseRootY w:w h:h overrideRedirect:YES];
    [self setValue:dict forKey:@"selectionBox"];

    id objectWindows = [windowManager valueForKey:@"objectWindows"];
    for (int i=0; i<[objectWindows count]; i++) {
        id dict = [objectWindows nth:i];
        if (dict == _selectionBox) {
NSLog(@"skipping SelectionBox");
            continue;
        }
        if (dict == x11dict) {
NSLog(@"skipping *Desktop");
            continue;
        }
        [dict setValue:nil forKey:@"isSelected"];
        [dict setValue:@"1" forKey:@"needsRedraw"];
    }
    _buttonDownRootX = [event intValueForKey:@"mouseRootX"];
    _buttonDownRootY = [event intValueForKey:@"mouseRootY"];
}
- (void)handleMouseMoved:(id)event
{
NSLog(@"Desktop handleMouseMoved");
    if (!_selectionBox) {
        return;
    }

    int mouseRootX = [event intValueForKey:@"mouseRootX"];
    int mouseRootY = [event intValueForKey:@"mouseRootY"];
    int newX = _buttonDownRootX;
    int newY = _buttonDownRootY;
    int newWidth = mouseRootX - _buttonDownRootX;
    int newHeight = mouseRootY - _buttonDownRootY;
    if (newWidth == 0) {
        newWidth = 1;
    } else if (newWidth < 0) {
        newX = mouseRootX;
        newWidth *= -1;
        newWidth++;
    }
    if (newHeight == 0) {
        newHeight = 1;
    } else if (newHeight < 0) {
        newY = mouseRootY;
        newHeight *= -1;
        newHeight++;
    }
    [_selectionBox setValue:nsfmt(@"%d", newX) forKey:@"x"];
    [_selectionBox setValue:nsfmt(@"%d", newY) forKey:@"y"];
    [_selectionBox setValue:nsfmt(@"%d", newWidth) forKey:@"w"];
    [_selectionBox setValue:nsfmt(@"%d", newHeight) forKey:@"h"];
    [_selectionBox setValue:@"1" forKey:@"needsRedraw"];
    [_selectionBox setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];
    [_selectionBox setValue:nsfmt(@"%d %d", newWidth, newHeight) forKey:@"resizeWindow"];
    Int4 r = [Definitions rectWithX:newX y:newY w:newWidth h:newHeight];
    id windowManager = [event valueForKey:@"windowManager"];
    id x11dict = [event valueForKey:@"x11dict"];
    id objectWindows = [windowManager valueForKey:@"objectWindows"];
    for (int i=0; i<[objectWindows count]; i++) {
        id dict = [objectWindows nth:i];
        if (dict == _selectionBox) {
NSLog(@"skipping SelectionBox");
            continue;
        }
        if (dict == x11dict) {
NSLog(@"skipping *Desktop");
            continue;
        }
        int x = [dict intValueForKey:@"x"];
        int y = [dict intValueForKey:@"y"];
        int w = [dict intValueForKey:@"w"];
        int h = [dict intValueForKey:@"h"];
        Int4 r2 = [Definitions rectWithX:x y:y w:w h:h];
        if ([Definitions doesRect:r intersectRect:r2]) {
            [dict setValue:@"1" forKey:@"isSelected"];
            [dict setValue:@"1" forKey:@"needsRedraw"];
        } else {
            [dict setValue:nil forKey:@"isSelected"];
            [dict setValue:@"1" forKey:@"needsRedraw"];
        }
    }
}
- (void)handleMouseUp:(id)event
{
NSLog(@"Desktop handleMouseUp");
    if (_selectionBox) {
        [_selectionBox setValue:@"1" forKey:@"shouldCloseWindow"];
        [self setValue:nil forKey:@"selectionBox"];
    }
}
@end

