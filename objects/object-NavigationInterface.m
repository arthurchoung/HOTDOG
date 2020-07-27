/*

 PEEOS

 Copyright (c) 2020 Arthur Choung. All rights reserved.

 Email: arthur -at- peeos.org

 This file is part of PEEOS.

 PEEOS is free software: you can redistribute it and/or modify it
 under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <https://www.gnu.org/licenses/>.

 */

#import "PEEOS.h"

@implementation NSArray(fjkdlsjfklsdlkjf)
- (void)generateClassMenuNamesIfNecessary
{
    for (id elt in self) {
        id name = [elt valueForKey:@"name"];
        id message = [elt valueForKey:@"message"];
        if (![name length] && [message length]) {
            [elt setValue:message forKey:@"name"];
        }
    }
}
@end


@implementation NSObject(fsdfjklsdjklfjsdklf)

- (void)handleClassMenuKeyDown:(id)str
{
    [self handleClassMenuForKey:@"keyDown" value:str];
}
- (void)handleClassMenuKeyEquivalent:(id)str
{
    [self handleClassMenuForKey:@"keyEquivalent" value:str];
}
- (void)handleClassMenuForKey:(id)key value:(id)value
{
    NSLog(@"handleClassMenuForKey:%@ value:%@", key, value);
    id target = self;
    BOOL isInterface = NO;
    if ([self isKindOfClass:[@"NavigationInterface" asClass]]) {
        isInterface = YES;
        target = [self valueForKeyPath:@"context.object"];
    }

    id classMenu = [target classMenuForObject];
    id choice = [classMenu objectWithValue:value forKey:key];
    if (choice) {
NSLog(@"choice %@", [choice allKeysAndValues]);
        id message = [choice valueForKey:@"message"];
        if (message) {
NSLog(@"target %@", target);
[target evaluateMessage:message];
        }
        return;
    }
}



+ (id)classMenuForObject
{
    NSLog(@"classMenuForObject %@", self);
    id classMenu = nil;
    if ([self respondsToSelector:@selector(classMenu)]) {
        return [self classMenu];
    }
    if (!classMenu) {
        Class classCursor = self;
        while (classCursor) {
            id path = [Definitions execDir:nsfmt(@"ClassMenus/%s.csv", class_getName(classCursor))];
            NSLog(@"path %@", path);
            classMenu = [path parseFileAsCSV];
            if (classMenu) {
                break;
            }
            classCursor = class_getSuperclass(classCursor);
        }
    }
    [classMenu generateClassMenuNamesIfNecessary];
    return classMenu;
}
- (id)classMenuForObject
{
    id result = nil;
    if ([self respondsToSelector:@selector(classMenu)]) {
        return [self classMenu];
    }
    if (!result) {
        result = [[self class] classMenuForObject];
    }
    [result generateClassMenuNamesIfNecessary];
    return result;
}
@end


