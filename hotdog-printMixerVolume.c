#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/soundcard.h>

int main()
{
    int fd = open("/dev/mixer", O_RDWR);
    if (fd < 0) {
        fprintf(stderr, "unable to open /dev/mixer\n");
        exit(1);
    }

    int volume = 0;
    int val = 0;
    for(;;) {
        ioctl(fd, SOUND_MIXER_READ_VOLUME, &val);
        if (val != volume) {
            volume = val;
            double volumepct = (double)volume / 25700.0;
            printf("volume:%f volumeint:%d\n", volumepct, volume);
            fflush(stdout);
        }
        usleep(40000);
    }

    exit(0);
}

