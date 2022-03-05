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

#define MAX_RECT 640

static unsigned char *checkmark_pixels =
"        bb\n"
"        bb\n"
"       bb \n"
"       bb \n"
"      bb  \n"
"      bb  \n"
"bb   bb   \n"
"bb   bb   \n"
" bb bb    \n"
" bb bb    \n"
"  bbb     \n"
"  bbb     \n"
"          \n"
;
static unsigned char *slider_left =
"    \n"
"    \n"
"    \n"
"    \n"
"    \n"
"   b\n"
"  b.\n"
" b..\n"
" b.b\n"
"b..b\n"
"b.b.\n"
"b.bb\n"
"b.b.\n"
"b..b\n"
" b.b\n"
" b..\n"
"  b.\n"
"   b\n"
"    \n"
"    \n"
"    \n"
"    \n"
"    \n"
;
static unsigned char *slider_middle =
"  \n"
"  \n"
"  \n"
"  \n"
"  \n"
"bb\n"
"..\n"
"bb\n"
"b.\n"
".b\n"
"b.\n"
".b\n"
"b.\n"
".b\n"
"b.\n"
"bb\n"
"..\n"
"bb\n"
"  \n"
"  \n"
"  \n"
"  \n"
"  \n"
;
static unsigned char *slider_right =
"    \n"
"    \n"
"    \n"
"    \n"
"    \n"
"b   \n"
".b  \n"
"..b \n"
"b.b \n"
"...b\n"
"bb.b\n"
".b.b\n"
"bb.b\n"
"...b\n"
"b.b \n"
"..b \n"
".b  \n"
"b   \n"
"    \n"
"    \n"
"    \n"
"    \n"
"    \n"
;
static unsigned char *slider_knob =
"   bbbbb   \n"
" bb.....bb \n"
"b.b.....b.b\n"
"b.b.....b.b\n"
"b.b.....b.b\n"
"b.b.....b.b\n"
"b.b.....b.b\n"
"b.b.....b.b\n"
"b.b.....b.b\n"
"b.b.....b.b\n"
"b.b.....b.b\n"
"b.b.....b.b\n"
"b.b.....b.b\n"
"b.b.....b.b\n"
"b.b.....b.b\n"
"b.b.....b.b\n"
"b.b.....b.b\n"
"b.b.....b.b\n"
"b.b.....b.b\n"
"b.b.....b.b\n"
"b.b.....b.b\n"
" bb.....bb \n"
"   bbbbb   \n"
;
static unsigned char *toggle_off_button =
"1111111111111111111111111111111111111111\n"
"10000000000000000001...................1\n"
"10000000000000000001..bbb..bbbbb.bbbbb.1\n"
"10000000000000000001.b...b.b.....b.....1\n"
"10000000000000000001.b...b.b.....b.....1\n"
"10000000000000000001.b...b.bbbb..bbbb..1\n"
"10000000000000000001.b...b.b.....b.....1\n"
"10000000000000000001.b...b.b.....b.....1\n"
"10000000000000000001..bbb..b.....b.....1\n"
"10000000000000000001...................1\n"
"1111111111111111111111111111111111111111\n"
;
static unsigned char *toggle_on_button =
"1111111111111111111111111111111111111111\n"
"1...................10000000000000000001\n"
"1.....bbb..b...b....10000000000000000001\n"
"1....b...b.bb..b....10000000000000000001\n"
"1....b...b.b.b.b....10000000000000000001\n"
"1....b...b.b..bb....10000000000000000001\n"
"1....b...b.b...b....10000000000000000001\n"
"1....b...b.b...b....10000000000000000001\n"
"1.....bbb..b...b....10000000000000000001\n"
"1...................10000000000000000001\n"
"1111111111111111111111111111111111111111\n"
;

static unsigned char *button_top_left = 
"   b\n"
" bb.\n"
" b..\n"
;
static unsigned char *button_top_middle = 
"b\n"
".\n"
".\n"
;
static unsigned char *button_top_right = 
"b   \n"
".bb \n"
"..b \n"
;

static unsigned char *button_middle_left =
"b...\n"
;
static unsigned char *button_middle_middle =
".\n"
;
static unsigned char *button_middle_right =
"...b\n"
;

static unsigned char *button_bottom_left =
" b..\n"
" bb.\n"
"   b\n"
;
static unsigned char *button_bottom_middle =
".\n"
".\n"
"b\n"
;
static unsigned char *button_bottom_right =
"..b \n"
".bb \n"
"b   \n"
;

static unsigned char *button_top_left_squared = 
"bbbb\n"
"b...\n"
"b...\n"
;
static unsigned char *button_top_right_squared = 
"bbbb\n"
"...b\n"
"...b\n"
;

