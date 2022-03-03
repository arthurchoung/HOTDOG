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

#include <time.h>

#ifdef BUILD_FOR_OSX
static uint64_t osx_clock()
{
    return mach_absolute_time();
//    return clock_gettime_nsec_np(CLOCK_MONOTONIC_RAW);
}
#endif


@implementation Definitions(jefklwmfkldmsklfmklsdf)
+ (id)Stopwatch
{
    return [@"Stopwatch" asInstance];
}
@end

@interface Stopwatch : IvarObject
{
    Int4 _elapsedTextRect;
    Int4 _lapTextRect;
    Int4 _startButtonRect;
    Int4 _resetButtonRect;
#ifdef BUILD_FOR_LINUX
    struct timespec _startTime;
    struct timespec _endTime;
    struct timespec _lapTime;
#endif
#ifdef BUILD_FOR_OSX
    uint64_t _startTime;
    uint64_t _endTime;
    uint64_t _lapTime;
#endif
#ifdef BUILD_FOR_IOS
    CFTimeInterval _startTime;
    CFTimeInterval _endTime;
    CFTimeInterval _lapTime;
#endif
    double _cumulativeTime;
    double _cumulativeLapTime;
    BOOL _resetButtonDown;
}
@end
@implementation Stopwatch

- (int)preferredWidth
{
    return 300;
}
- (int)preferredHeight
{
    return 130;
}

- (BOOL)shouldAnimate
{
#ifdef BUILD_FOR_LINUX
    if (_startTime.tv_sec) {
        if (!_endTime.tv_sec) {
            return YES;
        }
    }
#endif
#ifdef BUILD_FOR_OSX
    if (_startTime) {
        if (!_endTime) {
            return YES;
        }
    }
#endif
#ifdef BUILD_FOR_IOS
    if (_startTime) {
        if (!_endTime) {
            return YES;
        }
    }
#endif
    return NO;
}
- (void)calculateRects:(Int4)r
{
    _startButtonRect = r;
    _startButtonRect.y = r.y+r.h-30;
    _startButtonRect.w = r.w/2;
    _startButtonRect.h = 30;
    _resetButtonRect = _startButtonRect;
    _resetButtonRect.x += _startButtonRect.w;
    _elapsedTextRect = r;
    _elapsedTextRect.h = 20;
    _lapTextRect = r;
    _lapTextRect.y += _elapsedTextRect.h;
    _lapTextRect.h -= _elapsedTextRect.h;
    _lapTextRect.h -= _startButtonRect.h;
}
- (void)beginIteration:(id)event rect:(Int4)r
{
}

#ifdef BUILD_FOR_LINUX
- (double)timeDifference:(struct timespec)time1 :(struct timespec)time2
{
    double diff_time = ((double)time2.tv_sec + 1.0e-9*time2.tv_nsec) - ((double)time1.tv_sec + 1.0e-9*time1.tv_nsec);
    return diff_time;
}
#endif
#ifdef BUILD_FOR_OSX
- (double)timeDifference:(uint64_t)time1 :(uint64_t)time2
{
    uint64_t diff = time2 - time1;
    double nsec = (double)diff / 1000000000.0;
    return nsec;
}
#endif
#ifdef BUILD_FOR_IOS
- (double)timeDifference:(double)time1 :(double)time2
{
    return time2 - time1;
}
#endif

- (id)timeDifferenceAsString:(double)diff_time
{
    return nsfmt(@"%.2d:%.2d.%.1d", ((int)diff_time)/60, ((int)diff_time)%60, ((int)(diff_time * 10.0)) % 10);
}

- (void)handleStartButton
{
#ifdef BUILD_FOR_LINUX
    if (_startTime.tv_sec) {
        if (_endTime.tv_sec) {
            /* Start */
            _cumulativeTime += [self timeDifference:_startTime :_endTime];
            _cumulativeLapTime += [self timeDifference:_lapTime :_endTime];
            clock_gettime(CLOCK_MONOTONIC, &_startTime);
            _lapTime = _startTime;
            memset(&_endTime, 0, sizeof(struct timespec));
        } else {
            /* Stop */
            clock_gettime(CLOCK_MONOTONIC, &_endTime);
        }
    } else {
        /* Start */
        clock_gettime(CLOCK_MONOTONIC, &_startTime);
        _lapTime = _startTime;
    }
#endif
#ifdef BUILD_FOR_OSX
    if (_startTime) {
        if (_endTime) {
            /* Start */
            _cumulativeTime += [self timeDifference:_startTime :_endTime];
            _cumulativeLapTime += [self timeDifference:_lapTime :_endTime];
            _startTime = osx_clock();
            _lapTime = _startTime;
            _endTime = 0;
        } else {
            /* Stop */
            _endTime = osx_clock();
        }
    } else {
        /* Start */
        _startTime = osx_clock();
        _lapTime = _startTime;
    }
#endif
#ifdef BUILD_FOR_IOS
    if (_startTime) {
        if (_endTime) {
            /* Start */
            _cumulativeTime += [self timeDifference:_startTime :_endTime];
            _cumulativeLapTime += [self timeDifference:_lapTime :_endTime];
            _startTime = CACurrentMediaTime();
            _lapTime = _startTime;
            _endTime = 0.0;
        } else {
            /* Stop */
            _endTime = CACurrentMediaTime();
        }
    } else {
        /* Start */
        _startTime = CACurrentMediaTime();
        _lapTime = _startTime;
    }
#endif
}

