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

static char *trash_can_palette =
"b #000000\n"
". #000022\n"
"X #FF8800\n"
"o #0055AA\n"
"O #FFFFFF\n"
;

static char *trash_can_pixels =
"                            ................             \n"
"                            bbbbbbbbbbbbbbbb             \n"
"                           ...            ...            \n"
"                           bbb            bbb            \n"
"                ......................................   \n"
"                bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb   \n"
"              ..X.X.X.X.X.X.XXXXXXXXXXXXXXXXXXXXXXXXXX.. \n"
"              bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
"             ..X.X.X.X.X.X.X.X.X.X.X.XXXXXXXXXXXXXXXXXX..\n"
"             bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"             ............................................\n"
"             bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"              ..X.X.X.X.X.X.X.XXXXXXXXXXXXXXXXXXXXXXXX.. \n"
"              bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
"              ...X.X.X.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX.. \n"
"              bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
"               ...X......XXXXXXX.......XXXXXX.....XXX..  \n"
"               bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
"               ..X...X.X...XXX...X.X.X..XXX..X.X...XX..  \n"
"               bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
"               ...X...XXX..XXX..X.XXXX..XXX...XXX..XX..  \n"
"               bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
"               ..X...X.XX..XXX...X.XXX..XXX..X.XX..XX..  \n"
"               bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
"                ..X...XXX..XXX..X.XXXX..XXX...XXX..X..   \n"
"                bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb   \n"
"                ...X...XXX..XX...X.XXX..XX...XXX..XX..   \n"
"                bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb   \n"
"                ..X...X.XX..XX..X.XXXX..XX..X.XX..XX..   \n"
"                bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb   \n"
"                ...X...XXX..XXX..X.XX..XXX...XXX..XX..   \n"
"                bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb   \n"
"                 ...X...XX..XXX...XXX..XXX..XXX..XX..    \n"
"                 bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb    \n"
"                 ..X...X.X..XXX..X.XX..XXX...XX..XX..    \n"
"                 bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb    \n"
"                 ...X...XXX..XX...XXX..XX...XXX..XX..    \n"
"                 bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb    \n"
"                 ..X.X...XX..XX..X.XX..XX..X.X..XXX..    \n"
"                 bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb    \n"
"             .......X...X.X..XXX..XX..XXX...XX..XX..     \n"
"             bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb     \n"
"    .................X...X...XXX...X..XXX..X...XXX..     \n"
"    bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb     \n"
"....................X.X.....X.X.X....XXXXX....XXXX..     \n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb     \n"
"  .....................X.X.X.X.X.XXXXXXXXXXXXXXX...      \n"
"  bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb      \n"
"       ..........................................        \n"
"       bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb        \n"
"                 ....................                    \n"
"                 bbbbbbbbbbbbbbbbbbbb                    \n"
;


static char *open_trash_can_palette =
"b #000000\n"
". #000022\n"
"X #FF8800\n"
"o #0055AA\n"
"O #FFFFFF\n"
;

