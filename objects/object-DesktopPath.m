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

static id _text = @"FIXME: This window should not be displayed";

@implementation Definitions(fmkelwmfklsdklfmklsdmfklsdklfm)
+ (id)DesktopPath
{
    return [@"DesktopPath" asInstance];
}
@end

@interface DesktopPath : IvarObject
{
    time_t _desktopPathTimestamp;
}
@end
@implementation DesktopPath
- (id)dictForObjectFilePath:(id)filePath objectWindows:(id)objectWindows
{
    for (int i=0; i<[objectWindows count]; i++) {
        id dict = [objectWindows nth:i];
        id val = [dict valueForKey:@"filePath"];
        if ([val isEqual:filePath]) {
            return dict;
        }
    }
    return nil;
}
- (void)handleBackgroundUpdate:(id)event
{
    id path = [Definitions configDir:@"Desktop"];
    time_t timestamp = [path fileModificationTimestamp];
    if (timestamp != _desktopPathTimestamp) {
        id windowManager = [event valueForKey:@"windowManager"];
        [self handleDesktopPath:path windowManager:windowManager];
        _desktopPathTimestamp = timestamp;
    }
}

- (void)handleDesktopPath:(id)desktopPath windowManager:(id)windowManager
{
    id objectWindows = [windowManager valueForKey:@"objectWindows"];

    id contents = [desktopPath contentsOfDirectoryWithFullPaths];
    for (int i=0; i<[objectWindows count]; i++) {
        id dict = [objectWindows nth:i];
        id filePath = [dict valueForKey:@"filePath"];
        if (!filePath) {
            continue;
        }
        if ([contents containsObject:filePath]) {
            continue;
        }
        [dict setValue:@"1" forKey:@"shouldCloseWindow"];
    }


    int monitorWidth = [windowManager intValueForKey:@"rootWindowWidth"];
    int monitorHeight = [windowManager intValueForKey:@"rootWindowHeight"];


    int maxWidth = 16;
    int cursorX = 10;
    int cursorY = 30;
    for (int i=0; i<[contents count]; i++) {
        id path = [contents nth:i];
        if ([[path lastPathComponent] hasPrefix:@"."]) {
            continue;
        }
        id dict = [self dictForObjectFilePath:path objectWindows:objectWindows];
        if (!dict) {
            id obj = [path iconFromFile];
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
            [windowManager openWindowForObject:obj x:cursorX y:cursorY w:w h:h overrideRedirect:YES];
            cursorY += h+10;
            dict = [windowManager dictForObject:obj];
            [dict setValue:path forKey:@"filePath"];
        } else {
            id icon = [path iconFromFile];
            id fileDict = [icon valueForKey:@"fileDict"];
            if (fileDict) {
                id obj = [dict valueForKey:@"object"];
                [obj setValue:fileDict forKey:@"fileDict"];
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
                [dict setValue:nsfmt(@"%d %d", w, h) forKey:@"resizeWindow"];
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
@end