- (void)handleResetButton
{
#ifdef BUILD_FOR_LINUX
    if (_startTime.tv_sec) {
        if (_endTime.tv_sec) {
            /* Reset */
            memset(&_startTime, 0, sizeof(struct timespec));
            memset(&_endTime, 0, sizeof(struct timespec));
            memset(&_lapTime, 0, sizeof(struct timespec));
            _cumulativeTime = 0;
            _cumulativeLapTime = 0;
        } else {
            /* Lap */
            struct timespec timeNow;
            clock_gettime(CLOCK_MONOTONIC, &timeNow);
//            id str = nsfmt(@"Lap %d %@", [_array count]+1, [self timeDifferenceAsString:[self timeDifference:_lapTime :timeNow]+_cumulativeLapTime]);
            _lapTime = timeNow;
            _cumulativeLapTime = 0;
        }
    }
#endif
#ifdef BUILD_FOR_OSX
    if (_startTime) {
        if (_endTime) {
            /* Reset */
            _startTime = 0;
            _endTime = 0;
            _lapTime = 0;
            _cumulativeTime = 0.0;
            _cumulativeLapTime = 0.0;
        } else {
            /* Lap */
            uint64_t timeNow = osx_clock();
//            id str = nsfmt(@"Lap %d %@", [_array count]+1, [self timeDifferenceAsString:[self timeDifference:_lapTime :timeNow]+_cumulativeLapTime]);
            _lapTime = timeNow;
            _cumulativeLapTime = 0.0;
        }
    }
#endif
#ifdef BUILD_FOR_IOS
    if (_startTime) {
        if (_endTime) {
            /* Reset */
            _startTime = 0;
            _endTime = 0;
            _lapTime = 0;
            _cumulativeTime = 0;
            _cumulativeLapTime = 0;
        } else {
            /* Lap */
            CFTimeInterval timeNow = CACurrentMediaTime();
//            id str = nsfmt(@"Lap %d %@", [_array count]+1, [self timeDifferenceAsString:[self timeDifference:_lapTime :timeNow]+_cumulativeLapTime]);
            _lapTime = timeNow;
            _cumulativeLapTime = 0;
        }
    }
#endif
}

- (void)handleMouseDown:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    if ([Definitions isX:mouseX y:mouseY insideRect:_startButtonRect]) {
        [self handleStartButton];
        return;
    }
    if ([Definitions isX:mouseX y:mouseY insideRect:_resetButtonRect]) {
        [self handleResetButton];
        _resetButtonDown = YES;
        return;
    }
}

