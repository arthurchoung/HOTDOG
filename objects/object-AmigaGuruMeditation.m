#import "HOTDOG.h"

@implementation Definitions(fmeiowmvkdsvijewi)
+ (id)AmigaGuruMeditation
{
    id obj = [@"AmigaGuruMeditation" asInstance];
    id text = @"Software Failure.   Press left mouse button to continue.";
    [obj setValue:text forKey:@"text"];
    return obj;
}
@end

@interface AmigaGuruMeditation : IvarObject
{
    int _iteration;
    id _text;
}
@end
@implementation AmigaGuruMeditation
- (int)preferredWidth
{
    id bitmap = [[[@"Bitmap" asClass] bitmapWithWidth:1 height:1] autorelease];
    [bitmap useTopazFont];
    return [bitmap bitmapWidthForText:_text] + 80;
}
- (int)preferredHeight
{
    return 74;
}
- (BOOL)shouldAnimate
{
    return YES;
}
- (void)beginIteration:(id)event rect:(Int4)r
{
    _iteration++;
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    if (_iteration/60 % 2 == 0) {
        [bitmap setColor:@"red"];
        [bitmap fillRect:r];
        Int4 r1 = [Definitions rectWithPadding:r w:-8 h:-8];
        [bitmap setColor:@"black"];
        [bitmap fillRect:r1];
    } else {
        [bitmap setColor:@"black"];
        [bitmap fillRect:r];
    }
    [bitmap useTopazFont];
    [bitmap setColor:@"red"];
    [bitmap drawBitmapText:_text centeredAtX:r.x+r.w/2 y:8];
    [bitmap drawBitmapText:@"Guru Meditation #00000004.00000000" centeredAtX:r.x+r.w/2 y:36];
}
- (void)handleMouseDown:(id)event
{
    exit(0);
}
@end

