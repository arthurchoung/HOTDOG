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

#ifdef BUILD_FOR_LINUX
@implementation Definitions(fjkdlsjfklsdjkf)
+ (BOOL)confirmWithAlert:(id)text
{
    return [Definitions confirmWithAlert:text title:@"Confirm"];
}
+ (BOOL)confirmWithAlert:(id)text title:(id)title
{
    id quotedText = [[text keepAlphanumericCharactersAndSpacesAndPunctuation] asQuotedString];
    id message = nsfmt(@"ConfirmationDialog:%@|showInXWindowWithWidth:%d height:%d|exit:0", quotedText, 600, 400);
    id cmd = @[ @"hotdog", message ];
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
    id text = [firstChoice keepAlphanumericCharactersAndSpacesAndPunctuation];
    id message = nsfmt(@"ConfirmationDialog:%@|showInXWindowWithWidth:%d height:%d|exit:0", [text asQuotedString], 600, 400);
    id cmd = @[ @"hotdog", message ];
    id outputData = [cmd runCommandAndReturnOutput];
    id output = [outputData asString];
    if ([output isEqual:@"OK"]) {
        id result = [self evaluateMessage:firstChoice];
        [result evaluateMessage:continuation];
    }
}
- (void)confirmWithAlert:(id)text title:(id)title continuation:(id)continuation
{
    id quotedText = [[[self str:text] keepAlphanumericCharactersAndSpacesAndPunctuation] asQuotedString];
    id message = nsfmt(@"ConfirmationDialog:%@|showInXWindowWithWidth:%d height:%d|exit:0", quotedText, 600, 400);
    id cmd = @[ @"hotdog", message ];
    id outputData = [cmd runCommandAndReturnOutput];
    id output = [outputData asString];
    if ([output isEqual:@"OK"]) {
        [self evaluateMessage:continuation];
    }
}
- (void)confirmWithAlert:(id)text title:(id)title okText:(id)okText continuation:(id)continuation
{
    id quotedText = [[[self str:text] keepAlphanumericCharactersAndSpacesAndPunctuation] asQuotedString];
    id quotedOkText = [[[self str:okText] keepAlphanumericCharactersAndSpacesAndPunctuation] asQuotedString];
    id message = nsfmt(@"ConfirmationDialog:%@ okText:%@|showInXWindowWithWidth:%d height:%d|exit:0", quotedText, quotedOkText, 600, 400);
    id cmd = @[ @"hotdog", message ];
    id outputData = [cmd runCommandAndReturnOutput];
    id output = [outputData asString];
    if ([output isEqual:okText]) {
        [self evaluateMessage:continuation];
    }
}
@end
#endif

@implementation Definitions(jfldslkfjdslkjf)
+ (id)ConfirmationDialog:(id)text okText:(id)okText
{
    id obj = [@"ConfirmationDialog" asInstance];
    [obj setValue:text forKey:@"text"];
    [obj setValue:okText forKey:@"okText"];
    return obj;
}

+ (id)ConfirmationDialog:(id)text
{
    id obj = [@"ConfirmationDialog" asInstance];
    [obj setValue:text forKey:@"text"];
    [obj setValue:@"OK" forKey:@"okText"];
    return obj;
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
    int _numberOfRects;
    Int4 _rects[2];
    int _buttonDown;
    int _buttonHover;
}
@end
@implementation ConfirmationDialog
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [Definitions drawAlertBorderInBitmap:bitmap rect:r];
    char *palette = "b #000000\n. #ffffff\n";
    [bitmap drawCString:[Definitions cStringForBitmapMessageIcon] palette:palette x:28 y:28];
    Int4 okButtonRect = [Definitions rectWithX:r.w-88 y:r.h-21-28 w:70 h:28];
    _rects[0] = okButtonRect;
    if ((_buttonDown == 1) && (_buttonDown == _buttonHover)) {
        char *palette = ". #000000\nb #000000\nw #ffffff\n";
        [Definitions drawDefaultButtonInBitmap:bitmap rect:okButtonRect palette:palette];
        [bitmap setColorIntR:255 g:255 b:255 a:255];
        [bitmap drawBitmapText:_okText centeredInRect:okButtonRect];
    } else {
        char *palette = ". #ffffff\nb #000000\nw #ffffff\n";
        [Definitions drawDefaultButtonInBitmap:bitmap rect:okButtonRect palette:palette];
        [bitmap setColorIntR:0 g:0 b:0 a:255];
        [bitmap drawBitmapText:_okText centeredInRect:okButtonRect];
    }
    Int4 cancelButtonRect = [Definitions rectWithX:r.w-88-70-35 y:r.h-21-28 w:70 h:28];
    _rects[1] = cancelButtonRect;
    _numberOfRects = 2;
    if ((_buttonDown == 2) && (_buttonDown == _buttonHover)) {
        char *palette = ". #000000\nb #000000\nw #ffffff\n";
        [Definitions drawButtonInBitmap:bitmap rect:cancelButtonRect palette:palette];
        [bitmap setColorIntR:255 g:255 b:255 a:255];
        [bitmap drawBitmapText:@"Cancel" centeredInRect:cancelButtonRect];
    } else {
        char *palette = ". #ffffff\nb #000000\nw #ffffff\n";
        [Definitions drawButtonInBitmap:bitmap rect:cancelButtonRect palette:palette];
        [bitmap setColorIntR:0 g:0 b:0 a:255];
        [bitmap drawBitmapText:@"Cancel" centeredInRect:cancelButtonRect];
    }
    int textWidth = (int)r.w - 89 - 18;
    id text = [bitmap fitBitmapString:_text width:textWidth];
    [bitmap setColorIntR:0 g:0 b:0 a:255];
    [bitmap drawBitmapText:text x:89 y:24];
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
        id x11dict = [event valueForKey:@"x11dict"];
        [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
        [_okText writeToStandardOutput];
    } else if (buttonUp == 2) {
        id x11dict = [event valueForKey:@"x11dict"];
        [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
        [@"Cancel" writeToStandardOutput];
    }
}
@end

