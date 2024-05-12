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

static unsigned char *bitmapDefaultButtonLeftPixels =
"     bbb\n"
"   bbbbb\n"
"  bbbbbb\n"
" bbbbwww\n"
" bbbwwwb\n"
"bbbwwbb.\n"
"bbbwwb..\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwb...\n"
"bbbwwb..\n"
"bbbwwbb.\n"
" bbbwwwb\n"
" bbbbwww\n"
"  bbbbbb\n"
"   bbbbb\n"
"     bbb\n"
;
static unsigned char *bitmapDefaultButtonMiddlePixels =
"b\n"
"b\n"
"b\n"
"w\n"
"b\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
".\n"
"b\n"
"w\n"
"b\n"
"b\n"
"b\n"
;
static unsigned char *bitmapDefaultButtonRightPixels =
"bbb     \n"
"bbbbb   \n"
"bbbbbb  \n"
"wwwbbbb \n"
"bwwwbbb \n"
".bbwwbbb\n"
"..bwwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"...bwbbb\n"
"..bwwbbb\n"
".bbwwbbb\n"
"bwwwbbb \n"
"wwwbbbb \n"
"bbbbbb  \n"
"bbbbb   \n"
"bbb     \n"
;
static void drawDefaultButtonInBitmap_rect_palette_(id bitmap, Int4 r, unsigned char *palette)
{
    unsigned char *left = bitmapDefaultButtonLeftPixels;
    unsigned char *middle = bitmapDefaultButtonMiddlePixels;
    unsigned char *right = bitmapDefaultButtonRightPixels;

    [Definitions drawInBitmap:bitmap left:left middle:middle right:right centeredInRect:r palette:palette];
}



static void drawAlertBorderInBitmap_rect_(id bitmap, Int4 r)
{
    [bitmap setColor:@"white"];
    [bitmap fillRect:r];
    unsigned char *pixels = [bitmap pixelBytes];
    if (!pixels) {
        return;
    }
    int bitmapWidth = [bitmap bitmapWidth];
    int bitmapHeight = [bitmap bitmapHeight];
    int bitmapStride = [bitmap bitmapStride];
    for (int i=0; i<bitmapWidth; i++) {
        unsigned char *p = pixels + i*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }
    for (int i=3; i<bitmapWidth-3; i++) {
        unsigned char *p = pixels + bitmapStride*3 + i*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }
    for (int i=4; i<bitmapWidth-4; i++) {
        unsigned char *p = pixels + bitmapStride*4 + i*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }

    for (int i=0; i<bitmapWidth; i++) {
        unsigned char *p = pixels + bitmapStride*(bitmapHeight-1) + i*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }
    for (int i=3; i<bitmapWidth-3; i++) {
        unsigned char *p = pixels + bitmapStride*(bitmapHeight-1-3) + i*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }
    for (int i=4; i<bitmapWidth-4; i++) {
        unsigned char *p = pixels + bitmapStride*(bitmapHeight-1-4) + i*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }

    for (int i=1; i<bitmapHeight-1; i++) {
        unsigned char *p = pixels + bitmapStride*i + 0;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }
    for (int i=1; i<bitmapHeight-1; i++) {
        unsigned char *p = pixels + bitmapStride*i + (bitmapWidth-1)*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }
    for (int i=4; i<bitmapHeight-4; i++) {
        unsigned char *p = pixels + bitmapStride*i + 3*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }
    for (int i=4; i<bitmapHeight-4; i++) {
        unsigned char *p = pixels + bitmapStride*i + (bitmapWidth-1-3)*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }
    for (int i=5; i<bitmapHeight-5; i++) {
        unsigned char *p = pixels + bitmapStride*i + 4*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }
    for (int i=5; i<bitmapHeight-5; i++) {
        unsigned char *p = pixels + bitmapStride*i + (bitmapWidth-1-4)*4;
        p[0] = 0; p[1] = 0; p[2] = 0; p[3] = 0;
    }

}

@implementation NSObject(jflkdsjfoiewjflkdsjfklsdjf)
- (void)showAlert
{
    [[self description] showAlert];
}

@end

#if defined(BUILD_FOR_LINUX) || defined(BUILD_FOR_FREEBSD)

#ifdef BUILD_FOR_ANDROID
@implementation Definitions(fjkdlsjfkldsjfkldsjklfwejffjdkjfkdjlsdfjdsk)
+ (void)showAlert:(id)text
{
    NSLog(@"%@", text);
}
@end
@implementation NSString(fmeklwmfklsdmfklsdmkflmsd)
- (void)showAlert
{
    NSLog(@"%@", self);
}
@end
#else
@implementation Definitions(fjkdlsjfkldsjfkldsjklfwejffjdkjfkdjlsd)
+ (void)showAlert:(id)text
{
    id windowManager = [@"windowManager" valueForKey];
    if ([windowManager intValueForKey:@"isWindowManager"]) {
NSLog(@"showAlert:'%@'", text);
        return;
    }
    id cmd = nsarr();
    [cmd addObject:@"hotdog"];
    [cmd addObject:@"alert"];
    [cmd runCommandInBackgroundAndWriteStringToStandardInput:text];
}
@end
@implementation NSString(yjfhjhjhmv)


- (void)showAlert
{
    id windowManager = [@"windowManager" valueForKey];
    if ([windowManager intValueForKey:@"isWindowManager"]) {
NSLog(@"showAlert:'%@'", self);
        return;
    }
    id cmd = nsarr();
    [cmd addObject:@"hotdog"];
    [cmd addObject:@"alert"];
    [cmd runCommandInBackgroundAndWriteStringToStandardInput:self];
}

@end
#endif

#endif


