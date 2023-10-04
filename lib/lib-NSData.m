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

@implementation NSData(fiewojfidsojfkdsjfkdsj)
- (id)blocksFromData
{
    id results = nsarr();
    id dict = nsdict();
    for(;;) {
        id line = [self readLine];
        if (!line) {
            break;
        }
        int len = [line length];
        if (!len) {
            // empty line
            if ([dict count]) {
                [results addObject:dict];
                dict = nsdict();
            }
        } else {
            char *buf = [line UTF8String];
            char *p = strchr(buf, ':');
            if (p) {
                *p = 0;
                p++;
                [dict setValue:nsfmt(@"%s", p) forKey:nsfmt(@"%s", buf)];
            }
        }
    }
    if ([dict count]) {
        [results addObject:dict];
    }
    return results;
}

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
- (id)bitmapFromPPMP6
{
    id data = self;
    unsigned char *a = [data bytes];
    int len = [data length];
    unsigned char *end = a + len;

    if ((len >= 2) && (a[0] == 'P') && (a[1] == '6')) {
    } else {
NSLog(@"unsupported, expecting P6");
        return nil;
    }

    if ((len >= 3) && (a[2] == '\n')) {
    } else {
NSLog(@"expecting newline");
        return nil;
    }

    if (len-3 <= 1) {
NSLog(@"not enough data");
        return nil;
    }
    unsigned char *b = memchr(a+3, ' ', len-3);
    if (!b) {
NSLog(@"expecting space");
        return nil;
    }
    *b = 0;
    b++;
    int w = strtol(a+3, NULL, 10);

    if (len-(b-a) <= 1) {
NSLog(@"not enough data");
        return nil;
    }
    unsigned char *c = memchr(b, '\n', len-(b-a));
    if (!c) {
NSLog(@"expecting newline");
        return nil;
    }
    *c = 0;
    c++;
    int h = strtol(b, NULL, 10);

    if (len-(c-a) <= 1) {
NSLog(@"not enough data");
        return nil;
    }
    unsigned char *d = memchr(c, '\n', len-(c-a));
    if (!d) {
NSLog(@"expecting newline");
        return nil;
    }
    *d = 0;
    d++;
    int maxval = strtol(c, NULL, 10);

    int index = d - a;
//NSLog(@"index %d w %d h %d maxval %d len %d", index, w, h, maxval, len);

    if (maxval == 255) {
        if (index+(w*h*3) == len) {
        } else {
NSLog(@"invalid length %d index %d w %d h %d", len, index, w, h);
            return nil;
        }
        id bitmap = [Definitions bitmapWithWidth:w height:h];
        unsigned char *pixels = [bitmap pixelBytes];
        for (int y=0; y<h; y++) {
            for (int x=0; x<w; x++) {
                pixels[0] = d[2];
                pixels[1] = d[1];
                pixels[2] = d[0];
                pixels[3] = 255;
                pixels += 4;
                d += 3;
            }
        }
        return bitmap;
    } else if (maxval == 65535) {
        if (index+(w*h*6) == len) {
        } else {
NSLog(@"invalid length");
            return nil;
        }
        id bitmap = [Definitions bitmapWithWidth:w height:h];
        unsigned char *pixels = [bitmap pixelBytes];
        for (int y=0; y<h; y++) {
            for (int x=0; x<w; x++) {
                pixels[0] = d[4];
                pixels[1] = d[2];
                pixels[2] = d[0];
                pixels[3] = 255;
                pixels += 4;
                d += 6;
            }
        }
        return bitmap;
    } else {
NSLog(@"unsupported maxval %d", maxval);
        return nil;
    }
}
@end




