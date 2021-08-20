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

@implementation NSString(fjkdlsjfklsdjf)
- (id)runFileHandler
{
    id handlers = [[Definitions configDir:@"Config/fileHandlers.csv"] parseCSVFile];
    for (int i=0; i<[handlers count]; i++) {
        id elt = [handlers nth:i];
        id suffix = [elt valueForKey:@"suffix"];
        if ([self hasSuffix:suffix]) {
            id message = [elt valueForKey:@"message"];
NSLog(@"message '%@'", message);
            return [self evaluateMessage:message];
        }
    }
    [nsfmt(@"Unknown file type for '%@'", self) showAlert];
    return nil;
}
- (id)handleFileWithMPV
{
    id cmd = nsarr();
    [cmd addObject:@"mpv"];
    [cmd addObject:@"--hwdec=auto"];
    [cmd addObject:@"--force-window=yes"];
    [cmd addObject:@"--volume-max=200"];
    [cmd addObject:@"--video-unscaled=yes"];
    [cmd addObject:self];
    [cmd runCommandInBackground];
    return nil;
}
- (id)handleFileWithMAME
{
    id cmd = nsarr();
    [cmd addObject:@"mame"];
    [cmd addObject:[[self lastPathComponent] stringByDeletingPathExtension]];
    [cmd runCommandInBackground];
    return nil;
}
@end

@implementation NSArray(fjdklsfjlkdsjfklskdljfsd)
- (void)shuffleFilesWithMPV
{
    id cmd = nsarr();
    [cmd addObject:@"mpv"];
    [cmd addObject:@"--hwdec=auto"];
    [cmd addObject:@"--force-window=yes"];
    [cmd addObject:@"--shuffle"];
    for (int i=0; i<[self count]; i++) {
        id elt = [self nth:i];
        id filePath = [elt valueForKey:@"filePath"];
        if (filePath) {
            [cmd addObject:filePath];
        }
    }
    [cmd runCommandInBackground];
}
- (void)handleFileWithMPVForIndex:(int)index makePlaylistWithSuffixes:(id)suffixes
{
    id filePath = [[self nth:index] valueForKey:@"filePath"];
    if (!filePath) {
        return;
    }

    id playlistArray = nsarr();
    for (int i=0; i<[self count]; i++) {
        id elt = [self nth:i];
        id eltFilePath = [elt valueForKey:@"filePath"];
        if ([[eltFilePath lowercaseString] hasAnySuffix:suffixes] || (i == index)) {
            [playlistArray addObject:eltFilePath];
        }
    }
    int playlistIndex = 0;
    for (int i=0; i<[playlistArray count]; i++) {
        id elt = [playlistArray nth:i];
        if ([elt isEqual:filePath]) {
            playlistIndex = i;
            break;
        }
    }
    id cmd = nsarr();
    [cmd addObject:@"mpv"];
    [cmd addObject:@"--hwdec=auto"];
    [cmd addObject:@"--force-window=yes"];
    [cmd addObject:@"--playlist-start"];
    [cmd addObject:nsfmt(@"%d", playlistIndex)];
    [cmd addObjectsFromArray:playlistArray];
    [cmd runCommandInBackground];
}
@end