@implementation Definitions(jfldslkfjdslknvmcnxmjf)
+ (char *)cStringForBitmapMessageIcon
{
    return
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
"b........bbbbbbbbbbbbbbbbbbbbbbb\n"
"b........bbbbbbbbbbbbbbbbbbbbbbb\n"
"b........bbbbbbbbbbbbbbbbbbbbbbb\n"
"b........bbbbbbbbbbbbbbbbbbbbbbb\n"
"b........bbbbbbbbb......bbbbbbbb\n"
"b...b....bbbbbbb..........bbbbbb\n"
"b...b....bbbbbb............bbbbb\n"
"b...b....bbbbb..............bbbb\n"
"b........bbbb................bbb\n"
"b........bbbb................bbb\n"
"b........bbb..................bb\n"
"b........bbb...bbb.bbb.bbb....bb\n"
"b........bbb..................bb\n"
"b........bbb..................bb\n"
"b........bbb...bbb.bbb.b.b....bb\n"
"b........bbb..................bb\n"
"b........bbb..................bb\n"
"b........bbb...bbb.b.bbb......bb\n"
"b........bbb..................bb\n"
"b....bbbbbbb..................bb\n"
"b......bbbbb...bbbb.bbb.bb....bb\n"
"b......bbbbb.................bbb\n"
"b......bbbbb.................bbb\n"
"b......bbbbb................bbbb\n"
"b......bbbb................bbbbb\n"
"b...bbbbb................bbbbbbb\n"
"b......bbbbbbbbbbbbbbbbbbbbbbbbb\n"
"b......bbbbbbbbbbbbbbbbbbbbbbbbb\n"
"b......bbbbbbbbbbbbbbbbbbbbbbbbb\n"
"b......bbbbbbbbbbbbbbbbbbbbbbbbb\n"
"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb\n"
;
}
+ (int)preferredHeightForBitmapMessageAlert:(id)text width:(int)width
{
    int textWidth = width - 89 - 18;
    id fittedText = [Definitions fitBitmapString:text width:textWidth];

    int minAlertHeight = 28 + 32 + 23 + 28 + 21;
    int textHeight = [Definitions bitmapHeightForText:fittedText];
    int alertHeight = 24 + textHeight + 20 + 28 + 21;
    if (alertHeight < minAlertHeight) {
        alertHeight = minAlertHeight;
    }
    return alertHeight;
}
@end

@interface BitmapMessageAlert : IvarObject
{
    id _text;
    Int4 _buttonRect;
    int _buttonDown;
    int _buttonHover;
    int _returnKey;
}
@end
@implementation BitmapMessageAlert
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    drawAlertBorderInBitmap_rect_(bitmap, r);
    char *palette = "b #000000\n. #ffffff\n";
    [bitmap drawCString:[Definitions cStringForBitmapMessageIcon] palette:palette x:28 y:28];
    _buttonRect = [Definitions rectWithX:r.w-88 y:r.h-21-28 w:70 h:28];
    Int4 textRect = _buttonRect;
    textRect.y += 1;
    BOOL okButtonDown = NO;
    if (_buttonDown && _buttonHover) {
        okButtonDown = YES;
    } else if (_returnKey) {
        okButtonDown = YES;
    }
    if (okButtonDown) {
        char *palette = ". #000000\nb #000000\nw #ffffff\n";
        drawDefaultButtonInBitmap_rect_palette_(bitmap, _buttonRect, palette);
        [bitmap setColorIntR:255 g:255 b:255 a:255];
        [bitmap drawBitmapText:@"OK" centeredInRect:textRect];
    } else {
        char *palette = ". #ffffff\nb #000000\nw #ffffff\n";
        drawDefaultButtonInBitmap_rect_palette_(bitmap, _buttonRect, palette);
        [bitmap setColorIntR:0 g:0 b:0 a:255];
        [bitmap drawBitmapText:@"OK" centeredInRect:textRect];
    }
    int textWidth = (int)r.w - 89 - 18;
    id text = [bitmap fitBitmapString:_text width:textWidth];
    [bitmap setColorIntR:0 g:0 b:0 a:255];
    [bitmap drawBitmapText:text x:89 y:24];
}
- (void)handleKeyDown:(id)event
{
    id str = [event valueForKey:@"keyString"];
    if ([str isEqual:@"return"] || [str isEqual:@"shift-return"]) {
        _returnKey = 1;
    }
}
- (void)handleKeyUp:(id)event
{
    id str = [event valueForKey:@"keyString"];
    if ([str isEqual:@"return"] || [str isEqual:@"shift-return"]) {
        if (_returnKey) {
            [self handleCloseEvent:event];
            _returnKey = 0;
        }
    }
}
- (void)handleMouseDown:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    _buttonDown = 0;
    if ([Definitions isX:mouseX y:mouseY insideRect:_buttonRect]) {
        _buttonDown = 1;
    }
}
- (void)handleMouseMoved:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    _buttonHover = 0;
    if ([Definitions isX:mouseX y:mouseY insideRect:_buttonRect]) {
        _buttonHover = 1;
    }
}
- (void)handleMouseUp:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    int buttonUp = 0;
    if ([Definitions isX:mouseX y:mouseY insideRect:_buttonRect]) {
        if (_buttonDown == 1) {
            buttonUp = _buttonDown;
        }
    }
    _buttonDown = 0;
    if (buttonUp == 1) {
        [self handleCloseEvent:event];
    }
}
- (void)handleCloseEvent:(id)event
{
    id x11dict = [event valueForKey:@"x11dict"];
    [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
}
@end

@implementation NSString(fjlkdslkjfsdjf)
- (id)asBitmapMessageAlert
{
    id obj = [@"BitmapMessageAlert" asInstance];
    [obj setValue:self forKey:@"text"];
    return obj;
}
@end
