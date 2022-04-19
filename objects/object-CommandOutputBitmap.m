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
            id arr = [@"pixels palette highlightedPalette" split];
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
@end