static unsigned char *button_bottom_left_squared =
"b...\n"
"b...\n"
"bbbb\n"
;
static unsigned char *button_bottom_right_squared =
"...b\n"
"...b\n"
"bbbb\n"
;

@implementation Definitions(fjkdlsjfklsdjfklsdfjdksjfkdsfjdskfjksdljfj)
+ (id)AdventurePanel
{
    id generatecmd = nsarr();
    [generatecmd addObject:@"./generateAdventurePanel.pl"];

    id obj = [@"Panel" asInstance];
    [obj setValue:generatecmd forKey:@"generateCommand"];
    [obj updateArray];
    return obj;
}
+ (id)AudioPanel
{
    id generatecmd = nsarr();
    [generatecmd addObject:@"hotdog-generateAudioPanel.pl"];
    id observercmd = nsarr();
    [observercmd addObject:@"hotdog-monitorAudioDevices.pl"];
    id observer = [observercmd runCommandAndReturnProcess];
    if (!observer) {
NSLog(@"unable to run observer command %@", observercmd);
exit(1);
    }

    id obj = [@"Panel" asInstance];
    [obj setValue:generatecmd forKey:@"generateCommand"];
    [obj setValue:observer forKey:@"observer"];
    [obj updateArray];
    return obj;
}
+ (id)ALSAPanel
{
    id lines = [Definitions linesFromStandardInput];

    id observercmd = nsarr();
    [observercmd addObject:@"hotdog-printALSAUpdates"];
    id observer = [observercmd runCommandAndReturnProcess];
    if (!observer) {
NSLog(@"unable to run observer command %@", observercmd);
exit(1);
    }

    id obj = [@"Panel" asInstance];
    [obj setValue:@"1" forKey:@"waitForObserver"];
    [obj setValue:observer forKey:@"observer"];
    [obj setValue:lines forKey:@"array"];
    return obj;
}
+ (id)CalendarPanel
{
    id generatecmd = nsarr();
    [generatecmd addObject:@"hotdog-generateCalendarPanel.pl"];

    id obj = [@"Panel" asInstance];
    [obj setValue:generatecmd forKey:@"generateCommand"];
    [obj updateArray];
    return obj;
}
+ (id)VideoCamerasPanel
{
    id generatecmd = nsarr();
    [generatecmd addObject:@"hotdog-generateVideoCamerasPanel.pl"];

    id obj = [@"Panel" asInstance];
    [obj setValue:generatecmd forKey:@"generateCommand"];
    [obj updateArray];
    return obj;
}
+ (id)DateTimePanel
{
    id generatecmd = nsarr();
    [generatecmd addObject:@"hotdog-generateDateTimePanel.pl"];

    id obj = [@"Panel" asInstance];
    [obj setValue:generatecmd forKey:@"generateCommand"];
    [obj updateArray];
    return obj;
}
+ (id)WifiNetworksPanel
{
    id generatecmd = nsarr();
    [generatecmd addObject:@"hotdog-generateWifiNetworksPanel.pl"];

    id obj = [@"Panel" asInstance];
    [obj setValue:generatecmd forKey:@"generateCommand"];
    [obj updateArray];
    return obj;
}
+ (id)NetworkPanel
{
    id generatecmd = nsarr();
    [generatecmd addObject:@"hotdog-generateNetworkPanel.pl"];
    id observercmd = nsarr();
    [observercmd addObject:@"hotdog-monitorNetworkInterfaces"];
    id observer = [observercmd runCommandAndReturnProcess];
    if (!observer) {
NSLog(@"unable to run observer command %@", observercmd);
exit(1);
    }

    id obj = [@"Panel" asInstance];
    [obj setValue:generatecmd forKey:@"generateCommand"];
    [obj setValue:observer forKey:@"observer"];
    [obj updateArray];
    return obj;
}
+ (id)DrivesPanel
{
    id generatecmd = nsarr();
    [generatecmd addObject:@"hotdog-generateDrivesPanel.pl"];
    id observercmd = nsarr();
    [observercmd addObject:@"hotdog-monitorBlockDevices"];
    id observer = [observercmd runCommandAndReturnProcess];
    if (!observer) {
NSLog(@"unable to run observer command %@", observercmd);
exit(1);
    }

    id obj = [@"Panel" asInstance];
    [obj setValue:generatecmd forKey:@"generateCommand"];
    [obj setValue:observer forKey:@"observer"];
    [obj updateArray];
    return obj;
}
+ (id)Panel
{
    id lines = [Definitions linesFromStandardInput];

    id obj = [@"Panel" asInstance];
    [obj setValue:lines forKey:@"array"];
    [obj setValue:[@"." asRealPath] forKey:@"currentDirectory"];
    return obj;
}
+ (id)Panel:(id)cmd
{
    id obj = [@"Panel" asInstance];
    [obj setValue:cmd forKey:@"generateCommand"];
    [obj setValue:[@"." asRealPath] forKey:@"currentDirectory"];
    if ([obj respondsToSelector:@selector(updateArrayAndTimestamp)]) {
        [obj updateArrayAndTimestamp];
    }
    return obj;
}
@end
@implementation NSString(jfkelwjfklsdmkflmsdklfm)
- (id)panelFromString
{
    id lines = [self split:@"\n"];

    id obj = [@"Panel" asInstance];
    [obj setValue:lines forKey:@"array"];
    [obj setValue:[@"." asRealPath] forKey:@"currentDirectory"];
    return obj;
}
@end