@implementation Definitions(jfkldsjfkldsjlkfj)
+ (void)drawForwardButtonInBitmap:(id)bitmap rect:(Int4)r palette:(char *)palette
{
    char *left = [Definitions cStringForBitmapForwardButtonLeft];
    char *middle = [Definitions cStringForBitmapForwardButtonMiddle];
    char *right = [Definitions cStringForBitmapForwardButtonRight];

    [Definitions drawInBitmap:bitmap left:left middle:middle right:right centeredInRect:r palette:palette];
}
+ (void)drawBackButtonInBitmap:(id)bitmap rect:(Int4)r palette:(char *)palette
{
    char *left = [Definitions cStringForBitmapBackButtonLeft];
    char *middle = [Definitions cStringForBitmapBackButtonMiddle];
    char *right = [Definitions cStringForBitmapBackButtonRight];

    [Definitions drawInBitmap:bitmap left:left middle:middle right:right centeredInRect:r palette:palette];
}
+ (void)fixupEvent:(id)event forBitmapObject:(id)obj
{
    if ([obj respondsToSelector:@selector(bitmapWidth)]) {
        if ([obj respondsToSelector:@selector(bitmapHeight)]) {
            int navigationBarHeight = [Definitions navigationBarHeight];
            int bitmapWidth = [obj bitmapWidth]; 
            int bitmapHeight = [obj bitmapHeight];
            int viewWidth = [event intValueForKey:@"viewWidth"];
            int viewHeight = [event intValueForKey:@"viewHeight"];
            int mouseX = [event intValueForKey:@"mouseX"];
            int mouseY = [event intValueForKey:@"mouseY"] - navigationBarHeight;
            int adjustedX = (double)mouseX / ((double)viewWidth/(double)bitmapWidth);
            int adjustedY = (double)mouseY / ((double)viewHeight/(double)bitmapHeight);
            [event setValue:nsfmt(@"%d", adjustedX) forKey:@"mouseX"];
            [event setValue:nsfmt(@"%d", adjustedY) forKey:@"mouseY"];
            [event setValue:nsfmt(@"%d", bitmapWidth) forKey:@"viewWidth"];
            [event setValue:nsfmt(@"%d", bitmapHeight) forKey:@"viewHeight"];
        }
    }
}
+ (char *)cStringForBitmapBackButtonLeft
{
    return
"     b\n"
"    bb\n"
"    b.\n"
"   bb.\n"
"   b..\n"
"  bb..\n"
"  b...\n"
" bb...\n"
" b....\n"
"bb....\n"
"bb....\n"
" b....\n"
" bb...\n"
"  b...\n"
"  bb..\n"
"   b..\n"
"   bb.\n"
"    b.\n"
"    bb\n"
"     b\n"
;
}
+ (char *)cStringForBitmapBackButtonMiddle
{
    return
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
}
+ (char *)cStringForBitmapBackButtonRight
{
    return
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
}
+ (char *)cStringForBitmapForwardButtonLeft
{
    return
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
}
+ (char *)cStringForBitmapForwardButtonMiddle
{
    return
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
}
+ (char *)cStringForBitmapForwardButtonRight
{
    return
"b     \n"
"bb    \n"
".b    \n"
".bb   \n"
"..b   \n"
"..bb  \n"
"...b  \n"
"...bb \n"
"....b \n"
"....bb\n"
"....bb\n"
"....b \n"
"...bb \n"
"...b  \n"
"..bb  \n"
"..b   \n"
".bb   \n"
".b    \n"
"bb    \n"
"b     \n"
;
}
@end

@implementation NSObject(Jfkldslkfjsdklfj)
- (id)asNavigationInterface
{
    id obj = [@"NavigationInterface" asInstance];
    [obj pushObject:self];
    return obj;
}
@end



@implementation Definitions(fjdkslfjklsdjf)
+ (void)popFromMainInterface
{
    [[Definitions mainInterface] popObject];
}
+ (id)mainMenuInterface
{
    return [[[Definitions execDir:@"Config/mainMenu.csv"] menuFromPath] asListInterface];
}

+ (int)navigationBarHeight
{
    return 44;
}



#ifdef BUILD_FOR_OSX
+ (id)mainInterface
{
    id keyWindow = [NSApp keyWindow];
    id contentView = [keyWindow contentView];
    id obj = [contentView valueForKey:@"object"];
    if ([obj isKindOfClass:[@"NavigationInterface" asClass]]) {
        return obj;
    }
    return [@"NavigationInterface" asInstance];
}
#endif
#ifdef BUILD_FOR_IOS
+ (id)mainInterface
{
    return [Definitions rootViewController];
}
#endif
#ifdef BUILD_FOR_LINUX
+ (id)mainInterface
{
    id obj = [@"mainInterface" valueForKey];
    if (!obj) {
        obj = [@"NavigationInterface" asInstance];
        [obj setAsValueForKey:@"mainInterface"];
    }
    return obj;
}
#endif

#ifdef BUILD_FOR_IOS
+ (id)interfaceObject
{
    id interface = [Definitions mainInterface];
    id viewControllers = [interface valueForKey:@"viewControllers"];
    viewControllers = [viewControllers reverse];
    for (id elt in viewControllers) {
        if ([elt isKindOfClass:[@"ArrayViewController" asClass]]) {
            id tv = [[elt view] tableView];
            id arr = [elt valueForKey:@"array"];
            id indexPath = [tv indexPathForSelectedRow];
            if (indexPath) {
                id selectedObject = [arr nth:[indexPath row]];
                return selectedObject;
            }
        } else if ([elt isKindOfClass:[@"ObjectViewController" asClass]]) {
            id object = [elt valueForKey:@"object"];
            return object;
        }
    }
    return nil;
}

