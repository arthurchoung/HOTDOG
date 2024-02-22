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

static unsigned char *bitmapButtonLeftPixels =
"   b\n"
" bb.\n"
" b..\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
"b...\n"
" b..\n"
" bb.\n"
"   b\n"
;
static unsigned char *bitmapButtonMiddlePixels =
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
"b\n"
;
static unsigned char *bitmapButtonRightPixels =
"b   \n"
".bb \n"
"..b \n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"...b\n"
"..b \n"
".bb \n"
"b   \n"
;

static void drawButtonInBitmap_rect_palette_(id bitmap, Int4 r, unsigned char *palette)
{
    unsigned char *left = bitmapButtonLeftPixels;
    unsigned char *middle = bitmapButtonMiddlePixels;
    unsigned char *right = bitmapButtonRightPixels;

    [Definitions drawInBitmap:bitmap left:left middle:middle right:right centeredInRect:r palette:palette];
}


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

#ifdef BUILD_FOR_LINUX
@implementation Definitions(fjkdlsjfklsdjkf)
+ (BOOL)confirmWithAlert:(id)text
{
    return [Definitions confirmWithAlert:text title:@"Confirm"];
}
+ (BOOL)confirmWithAlert:(id)text title:(id)title
{
    id quotedText = [[text keepAlphanumericCharactersAndSpacesAndPunctuationAndNewlines] asQuotedString];
    id message = nsfmt(@"ConfirmationDialog:%@|showInXWindowWithWidth:%d height:%d|exit:0", quotedText, 600, 400);
    id cmd = nsarr();
    [cmd addObject:@"hotdog"];
    [cmd addObject:message];
    id outputData = [cmd runCommandAndReturnOutput];
    id output = [outputData asString];
    if ([output isEqual:@"OK"]) {
        return YES;
    }
    return NO;
}
@end
@implementation NSObject(jfkldsjfkldsjklfjdslkfjkdslfklj)
- (void)choosePathWithActionSheet:(id)choices continuation:(id)continuation
{
    id firstChoice = [choices nth:0];
    if (!firstChoice) {
        return;
    }
    id text = [firstChoice keepAlphanumericCharactersAndSpacesAndPunctuationAndNewlines];
    id message = nsfmt(@"ConfirmationDialog:%@|showInXWindowWithWidth:%d height:%d|exit:0", [text asQuotedString], 600, 400);
    id cmd = nsarr();
    [cmd addObject:@"hotdog"];
    [cmd addObject:message];
    id outputData = [cmd runCommandAndReturnOutput];
    id output = [outputData asString];
    if ([output isEqual:@"OK"]) {
        id result = [self evaluateMessage:firstChoice];
        [result evaluateMessage:continuation];
    }
}
- (void)confirmWithAlert:(id)text title:(id)title continuation:(id)continuation
{
    id quotedText = [[[self str:text] keepAlphanumericCharactersAndSpacesAndPunctuationAndNewlines] asQuotedString];
    id message = nsfmt(@"ConfirmationDialog:%@|showInXWindowWithWidth:%d height:%d|exit:0", quotedText, 600, 400);
    id cmd = nsarr();
    [cmd addObject:@"hotdog"];
    [cmd addObject:message];
    id outputData = [cmd runCommandAndReturnOutput];
    id output = [outputData asString];
    if ([output isEqual:@"OK"]) {
        [self evaluateMessage:continuation];
    }
}
- (void)confirmWithAlert:(id)text title:(id)title okText:(id)okText continuation:(id)continuation
{
    id quotedText = [[[self str:text] keepAlphanumericCharactersAndSpacesAndPunctuationAndNewlines] asQuotedString];
    id quotedOkText = [[[self str:okText] keepAlphanumericCharactersAndSpacesAndPunctuation] asQuotedString];
    id message = nsfmt(@"ConfirmationDialog:%@ okText:%@|showInXWindowWithWidth:%d height:%d|exit:0", quotedText, quotedOkText, 600, 400);
    id cmd = nsarr();
    [cmd addObject:@"hotdog"];
    [cmd addObject:message];
    id outputData = [cmd runCommandAndReturnOutput];
    id output = [outputData asString];
    if ([output isEqual:okText]) {
        [self evaluateMessage:continuation];
    }
}
@end
#endif

@implementation Definitions(jfldslkfjdslkjf)
+ (id)ConfirmationDialog:(id)text okText:(id)okText cancelText:(id)cancelText
{
    id obj = [@"ConfirmationDialog" asInstance];
    [obj setValue:text forKey:@"text"];
    [obj setValue:okText forKey:@"okText"];
    [obj setValue:cancelText forKey:@"cancelText"];
    return obj;
}
+ (id)ConfirmationDialog:(id)text okText:(id)okText
{
    return [Definitions ConfirmationDialog:text okText:okText cancelText:@"Cancel"];
}

