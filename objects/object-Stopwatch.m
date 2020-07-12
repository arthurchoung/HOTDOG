#import "PEEOS.h"

#include <time.h>

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
#else
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

- (BOOL)shouldAnimate
{
#ifdef BUILD_FOR_LINUX
    if (_startTime.tv_sec) {
        if (!_endTime.tv_sec) {
            return YES;
        }
    }
#else
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
}
- (void)performIteration:(id)event
{
}

#ifdef BUILD_FOR_LINUX
- (double)timeDifference:(struct timespec)time1 :(struct timespec)time2
{
    double diff_time = ((double)time2.tv_sec + 1.0e-9*time2.tv_nsec) - ((double)time1.tv_sec + 1.0e-9*time1.tv_nsec);
    return diff_time;
}
#else
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
#else
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
#else
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
#else
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
        id textBitmap = [[[[@"Bitmap" asClass] alloc] initWithWidth:textWidth+3 height:textHeight] autorelease];
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
#else
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
#else
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