+ (id)interfaceValueForKey:(id)key
{
    id interface = [Definitions mainInterface];
    id viewControllers = [interface valueForKey:@"viewControllers"];
    viewControllers = [viewControllers reverse];
    for (id elt in viewControllers) {
        if ([elt isKindOfClass:[@"ArrayViewController" asClass]]) {
            id tv = [[elt view] tableView];
            id arr = [elt valueForKey:@"array"];
            id indexPath = [tv indexPathForSelectedRow];
            if (indexPath) {
                id selectedObject = [arr nth:[indexPath row]];
                id val = [selectedObject valueForKey:key];
                if (val) {
                    return val;
                }    
            }
        } else if ([elt isKindOfClass:[@"ObjectViewController" asClass]]) {
            id object = [elt valueForKey:@"object"];
            id val = [object valueForKey:key];
            if (val) {
                return val;
            }
        }
    }
    return nil;
}
#else
+ (id)interfaceObject
{
    id interface = [Definitions mainInterface];
    id context = [interface valueForKey:@"context"];
    id cursor = context;
    for(;;) {
        if (!cursor) {
            break;
        }
        id obj = [cursor valueForKey:@"object"];
        if ([obj isKindOfClass:[@"ListInterface" asClass]]) {
            id selectedObject = [obj valueForKey:@"selectedObject"];
            if (selectedObject) {
                return selectedObject;
            }
        } else {
            return obj;
        }
        cursor = [cursor valueForKey:@"previous"];
    }
    return nil;
}
+ (id)interfaceValueForKey:(id)key
{
    id interface = [Definitions mainInterface];
    id context = [interface valueForKey:@"context"];
    id cursor = context;
    for(;;) {
        if (!cursor) {
            break;
        }
        id obj = [cursor valueForKey:@"object"];
        id selectedObject = [obj valueForKey:@"selectedObject"];
        id val = [selectedObject valueForKey:key];
        if (val) {
            return val;
        }
        cursor = [cursor valueForKey:@"previous"];
    }
    return nil;
}
#endif
@end



#ifdef BUILD_FOR_IOS
@implementation NSObject(jfkdlsjfkldsjfklsjf)
- (void)pushToMainInterface
{
NSLog(@"NSObject pushToMainInterface");
    id result = self;
    id obj = nil;
    if ([result isKindOfClass:[UIViewController class]]) {
    } else if ([result isKindOfClass:[UIView class]]) {
        result = [result asViewController];
    } else if ([result isKindOfClass:[NSArray class]]) {
        result = [result asArrayViewController];
    } else if ([result isKindOfClass:[NSDictionary class]]) {
NSLog(@"is dictionary: %@", [result allKeysAndValues]);
        result = [result asKeyValueArray];
        result = [result asArrayViewController];
    } else {
        obj = result;
        result = [result asObjectViewController];
    }
    if (result) {
        if (result != [[Definitions mainInterface] topViewController]) {
            [[Definitions mainInterface] pushViewController:result animated:1];
        }
    }
}
@end
#else
@implementation NSDictionary(fjkldsjfklsdjfk)
- (void)pushToMainInterface
{
    id obj = [@"ListInterface" asInstance];
    [obj setupDict:self];
    [obj pushToMainInterface];
}
@end

@implementation NSArray(jfkdsljfklsdjf)
- (void)pushToMainInterface
{
    id obj = [@"ListInterface" asInstance];
    [obj setup:self];
    [obj pushToMainInterface];
}
@end
@implementation NSString(jfkldsjklfjsdkf)
- (void)pushToMainInterface
{
    NSLog(@"pushToMainInterface %@", self);
    [[Definitions mainInterface] pushObject:self];
}
@end
@implementation NSObject(jfkldsjklfjsdkf)
- (void)pushToMainInterface
{
    NSLog(@"pushToMainInterface %@", self);
    [[Definitions mainInterface] pushObject:self];
}
@end
#endif

@interface NavigationInterface : IvarObject
{
    BOOL _buttonPassthrough;
    id _buttonDown;
    id _buttonHover;
    id _context;
    id _inputString;
    id _rightButtonDown;
    int _animateIteration;
    int _animateMaxIteration;
    id _animateFromContext;
    id _animateToContext;
    id _animateTransition;
}
@end

