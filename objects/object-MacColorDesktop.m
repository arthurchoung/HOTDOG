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

static id fileMenuCSV =
@"hotKey,displayName,messageForClick\n"
@",\"New Folder\",\"'New Folder'|showAlert\"\n"
@",\"Open\",\"1\"\n"
@",\"Print\",\"1\"\n"
@",\"Close Window\",\"1\"\n"
@",,\n"
@",\"Get Info\",\"1\"\n"
@",\"Sharing...\",\"1\"\n"
@",\"Duplicate\",\"1\"\n"
@",\"Make Alias\",\"1\"\n"
@",\"Put Away\",\"1\"\n"
@",,\n"
@",\"Find...\",\"1\"\n"
@",\"Find Again\",\"1\"\n"
@",,\n"
@",\"Page Setup...\",\"1\"\n"
@",\"Print Window...\",\"1\"\n"
@",,\n"
@",\"Quit MacColorDesktop\",\"'desktopObject'|valueForKey|exit:0\"\n"
;

static id editMenuCSV =
@"hotKey,displayName,messageForClick\n"
@",\"Undo\",\"1\"\n"
@",,\n"
@",\"Cut\",\"1\"\n"
@",\"Copy\",\"1\"\n"
@",\"Paste\",\"1\"\n"
@",\"Clear\",\"1\"\n"
@",\"Select All\",\"1\"\n"
@",,\n"
@",\"Show Clipboard\",\"1\"\n"
;

static id viewMenuCSV =
@"hotKey,displayName,messageForClick\n"
@",\"by Small Icon\",\"1\"\n"
@",\"by Icon\",\"1\"\n"
@",\"by Name\",\"1\"\n"
@",\"by Size\",\"1\"\n"
@",\"by Kind\",\"1\"\n"
@",\"by Label\",\"1\"\n"
@",\"by Date\",\"1\"\n"
;

static id labelMenuCSV =
@"hotKey,displayName,messageForClick\n"
@",\"None\",\"1\"\n"
@",,\n"
@",\"Essential\",\"1\"\n"
@",\"Hot\",\"1\"\n"
@",\"In Progress\",\"1\"\n"
@",\"Cool\",\"1\"\n"
@",\"Personal\",\"1\"\n"
@",\"Project 1\",\"1\"\n"
@",\"Project 2\",\"1\"\n"
;

static id specialMenuCSV =
@"hotKey,displayName,messageForClick\n"
@",\"Clean Up Window\",\"1\"\n"
@",\"Empty Trash...\",\"1\"\n"
@",,\n"
@",\"Eject Disk\",\"1\"\n"
@",\"Erase Disk...\",\"1\"\n"
@",,\n"
@",\"Restart\",\"1\"\n"
@",\"Shut Down\",\"1\"\n"
;

@implementation Definitions(fmekwljfkdsjfksdmfklsdmfklsdmklfmlskdkf)
+ (id)getMacColorDirForPath:(id)path
{
    if (!path) {
        return nil;
    }

    id windowManager = [@"windowManager" valueForKey];
    id objectWindows = [windowManager valueForKey:@"objectWindows"];
    for (int i=0; i<[objectWindows count]; i++) {
        id elt = [objectWindows nth:i];
        id object = [elt valueForKey:@"object"];
        if (object) {
            id className = [object className];
            if ([className isEqual:@"MacColorDir"]) {
                id objectPath = [object valueForKey:@"path"];
                if ([objectPath isEqual:path]) {
                    return elt;
                }
            }
        }
    }

    return nil;
}

+ (void)openMacColorDirForPath:(id)path
{
    id realPath = [path asRealPath];

    id windowManager = [@"windowManager" valueForKey];

    id elt = [Definitions getMacColorDirForPath:realPath];
    if (elt) {
        [windowManager raiseObjectWindow:elt];
        return;
    }

    if ([realPath isDirectory]) {
        id object = [Definitions MacColorDir:realPath];
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

@implementation Definitions(fmekwlmfklsdmfklsmdklfmksldfjdksjfk)
+ (id)MacColorDesktop
{
    id observercmd = nsarr();
    [observercmd addObject:@"hotdog-monitorMountChanges"];
    id observer = [observercmd runCommandAndReturnProcess];
    if (!observer) {
NSLog(@"unable to run observer command %@", observercmd);
exit(1);
    }

    id obj = [@"MacColorDesktop" asInstance];
    [obj setValue:observer forKey:@"observer"];
    return obj;
}
@end

@interface MacColorDesktop : IvarObject
{
    id _observer;
    time_t _timestamp;

    id _selectionBox;
    int _buttonDownRootX;
    int _buttonDownRootY;
}
@end
@implementation MacColorDesktop
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
    id fileMenu = [[fileMenuCSV parseCSVFromString] asMenu];
    [fileMenu setValue:@"File" forKey:@"title"];
    [fileMenu setValue:@"1" forKey:@"unmapInsteadOfClose"];
    id editMenu = [[editMenuCSV parseCSVFromString] asMenu];
    [editMenu setValue:@"Edit" forKey:@"title"];
    [editMenu setValue:@"1" forKey:@"unmapInsteadOfClose"];
    id viewMenu = [[viewMenuCSV parseCSVFromString] asMenu];
    [viewMenu setValue:@"View" forKey:@"title"];
    [viewMenu setValue:@"1" forKey:@"unmapInsteadOfClose"];
    id labelMenu = [[labelMenuCSV parseCSVFromString] asMenu];
    [labelMenu setValue:@"Label" forKey:@"title"];
    [labelMenu setValue:@"1" forKey:@"unmapInsteadOfClose"];
    id specialMenu = [[specialMenuCSV parseCSVFromString] asMenu];
    [specialMenu setValue:@"Special" forKey:@"title"];
    [specialMenu setValue:@"1" forKey:@"unmapInsteadOfClose"];
    id results = nsarr();
    [results addObject:fileMenu];
    [results addObject:editMenu];
    [results addObject:viewMenu];
    [results addObject:labelMenu];
    [results addObject:specialMenu];
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
    [lines addObject:@"builtin:MacColorTrashIcon mountpoint:Trash"];

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
                obj = [@"MacColorComputerIcon" asInstance];
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

