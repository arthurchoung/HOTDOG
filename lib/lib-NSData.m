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

@implementation NSData(fiewojfidsojfkdsjfkdsj)

- (id)asStringOfByteValues
{
    id results = nsarr();
    unsigned char *bytes = [self bytes];
    for (int i=0; i<[self length]; i++) {
        [results addObject:nsfmt(@"%d\n", bytes[i])];
    }
    return [results join:@""];
}

- (id)description
{
    return nsfmt(@"<NSData: %d bytes>", [self length]);
}

- (const unsigned char) byteAtIndex:(int) i
{
    const unsigned char buffer[2];
    [self getBytes:(void *)&buffer location:i length:1];
    return buffer[0];
}
- (int32_t)int32AtIndex:(int)i
{
    uint8_t buffer[4];
    [self getBytes:(void *)&buffer location:i length:4];
    return buffer[0]*256*256*256 + buffer[1]*256*256 + buffer[2]*256 + buffer[3];
}


- (id)asString
{
    return [[[NSString alloc] initWithBytes:[self bytes] length:[self length]] autorelease];
}

- (id)readGroupOfLines
{
    id data = self;
    int len = [data length];
    if (!len) {
        return nil;
    }
    char *bytes = [data bytes];
    char *cursor = bytes;
    char *p = NULL;

    for (;;) {
        if (len-(cursor-bytes) <= 0) {
            return nil;
        }
        p = memchr(cursor, '\n', len-(cursor-bytes));
        if (!p) {
            return nil;
        }
        if (p == cursor) {
            break;
        }
        cursor = p+1;
    }


    id result;
    if (p == bytes) {
        result = @"";
    } else {
        result = nscstrn(bytes, p-bytes);
    }
    [data deleteBytesFromIndex:0 length:p-bytes+1];
    return result;
}
- (id)readLine
{
    id data = self;
    int len = [data length];
    if (!len) {
        return nil;
    }
    char *bytes = [data bytes];
    char *p = memchr(bytes, '\n', len);
    if (!p) {
        return nil;
    }
    id result;
    if (p == bytes) {
        result = @"";
    } else {
        result = nscstrn(bytes, p-bytes);
    }
    [data deleteBytesFromIndex:0 length:p-bytes+1];
    return result;
}
@end