@implementation NavigationInterface
- (void)drawTransitionInBitmap:(id)bitmap rect:(Int4)r
{
//FIXME use textures
    int w = r.w;
    int h = r.h;

    if ([_animateTransition isEqual:@"forward"]) {
        [bitmap setColor:@"white"];
        [bitmap fillRect:r];
        double pct = (double)_animateIteration / (double)_animateMaxIteration;
        id prevObject = [_animateFromContext valueForKey:@"object"];
        id prevBitmap = [_animateFromContext valueForKey:@"bitmap"];
        if (!prevBitmap) {
            prevBitmap = [bitmap bitmapWithWidth:w height:h];
            if ([prevObject respondsToSelector:@selector(drawInBitmap:rect:)]) {
                [prevObject drawInBitmap:prevBitmap rect:[Definitions rectWithX:0 y:0 w:w h:h]];
            }
            [_animateFromContext setValue:prevBitmap forKey:@"bitmap"];
        }
        id nextObject = [_animateToContext valueForKey:@"object"];
        id nextBitmap = [_animateToContext valueForKey:@"bitmap"];
        if (!nextBitmap) {
            nextBitmap = [bitmap bitmapWithWidth:w height:h];
            if ([nextObject respondsToSelector:@selector(drawInBitmap:rect:)]) {
                [nextObject drawInBitmap:nextBitmap rect:[Definitions rectWithX:0 y:0 w:w h:h]];
            }
            [_animateToContext setValue:nextBitmap forKey:@"bitmap"];
        }
        [bitmap drawBitmap:prevBitmap x:-w*pct y:r.y];
        [bitmap drawBitmap:nextBitmap x:w-w*pct y:r.y];
    } else if ([_animateTransition isEqual:@"reverse"]) {
        [bitmap setColor:@"white"];
        [bitmap fillRect:r];
        double pct = (double)_animateIteration / (double)_animateMaxIteration;

        id prevObject = [_animateFromContext valueForKey:@"object"];
        id prevBitmap = [_animateFromContext valueForKey:@"bitmap"];
        if (!prevBitmap) {
            prevBitmap = [bitmap bitmapWithWidth:w height:h];
            if ([prevObject respondsToSelector:@selector(drawInBitmap:rect:)]) {
                [prevObject drawInBitmap:prevBitmap rect:[Definitions rectWithX:0 y:0 w:w h:h]];
            }
            [_animateFromContext setValue:prevBitmap forKey:@"bitmap"];
        }
        id nextObject = [_animateToContext valueForKey:@"object"];
        id nextBitmap = [_animateToContext valueForKey:@"bitmap"];
        if (!nextBitmap) {
            nextBitmap = [bitmap bitmapWithWidth:w height:h];
            if ([nextObject respondsToSelector:@selector(drawInBitmap:rect:)]) {
                [nextObject drawInBitmap:nextBitmap rect:[Definitions rectWithX:0 y:0 w:w h:h]];
            }
            [_animateToContext setValue:nextBitmap forKey:@"bitmap"];
        }




        [bitmap drawBitmap:prevBitmap x:w*pct y:r.y];
        [bitmap drawBitmap:nextBitmap x:-w+w*pct y:r.y];
    }
}

- (void)transition:(id)transition context:(id)nextContext
{
    _animateIteration = 0;
    _animateMaxIteration = 12;
    [self setValue:transition forKey:@"animateTransition"];
    [self setValue:_context forKey:@"animateFromContext"];
    [self setValue:nextContext forKey:@"animateToContext"];
    [self setValue:nil forKey:@"context"];
}


- (void)popToObject:(id)obj
{
    id cursor = _context;
    for(;;) {
        cursor = [cursor valueForKey:@"previous"];
        if (cursor) {
NSLog(@"popToObject %@", [cursor valueForKey:@"object"]);
            if (obj == [cursor valueForKey:@"object"]) {
                [self transition:@"reverse" context:cursor];
                return;
            }
        } else {
            break;
        }
    }
}

- (void)popObject
{
    id previous = [_context valueForKey:@"previous"];
    if (previous) {
        [self transition:@"reverse" context:previous];
    }
}

- (void)pushObject:(id)obj
{
    if (!obj) {
        return;
    }
    if ([obj isKindOfClass:[NavigationInterface class]]) {
NSLog(@"pushObject:%@ not allowed", obj);
        return;
    }
    id newContext = nsdict();
    [newContext setValue:_context forKey:@"previous"];
    [newContext setValue:obj forKey:@"object"];
    if (!_context) {
        [self setValue:newContext forKey:@"context"];
    } else {
        [self transition:@"forward" context:newContext];
    }
}


