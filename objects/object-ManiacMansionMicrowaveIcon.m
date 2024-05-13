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

static id menuCSV =
@"displayName,messageForClick\n"
@"Microwave,\n"
@"\"Open Microwave\",\"setValue:1 forKey:'open'\"\n"
@"\"Close Microwave\",\"setValue:0 forKey:'open'\"\n"
@"\"Turn On Microwave\",\"turnOnMicrowave\"\n"
@"\"Remove From Microwave And Eat\",\"removeFromMicrowaveAndEat\"\n"
;

static char *microwavePalette =
". #000000\n"
"x #525452\n"
"X #AC0000\n"
"o #AC5400\n"
"O #0000AC\n"
"+ #5254FF\n"
"@ #ACA9AC\n"
"# #FFFEFF\n"
;

static char *microwavePixels =
"zzzzzzzzzzzzzzzz........................................................................................................................\n"
"zzzzzzzzzzzzzzzz........................................................................................................................\n"
"zzzzzzzzzzzzzzzz..XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX......\n"
"zzzzzzzzzzzzzzzz..XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX......\n"
"zzzzzzzzzzzzzzzz..XXooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooXX......\n"
"zzzzzzzzzzzzzzzz..XXooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooXX......\n"
"zzzzzzzzzzzzzzzz..XXoo................................................................................xxxx......................XX......\n"
"zzzzzzzzzzzzzzzz..XXoo................................................................................xxxx......................XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx..##@@..OOOOOOOOOOOOOOOOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx..##@@..OOOOOOOOOOOOOOOOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........................................................................xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........................................................................xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx....@@@@@@@@@@..........................................................xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx....@@@@@@@@@@..........................................................xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@..................................................................@@xx..##@@..OO..............OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@..................................................................@@xx..##@@..OO..............OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..##..##..##..OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..##..##..##..OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..............OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..............OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..##..##..##..OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..##..##..##..OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..............OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..............OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..##..##..##..OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..##..##..##..OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..............OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..............OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..##########..OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..##########..OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..............OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..............OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..............OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..............OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..............OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..............OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@..................................................................@@xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@..................................................................@@xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@..xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@..xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx..##@@..OO############@@OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx..##@@..OO############@@OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo................................................................................##@@......................XX......\n"
"zzzzzzzzzzzzzzzz..XXoo................................................................................##@@......................XX......\n"
"zzzzzzzzzzzzzzzz..XXooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooXXXX....  \n"
"zzzzzzzzzzzzzzzz..XXooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooXXXX....  \n"
"zzzzzzzzzzzzzzzz....................................................................................................................    \n"
"zzzzzzzzzzzzzzzz....................................................................................................................    \n"
"zzzzzzzzzzzzzzzz          xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx....        \n"
"zzzzzzzzzzzzzzzz          xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx....        \n"
;

static char *openMicrowavePalette =
"* #000000\n"
". #525452\n"
"X #AC0000\n"
"o #AC5400\n"
"O #0000AC\n"
"+ #5254FF\n"
"@ #ACA9AC\n"
"# #FFFEFF\n"
;

