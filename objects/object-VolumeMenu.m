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

#include <stdio.h>

@implementation Definitions(fjkdlsjfklmnekwlvmlkdsjkvs)
+ (id)VolumeMenu
{
    return [Definitions VolumeMenu:@"hw:0" :@"Master"];
}
+ (id)VolumeMenu:(id)cardName :(id)mixerName
{
    id obj = [@"VolumeMenu" asInstance];
    [obj setValue:cardName forKey:@"alsaCardName"];
    [obj setValue:mixerName forKey:@"alsaMixerName"];
    [obj setup];
    return obj;
}
@end

@interface TestVerticalSlider : IvarObject
@end
@implementation TestVerticalSlider
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [Definitions drawVerticalSliderInBitmap:bitmap rect:r pct:0.0];
}
@end

@implementation Definitions(fjkdlsjfklsdjklfsdklfj)
+ (char *)cStringForBitmapVerticalSliderTop
{
    return
"         bbbbb         \n"
"       bb.....bb       \n"
"      b...bbb...b      \n"
"     b..bb.b.bb..b     \n"
;
}

+ (char *)cStringForBitmapVerticalSliderMiddle
{
    return
"     b.bb.b.b.bb.b     \n"
"     b.b.b.b.b.b.b     \n"
;
}

+ (char *)cStringForBitmapVerticalSliderBottom
{
    return
"     b..b.b.b.b..b     \n"
"      b...bbb...b      \n"
"       bb.....bb       \n"
"         bbbbb         \n"
;
}

+ (char *)cStringForBitmapVerticalSliderKnob
{
    return
"  bbbbbbbbbbbbbbbbbbb  \n"
" b...................b \n"
" bbbbbbbbbbbbbbbbbbbbb \n"
"b.....................b\n"
"b.....................b\n"
"b.....................b\n"
"b.....................b\n"
"b.....................b\n"
" bbbbbbbbbbbbbbbbbbbbb \n"
" b...................b \n"
"  bbbbbbbbbbbbbbbbbbb  \n"
;
}

+ (void)drawVerticalSliderInBitmap:(id)bitmap rect:(Int4)r pct:(double)pct
{
    char *top = [Definitions cStringForBitmapVerticalSliderTop];
    char *middle = [Definitions cStringForBitmapVerticalSliderMiddle];
    char *bottom = [Definitions cStringForBitmapVerticalSliderBottom];
    char *knob = [Definitions cStringForBitmapVerticalSliderKnob];

    int heightForTop = [Definitions heightForCString:top];
    int heightForMiddle = [Definitions heightForCString:middle];
    int heightForBottom = [Definitions heightForCString:bottom];
    int heightForKnob = [Definitions heightForCString:knob];

    int widthForMiddle = [Definitions widthForCString:middle];
    int widthForKnob = [Definitions widthForCString:knob];
    int middleXOffset = (r.w - widthForMiddle)/2;
    int knobXOffset = (r.w - widthForKnob)/2;

    char *palette = "b #000000\n. #ffffff\n";
    [bitmap drawCString:top palette:palette x:r.x+middleXOffset y:r.y];
    int y;
    for (y=r.y+heightForTop; y<r.y+r.h-heightForBottom; y+=heightForMiddle) {
        [bitmap drawCString:middle palette:palette x:r.x+middleXOffset y:y];
    }
    [bitmap drawCString:bottom palette:palette x:r.x+middleXOffset y:r.y+r.h-heightForBottom];
    int knobY = (int)(r.h-heightForTop-heightForBottom-heightForKnob) * pct;
    [bitmap drawCString:knob palette:palette x:r.x+knobXOffset y:r.y+r.h-heightForBottom-knobY-heightForKnob];
}
@end

@interface VolumeMenu : IvarObject
{
    id _alsaCardName;
    id _alsaMixerName;
    id _alsaStatus;
    id _alsaVolume;
    double _volume;
    int _playbackSwitch;
    double _grabbedSliderPct;
    int _mouseX;
    int _mouseY;
    Int4 _rectForVolumeSliderTrack;
    Int4 _rectForVolumeSliderKnob;
    int _grabbedVolumeSliderY;
}
@end
@implementation VolumeMenu
- (int *)x11WindowMaskPointsForWidth:(int)w height:(int)h
{
    static int points[5];
    points[0] = 5; // length of array including this number

    points[1] = 0; // lower left corner
    points[2] = h-1;

    points[3] = w-1; // upper right corner
    points[4] = 0;
    return points;
}

- (void)setup
{
    id cmd = nsarr();
    [cmd addObject:@"hotdog-printALSAStatus"];
    if (_alsaCardName) {
        [cmd addObject:_alsaCardName];
        if (_alsaMixerName) {
            [cmd addObject:_alsaMixerName];
        }
    }
    id alsaStatus = [cmd runCommandAndReturnProcess];
    [self setValue:alsaStatus forKey:@"alsaStatus"];

    cmd = nsarr();
    [cmd addObject:@"hotdog-setALSAVolume"];
    if (_alsaCardName) {
        [cmd addObject:_alsaCardName];
        if (_alsaMixerName) {
            [cmd addObject:_alsaMixerName];
        }
    }
    id alsaVolume = [cmd runCommandAndReturnProcess];
    [self setValue:alsaVolume forKey:@"alsaVolume"];
    _volume = 0.0;
    _playbackSwitch = 0;
}