- (int)fileDescriptor
{
    id obj = [_context valueForKey:@"object"];
    if ([obj respondsToSelector:@selector(fileDescriptor)]) {
        return [obj fileDescriptor];
    }
    return -1;
}
- (void)handleFileDescriptor
{
    id obj = [_context valueForKey:@"object"];
    if ([obj respondsToSelector:@selector(handleFileDescriptor)]) {
        [obj handleFileDescriptor];
    }
}
- (id)fileDescriptorObjects
{
    id obj = [_context valueForKey:@"object"];
    if ([obj respondsToSelector:@selector(fileDescriptorObjects)]) {
        return [obj fileDescriptorObjects];
    }
    return nil;
}

- (void)handleBackgroundUpdate:(id)event
{
    id obj = [_context valueForKey:@"object"];
    if (obj) {
        if ([obj respondsToSelector:@selector(handleBackgroundUpdate:)]) {
            [obj handleBackgroundUpdate:event];
        }
    }
}
- (BOOL)shouldAnimate
{
    if (_animateIteration < _animateMaxIteration) {
        return YES;
    }
    id obj = [_context valueForKey:@"object"];
    if (obj) {
        if ([obj respondsToSelector:@selector(shouldAnimate)]) {
            if ([obj shouldAnimate]) {
                return YES;
            }
        }
    }
    return NO;
}
    
- (void)beginIteration:(id)event rect:(Int4)r
{
    if (_animateIteration < _animateMaxIteration) {
NSLog(@"beginIteration animateIteration %d", _animateIteration);
        _animateIteration++;
        if (_animateIteration >= _animateMaxIteration) {
            [_animateFromContext setValue:nil forKey:@"bitmap"];
            [_animateToContext setValue:nil forKey:@"bitmap"];
            [self setValue:_animateToContext forKey:@"context"];
            [self setValue:nil forKey:@"animateFromContext"];
            [self setValue:nil forKey:@"animateToContext"];
NSLog(@"context %@", _context);
#ifdef BUILD_FOR_OSX
[[[NSApp keyWindow] contentView] configureLayers];
[[NSApp keyWindow] updateClassMenuItems];
#endif
        }
        return;
    }
    id obj = [_context valueForKey:@"object"];
    if (obj) {
        if ([obj respondsToSelector:@selector(beginIteration:rect:)]) {
            [obj beginIteration:event rect:r];
        }
    }
}
- (void)endIteration:(id)event
{
    id obj = [_context valueForKey:@"object"];
    if (obj) {
        if ([obj respondsToSelector:@selector(endIteration:)]) {
            [obj endIteration:event];
        }
    }
}


- (id)buttonForMousePosEvent:(id)event
{
    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];

    if (mouseY < 0) {
        return nil;
    }
    if (mouseY >= [Definitions navigationBarHeight]) {
        return nil;
    }

    if (mouseX < 0) {
        return nil;
    } else if (mouseX >= [event intValueForKey:@"viewWidth"]) {
        return nil;
    } else if (mouseX < [event intValueForKey:@"viewWidth"] / 4) {
        return @"backButton";
    } else if (mouseX > [event intValueForKey:@"viewWidth"] / 4 * 3) {
        return @"forwardButton";
    } else {
        return @"header";
    }
    
    return nil;
}

- (void)handleMagnify:(id)event
{
    id obj = [_context valueForKey:@"object"];
    if ([obj respondsToSelector:@selector(handleMagnify:)]) {
        [obj handleMagnify:event];
    }
}

- (void)handleScrollWheel:(id)event
{
    id obj = [_context valueForKey:@"object"];
    if ([obj respondsToSelector:@selector(handleScrollWheel:)]) {
        int navigationBarHeight = [Definitions navigationBarHeight];
        [event setValue:nsfmt(@"%d", [event intValueForKey:@"viewHeight"] - navigationBarHeight) forKey:@"viewHeight"];
        [obj handleScrollWheel:event];
    }
}
- (void)handleMouseDown:(id)event
{
    id obj = [_context valueForKey:@"object"];
    int mouseY = [event intValueForKey:@"mouseY"];
    int navigationBarHeight = [Definitions navigationBarHeight];
    if (mouseY < navigationBarHeight) {
        id button = [self buttonForMousePosEvent:event];
        [self setValue:button forKey:@"buttonDown"];
        _buttonPassthrough = NO;
    } else {
        [event setValue:nsfmt(@"%d", [event intValueForKey:@"viewHeight"] - navigationBarHeight) forKey:@"viewHeight"];
        if ([obj respondsToSelector:@selector(handleMouseDown:)]) {
            [Definitions fixupEvent:event forBitmapObject:obj];
            [obj handleMouseDown:event];
        }
        _buttonPassthrough = YES;
    }
}
- (void)handleRightMouseDown:(id)event
{
    id obj = [_context valueForKey:@"object"];
    int mouseY = [event intValueForKey:@"mouseY"];
    int navigationBarHeight = [Definitions navigationBarHeight];
    if (mouseY < navigationBarHeight) {
        id button = [self buttonForMousePosEvent:event];
        [self setValue:button forKey:@"rightButtonDown"];
        _buttonPassthrough = NO;
    } else {
        [event setValue:nsfmt(@"%d", [event intValueForKey:@"viewHeight"] - [Definitions navigationBarHeight]) forKey:@"viewHeight"];
        if ([obj respondsToSelector:@selector(handleRightMouseDown:)]) {
            [obj handleRightMouseDown:event];
            _buttonPassthrough = YES;
        }
    }
}

