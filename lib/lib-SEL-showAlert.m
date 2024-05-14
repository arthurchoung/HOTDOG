/*

 HOTDOG

 Copyright (c) 2020 Arthur Choung. All rights reserved.

 Email: arthur -at- hotdogpucko.com

 This file is part of HOTDOG.

 HOTDOG is free software: you can redistribute it and/or modify
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