static char *openMicrowavePixels =
"                ************************************************************************************************************************\n"
"                ************************************************************************************************************************\n"
"                **XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX******\n"
"                **XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX******\n"
"                **XXooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooXX******\n"
"                **XXooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooXX******\n"
"******************************************************************************************************....**********************XX******\n"
"******************************************************************************************************....**********************XX******\n"
"**..**................**............................................................................**##@@**OOOOOOOOOOOOOOOOOO**XX******\n"
"**..**................**............................................................................**##@@**OOOOOOOOOOOOOOOOOO**XX******\n"
"**..**................**..************************************************************************..**##@@**OO++++++++++++OOOO**XX******\n"
"**..**................**..************************************************************************..**##@@**OO++++++++++++OOOO**XX******\n"
"**..**....@@@@@@@@@@..**..************************************************************************..**##@@**OO++++++++++++OOOO**XX******\n"
"**..**....@@@@@@@@@@..**..************************************************************************..**##@@**OO++++++++++++OOOO**XX******\n"
"**..**....@@@@@@@@@@..**..************************************************************************..**##@@**OO**************OO**XX******\n"
"**..**....@@@@@@@@@@..**..************************************************************************..**##@@**OO**************OO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO**##**##**##**OO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO**##**##**##**OO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO**************OO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO**************OO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO**##**##**##**OO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO**##**##**##**OO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO**************OO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO**************OO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO**##**##**##**OO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO**##**##**##**OO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO**************OO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO**************OO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO**##########**OO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO**##########**OO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO**************OO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO**************OO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO++++++++++++OOOO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO++++++++++++OOOO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO++++++++++++OOOO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO++++++++++++OOOO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO++++++++++++OOOO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO++++++++++++OOOO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO++++++++++++OOOO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO++++++++++++OOOO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO**************OO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO**************OO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO**************OO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO**************OO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO++++++++++++OOOO**XX******\n"
"**..**....@@@@@@@@@@..**..********........................................................********..**##@@**OO++++++++++++OOOO**XX******\n"
"**..**....@@@@@@@@@@..**..************************************************************************..**##@@**OO++++++++++++OOOO**XX******\n"
"**..**....@@@@@@@@@@..**..************************************************************************..**##@@**OO++++++++++++OOOO**XX******\n"
"**..**................**..************************************************************************..**##@@**OO++++++++++++OOOO**XX******\n"
"**..**................**..************************************************************************..**##@@**OO++++++++++++OOOO**XX******\n"
"**..**................**............................................................................**##@@**OO############@@OO**XX******\n"
"**..**................**............................................................................**##@@**OO############@@OO**XX******\n"
"******************************************************************************************************##@@**********************XX******\n"
"******************************************************************************************************##@@**********************XX******\n"
"                **XXooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooXXXX****  \n"
"                **XXooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooXXXX****  \n"
"                ********************************************************************************************************************    \n"
"                ********************************************************************************************************************    \n"
"                          ..................................................................................................****        \n"
"                          ..................................................................................................****        \n"
;

static char *turnedOnMicrowavePalette =
". #000000\n"
"x #a2a4a2\n"
"y #525452\n"
"X #AC0000\n"
"o #AC5400\n"
"O #0000AC\n"
"+ #5254FF\n"
"@ #ACA9AC\n"
"# #FFFEFF\n"
;

static char *turnedOnMicrowavePixels =
"zzzzzzzzzzzzzzzz........................................................................................................................\n"
"zzzzzzzzzzzzzzzz........................................................................................................................\n"
"zzzzzzzzzzzzzzzz..XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX......\n"
"zzzzzzzzzzzzzzzz..XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX......\n"
"zzzzzzzzzzzzzzzz..XXooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooXX......\n"
"zzzzzzzzzzzzzzzz..XXooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooXX......\n"
"zzzzzzzzzzzzzzzz..XXoo................................................................................yyyy......................XX......\n"
"zzzzzzzzzzzzzzzz..XXoo................................................................................yyyy......................XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx..##@@..OOOOOOOOOOOOOOOOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx..##@@..OOOOOOOOOOOOOOOOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........................................................................xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........................................................................xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx....@@@@@@@@@@..........................................................xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx....@@@@@@@@@@..........................................................xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@..................................................................@@xx..##@@..OO..............OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@..................................................................@@xx..##@@..OO..............OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..##..##..##..OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..##..##..##..OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..............OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..............OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..##..##..##..OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..##..##..##..OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..............OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..............OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..##..##..##..OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..##..##..##..OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..............OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..............OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..##########..OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..##########..OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..............OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..............OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx........xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..............OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..............OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..............OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO..............OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@....xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx......@@xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@..................................................................@@xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@..................................................................@@xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@..xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xx..@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@..xx..##@@..OO++++++++++++OOOO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx..##@@..OO############@@OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx..##@@..OO############@@OO..XX......\n"
"zzzzzzzzzzzzzzzz..XXoo................................................................................##@@......................XX......\n"
"zzzzzzzzzzzzzzzz..XXoo................................................................................##@@......................XX......\n"
"zzzzzzzzzzzzzzzz..XXooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooXXXX....  \n"
"zzzzzzzzzzzzzzzz..XXooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooXXXX....  \n"
"zzzzzzzzzzzzzzzz....................................................................................................................    \n"
"zzzzzzzzzzzzzzzz....................................................................................................................    \n"
"zzzzzzzzzzzzzzzz          xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx....        \n"
"zzzzzzzzzzzzzzzz          xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx....        \n"
;