- (void)handleMouseUp:(id)event
{
    id obj = [_context valueForKey:@"object"];
    if (!_buttonPassthrough) {
        if (!_buttonDown) {
            return;
        }
        id buttonDown = _buttonDown;
        [self setValue:nil forKey:@"buttonDown"];
        _buttonPassthrough = NO;
        if ([buttonDown isEqual:_buttonHover]) {
            if ([buttonDown isEqual:@"backButton"]) {
                [self goBack];
            } else if ([buttonDown isEqual:@"forwardButton"]) {
            }
        }
    } else {
        int navigationBarHeight = [Definitions navigationBarHeight];
        [event setValue:nsfmt(@"%d", [event intValueForKey:@"viewHeight"] - navigationBarHeight) forKey:@"viewHeight"];
        if ([obj respondsToSelector:@selector(handleMouseUp:)]) {
            [Definitions fixupEvent:event forBitmapObject:obj];
            [obj handleMouseUp:event];
        }
        _buttonPassthrough = NO;
    }
}
- (void)handleRightMouseUp:(id)event
{
    id obj = [_context valueForKey:@"object"];
    if (!_buttonPassthrough) {
        if (!_rightButtonDown) {
            return;
        }
        id rightButtonDown = _rightButtonDown;
        [self setValue:nil forKey:@"rightButtonDown"];
        _buttonPassthrough = NO;
        if ([rightButtonDown isEqual:_buttonHover]) {
            if ([rightButtonDown isEqual:@"header"]) {
NSLog(@"handleRightClick:%@", rightButtonDown);
NSLog(@"obj %@", obj);
                id menu = [obj classMenuForObject];
                for (id choice in menu) {
                    [choice setValue:@"#{name}" forKey:@"stringFormat"];
                    if ([choice intValueForKey:@"drawChevron"]) {
                        [choice setValue:@"message|evaluateMessageWithContext:previousObject" forKey:@"messageForClick"];
                    } else {
                        [choice setValue:@"message|evaluateMessageWithContext:previousObject ; mainInterface | popToObject:(selectedObject|previousObject)" forKey:@"messageForClick"];
                    }
                    [choice setValue:obj forKey:@"previousObject"];
                }
                [[menu asListInterface] pushToMainInterface];
            }
        }
    } else {
        int navigationBarHeight = [Definitions navigationBarHeight];
        [event setValue:nsfmt(@"%d", [event intValueForKey:@"viewHeight"] - navigationBarHeight) forKey:@"viewHeight"];
        if ([obj respondsToSelector:@selector(handleRightMouseUp:)]) {
            [obj handleRightMouseUp:event];
        }
        _buttonPassthrough = NO;
    }
}


- (void)handleMouseMoved:(id)event
{
    id obj = [_context valueForKey:@"object"];
    int mouseY = [event intValueForKey:@"mouseY"];
    int cellHeight = [Definitions navigationBarHeight];
    BOOL passthrough = NO;
    if (_buttonDown) {
        passthrough = _buttonPassthrough;
    } else {
        if (mouseY < cellHeight) {
            passthrough = NO;
        } else {
            passthrough = YES;
        }
    }
    
    if (!passthrough) {
        id button = [self buttonForMousePosEvent:event];
        [self setValue:button forKey:@"buttonHover"];
    } else {
        [event setValue:nsfmt(@"%d", [event intValueForKey:@"viewHeight"] - cellHeight) forKey:@"viewHeight"];
        if ([obj respondsToSelector:@selector(handleMouseMoved:)]) {
            [Definitions fixupEvent:event forBitmapObject:obj];
            [obj handleMouseMoved:event];
        }
    }
}

