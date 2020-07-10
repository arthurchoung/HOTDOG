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

#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <signal.h>
#include <errno.h>

@implementation NSString(JFksdljfklsdjfkljsdkf)
- (id)findInPath
{
    id execPath = [Definitions execDir:self];
    if ([execPath fileExists]) {
        return execPath;
    }

    id utilsPath = [Definitions execDir:nsfmt(@"Utils/%@", self)];
    if ([utilsPath fileExists]) {
        return utilsPath;
    }

    char *cstr = getenv("PATH");
    if (!cstr) {
        cstr = "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin";
    }
    id str = nscstr(cstr);
    id arr = [str split:@":"];
    for (id elt in arr) {
        id path = [elt stringByAppendingPathComponent:self];
        if ([path fileExists]) {
            return path;
        }
    }
    return nil;
}

@end

@implementation Definitions(jfkldsjfklsdjf)
+ (void)runCommandInBackground:(id)cmd
{
    [cmd runCommandInBackground];
}
@end

@interface FileDescriptor : IvarObject
{
    int _len;
    int _fd;
    id _data;
    int _pid;
    id _status;
    int _writefd;
    id _exitStatus;
}
@end
@implementation FileDescriptor

- (id)init
{
    self = [super init];
    if (self) {
        _fd = -1;
        _writefd = -1;
    }
    return self;
}

- (void)dealloc
{
NSLog(@"FileDescriptor dealloc pid %d", _pid);
    if (_writefd != -1) {
        close(_writefd);
        _writefd = -1;
    }
    if (_fd != -1) {
        close(_fd);
        _fd = -1;
    }
    if (_pid) {
        kill(_pid, SIGTERM);
        _pid = 0;
    }
    [super dealloc];
}

- (int)fileDescriptor
{
    return _fd;
}

- (void)handleFileDescriptor
{
    if (_fd == -1) {
        return;
    }
    if (!_data) {
        [self setValue:[[[NSMutableData alloc] init] autorelease] forKey:@"data"];
    }
    char buf[4096];
    int result = read(_fd, buf, sizeof(buf));
    if (result > 0) {
//NSLog(@"Received %d bytes", result);
        [_data appendBytes:buf length:result];
        _len = result;
    } else if (result == 0) {
        close(_fd);
        _fd = -1;
        [self setValue:@"Success" forKey:@"status"];
    } else {
        close(_fd);
        _fd = -1;
        [self setValue:nsfmt(@"Error: %s", strerror(errno)) forKey:@"status"];
    }
}
- (void)writeBytes:(char *)bytes length:(int)length
{
    if (_writefd == -1) {
        return;
    }
    write(_writefd, bytes, length);
}
- (BOOL)writeString:(id)str
{
NSLog(@"writeString writefd %d", _writefd);
    if (_writefd == -1) {
        return NO;
    }
    int len = [str length];
NSLog(@"writeString len %d", len);
    int result = write(_writefd, [str UTF8String], len);
NSLog(@"writeString result %d", result);
    if (result == len) {
        return YES;
    }
    return NO;
}
- (void)writeDataAndCloseOutput:(id)data
{
    [self writeData:data];
    [self closeOutput];
}
- (void)writeData:(id)data
{
    if (_writefd == -1) {
        return;
    }
    int result = write(_writefd, [data bytes], [data length]);
NSLog(@"write result %d", result);
}
- (void)closeOutput
{
    if (_writefd == -1) {
        return;
    }
    close(_writefd);
    _writefd = -1;
}
- (void)closeInput
{
    if (_fd == -1) {
        return;
    }
    close(_fd);
    _fd = -1;
}

- (id)readAllDataThenCloseInputAndWait
{
    id data = [self readAllData];
    [self closeInput];
    [self waitForExitStatus];
    return data;
}

- (id)readAllData
{
    id data = [[[NSMutableData alloc] init] autorelease];
    char readbuf[4096];
    for(;;) {
        int result = read(_fd, readbuf, sizeof(readbuf));
        if (result > 0) {
//NSLog(@"Received %d bytes", result);
            [data appendBytes:readbuf length:result];
        } else if (result == 0) {
            NSLog(@"EOF");
            break;
        } else {
            perror("Error");
            data = nil;
            break;
        }
    }
    return data;
}
- (void)drawInBitmap:(id)bitmap rect:(Int4)r
{
    id str = [_data asString];
    if (_status) {
        str = nsfmt(@"%@*** %@ ***", str, _status);
    }
    [bitmap setColor:@"white"];
    [bitmap fillRect:r];
    [bitmap setColorIntR:0 g:0 b:0 a:255];
    [bitmap drawBitmapText:str x:0+5 y:r.h-1-5];
}
- (id)waitForExitStatus
{
    if (_exitStatus) {
        return _exitStatus;
    }
    if (!_pid) {
        return nil;
    }
    int wstatus = 0;
    if (waitpid(_pid, &wstatus, 0) == _pid) {
        _pid = 0;
        if (WIFEXITED(wstatus)) {
            int status = WEXITSTATUS(wstatus);
            id str = nsfmt(@"%d", status);
            [self setValue:str forKey:@"exitStatus"];
            return str;
        }
    }
    return nil;
}


@end