@interface ManiacMansionMicrowaveIcon : IvarObject
{
    BOOL _needsRedraw;
    int _backgroundClock;
    int _open;
    int _on;
    id _userObject;

    id _path;
    BOOL _buttonDown;
    int _buttonDownX;
    int _buttonDownY;
    id _buttonDownTimestamp;

    id _dragX11Dict;
}
@end
@implementation ManiacMansionMicrowaveIcon
- (int)preferredWidth
{
    static int w = 0;
    if (!w) {
        w = [Definitions widthForCString:microwavePixels];
        if ([_path length]) {
            id bitmap = [Definitions bitmapWithWidth:1 height:1];
            [bitmap useWinSystemFont];
            int textWidth = [bitmap bitmapWidthForText:_path];
            if (textWidth > w) {
                w = textWidth;
            }
        }
    }
    return w;
}
- (int)preferredHeight
{
    static int h = 0;
    if (!h) {
        h = [Definitions heightForCString:microwavePixels];
        if ([_path length]) {
            id bitmap = [Definitions bitmapWithWidth:1 height:1];
            [bitmap useWinSystemFont];
            int textHeight = [bitmap bitmapHeightForText:_path];
            h += textHeight;
        }
    }
    return h;
}

- (BOOL)shouldAnimate
{
    if (_needsRedraw) {
        _needsRedraw = NO;
        return YES;
    }
    return NO;
}

- (void)drawInBitmap:(id)bitmap rect:(Int4)r context:(id)context
{
    BOOL hasFocus = NO;
    {
        id windowManager = [@"windowManager" valueForKey];
        unsigned long focusInEventWindow = [[windowManager valueForKey:@"focusInEventWindow"] unsignedLongValue];
        unsigned long win = [[context valueForKey:@"window"] unsignedLongValue];
        if (focusInEventWindow && (focusInEventWindow == win)) {
            hasFocus = YES;
        }
    }

    char *pixels = microwavePixels;
    char *palette = microwavePalette;
    if (_open) {
        pixels = openMicrowavePixels;
        palette = openMicrowavePalette;
    } else if (_on) {
        pixels = turnedOnMicrowavePixels;
        palette = turnedOnMicrowavePalette;
    }

    int w = [Definitions widthForCString:pixels];
    int h = [Definitions heightForCString:pixels];

    [bitmap drawCString:pixels palette:palette x:r.x+(r.w-w)/2 y:r.y];

    if (_userObject) {
        if ([_userObject respondsToSelector:@selector(drawInBitmap:rect:context:)]) {
            int w = 16;
            if ([_userObject respondsToSelector:@selector(preferredWidth)]) {
                w = [_userObject preferredWidth];
            }
            int h = 16;
            if ([_userObject respondsToSelector:@selector(preferredHeight)]) {
                h = [_userObject preferredHeight];
            }
            Int4 r1;
            r1.x = 34;
            r1.y = 16;
            r1.w = w;
            r1.h = h;
            [_userObject drawInBitmap:bitmap rect:r1 context:nil];
        }
    }

    if ([_path length]) {
        [bitmap useWinSystemFont];
        int textWidth = [bitmap bitmapWidthForText:_path];
        int textHeight = [bitmap bitmapHeightForText:_path];
        if (hasFocus) {
            [bitmap setColor:@"black"];
        } else {
            [bitmap setColor:@"white"];
        }
        [bitmap fillRectangleAtX:r.x+(r.w-textWidth)/2 y:r.y+h w:textWidth h:textHeight];
        if (hasFocus) {
            [bitmap setColor:@"white"];
        } else {
            [bitmap setColor:@"black"];
        }
        [bitmap drawBitmapText:_path x:r.x+(r.w-textWidth)/2 y:r.y+h];
    }

    id windowManager = [@"windowManager" valueForKey];
    unsigned long win = [[context valueForKey:@"window"] unsignedLongValue];
    if (win) {
        [windowManager addMaskToWindow:win bitmap:bitmap];
    }
}