- (void)handleKeyDown:(id)event
{
    id obj = [_context valueForKey:@"object"];
    if (!obj) {
        return;
    }
    id keyString = [event valueForKey:@"keyString"];
NSLog(@"keyString '%@'", keyString);
    if (!_inputString) {
        if ([keyString isEqual:@":"]) {
            [self setValue:@"" forKey:@"inputString"];
            return;
        }
    } else {
        if ([keyString isEqual:@"shiftbackspace"]) {
            [self setValue:nil forKey:@"inputString"];
            return;
        } else if ([keyString isEqual:@"backspace"]) {
            if ([_inputString length]) {
                [self setValue:[_inputString stringToIndex:-1] forKey:@"inputString"];
            } else {
                [self setValue:nil forKey:@"inputString"];
            }
            return;
        } else if ([keyString isEqual:@"return"]) {
            id result = nil;
            if ([_inputString length]) {
                if ([obj isKindOfClass:[@"ListInterface" asClass]]) {
                    if ([_inputString hasPrefix:@"~"]) {
                        [self setValue:[_inputString stringFromIndex:1] forKey:@"inputString"];
                    } else {
                        obj = [obj valueForKey:@"array"];
                    }
                }
                result = [obj evaluateMessage:_inputString];
            }
            [self setValue:nil forKey:@"inputString"];
            if (obj == result) {
            } else {
                [result pushToMainInterface];
            }
            return;
        } else if ([keyString isEqual:@"space"]) {
            [self setValue:nsfmt(@"%@ ", _inputString) forKey:@"inputString"];
            return;
        } else if ([keyString length] == 1) {
            [self setValue:nsfmt(@"%@%@", _inputString, keyString) forKey:@"inputString"];
            return;
        }
    }
    

    if ([obj respondsToSelector:@selector(handleKeyDown:)]) {
        [obj handleKeyDown:event];
    } else {
        if ([event intValueForKey:@"keyMod1"]) {
            [obj handleClassMenuKeyEquivalent:[event valueForKey:@"keyString"]];
        } else {
            [obj handleClassMenuKeyDown:[event valueForKey:@"keyString"]];
        }
    }
}
- (void)handleKeyUp:(id)event
{
    id obj = [_context valueForKey:@"object"];
    if (!obj) {
        return;
    }

    if ([obj respondsToSelector:@selector(handleKeyUp:)]) {
        [obj handleKeyUp:event];
    }
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    int navigationBarHeight = [Definitions navigationBarHeight];

    id title = nil;

    Int4 r1 = r;
    r1.y += navigationBarHeight;
    r1.h -= navigationBarHeight;

    if (_animateIteration < _animateMaxIteration) {
        [self drawTransitionInBitmap:bitmap rect:r1];
    } else {
        id obj = [_context valueForKey:@"object"];
        if (obj) {
            id headerFormat = [obj valueForKey:@"headerFormat"];
            title = (headerFormat) ? [obj str:headerFormat] : nsfmt(@"%@", [obj class]);
            if ([obj respondsToSelector:@selector(drawInBitmap:rect:)]) {
                [obj drawInBitmap:bitmap rect:r1];
            }
#ifdef BUILD_FOR_LINUX
#ifdef BUILD_FOR_ANDROID
#else
            else if ([obj respondsToSelector:@selector(pixelBytesRGBA8888)]) {
                if (![[@"windowManager" valueForKey] valueForKey:@"openGLTexture"]) {
                    int bitmapWidth = [obj bitmapWidth];
                    int bitmapHeight = [obj bitmapHeight];
                    char *bytes = [obj pixelBytesRGBA8888];
                    [bitmap drawBytes:bytes bitmapWidth:bitmapWidth bitmapHeight:bitmapHeight x:r.x y:navigationBarHeight+r.y w:r.w h:r.h-navigationBarHeight]; // I think the y: calculation is wrong
                }
            }
            else if ([obj respondsToSelector:@selector(pixelBytesBGR565)]) {
                if (![[@"windowManager" valueForKey] valueForKey:@"openGLTexture"]) {
                    int bitmapWidth = [obj bitmapWidth];
                    int bitmapHeight = [obj bitmapHeight];
                    char *bytes = [obj pixelBytesBGR565];
                    [bitmap drawBytes565:bytes bitmapWidth:bitmapWidth bitmapHeight:bitmapHeight x:r.x y:navigationBarHeight+r.y w:r.w h:r.h-navigationBarHeight]; // I think the y: calculation is wrong
                }
            }
#endif
#endif
            else {
                [bitmap setColor:@"white"];
                [bitmap fillRect:r1];
                [bitmap setColor:@"black"];
                id text = [obj description];
                text = [bitmap fitBitmapString:text width:r1.w-10];
                [bitmap drawBitmapText:text x:r1.x+5 y:r1.y+5];
            }
        }
    }

    [self drawNavigationBarInBitmap:bitmap rect:r title:title backButton:([_context valueForKey:@"previous"]) ? @"Back" : nil forwardButton:nil];



    if (_inputString) {
        Int4 boxRect = [Definitions rectWithX:r.x y:r.h/2.0 w:r.w h:20.0];
        [bitmap setColor:@"cyan"];
        [bitmap fillRect:boxRect];
        [bitmap setColorIntR:0 g:0 b:0 a:255];
        [bitmap drawBitmapText:_inputString centeredInRect:boxRect];
    }
}
- (void)drawNavigationBarInBitmap:(id)bitmap rect:(Int4)rect title:(id)title backButton:(id)backButton forwardButton:(id)forwardButton
{
    int cellHeight = [Definitions navigationBarHeight];

    Int4 headerRect = [Definitions rectWithX:rect.x y:rect.y w:rect.w h:cellHeight];
    [bitmap setColor:@"#7990ae"];
    [bitmap fillRect:headerRect];
Int4 shadowRect = headerRect;
shadowRect.y -= 1;
    [bitmap setColorIntR:0x4c g:0x55 b:0x61 a:255];
    [bitmap drawBitmapText:title centeredInRect:shadowRect];
    [bitmap setColorIntR:240 g:240 b:240 a:255];
    [bitmap drawBitmapText:title centeredInRect:headerRect];
    [bitmap setColor:@"black"];
    [bitmap drawHorizontalLineX:headerRect.x x:headerRect.x+headerRect.w y:headerRect.y+headerRect.h-1];
    
    if (backButton) {
        Int4 buttonRect = [Definitions rectWithX:headerRect.x y:headerRect.y w:headerRect.w/4.0 h:headerRect.h];
        if ([_buttonDown isEqual:@"backButton"] && [_buttonHover isEqual:@"backButton"]) {
            char *palette = ". #344972\nb #000000\n";
            [Definitions drawBackButtonInBitmap:bitmap rect:buttonRect palette:palette];
Int4 shadowRect = buttonRect;
shadowRect.y -= 1;
[bitmap setColorIntR:0x4c g:0x55 b:0x61 a:255];
[bitmap drawBitmapText:backButton centeredInRect:shadowRect];
[bitmap setColorIntR:255 g:255 b:255 a:255];
            [bitmap drawBitmapText:backButton centeredInRect:buttonRect];
        } else {
            char *palette = ". #587398\nb #000000\n";
            [Definitions drawBackButtonInBitmap:bitmap rect:buttonRect palette:palette];
Int4 shadowRect = buttonRect;
shadowRect.y -= 1;
[bitmap setColorIntR:0x4c g:0x55 b:0x61 a:255];
[bitmap drawBitmapText:backButton centeredInRect:shadowRect];
[bitmap setColorIntR:240 g:240 b:240 a:255];
            [bitmap drawBitmapText:backButton centeredInRect:buttonRect];
        }
    }

    if (forwardButton) {
        Int4 buttonRect = [Definitions rectWithX:headerRect.x+headerRect.w/4.0*3.0 y:headerRect.y w:headerRect.w/4.0 h:headerRect.h];
        if ([_buttonDown isEqual:@"forwardButton"] && [_buttonHover isEqual:@"forwardButton"]) {
            char *palette = ". #000000\nb #000000\n";
            [Definitions drawForwardButtonInBitmap:bitmap rect:buttonRect palette:palette];
            [bitmap setColorIntR:255 g:255 b:255 a:255];
            [bitmap drawBitmapText:forwardButton centeredInRect:buttonRect];
        } else {
            char *palette = ". #ffffff\nb #000000\n";
            [Definitions drawForwardButtonInBitmap:bitmap rect:buttonRect palette:palette];
            [bitmap setColorIntR:0 g:0 b:0 a:255];
            [bitmap drawBitmapText:forwardButton centeredInRect:buttonRect];
        }
    }
}
- (void)goBack
{
    [self popObject];
}
@end