@implementation NSArray(jfkdlsjfkldsjflksdjf)
- (void)runCommandWithSudoInBackground
{
    id cmd = [@[ @"sudo", @"-S" ] arrayByAddingObjectsFromArray:self];
    id pipe = [cmd runCommandAndReturnPipe];
    [pipe writeData:[nsfmt(@"%@\n", [Definitions getPassword]) asData]];
    [pipe closeOutput];
    [pipe setValue:@"0" forKey:@"pid"];
}
- (id)runCommandWithSudoAndReturnOutput
{
    id cmd = [@[ @"sudo", @"-S" ] arrayByAddingObjectsFromArray:self];
    id pipe = [cmd runCommandAndReturnPipe];
    [pipe writeData:[nsfmt(@"%@\n", [Definitions getPassword]) asData]];
    [pipe closeOutput];
    return [pipe readAllDataThenCloseInputAndWait];
}
- (id)runCommandWithSudoAndReturnPipe
{
    id cmd = [@[ @"sudo", @"-S" ] arrayByAddingObjectsFromArray:self];
    id pipe = [cmd runCommandAndReturnPipe];
    [pipe writeData:[nsfmt(@"%@\n", [Definitions getPassword]) asData]];
    [pipe closeOutput];
    return pipe;
}
@end


@implementation Definitions(jkfldsjfks)
+ (id)dataFromStandardInput
{
NSLog(@"dataFromStandardInput");
    id data = [NSMutableData data];
    for(;;) {
#define BUF_SIZE 16384
        char buf[BUF_SIZE];
        int n = read(0, buf, BUF_SIZE);
NSLog(@"read n %d", n);
        if (n <= 0) {
            return data;
        }
        [data appendBytes:buf length:n];
    }
    
}
@end

@implementation NSString(jksldfjkldsjflk)
- (void)writeToStandardOutput
{
    char *bytes = [self UTF8String];
    int length = strlen(bytes);
    if (length) {
        write(1, bytes, length);
    }
}
@end
@implementation NSData(jkfldsjfks)
- (void)writeToStandardOutput
{
    void *bytes = [self bytes];
    int length = [self length];
    if (length) {
        write(1, bytes, length);
    }
}
@end

@implementation NSArray(jfklsdjkdsfjsdff)
- (int)runCommandInBackground
{
    id pid = [self runCommandAndReturn:NO];
    return [pid intValue];
}
@end

@implementation NSArray(jfklsdjkf)
- (id)runAsArgumentsForCommandAndReturnOutput:(id)command
{
NSLog(@"runAsArgumentsForCommandAndReturnOutput %@ self %@", command, self);
    id arr = nsarr();
    [arr addObjectsFromArray:command];
    [arr addObjectsFromArray:self];
    return [arr runCommandAndReturnOutput];
}

- (id)runCommandAndReturnExitStatus
{
    id pipe = [self runCommandAndReturnPipe];
    return [pipe waitForExitStatus];
}

- (id)runCommandAndReturnOutput
{
    id pipe = [self runCommandAndReturnPipe];
    return [pipe readAllDataThenCloseInputAndWait];
}

- (id)runCommandAndReturnPipe
{
    return [self runCommandAndReturn:YES];
}

- (id)runCommandAndReturn:(BOOL)usePipe
{
    NSLog(@"runCommandAndReturn: %@", self);
    if ([self count] < 1) {
        return nil;
    }
    
    int fdzero[2];
    int     fd[2];
    pid_t   childpid;
    
    if (usePipe) {
        pipe(fdzero);
        pipe(fd);
    }
    
    if((childpid = fork()) == -1)
    {
        perror("fork");
        return nil;
    }
    
    if(childpid == 0)
    {

        if (usePipe) {
            close(fdzero[1]);
            dup2(fdzero[0], STDIN_FILENO);
            close(fdzero[0]);

            /* Child process closes up input side of pipe */
            close(fd[0]);
            dup2(fd[1], STDOUT_FILENO);
            close(fd[1]);
        } else {
            setpgid(0, 0);
            int nullfd = open("/dev/null", O_RDONLY);
            if (nullfd < 0) {
NSLog(@"unable to open /dev/null");
            } else {
                dup2(nullfd, 0);
            }
        }

        int argc = [self count];
        char **argv = malloc(sizeof(char *)*(argc+1));
        for (int i=0; i<argc; i++) {
            if (i == 0) {
                id elt = [self nth:0];
                if ([elt hasPrefix:@"/"]) {
                    argv[0] = [elt UTF8String];
                    continue;
                }
                id path = [elt findInPath];
                if (path) {
                    argv[0] = [path UTF8String];
                } else {
                    argv[0] = [elt UTF8String];
                }
            } else {
                argv[i] = [[self nth:i] UTF8String];
            }
        }
        argv[argc] = 0;
        execv(argv[0], argv);
        free(argv);
        _exit(0);
    }
    else
    {
        if (usePipe) {
            close(fdzero[0]);

            /* Parent process closes up output side of pipe */
            close(fd[1]);

            id fileDescriptor = [[[FileDescriptor alloc] init] autorelease];
            [fileDescriptor setValue:nsfmt(@"%d", fd[0]) forKey:@"fd"];
            [fileDescriptor setValue:nsfmt(@"%d", childpid) forKey:@"pid"];
            [fileDescriptor setValue:nsfmt(@"%d", fdzero[1]) forKey:@"writefd"];
            return fileDescriptor;
        } else {
            return nsfmt(@"%d", childpid);
        }

    }
}


@end

@implementation NSString(jfklsdkfj)
- (id)downloadURL
{
    return [self downloadURLWithCurl];
}
- (id)downloadURLWithCurl
{
    NSLog(@"downloadURLWithCurl %@", self);
    id arr = nsarr();
    [arr addObject:@"curl"];
#ifdef BUILD_FOR_IOS
    [arr addObject:@"-k"];
#endif
    [arr addObject:self];
    return [arr runCommandAndReturnOutput];
}
@end