- (void)handleMouseDown:(id)event
{
    id windowManager = [@"windowManager" valueForKey];
    id x11dict = [event valueForKey:@"x11dict"];

    {
        unsigned long win = [[x11dict valueForKey:@"window"] unsignedLongValue];
        if (win) {
            [windowManager XRaiseWindow:win];
        }
    }

    int mouseX = [event intValueForKey:@"mouseX"];
    int mouseY = [event intValueForKey:@"mouseY"];
    _buttonDown = YES;
    _buttonDownX = mouseX;
    _buttonDownY = mouseY;

    id timestamp = [Definitions gettimeofday];
    if (_buttonDownTimestamp) {
        if ([timestamp doubleValue]-[_buttonDownTimestamp doubleValue] <= 0.3) {
            [self setValue:nil forKey:@"buttonDownTimestamp"];
            if ([self respondsToSelector:@selector(handleDoubleClick)]) {
                [self handleDoubleClick];
            }
            return;
        }
    }
    [self setValue:timestamp forKey:@"buttonDownTimestamp"];
}

- (void)handleMouseMoved:(id)event
{
    id x11dict = [event valueForKey:@"x11dict"];

    if (!_buttonDown && !_dragX11Dict) {
        return;
    }

    int mouseRootX = [event intValueForKey:@"mouseRootX"];
    int mouseRootY = [event intValueForKey:@"mouseRootY"];

    if (!_dragX11Dict) {
        id windowManager = [event valueForKey:@"windowManager"];
        id objectWindows = [windowManager valueForKey:@"objectWindows"];
        for (int i=0; i<[objectWindows count]; i++) {
            id elt = [objectWindows nth:i];
            [elt setValue:nil forKey:@"isSelected"];
        }
        [x11dict setValue:@"1" forKey:@"isSelected"];

        id newx11dict = [Definitions selectedBitmapForSelectedItemsInArray:objectWindows buttonDownElt:x11dict offsetX:_buttonDownX y:_buttonDownY mouseRootX:mouseRootX y:mouseRootY windowManager:windowManager];

        [self setValue:newx11dict forKey:@"dragX11Dict"];
    } else {

        int newX = mouseRootX - [_dragX11Dict intValueForKey:@"buttonDownOffsetX"];
        int newY = mouseRootY - [_dragX11Dict intValueForKey:@"buttonDownOffsetY"];

        [_dragX11Dict setValue:nsfmt(@"%d", newX) forKey:@"x"];
        [_dragX11Dict setValue:nsfmt(@"%d", newY) forKey:@"y"];

        [_dragX11Dict setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];
    }
}
- (void)handleMouseUp:(id)event
{
    _buttonDown = NO;
    id x11dict = [event valueForKey:@"x11dict"];
    if (_dragX11Dict) {

        id windowManager = [event valueForKey:@"windowManager"];
        int mouseRootX = [event intValueForKey:@"mouseRootX"];
        int mouseRootY = [event intValueForKey:@"mouseRootY"];

        int newX = mouseRootX - _buttonDownX;
        int newY = mouseRootY - _buttonDownY;
        [x11dict setValue:nsfmt(@"%d", newX) forKey:@"x"];
        [x11dict setValue:nsfmt(@"%d", newY) forKey:@"y"];
        [x11dict setValue:nsfmt(@"%d %d", newX, newY) forKey:@"moveWindow"];

        [_dragX11Dict setValue:@"1" forKey:@"shouldCloseWindow"];
        [self setValue:nil forKey:@"dragX11Dict"];
    }
}
- (void)handleRightMouseDown:(id)event
{
    id windowManager = [event valueForKey:@"windowManager"];
    int mouseRootX = [event intValueForKey:@"mouseRootX"];
    int mouseRootY = [event intValueForKey:@"mouseRootY"];

    id obj = [[menuCSV parseCSVFromString] asMenu];
    if (obj) {
        [obj setValue:self forKey:@"contextualObject"];
        [windowManager openButtonDownMenuForObject:obj x:mouseRootX y:mouseRootY w:0 h:0];
    }
}
- (void)handleDoubleClick
{
    if (_open) {
        _open = NO;
    } else {
        _open = YES;
    }
}
- (void)handleBackgroundUpdate:(id)event
{
    if (_backgroundClock > 0) {
        _backgroundClock--;
        if (_backgroundClock == 2) {
            if (_userObject) {
                if (![_userObject intValueForKey:@"cooked"]) {
                    [_userObject setValue:@"1" forKey:@"cooked"];
                    _needsRedraw = YES;
                    id cmd = nsarr();
                    [cmd addObject:@"aplay"];
                    [cmd addObject:[Definitions configDir:@"Sounds/LOZ_Boss_Hit.wav"]];
                    [cmd runCommandInBackground];
                }
            }
        } else if (_backgroundClock == 0) {
            _on = NO;
            _needsRedraw = YES;
            id cmd = nsarr();
            [cmd addObject:@"aplay"];
            [cmd addObject:[Definitions configDir:@"Sounds/LOZ_Fanfare.wav"]];
            [cmd runCommandInBackground];
        }
    }
}