@interface Panel : IvarObject
{
    id _currentDirectory;
    time_t _timestamp;
    int _seconds;
    id _generateCommand;
    id _observer;
    BOOL _waitForObserver;
    id _lastLine;
    id _array;
    Int4 _rect[MAX_RECT];
    id _buttons;
    char _buttonType[MAX_RECT];
    int _buttonDown;
    int _buttonHover;
    int _buttonDownX;
    int _buttonDownY;
    int _buttonDownOffsetX;
    int _buttonDownOffsetY;
    int _buttonDownMinKnobX;
    int _buttonDownMaxKnobX;
    double _buttonDownKnobPct;
    int _scrollY;

    id _bitmap;
    Int4 _r;
    int _cursorY;

    id _menuDict;
}
@end
@implementation Panel
- (void)handleBackgroundUpdate:(id)event
{
    if (!_currentDirectory) {
        return;
    }
    time_t timestamp = [_currentDirectory fileModificationTimestamp];
    if (timestamp == _timestamp) {
        _seconds++;
        return;
    }
    if (_generateCommand) {
        [self updateArray];
    }
    _timestamp = timestamp;
    _seconds = 0;
}
- (int)fileDescriptor
{
    if (_observer) {
        return [_observer fileDescriptor];
    }
    return -1;
}
- (void)handleFileDescriptor
{
    if (_observer) {
        [_observer handleFileDescriptor];
        id data = [_observer valueForKey:@"data"];
        id lastLine = nil;
        for(;;) {
            id line = [data readLine];
//NSLog(@"line '%@'", line);
            if (!line) {
                break;
            }
            lastLine = line;
        }
        if (lastLine) {
            [self setValue:lastLine forKey:@"lastLine"];
            if (_generateCommand) {
                [self updateArray];
            }
        }
        return;
    }
}
- (void)updateArray
{
NSLog(@"Panel updateArray path %@", _currentDirectory);
    id output = [[[_generateCommand runCommandAndReturnOutput] asString] split:@"\n"];
    if (output) {
        [self setValue:output forKey:@"array"];
    }
}
- (void)updateArrayAndTimestamp
{
NSLog(@"Panel updateArrayAndTimestamp path %@", _currentDirectory);
    time_t timestamp = [_currentDirectory fileModificationTimestamp];
    id output = [[[_generateCommand runCommandAndReturnOutput] asString] split:@"\n"];
    if (output) {
        [self setValue:output forKey:@"array"];
        _timestamp = timestamp;
    }
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [bitmap setColor:@"#aaaaaa"];
    [bitmap fillRect:r];
//    [Definitions drawStripedBackgroundInBitmap:bitmap rect:r];

    [self setValue:nsarr() forKey:@"buttons"];

    _cursorY = -_scrollY + r.y + 5;
    _r = r;

    if (_waitForObserver && !_lastLine) {
NSLog(@"waiting for input");
        return;
    }

    [self setValue:bitmap forKey:@"bitmap"];
    for (int i=0; i<[_array count]; i++) {
        if (_cursorY >= r.y + r.h) {
            break;
        }
        if ([_buttons count] >= MAX_RECT) {
            [self panelText:@"MAX_RECT reached"];
            break;
        }
        id elt = [_array nth:i];
        [self evaluateMessage:elt];
    }
    [self setValue:nil forKey:@"bitmap"];
}
- (void)panelFillWithColor:(id)color
{
    [_bitmap setColor:color];
    [_bitmap fillRect:_r];
}
- (void)panelHorizontalStripes
{
    [Definitions drawHorizontalStripesInBitmap:_bitmap rect:_r];
}
- (void)panelStripedBackground
{
    [Definitions drawStripedBackgroundInBitmap:_bitmap rect:_r];
}

- (void)panelColor:(id)color
{
    [_bitmap setColor:color];
}

- (void)panelBlankSpace:(int)h
{
    _cursorY += h;
}
- (void)panelLine
{
    [self panelLine:1];
}

- (void)panelLine:(int)h
{
    if (h == 1) {
        [_bitmap drawHorizontalLineAtX:_r.x x:_r.x+_r.w-1 y:_cursorY];
    } else if (h > 1) {
        [_bitmap fillRectangleAtX:_r.x y:_cursorY w:_r.w h:h];
    }
    _cursorY += h;
}

