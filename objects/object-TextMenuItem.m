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

@implementation Definitions(dsfjkdsjflkdsjlkfsdjf)
+ (id)TextMenuItem:(id)text
{
    id obj = [@"TextMenuItem" asInstance];
    [obj setValue:text forKey:@"text"];
    return obj;
}
@end

@interface TextMenuItem : IvarObject
{
    id _text;
}
@end

@implementation TextMenuItem
- (int)preferredWidth
{
    id str = [self str:_text];
    int w = [Definitions bitmapWidthForText:str];
    if (w) {
        return w;
    }
    return 10;
}
- (int)preferredWidthForBitmap:(id)bitmap
{
    id str = [self str:_text];
    int w = [bitmap bitmapWidthForText:str];
    if (w) {
        return w;
    }
    return 10;
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    id str = [self str:_text];
    int textW = [bitmap bitmapWidthForText:str];
    if (textW > r.w) {
        str = [bitmap fitBitmapString:str width:r.w];
    }
    [bitmap drawBitmapText:str x:r.x y:r.y+3];
}
- (void)drawHighlightedInBitmap:(id)bitmap rect:(Int4)r
{
    id str = [self str:_text];
    int textW = [bitmap bitmapWidthForText:str];
    if (textW > r.w) {
        str = [bitmap fitBitmapString:str width:r.w];
    }
    [bitmap setColorIntR:255 g:255 b:255 a:255];
    [bitmap drawBitmapText:str x:r.x y:r.y+3];
}


@end