- (void)handleMouseUp:(id)event
{
    _resetButtonDown = NO;
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [self calculateRects:r];
/*
    Int4 topRect = [Definitions rectWithX:r.x y:r.y+r.h-20.0*4 w:r.w h:20.0*4];
    Int4 bottomRect = [Definitions rectWithX:r.x y:r.y w:r.w h:r.h-20.0*4];
    [bitmap setColor:@"white"];
    [bitmap fillRect:r];
    [bitmap setColor:@"black"];
    [bitmap fillRect:topRect];
*/

#ifdef BUILD_FOR_LINUX
    struct timespec timeNow;
    if (_endTime.tv_sec) {
        timeNow = _endTime;
    } else {
        clock_gettime(CLOCK_MONOTONIC, &timeNow);
    }

    id elapsedStr = @"00:00.0";
    if (_startTime.tv_sec) {
        elapsedStr = [self timeDifferenceAsString:[self timeDifference:_startTime :timeNow]+_cumulativeTime];
    }

    id lapStr = @"00:00.0";
    if (_lapTime.tv_sec) {
        lapStr = [self timeDifferenceAsString:[self timeDifference:_lapTime :timeNow]+_cumulativeLapTime];
    } else {
        lapStr = elapsedStr;
    }
#endif
#ifdef BUILD_FOR_OSX
    uint64_t timeNow;
    if (_endTime) {
        timeNow = _endTime;
    } else {
        timeNow = osx_clock();
    }

    id elapsedStr = @"00:00.0";
    if (_startTime) {
        elapsedStr = [self timeDifferenceAsString:[self timeDifference:_startTime :timeNow]+_cumulativeTime];
    }

    id lapStr = @"00:00.0";
    if (_lapTime) {
        lapStr = [self timeDifferenceAsString:[self timeDifference:_lapTime :timeNow]+_cumulativeLapTime];
    } else {
        lapStr = elapsedStr;
    }
#endif
#ifdef BUILD_FOR_IOS
    CFTimeInterval timeNow;
    if (_endTime) {
        timeNow = _endTime;
    } else {
        timeNow = CACurrentMediaTime();
    }

    id elapsedStr = @"00:00.0";
    if (_startTime) {
        elapsedStr = [self timeDifferenceAsString:[self timeDifference:_startTime :timeNow]+_cumulativeTime];
    }

    id lapStr = @"00:00.0";
    if (_lapTime) {
        lapStr = [self timeDifferenceAsString:[self timeDifference:_lapTime :timeNow]+_cumulativeLapTime];
    } else {
        lapStr = elapsedStr;
    }
#endif

    {
        Int4 textRect = _elapsedTextRect;
        [bitmap setColorIntR:128 g:128 b:128 a:255];
        [bitmap drawBitmapText:elapsedStr rightAlignedInRect:textRect];
    }
    {
        Int4 textRect = _lapTextRect;
        int textWidth = [bitmap bitmapWidthForText:@"00:00.0"];
        int textHeight = [bitmap bitmapHeightForText:lapStr];
        id textBitmap = [Definitions bitmapWithWidth:textWidth+3 height:textHeight];
        [textBitmap setColorIntR:255 g:255 b:255 a:255];
        [textBitmap drawBitmapText:lapStr x:1 y:0];
        [bitmap drawBitmap:textBitmap x:textRect.x y:textRect.y w:textRect.w h:textRect.h];
    }

#ifdef BUILD_FOR_LINUX
    id leftButton = @"";
    char *leftPalette = ". #00ff00\nb #ffffff\n";
    if (_startTime.tv_sec) {
        if (_endTime.tv_sec) {
            leftButton = @"Start";
        } else {
            leftButton = @"Stop";
            leftPalette = ". #ff0000\nb #ffffff\n";
        }
    } else {
        leftButton = @"Start";
    }
#endif
#ifdef BUILD_FOR_OSX
    id leftButton = @"";
    char *leftPalette = ". #00ff00\nb #ffffff\n";
    if (_startTime) {
        if (_endTime) {
            leftButton = @"Start";
        } else {
            leftButton = @"Stop";
            leftPalette = ". #ff0000\nb #ffffff\n";
        }
    } else {
        leftButton = @"Start";
    }
#endif
#ifdef BUILD_FOR_IOS
    id leftButton = @"";
    char *leftPalette = ". #00ff00\nb #ffffff\n";
    if (_startTime) {
        if (_endTime) {
            leftButton = @"Start";
        } else {
            leftButton = @"Stop";
            leftPalette = ". #ff0000\nb #ffffff\n";
        }
    } else {
        leftButton = @"Start";
    }
#endif

    {
        Int4 buttonRect = _startButtonRect;
        if (0) {
            char *palette = ". #ffffff\nb #ffffff\n";
            [Definitions drawButtonInBitmap:bitmap rect:buttonRect palette:palette];
            [bitmap setColorIntR:0 g:0 b:0 a:255];
            [bitmap drawBitmapText:leftButton centeredInRect:buttonRect];
        } else {
            [Definitions drawButtonInBitmap:bitmap rect:buttonRect palette:leftPalette];
            [bitmap setColorIntR:255 g:255 b:255 a:255];
            [bitmap drawBitmapText:leftButton centeredInRect:buttonRect];
        }
    }

#ifdef BUILD_FOR_LINUX
    id rightButton = @"Reset";
    if (_startTime.tv_sec) {
        if (_endTime.tv_sec) {
            rightButton = @"Reset";
        } else {
            rightButton = @"Lap";
        }
    }
#endif
#ifdef BUILD_FOR_OSX
    id rightButton = @"Reset";
    if (_startTime) {
        if (_endTime) {
            rightButton = @"Reset";
        } else {
            rightButton = @"Lap";
        }
    }
#endif
#ifdef BUILD_FOR_IOS
    id rightButton = @"Reset";
    if (_startTime) {
        if (_endTime) {
            rightButton = @"Reset";
        } else {
            rightButton = @"Lap";
        }
    }
#endif

    char *colors = ". #000000\nb #ffffff\n";
    Int4 buttonRect = _resetButtonRect;
    if (rightButton) {
        if (_resetButtonDown) {
            char *palette = ". #444444\nb #ffffff\n";
            [Definitions drawButtonInBitmap:bitmap rect:buttonRect palette:palette];
            [bitmap setColorIntR:255 g:255 b:255 a:255];
            [bitmap drawBitmapText:rightButton centeredInRect:buttonRect];
        } else {
            char *palette = ". #888888\nb #ffffff\n";
            [Definitions drawButtonInBitmap:bitmap rect:buttonRect palette:palette];
            [bitmap setColorIntR:255 g:255 b:255 a:255];
            [bitmap drawBitmapText:rightButton centeredInRect:buttonRect];
        }
    }
}


@end