- (void)panelText:(id)text color:(id)color backgroundColor:(id)backgroundColor
{
    text = [_bitmap fitBitmapString:text width:_r.w-20];
    int textWidth = [_bitmap bitmapWidthForText:text];
    int textHeight = [_bitmap bitmapHeightForText:text];
    if (textHeight <= 0) {
        textHeight = [_bitmap bitmapHeightForText:@"X"];
    }

    [_bitmap setColor:backgroundColor];
    [_bitmap fillRectangleAtX:_r.x y:_cursorY w:_r.w h:textHeight];

    int x = _r.x;
    x += (_r.w - textWidth) / 2;
    if (color) {
        [_bitmap setColor:color];
    }
    [_bitmap drawBitmapText:text x:x y:_cursorY];
    _cursorY += textHeight;
}
- (void)panelText:(id)text color:(id)color
{
    text = [_bitmap fitBitmapString:text width:_r.w-20];
    int textWidth = [_bitmap bitmapWidthForText:text];
    int textHeight = [_bitmap bitmapHeightForText:text];
    if (textHeight <= 0) {
        textHeight = [_bitmap bitmapHeightForText:@"X"];
    }

    int x = _r.x;
    x += (_r.w - textWidth) / 2;
    if (color) {
        [_bitmap setColor:color];
    }
    [_bitmap drawBitmapText:text x:x y:_cursorY];
    _cursorY += textHeight;
}
- (void)panelText:(id)text
{
    [self panelText:text color:@"black"];
}
- (void)panelTopButton:(id)text
{
    [self panelTopButton:text message:@""];
}
- (void)panelTopButton:(id)text message:(id)message
{
    [self panelTopButton:text rightText:nil message:message];
}
- (void)panelTopButton:(id)text checkmark:(id)checkmark message:(id)message
{
    text = [_bitmap fitBitmapString:text width:_r.w-60];

    [self panelButton:text rightText:nil toggle:nil slider:nil checkmark:checkmark message:message leftMargin:18 width:_r.w-20 :button_top_left :button_top_middle :button_top_right :button_bottom_left_squared :button_bottom_middle :button_bottom_right_squared];
}
- (void)panelTopButton:(id)text rightText:(id)rightText message:(id)message
{
    text = [_bitmap fitBitmapString:text width:_r.w-40];

    [self panelButton:text rightText:rightText toggle:nil slider:nil checkmark:nil message:message leftMargin:0 width:_r.w-20 :button_top_left :button_top_middle :button_top_right :button_bottom_left_squared :button_bottom_middle :button_bottom_right_squared];
}
- (void)panelTopButton:(id)text toggle:(id)toggle message:(id)message
{
    text = [_bitmap fitBitmapString:text width:_r.w-40];

    [self panelButton:text rightText:nil toggle:toggle slider:nil checkmark:nil message:message leftMargin:0 width:_r.w-20 :button_top_left :button_top_middle :button_top_right :button_bottom_left_squared :button_bottom_middle :button_bottom_right_squared];
}
- (void)panelTopSlider:(id)slider message:(id)message
{
    [self panelButton:nil rightText:nil toggle:nil slider:slider checkmark:nil message:message leftMargin:0 width:_r.w-20 :button_top_left :button_top_middle :button_top_right :button_bottom_left_squared :button_bottom_middle :button_bottom_right_squared];
}
- (void)panelMiddleButton:(id)text
{
    [self panelMiddleButton:text message:@""];
}
- (void)panelMiddleButton:(id)text message:(id)message
{
    [self panelMiddleButton:text rightText:nil message:message];
}
- (void)panelMiddleButton:(id)text checkmark:(id)checkmark message:(id)message
{
    text = [_bitmap fitBitmapString:text width:_r.w-60];
    _cursorY -= 1;
    [self panelButton:text rightText:nil toggle:nil slider:nil checkmark:checkmark message:message leftMargin:18 width:_r.w-20 :button_top_left_squared :button_top_middle :button_top_right_squared :button_bottom_left_squared :button_bottom_middle :button_bottom_right_squared];
}
- (void)panelMiddleButton:(id)text rightText:(id)rightText message:(id)message
{
    text = [_bitmap fitBitmapString:text width:_r.w-40];
    _cursorY -= 1;
    [self panelButton:text rightText:rightText toggle:nil slider:nil checkmark:nil message:message leftMargin:0 width:_r.w-20 :button_top_left_squared :button_top_middle :button_top_right_squared :button_bottom_left_squared :button_bottom_middle :button_bottom_right_squared];
}
- (void)panelBottomButton:(id)text
{
    [self panelBottomButton:text message:@""];
}
- (void)panelBottomButton:(id)text message:(id)message
{
    [self panelBottomButton:text rightText:nil message:message];
}
- (void)panelBottomButton:(id)text checkmark:(id)checkmark message:(id)message
{
    text = [_bitmap fitBitmapString:text width:_r.w-60];
    _cursorY -= 1;
    [self panelButton:text rightText:nil toggle:nil slider:nil checkmark:checkmark message:message leftMargin:18 width:_r.w-20 :button_top_left_squared :button_top_middle :button_top_right_squared :button_bottom_left :button_bottom_middle :button_bottom_right];
}
- (void)panelBottomButton:(id)text rightText:(id)rightText message:(id)message
{
    text = [_bitmap fitBitmapString:text width:_r.w-40];
    _cursorY -= 1;
    [self panelButton:text rightText:rightText toggle:nil slider:nil checkmark:nil message:message leftMargin:0 width:_r.w-20 :button_top_left_squared :button_top_middle :button_top_right_squared :button_bottom_left :button_bottom_middle :button_bottom_right];
}
- (void)panelBottomButton:(id)text toggle:(id)toggle message:(id)message
{
    text = [_bitmap fitBitmapString:text width:_r.w-40];
    _cursorY -= 1;
    [self panelButton:text rightText:nil toggle:toggle slider:nil checkmark:nil message:message leftMargin:0 width:_r.w-20 :button_top_left_squared :button_top_middle :button_top_right_squared :button_bottom_left :button_bottom_middle :button_bottom_right];
}
- (void)panelSingleButton:(id)text
{
    [self panelSingleButton:text message:@""];
}
- (void)panelSingleButton:(id)text message:(id)message
{
    [self panelSingleButton:text rightText:nil message:message];
}
- (void)panelSingleButton:(id)text checkmark:(id)checkmark message:(id)message
{
    text = [_bitmap fitBitmapString:text width:_r.w-60];
    [self panelButton:text rightText:nil toggle:nil slider:nil checkmark:checkmark message:message leftMargin:18 width:_r.w-20 :button_top_left :button_top_middle :button_top_right :button_bottom_left :button_bottom_middle :button_bottom_right];
}
- (void)panelSingleSlider:(id)slider message:(id)message
{
    [self panelButton:nil rightText:nil toggle:nil slider:slider checkmark:nil message:message leftMargin:0 width:_r.w-20 :button_top_left :button_top_middle :button_top_right :button_bottom_left :button_bottom_middle :button_bottom_right];
}
- (void)panelSingleButton:(id)text rightText:(id)rightText message:(id)message
{
    text = [_bitmap fitBitmapString:text width:_r.w-40];
    [self panelButton:text rightText:rightText toggle:nil slider:nil checkmark:nil message:message leftMargin:0 width:_r.w-20 :button_top_left :button_top_middle :button_top_right :button_bottom_left :button_bottom_middle :button_bottom_right];
}
- (void)panelSingleButton:(id)text toggle:(id)toggle message:(id)message
{
    text = [_bitmap fitBitmapString:text width:_r.w-40];
    [self panelButton:text rightText:nil toggle:toggle slider:nil checkmark:nil message:message leftMargin:0 width:_r.w-20 :button_top_left :button_top_middle :button_top_right :button_bottom_left :button_bottom_middle :button_bottom_right];
}
- (void)panelButton:(id)text
{
    [self panelButton:text message:nil];
}
- (void)panelButton:(id)text message:(id)message
{
    text = [_bitmap fitBitmapString:text width:_r.w-40];
    int textWidth = [_bitmap bitmapWidthForText:text];
    
    [self panelButton:text rightText:nil toggle:nil slider:nil checkmark:nil message:message leftMargin:0 width:textWidth+20 :button_top_left :button_top_middle :button_top_right :button_bottom_left :button_bottom_middle :button_bottom_right];
}
- (void)panelButton:(id)text rightText:(id)rightText toggle:(id)toggle slider:(id)slider checkmark:(id)checkmark message:(id)message leftMargin:(int)leftMargin width:(int)width :(unsigned char *)top_left :(unsigned char *)top_middle :(unsigned char *)top_right :(unsigned char *)bottom_left :(unsigned char *)bottom_middle :(unsigned char *)bottom_right
{
    int buttonIndex = [_buttons count];
    [_buttons addObject:(message) ? message : @""];
    _buttonType[buttonIndex] = 'b';
    if (toggle) {
        _buttonType[buttonIndex] = 't';
    }
    if (slider) {
        _buttonType[buttonIndex] = 's';
    }

    int textWidth = [_bitmap bitmapWidthForText:text];
    int textHeight = [_bitmap bitmapHeightForText:text];
    if (textHeight <= 0) {
        textHeight = [_bitmap bitmapHeightForText:@"X"];
    }

    Int4 r1;
    r1.x = _r.x;
    r1.y = _cursorY;
    r1.w = width;
    r1.h = textHeight + 10;
    if (slider) {
        if (r1.h < 33) {
            r1.h = 33;
        }
    }
    r1.x += (_r.w - r1.w) / 2;
    _rect[buttonIndex] = r1;
    
    char *palette = "b #000000\n. #ffffff\n";
    id textColor = @"#000000";

    if (_buttonType[buttonIndex] == 'b') {
        if ((_buttonDown-1 == buttonIndex) && (_buttonDown == _buttonHover)) {
            palette = "b #000000\n. #0000ff\n";
            textColor = @"#ffffff";
        } else if (!_buttonDown && (_buttonHover-1 == buttonIndex)) {
            palette = "b #000000\n. #000000\n";
            textColor = @"#ffffff";
        }
    }

    [Definitions drawInBitmap:_bitmap left:top_left middle:top_middle right:top_right x:r1.x y:r1.y w:r1.w palette:palette];
    for (int buttonY=r1.y+3; buttonY<r1.y+r1.h-3; buttonY++) {
        [Definitions drawInBitmap:_bitmap left:button_middle_left middle:button_middle_middle right:button_middle_right x:r1.x y:buttonY w:r1.w palette:palette];
    }
    [Definitions drawInBitmap:_bitmap left:bottom_left middle:bottom_middle right:bottom_right x:r1.x y:r1.y+r1.h-3 w:r1.w palette:palette];
    [_bitmap setColor:textColor];
    [_bitmap drawBitmapText:text x:r1.x+10+leftMargin y:r1.y+5];

    if (rightText) {
        int rightTextWidth = [_bitmap bitmapWidthForText:rightText];
        [_bitmap drawBitmapText:rightText x:r1.x+r1.w-10-rightTextWidth y:r1.y+5];
    } else if (toggle) {
        char *palette = "";
        char *pixels = "";
        if ([toggle intValue]) {
            pixels = toggle_on_button;
            if (_buttonDown && (_buttonDown-1 == buttonIndex) && (_buttonDown == _buttonHover)) {
                palette = "b #cccccc\n. #0000cc\n0 #555555\n1 #000000\n";
            } else {
                palette = "b #ffffff\n. #0000ff\n0 #888888\n1 #000000\n";
            }
        } else {
            pixels = toggle_off_button;
            if (_buttonDown && (_buttonDown-1 == buttonIndex) && (_buttonDown == _buttonHover)) {
                palette = "b #000000\n. #cccccc\n0 #555555\n1 #000000\n";
            } else {
                palette = "b #000000\n. #ffffff\n0 #888888\n1 #000000\n";
            }
        }
        int widthForToggle = [Definitions widthForCString:pixels];
        int heightForToggle = [Definitions heightForCString:pixels];
        int toggleX = r1.x+r1.w-10-40;
        int toggleY = r1.y+(r1.h-11)/2;
        [_bitmap drawCString:pixels palette:palette x:toggleX y:toggleY];
        _rect[buttonIndex].x = toggleX;
        _rect[buttonIndex].y = toggleY;
        _rect[buttonIndex].w = widthForToggle;
        _rect[buttonIndex].h = heightForToggle;
    } else if (slider) {
        char *palette = "b #000000\n. #ffffff\n";
        [Definitions drawInBitmap:_bitmap left:slider_left middle:slider_middle right:slider_right x:r1.x+10 y:r1.y+5 w:r1.w-20 palette:palette];
        int widthForLeft = [Definitions widthForCString:slider_left];
        int widthForRight = [Definitions widthForCString:slider_right];
        int widthForKnob = [Definitions widthForCString:slider_knob];
        int heightForKnob = [Definitions heightForCString:slider_knob];

        int knobX;
        if (_buttonDown && (_buttonDown-1 == buttonIndex)) {
            knobX = _buttonDownX - _buttonDownOffsetX;
            _buttonDownMinKnobX = r1.x+10+widthForLeft;
            _buttonDownMaxKnobX = r1.x+10+r1.w-20-widthForRight-widthForKnob;
            if (knobX < _buttonDownMinKnobX) {
                knobX = _buttonDownMinKnobX;
            }
            if (knobX > _buttonDownMaxKnobX) {
                knobX = _buttonDownMaxKnobX;
            }
        } else {
            double pct = [_lastLine doubleValueForKey:slider];
            knobX = r1.x + 10 + widthForLeft + (int)(r1.w-20-widthForLeft-widthForRight-widthForKnob) * pct;
        }

        [_bitmap drawCString:slider_knob palette:palette x:knobX y:r1.y+5];

        _rect[buttonIndex].x = knobX;
        _rect[buttonIndex].y = r1.y+5;
        _rect[buttonIndex].w = widthForKnob;
        _rect[buttonIndex].h = heightForKnob;
    } else if (checkmark) {
        if ([checkmark intValue]) {
            id palette = nsfmt(@"b %@\n", textColor);
            [_bitmap drawCString:checkmark_pixels palette:[palette UTF8String] x:r1.x+10 y:r1.y+5];
        }
    }

    _cursorY += r1.h;
}
- (void)panelCalendarRow:(id)elts
{
    [self panelCalendarRow:elts square:YES bgcolor:@"white" fgcolor:@"black"];
}
- (void)panelCalendarRow:(id)elts square:(BOOL)square bgcolor:(id)bgcolor fgcolor:(id)fgcolor
{
    int count = 7;
    int cellW = _r.w/count;
    if (cellW == _r.w) {
        cellW--;
    }
    int cellH = cellW;
    if (!square) {
        cellH = [_bitmap bitmapHeightForText:@"X"] + 10;
    }
    int rowW = cellW*count+1;
    int offsetX = (_r.w - rowW)/2;
    [_bitmap setColor:@"black"];
    [_bitmap drawHorizontalLineAtX:_r.x+offsetX x:_r.x+offsetX+rowW-1 y:_cursorY];
    _cursorY += 1;
    if ([elts count] == 0) {
        return;
    }
    [_bitmap setColor:bgcolor];
    [_bitmap fillRectangleAtX:_r.x+offsetX y:_cursorY w:rowW h:cellH];
    for (int i=0; i<=count; i++) {
        id elt = [elts nth:i];
        int x = _r.x+offsetX+i*cellW;
        int y = _cursorY;
        if ((i == 0) || (i == count)) {
            [_bitmap setColor:@"black"];
        } else {
            [_bitmap setColor:fgcolor];
        }
        [_bitmap drawVerticalLineAtX:x y:y y:_cursorY+cellH-1];
        if ([elt length]) {
            [_bitmap setColor:fgcolor];
            [_bitmap drawBitmapText:elt x:x+5 y:y+5];
        }
    }
    _cursorY += cellH;
}

