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

@implementation Definitions(fjdksljfklsdjklf)

+ (id)INotifyWait:(id)args
{
    if ([args isKindOfClass:[@"NSArray" asClass]]) {
        if (![args count]) {
            return nil;
        }
    } else {
        if (![args length]) {
            return nil;
        }
        args = @[ args ];
    }

    id files = nsarr();

    id cmd = nsarr();
    [cmd addObject:@"inotifywait"];
    [cmd addObject:@"-m"];
    [cmd addObject:@"-c"];
    for (id elt in args) {
        if ([elt isDirectory]) {
            [cmd addObject:elt];
        } else if ([elt isFile]) {
            id path = [elt stringByDeletingLastPathComponent];
            [cmd addObject:path];
            [files addObject:[elt lastPathComponent]];
        }
    }
    id pipe = [cmd runCommandAndReturnPipe];
    if (!pipe) {
        return nil;
    }
    [pipe closeOutput];
    id obj = [@"INotifyWait" asInstance];
    [obj setValue:args forKey:@"args"];
    if ([files count]) {
        [obj setValue:files forKey:@"files"];
    }
    [obj setValue:pipe forKey:@"pipe"];
    return obj;
}

@end
@interface INotifyWait : IvarObject
{
    id _args;
    id _files;
    id _pipe;
    id _notifications;
}
@end
@implementation INotifyWait
- (int)fileDescriptor
{
    if (_pipe) {
        return [_pipe fileDescriptor];
    }
    return -1;
}
- (void)handleFileDescriptor
{
    [_pipe handleFileDescriptor];
    for(;;) {
        id line = [[_pipe valueForKey:@"data"] readLine];
        if (!line) {
            break;
        }
NSLog(@"inotifywait line '%@'", line);
        id tokens = [[line parseCSVFromStringNoHeader] nth:0];
NSLog(@"inotifywait tokens '%@'", tokens);
        id path = [tokens nth:0];
        id attrib = [tokens nth:1];
        id file = [tokens nth:2];
        if ([attrib isEqual:@"CLOSE_WRITE,CLOSE"] || [attrib hasPrefix:@"DELETE"] || [attrib hasPrefix:@"MOVED_FROM"] || [attrib hasPrefix:@"MOVED_TO"] || [attrib hasPrefix:@"CREATE"]) {
            if (file && _files) {
                if (![_files containsObject:file]) {
                    continue;
                }
            }
            if (!_notifications) {
                [self setValue:nsarr() forKey:@"notifications"];
            }
            [_notifications addObject:path];
        }
    }
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [bitmap setColor:@"white"];
    [bitmap fillRect:r];
    [bitmap setColor:@"black"];
    [bitmap drawBitmapText:nsfmt(@"%@", [_notifications join:@"\n"]) x:r.x+4 y:r.y+4];
}
@end