- (int)preferredWidth
{
    char *middle = [Definitions cStringForBitmapVerticalSliderMiddle];
    int widthForMiddle = [Definitions widthForCString:middle];
    return widthForMiddle+8;
}
- (int)preferredHeight
{
    return 200;
}
- (int)fileDescriptor
{
    int fd = [_alsaStatus fileDescriptor];
    return fd;
}

- (void)handleFileDescriptor
{
    [_alsaStatus handleFileDescriptor];
    for(;;) {
        id line = [[_alsaStatus valueForKey:@"data"] readLine];
        if (!line) {
            break;
        }
NSLog(@"alsaStatus '%@'", line);
        _playbackSwitch = [line intValueForKey:@"playbackSwitch"];
        _volume = [line doubleValueForKey:@"volume"];
    }
}

- (void)handleMouseMoved:(id)event
{
    _mouseX = [event intValueForKey:@"mouseX"];
    _mouseY = [event intValueForKey:@"mouseY"];
    if (_grabbedVolumeSliderY) {
        [self updateVolumeSlider];
    } else {
        Int4 r = _rectForVolumeSliderKnob;
        r.y += 3;
        r.h -= 6;
        if ([Definitions isX:_mouseX y:_mouseY insideRect:r]) {
            _grabbedSliderPct = _volume;
            _grabbedVolumeSliderY = _mouseY - _rectForVolumeSliderKnob.y;
        }
    }
}
- (void)handleMouseUp:(id)event
{
    id x11dict = [event valueForKey:@"x11dict"];
    [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
}

- (void)updateVolumeSlider
{
    double sliderPct = _grabbedSliderPct;
    int adjustedSliderY = [Definitions adjustedYForPct:sliderPct rect:_rectForVolumeSliderKnob insideRect:_rectForVolumeSliderTrack];
    if (_grabbedVolumeSliderY) {
        adjustedSliderY = _mouseY - _grabbedVolumeSliderY;
    }
    if (adjustedSliderY < _rectForVolumeSliderTrack.y) {
        adjustedSliderY = _rectForVolumeSliderTrack.y;
    }
    if (adjustedSliderY+_rectForVolumeSliderKnob.h >= _rectForVolumeSliderTrack.y+_rectForVolumeSliderTrack.h) {
        adjustedSliderY = _rectForVolumeSliderTrack.y+_rectForVolumeSliderTrack.h-_rectForVolumeSliderKnob.h;
    }
    Int4 newRectForSlider = _rectForVolumeSliderKnob;
    newRectForSlider.y = adjustedSliderY;
    double newSliderPct = [Definitions normalizedYForRect:newRectForSlider insideRect:_rectForVolumeSliderTrack];
    newSliderPct = 1.0-newSliderPct;
    if (sliderPct != newSliderPct) {
        if (!_playbackSwitch) {
            static BOOL alreadyRun = NO;
            if (!alreadyRun) {
                id cmd = nsarr();
                [cmd addObject:@"hotdog-setALSAMute"];
                [cmd addObject:@"0"];
                if (_alsaCardName) {
                    [cmd addObject:_alsaCardName];
                    if (_alsaMixerName) {
                        [cmd addObject:_alsaMixerName];
                    }
                }
                [cmd runCommandInBackground];
                alreadyRun = YES;
            }
        }
        [_alsaVolume writeString:nsfmt(@"%f\n", newSliderPct)];
        _grabbedSliderPct = newSliderPct;
    }
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    id obj = self;
    
    Int4 rr = r;
    r.x += 1;
    r.y += 1;
    r.w -= 3;
    r.h -= 3;
    [bitmap setColor:@"white"];
    [bitmap fillRect:r];
    [bitmap setColor:@"black"];

    double sliderPct = _volume;
    if (_grabbedVolumeSliderY) {
        sliderPct = _grabbedSliderPct;
    }
    Int4 volumeSliderRect = r;
    volumeSliderRect.y += 4;
    volumeSliderRect.h -= 8;
    [self drawVolumeSliderInBitmap:bitmap rect:volumeSliderRect pct:sliderPct];

    [bitmap drawHorizontalLineAtX:rr.x x:rr.x+rr.w-1 y:rr.y];
    [bitmap drawHorizontalLineAtX:rr.x x:rr.x+rr.w-1 y:rr.y+rr.h-1];
    [bitmap drawHorizontalLineAtX:rr.x x:rr.x+rr.w-1 y:rr.y+rr.h-2];
    [bitmap drawVerticalLineAtX:rr.x y:rr.y y:rr.y+rr.h-1];
    [bitmap drawVerticalLineAtX:rr.x+rr.w-1 y:rr.y y:rr.y+rr.h-1];
    [bitmap drawVerticalLineAtX:rr.x+rr.w-2 y:rr.y y:rr.y+rr.h-1];
}

- (void)drawVolumeSliderInBitmap:(id)bitmap rect:(Int4)r pct:(double)pct
{
    _rectForVolumeSliderTrack = [Definitions rectWithX:r.x y:r.y+4 w:r.w h:r.h-8];
    double sliderPct = _volume;
    if (_grabbedVolumeSliderY) {
        sliderPct = _grabbedSliderPct;
    }
    int adjustedSliderY = [Definitions adjustedYForPct:1.0-sliderPct rect:_rectForVolumeSliderKnob insideRect:_rectForVolumeSliderTrack];
    _rectForVolumeSliderKnob = [Definitions rectWithX:r.x y:adjustedSliderY w:r.w h:11];

    [Definitions drawVerticalSliderInBitmap:bitmap rect:r pct:pct];

}
@end