- (void)handleMouseDown:(id)event
{
    int x = [event intValueForKey:@"mouseX"];
    int y = [event intValueForKey:@"mouseY"];
    for (int i=0; i<[_buttons count]; i++) {
        if ([Definitions isX:x y:y insideRect:_rect[i]]) {
            _buttonDown = i+1;
            if (_buttonType[i] == 's') {
                _buttonDownX = x;
                _buttonDownY = y;
                _buttonDownOffsetX = x - _rect[i].x;
                _buttonDownOffsetY = y - _rect[i].y;
            }
            return;
        }
    }
    _buttonDown = 0;
}
- (void)handleMouseMoved:(id)event
{
    if (_menuDict) {
        id object = [_menuDict valueForKey:@"object"];
        if ([object respondsToSelector:@selector(handleMouseMoved:)]) {
            id windowManager = [event valueForKey:@"windowManager"];
            int mouseRootX = [windowManager intValueForKey:@"mouseX"];
            int mouseRootY = [windowManager intValueForKey:@"mouseY"];
NSLog(@"handleMouseMoved windowManager %@", windowManager);
            int x = [_menuDict intValueForKey:@"x"];
            int y = [_menuDict intValueForKey:@"y"];
            int w = [_menuDict intValueForKey:@"w"];
            int h = [_menuDict intValueForKey:@"h"];
            id newEvent = [windowManager generateEventDictRootX:mouseRootX rootY:mouseRootY x:mouseRootX-x y:mouseRootY-y w:w h:h x11dict:_menuDict];
            [object handleMouseMoved:newEvent];
            [_menuDict setValue:@"1" forKey:@"needsRedraw"];
        }
        return;
    }

    int x = [event intValueForKey:@"mouseX"];
    int y = [event intValueForKey:@"mouseY"];
    if (_buttonDown && (_buttonType[_buttonDown-1] == 's')) {
        _buttonDownX = x;
        _buttonDownY = y;

        if (_buttonDownMaxKnobX) {
            int knobX = _buttonDownX - _buttonDownOffsetX;
            if (knobX < _buttonDownMinKnobX) {
                knobX = _buttonDownMinKnobX;
            }
            if (knobX > _buttonDownMaxKnobX) {
                knobX = _buttonDownMaxKnobX;
            }
            _buttonDownKnobPct = (double)(knobX - _buttonDownMinKnobX) / (double)(_buttonDownMaxKnobX - _buttonDownMinKnobX);
            id message = [_buttons nth:_buttonDown-1];
            if ([message length]) {
                [self evaluateMessage:message];
            }
        }

        return;
    }
    for (int i=0; i<[_buttons count]; i++) {
        if ([Definitions isX:x y:y insideRect:_rect[i]]) {
            _buttonHover = i+1;
            return;
        }
    }
    _buttonHover = 0;
}

