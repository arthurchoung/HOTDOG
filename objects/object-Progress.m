#import "HOTDOG.h"

@interface Progress : IvarObject
{
    BOOL _eof;
    id _text;
}
@end
@implementation Progress
- (int)preferredWidth
{
    return 400;
}
- (int)preferredHeight
{
    return 40;
}
- (int)fileDescriptor
{
    return 0;
}
- (void)handleFileDescriptor
{
    char buf[256];
    if (fgets(buf, 256, stdin)) {
        fputs(buf, stdout);
        fflush(stdout);
        id text = nsfmt(@"%s", buf);
        [self setValue:text forKey:@"text"];
    } else {
        _eof = YES;
    }
}
- (void)endIteration:(id)event
{
    if (_eof) {
        id x11dict = [event valueForKey:@"x11dict"];
        [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
    }
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    [bitmap setColor:@"white"];
    [bitmap fillRect:r];
    [bitmap setColor:@"black"];
    [bitmap drawBitmapText:_text x:r.x+5 y:r.y+5];
}
@end

