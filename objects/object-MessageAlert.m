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

@implementation NSObject(jflkdsjfoiewjflkdsjfklsdjf)
- (void)showAlert
{
    [[self description] showAlert];
}

@end

#ifdef BUILD_FOR_LINUX

@implementation Definitions(fjkdlsjfkldsjfkldsjklfwejffjdkjfkdjlsd)
+ (void)showAlert:(id)text
{
    id cmd = nsarr();
    [cmd addObject:@"hotdog"];
    [cmd addObject:@"alert"];
    [cmd runCommandInBackgroundAndWriteStringToStandardInput:text];
}
@end
@implementation NSString(yjfhjhjhmv)


- (void)showAlert
{
    id cmd = nsarr();
    [cmd addObject:@"hotdog"];
    [cmd addObject:@"alert"];
    [cmd runCommandInBackgroundAndWriteStringToStandardInput:self];
}

@end

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
    [Definitions drawAlertBorderInBitmap:bitmap rect:r];
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
        [Definitions drawDefaultButtonInBitmap:bitmap rect:_buttonRect palette:palette];
        [bitmap setColorIntR:255 g:255 b:255 a:255];
        [bitmap drawBitmapText:@"OK" centeredInRect:textRect];
    } else {
        char *palette = ". #ffffff\nb #000000\nw #ffffff\n";
        [Definitions drawDefaultButtonInBitmap:bitmap rect:_buttonRect palette:palette];
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