- (void)handleMouseUp:(id)event
{
    if (_menuDict) {
        id windowManager = [event valueForKey:@"windowManager"];
        id object = [_menuDict valueForKey:@"object"];
        if ([object respondsToSelector:@selector(handleMouseUp:)]) {
            int mouseRootX = [event intValueForKey:@"mouseRootX"];
            int mouseRootY = [event intValueForKey:@"mouseRootY"];
            int x = [_menuDict intValueForKey:@"x"];
            int y = [_menuDict intValueForKey:@"y"];
            int w = [_menuDict intValueForKey:@"w"];
            int h = [_menuDict intValueForKey:@"h"];
            id newEvent = [windowManager generateEventDictRootX:mouseRootX rootY:mouseRootY x:mouseRootX-x y:mouseRootY-y w:w h:h x11dict:_menuDict];
            [object handleMouseUp:newEvent];
            [_menuDict setValue:@"1" forKey:@"needsRedraw"];
/*
            int closingIteration = [object intValueForKey:@"closingIteration"];
            if (closingIteration) {
                _closingIteration = closingIteration;
                return;
            }
*/
        }
        [self setValue:nil forKey:@"menuDict"];
        return;
    }

    if (_buttonDown == 0) {
        return;
    }
    if (_buttonDown && (_buttonType[_buttonDown-1] == 's')) {
        _buttonDown = 0;
        return;
    }
    if (_buttonDown == _buttonHover) {
        id message = [_buttons nth:_buttonDown-1];
        if ([message length]) {
            [self evaluateMessage:message];
//            [self updateArray];
        }
    }
    _buttonDown = 0;
}
- (void)handleScrollWheel:(id)event
{
    if (_menuDict) {
        id windowManager = [event valueForKey:@"windowManager"];
        id object = [_menuDict valueForKey:@"object"];
        if ([object respondsToSelector:@selector(handleScrollWheel:)]) {
            int mouseRootX = [event intValueForKey:@"mouseRootX"];
            int mouseRootY = [event intValueForKey:@"mouseRootY"];
            int x = [_menuDict intValueForKey:@"x"];
            int y = [_menuDict intValueForKey:@"y"];
            int w = [_menuDict intValueForKey:@"w"];
            int h = [_menuDict intValueForKey:@"h"];
            id newEvent = [windowManager generateEventDictRootX:mouseRootX rootY:mouseRootY x:mouseRootX-x y:mouseRootY-y w:w h:h x11dict:_menuDict];
            [newEvent setValue:[event valueForKey:@"deltaX"] forKey:@"deltaX"];
            [newEvent setValue:[event valueForKey:@"deltaY"] forKey:@"deltaY"];
            [newEvent setValue:[event valueForKey:@"scrollingDeltaX"] forKey:@"scrollingDeltaX"];
            [newEvent setValue:[event valueForKey:@"scrollingDeltaY"] forKey:@"scrollingDeltaY"];
            [object handleScrollWheel:newEvent];
            [_menuDict setValue:@"1" forKey:@"needsRedraw"];
        }
        return;
    }

    _scrollY -= [event intValueForKey:@"deltaY"];
}
/*
- (void)handleRightMouseDown:(id)event
{
    id windowManager = [event valueForKey:@"windowManager"];
    int mouseRootX = [event intValueForKey:@"mouseRootX"];
    int mouseRootY = [event intValueForKey:@"mouseRootY"];
    id buttonDownWhich = [event valueForKey:@"buttonDownWhich"];

    id obj = [[[Definitions configDir:@"Config/rootWindowMenu.csv"] parseCSVFile] asMenu];
    int w = [obj preferredWidth];
    int h = [obj preferredHeight];
    id dict = [windowManager openWindowForObject:obj x:mouseRootX y:mouseRootY w:w+3 h:h+3 overrideRedirect:YES];
//    [windowManager setValue:dict forKey:@"buttonDownDict"];
//    [windowManager setValue:buttonDownWhich forKey:@"buttonDownWhich"];
    [self setValue:dict forKey:@"menuDict"];
}
*/
- (void)handleRightMouseUp:(id)event
{
NSLog(@"handleRightMouseUp");
    if (_menuDict) {
        [_menuDict setValue:@"1" forKey:@"shouldCloseWindow"];
        [self setValue:nil forKey:@"menuDict"];
    }
}
- (void)handleKeyDown:(id)event
{
    if (_menuDict) {
        id windowManager = [event valueForKey:@"windowManager"];
        id object = [_menuDict valueForKey:@"object"];
        if ([object respondsToSelector:@selector(handleKeyDown:)]) {
            [object handleKeyDown:event];
            [_menuDict setValue:@"1" forKey:@"needsRedraw"];
        }
    }
}
@end