+ (id)ConfirmationDialog:(id)text
{
    return [Definitions ConfirmationDialog:text okText:@"OK" cancelText:@"Cancel"];
}
+ (int)preferredHeightForConfirmationDialog:(id)text width:(int)width
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

@interface ConfirmationDialog: IvarObject
{
    id _text;
    id _okText;
    id _cancelText;
    int _numberOfRects;
    Int4 _rects[2];
    int _buttonDown;
    int _buttonHover;
    int _returnKey;
    int _dialogMode;
}
@end
@implementation ConfirmationDialog
- (int)preferredWidth
{
    return 480;
}
- (int)preferredHeight
{
    int h = [Definitions preferredHeightForConfirmationDialog:_text width:480];
    if (h > 240) {
        return h;
    }
    return 240;
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    drawAlertBorderInBitmap_rect_(bitmap, r);
    char *palette = "b #000000\n. #ffffff\n";
    [bitmap drawCString:[Definitions cStringForBitmapMessageIcon] palette:palette x:28 y:28];
//    Int4 okButtonRect = [Definitions rectWithX:r.w-88 y:r.h-21-28 w:70 h:28];
    int okTextWidth = [bitmap bitmapWidthForText:_okText];
    if (okTextWidth < 44) {
        okTextWidth = 44;
    }

    Int4 okButtonRect = [Definitions rectWithX:r.w-okTextWidth-26-18 y:r.h-21-28 w:okTextWidth+26 h:28];
    _rects[0] = okButtonRect;
    BOOL okButtonDown = NO;
    if ((_buttonDown == 1) && (_buttonDown == _buttonHover)) {
        okButtonDown = YES;
    } else if (_returnKey) {
        okButtonDown = YES;
    }
    if (okButtonDown) {
        char *palette = ". #000000\nb #000000\nw #ffffff\n";
        drawDefaultButtonInBitmap_rect_palette_(bitmap, okButtonRect, palette);
        [bitmap setColorIntR:255 g:255 b:255 a:255];
        [bitmap drawBitmapText:_okText centeredInRect:okButtonRect];
    } else {
        char *palette = ". #ffffff\nb #000000\nw #ffffff\n";
        drawDefaultButtonInBitmap_rect_palette_(bitmap, okButtonRect, palette);
        [bitmap setColorIntR:0 g:0 b:0 a:255];
        [bitmap drawBitmapText:_okText centeredInRect:okButtonRect];
    }
    Int4 cancelButtonRect = [Definitions rectWithX:okButtonRect.x-70-35 y:r.h-21-28 w:70 h:28];
    _rects[1] = cancelButtonRect;
    _numberOfRects = 2;
    if ((_buttonDown == 2) && (_buttonDown == _buttonHover)) {
        char *palette = ". #000000\nb #000000\nw #ffffff\n";
        drawButtonInBitmap_rect_palette_(bitmap, cancelButtonRect, palette);
        [bitmap setColorIntR:255 g:255 b:255 a:255];
        [bitmap drawBitmapText:_cancelText centeredInRect:cancelButtonRect];
    } else {
        char *palette = ". #ffffff\nb #000000\nw #ffffff\n";
        drawButtonInBitmap_rect_palette_(bitmap, cancelButtonRect, palette);
        [bitmap setColorIntR:0 g:0 b:0 a:255];
        [bitmap drawBitmapText:_cancelText centeredInRect:cancelButtonRect];
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
            [self handleOKButton:event];
            _returnKey = 0;
        }
    }
}
- (void)handleMouseDown:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    _buttonDown = 0;
    for (int i=0; i<_numberOfRects; i++) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_rects[i]]) {
            _buttonDown = i+1;
        }
    }
}
- (void)handleMouseMoved:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    _buttonHover = 0;
    for (int i=0; i<_numberOfRects; i++) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_rects[i]]) {
            _buttonHover = i+1;
        }
    }
}
- (void)handleMouseUp:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    int buttonUp = 0;
    for (int i=0; i<_numberOfRects; i++) {
        if ([Definitions isX:mouseX y:mouseY insideRect:_rects[i]]) {
            if (i+1 == _buttonDown) {
                buttonUp = _buttonDown;
            }
        }
    }
    _buttonDown = 0;
    if (buttonUp == 1) {
        [self handleOKButton:event];
    } else if (buttonUp == 2) {
        if (_dialogMode) {
            exit(1);
        }
        id x11dict = [event valueForKey:@"x11dict"];
        [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
        [_cancelText writeToStandardOutput];
    }
}
- (void)handleOKButton:(id)event
{
    if (_dialogMode) {
        exit(0);
    }
    id x11dict = [event valueForKey:@"x11dict"];
    [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
    [_okText writeToStandardOutput];
}
@end