static char *open_trash_can_pixels =
"                          ..................              \n"
"                          bbbbbbbbbbbbbbbbbb              \n"
"                   .......XXXXXXXXXXXXXXXXXX.......       \n"
"                   bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb       \n"
"              .....XXXXXXXX.................XXXXXXX.....  \n"
"              bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
"             ..XXXX........X.X.X.XXXXX.X.X.X......XXXXX.. \n"
"             bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
"            ..XX....X.X.X.X.X.XXXX.X.XXXX.X.X.X.X.....XX..\n"
"            bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"             ..X..XX.X.X.X.X.X.X.XXXXX.X.X.X.X.X.XXX..X.. \n"
"             bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb \n"
"              ......XXXXXXX.X.X.X.X.X.X.X.X.XXXXXX......  \n"
"              bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
"                  .........XXXXXXXXXXXXXXXXX........      \n"
"                  bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb      \n"
"                          ...................             \n"
"                          bbbbbbbbbbbbbbbbbbb             \n"
"              ..........................................  \n"
"              bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
"              ..X.X.X.X.X.X.X.XXXXXXXXXXXXXXXXXXXXXXXX..  \n"
"              bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
"              ...X.X.X.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX..  \n"
"              bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb  \n"
"               ...X......XXXXXXX.......XXXXXX.....XXX..   \n"
"               bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb   \n"
"               ..X...X.X...XXX...X.X.X..XXX..X.X...XX..   \n"
"               bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb   \n"
"               ...X...XXX..XXX..X.XXXX..XXX...XXX..XX..   \n"
"               bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb   \n"
"               ..X...X.XX..XXX...X.XXX..XXX..X.XX..XX..   \n"
"               bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb   \n"
"                ..X...XXX..XXX..X.XXXX..XXX...XXX..X..    \n"
"                bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb    \n"
"                ...X...XXX..XX...X.XXX..XX...XXX..XX..    \n"
"                bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb    \n"
"                ..X...X.XX..XX..X.XXXX..XX..X.XX..XX..    \n"
"                bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb    \n"
"                ...X...XXX..XXX..X.XX..XXX...XXX..XX..    \n"
"                bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb    \n"
"                 ...X...XX..XXX...XXX..XXX..XXX..XX..     \n"
"                 bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb     \n"
"                 ..X...X.X..XXX..X.XX..XXX...XX..XX..     \n"
"                 bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb     \n"
"                 ...X...XXX..XX...XXX..XX...XXX..XX..     \n"
"                 bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb     \n"
"                 ..X.X...XX..XX..X.XX..XX..X.X..XXX..     \n"
"                 bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb     \n"
"             .......X...X.X..XXX..XX..XXX...XX..XX..      \n"
"             bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb      \n"
"    .................X...X...XXX...X..XXX..X...XXX..      \n"
"    bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb      \n"
"....................X.X.....X.X.X....XXXXX....XXXX..      \n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb      \n"
"  .....................X.X.X.X.X.XXXXXXXXXXXXXXX...       \n"
"  bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb       \n"
"       ..........................................         \n"
"       bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb         \n"
"                 ....................                     \n"
"                 bbbbbbbbbbbbbbbbbbbb                     \n"
;

@implementation Definitions(INMfewlfmklsdmvklsjdklfjklsdf)
+ (id)AmigaSay
{
    id obj = [@"AmigaSay" asInstance];
    return obj;
}
@end


@interface AmigaSay : IvarObject
{
    int _animating;
    int _open;
    id _process;
}
@end
@implementation AmigaSay
- (BOOL)shouldAnimate
{
    return (_animating) ? YES : NO;
}

- (int)fileDescriptor
{
    if (_process) {
        return [_process fileDescriptor];
    } else {
        return -1;
    }
}

- (void)handleFileDescriptor
{
    if (_process) {
        [_process handleFileDescriptor];
        id status = [_process valueForKey:@"status"];
        if (status) {
            [self setValue:nil forKey:@"process"];
            _animating = 0;
        }
    }
}

- (int)preferredWidth
{
    return [Definitions widthForCString:open_trash_can_pixels]+10;
}
- (int)preferredHeight
{
    return [Definitions heightForCString:open_trash_can_pixels]+10;
}

- (void)beginIteration:(id)event rect:(Int4)r
{
    if (_animating) {
        _animating++;
    }
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [bitmap setColor:@"blue"];
    [bitmap fillRect:r];
    if ((_animating / 10) % 2 == 1) {
        [bitmap drawCString:open_trash_can_pixels palette:open_trash_can_palette x:r.x+5 y:r.y+5];
    } else {
        [bitmap drawCString:trash_can_pixels palette:trash_can_palette x:r.x+5 y:r.y+5];
    }
}
- (void)handleMouseDown:(id)event
{
NSLog(@"handleMouseDown");
    if (!_animating) {
        id text = [Definitions inputTextWithAlert:@"What should I say?"];
        if ([text length]) {
            _animating = 1;
            id cmd = nsarr();
            [cmd addObject:@"SAM"];
            [cmd addObject:text];
            id process = [cmd runCommandAndReturnProcess];
            [self setValue:process forKey:@"process"];
        }
    }
}
@end

