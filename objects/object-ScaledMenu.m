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

@interface ScaledMenu : IvarObject
{
    int _hasShadow;
    id _wrappedObject;
    int _pixelScaling;
}
@end

@implementation ScaledMenu

- (id)init
{
    self = [super init];
    if (self) {
        id obj = [@"AmigaMenu" asInstance];
        [self setValue:obj forKey:@"wrappedObject"];
        _hasShadow = [obj intValueForKey:@"hasShadow"];;
        int scaling = [[Definitions valueForEnvironmentVariable:@"HOTDOG_SCALING"] intValue];
        if (scaling < 1) {
            scaling = 1;
        }
        _pixelScaling = scaling;
    }
    return self;
}
- (int)preferredWidth
{
    if ([_wrappedObject respondsToSelector:@selector(preferredWidth)]) {
        int w = [_wrappedObject preferredWidth];
        return w*_pixelScaling;
    }
    return 100;
}
- (int)preferredHeight
{
    if ([_wrappedObject respondsToSelector:@selector(preferredHeight)]) {
        int h = [_wrappedObject preferredHeight];
        return h*_pixelScaling;
    }
    return 100;
}

- (int)fileDescriptor
{
    if ([_wrappedObject respondsToSelector:@selector(fileDescriptor)]) {
        return [_wrappedObject fileDescriptor];
    }
    return -1;
}

- (void)handleFileDescriptor
{
    if ([_wrappedObject respondsToSelector:@selector(handleFileDescriptor)]) {
        [_wrappedObject handleFileDescriptor];
    }
}

- (void)beginIteration:(id)event rect:(Int4)r
{
    if ([_wrappedObject respondsToSelector:@selector(beginIteration:rect:)]) {
        [_wrappedObject beginIteration:event rect:r];
    }
}

- (void)endIteration:(id)event
{
    if ([_wrappedObject respondsToSelector:@selector(endIteration:)]) {
        [_wrappedObject endIteration:event];
    }
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)r context:(id)context
{
    Int4 r1 = r;
    r1.w /= _pixelScaling;
    r1.h /= _pixelScaling;
    id wrappedBitmap = [Definitions bitmapWithWidth:r1.w height:r1.h];
    if ([_wrappedObject respondsToSelector:@selector(drawInBitmap:rect:context:)]) {
        [_wrappedObject drawInBitmap:wrappedBitmap rect:r1 context:context];
    } else if ([_wrappedObject respondsToSelector:@selector(drawInBitmap:rect:)]) {
        [_wrappedObject drawInBitmap:wrappedBitmap rect:r1];
    }
    [bitmap drawBitmap:wrappedBitmap x:r.x y:r.y w:r.w h:r.h];
}
- (void)handleKeyDown:(id)event
{
    if ([_wrappedObject respondsToSelector:@selector(handleKeyDown:)]) {
        [self fixupEvent:event];
        [_wrappedObject handleKeyDown:event];
    }
}
- (void)handleScrollWheel:(id)event
{
    if ([_wrappedObject respondsToSelector:@selector(handleScrollWheel:)]) {
        [self fixupEvent:event];
        [_wrappedObject handleScrollWheel:event];
    }
}
- (void)handleMouseMoved:(id)event
{
    if ([_wrappedObject respondsToSelector:@selector(handleMouseMoved:)]) {
        [self fixupEvent:event];
        [_wrappedObject handleMouseMoved:event];
    }
}

- (void)handleMouseUp:(id)event
{
    if ([_wrappedObject respondsToSelector:@selector(handleMouseUp:)]) {
        [self fixupEvent:event];
        [_wrappedObject handleMouseUp:event];
    }
}
- (void)handleRightMouseUp:(id)event
{
    if ([_wrappedObject respondsToSelector:@selector(handleRightMouseUp:)]) {
        [self fixupEvent:event];
        [_wrappedObject handleRightMouseUp:event];
    }
}
- (void)fixupEvent:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    int viewWidth = [event intValueForKey:@"viewWidth"];
    int viewHeight = [event intValueForKey:@"viewHeight"];
    mouseX /= _pixelScaling;
    mouseY /= _pixelScaling;
    viewWidth /= _pixelScaling;
    viewHeight /= _pixelScaling;
    [event setValue:nsfmt(@"%d", mouseX) forKey:@"mouseX"];
    [event setValue:nsfmt(@"%d", mouseY) forKey:@"mouseY"];
    [event setValue:nsfmt(@"%d", viewWidth) forKey:@"viewWidth"];
    [event setValue:nsfmt(@"%d", viewHeight) forKey:@"viewHeight"];
}
@end