- (void)handleDragAndDrop:(id)x11dict
{
    if (!_open) {
        [@"Microwave is not open." showAlert];
        return;
    }
    if (_userObject) {
        [@"Something is already in the microwave." showAlert];
        return;
    }
    id object = [x11dict valueForKey:@"object"];
    if (![object intValueForKey:@"microwavable"]) {
        [@"That item is not microwave safe." showAlert];
        return;
    }
    [object setValue:nil forKey:@"path"];
    [self setValue:object forKey:@"userObject"];
    [x11dict setValue:@"1" forKey:@"shouldCloseWindow"];
}

- (void)turnOnMicrowave
{
    if (_open) {
        [@"Unable to turn on. The microwave is open." showAlert];
    } else if (_on) {
        [@"The microwave is already on." showAlert];
    } else {
        _on = YES;
        _backgroundClock = 5;
        _needsRedraw = YES;
    }
}




- (void)removeFromMicrowaveAndEat
{
    if (!_open) {
        [@"The microwave is closed." showAlert];
        return;
    }

    if (!_userObject) {
        [@"There is nothing inside the microwave." showAlert];
        return;
    }

    id cmd = nsarr();
    [cmd addObject:@"aplay"];
    [cmd addObject:[Definitions configDir:@"Sounds/homer_eating.wav"]];
    [cmd runCommandInBackground];

    if ([_userObject intValueForKey:@"cooked"]) {
        [@"Nom nom nom nom nom nom" showAlert];
    } else {
        [@"It's not actually cooked... but oh well" showAlert];
    }

    [self setValue:nil forKey:@"userObject"];
    _needsRedraw = YES;

}

@end

