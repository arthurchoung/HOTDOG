#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <ctype.h>
#include <sys/soundcard.h>

int main()
{
    int fd = open("/dev/mixer", O_RDWR);
    if (fd < 0) {
        fprintf(stderr, "unable to open /dev/mixer\n");
        exit(1);
    }

    for(;;) {
        char buf[256];
        if (!fgets(buf, 256, stdin)) {
            break;
        }
        if (isdigit(buf[0]) || (buf[0] == '.')) {
            double val = strtod(buf, NULL);
            if ((val >= 0.0) && (val <= 1.0)) {
                int volume = (int)(25700.0 * val);
                ioctl(fd, SOUND_MIXER_WRITE_VOLUME, &volume);
            }
        }
    }

    exit(0);
}

