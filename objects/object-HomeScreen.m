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

static int numberOfRows = 6;
static int numberOfColumns = 4;

@implementation Definitions(iewofkdslmvkcxvbapdwppqppowdsdkskskskaj)
+ (id)HomeScreen
{
    id obj = [@"HomeScreen" asInstance];
    id arr = nsarr();
    id contents = [@"." contentsOfDirectory];
    for (int i=0; i<[contents count]; i++) {
        id elt = [contents nth:i];
        if ([elt isDirectory]) {
            id palette = [nsfmt(@"%@/00palette", elt) stringFromFile];
            id pixels = [nsfmt(@"%@/00pixels", elt) stringFromFile];
            if (palette && pixels) {
                id dict = nsdict();
                [dict setValue:elt forKey:@"name"];
                [dict setValue:palette forKey:@"palette"];
                [dict setValue:pixels forKey:@"pixels"];
                [arr addObject:dict];
            }
        }
    }
    [obj setValue:arr forKey:@"array"];
    return obj;
}
@end

@interface HomeScreen : IvarObject
{
    id _array;
    Int4 _rects[6*4];
    int _mouseDownX;
    int _mouseDownY;
}
@end
@implementation HomeScreen
- (int)preferredWidth
{
    return 320;
}
- (int)preferredHeight
{
    return 480;
}

- (void)beginIteration:(id)event rect:(Int4)r
{
    int cellW = r.w / numberOfColumns;
    int cellH = r.h / numberOfRows;
    for (int j=0; j<numberOfRows; j++) {
        for (int i=0; i<numberOfColumns; i++) {
            int index = j*numberOfColumns+i;
            _rects[index].x = cellW*i + (cellW-60)/2;
            _rects[index].y = cellH*j + (cellH-60)/2;
            _rects[index].w = 60;
            _rects[index].h = 60;
        }
    }
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [bitmap setColor:@"#c3c7cb"];
    [bitmap fillRect:r];
    [bitmap setColor:@"black"];
    for (int j=0; j<numberOfRows; j++) {
        for (int i=0; i<numberOfColumns; i++) {
            int index = j*numberOfColumns+i;
            id elt = [_array nth:index];
            if (!elt) {
                break;
            }
            id pixels = [elt valueForKey:@"pixels"];
            id palette = [elt valueForKey:@"palette"];
            int iconWidth = 40;
            int iconHeight = 40;
            if (pixels) {
                iconWidth = [Definitions widthForCString:[pixels UTF8String]];
                iconHeight = [Definitions heightForCString:[pixels UTF8String]];
            }
            [bitmap drawCString:[pixels UTF8String] palette:[palette UTF8String] x:_rects[index].x+(_rects[index].w-iconWidth)/2 y:_rects[index].y+_rects[index].h-iconHeight];
            id text = [elt valueForKey:@"name"];
            int textWidth = [bitmap bitmapWidthForText:text];
            [bitmap drawBitmapText:text x:_rects[index].x+_rects[index].w/2-textWidth/2 y:_rects[index].y+_rects[index].h/2+40];
        }
    }
}

- (void)handleMouseDown:(id)event
{
    _mouseDownX = [event intValueForKey:@"mouseX"];
    _mouseDownY = [event intValueForKey:@"mouseY"];
}

- (void)handleMouseUp:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    for (int i=0; i<numberOfRows*numberOfColumns; i++) {
        if ([Definitions isX:_mouseDownX y:_mouseDownY insideRect:_rects[i]]) {
            if ([Definitions isX:mouseX y:mouseY insideRect:_rects[i]]) {
                id elt = [_array nth:i];
                id name = [elt valueForKey:@"name"];
                if (name) {
                    id cmd = nsarr();
                    [cmd addObject:@"hotdog"];
                    [cmd addObject:@"open"];
                    [cmd addObject:name];
                    [cmd runCommandInBackground];
                }
            }
        }
    }
}

@end

