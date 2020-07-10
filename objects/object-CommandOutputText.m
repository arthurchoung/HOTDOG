/*

 PEEOS

 Copyright (c) 2020 Arthur Choung. All rights reserved.

 Email: arthur -at- peeos.org

 This file is part of PEEOS.

 PEEOS is free software: you can redistribute it and/or modify it
 under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <https://www.gnu.org/licenses/>.

 */

#import "PEEOS.h"

@implementation Definitions(fjkdlsfjlksdjkf)
+ (id)CommandOutputText:(id)cmd
{
    id pipe = [cmd runCommandAndReturnPipe];
    id obj = [@"CommandOutputText" asInstance];
    [obj setValue:pipe forKey:@"fileDescriptor"];
    return obj;
}
@end

@interface CommandOutputText : IvarObject
{
    id _fileDescriptor;
    id _lastLine;
    int _maxWidth;
}
@end
@implementation CommandOutputText
- (int)fileDescriptor
{
    if (_fileDescriptor) {
        return [_fileDescriptor fileDescriptor];
    }
    return -1;
}
- (void)handleFileDescriptor
{
    if (_fileDescriptor) {
        [_fileDescriptor handleFileDescriptor];
        for(;;) {
            id line = [[_fileDescriptor valueForKey:@"data"] readLine];
            if (!line) {
                break;
            }
            [self setValue:line forKey:@"lastLine"];
        }
    }
}
- (int)preferredWidth
{
    int len = [_lastLine length];
    if (!len) {
        return 200;
    }

    int w = [Definitions bitmapWidthForText:_lastLine];
    if (w > _maxWidth) {
        _maxWidth = w;
    }
    return _maxWidth;
}
- (int)preferredWidthForBitmap:(id)bitmap
{
    int len = [_lastLine length];
    if (!len) {
        return 200;
    }

    int w = [bitmap bitmapWidthForText:_lastLine];
    if (w > _maxWidth) {
        _maxWidth = w;
    }
    return _maxWidth;
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    id str = _lastLine;
    if (!str) {
        str = @"No output";
    }
    [bitmap drawBitmapText:str x:r.x y:r.y+4];
}
- (void)drawHighlightedInBitmap:(id)bitmap rect:(Int4)r
{
    id str = _lastLine;
    if (!str) {
        str = @"No output";
    }
    [bitmap setColorIntR:255 g:255 b:255 a:255];
    [bitmap drawBitmapText:str x:r.x y:r.y+4];
}

@end
