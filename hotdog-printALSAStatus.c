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

#include <alsa/asoundlib.h>

snd_ctl_t *_ctl;
char *_name = "hw:0";
char *_mix_name = "Master";

int setup()
{
    snd_ctl_t *ctl;
    int err;
    err = snd_ctl_open(&ctl, _name, SND_CTL_READONLY);
    if (err < 0) {
fprintf(stderr, "Unable to open ctl %s\n", _name);
        exit(1);
    }
    err = snd_ctl_subscribe_events(ctl, 1);
    if (err < 0) {
fprintf(stderr, "Unable to subscribe to ctl %s\n", _name);
        exit(1);
    }
    _ctl = ctl;

    return 1;
}

int read_alsa_event()
{
    snd_ctl_event_t *event;
    snd_ctl_event_alloca(&event);

    if (snd_ctl_read(_ctl, event) < 0) {
        return 0;
    }
    if (snd_ctl_event_get_type(event) != SND_CTL_EVENT_ELEM) {
        return 0;
    }

    unsigned int mask = snd_ctl_event_elem_get_mask(event);
    if (mask & SND_CTL_EVENT_MASK_VALUE) {
        return 1;
    }

    return 0;
}

double read_alsa_volume()
{
    snd_mixer_t* handle;
    snd_mixer_elem_t* elem;
    snd_mixer_selem_id_t* sid;

    long pmin, pmax;
    long get_vol, set_vol;

    snd_mixer_selem_id_alloca(&sid);

    //sets simple-mixer index and name
    snd_mixer_selem_id_set_index(sid, 0);
    snd_mixer_selem_id_set_name(sid, _mix_name);

    if ((snd_mixer_open(&handle, 0)) < 0) {
        return 0.0;
    }
    if ((snd_mixer_attach(handle, _name)) < 0) {
        snd_mixer_close(handle);
        return 0.0;
    }
    if ((snd_mixer_selem_register(handle, NULL, NULL)) < 0) {
        snd_mixer_close(handle);
        return 0.0;
    }
    int ret = snd_mixer_load(handle);
    if (ret < 0) {
        snd_mixer_close(handle);
        return 0.0;
    }
    elem = snd_mixer_find_selem(handle, sid);
    if (!elem) {
        snd_mixer_close(handle);
        return 0.0;
    }

    long minv=0, maxv=0;

    snd_mixer_selem_get_playback_volume_range (elem, &minv, &maxv);

    long outvol = 0;
    if(snd_mixer_selem_get_playback_volume(elem, 0, &outvol) < 0) {
        snd_mixer_close(handle);
        return 0;
//            return -6;
    }

    snd_mixer_close(handle);

    /* make the value bound to 100 */
    outvol -= minv;
    maxv -= minv;
    minv = 0;
    double result = (double)outvol;
    result /= (double)maxv;
    return result;
}


int read_alsa_playback_switch()
{
    snd_mixer_t* handle;
    snd_mixer_elem_t* elem;
    snd_mixer_selem_id_t* sid;

    long pmin, pmax;
    long get_vol, set_vol;

    if ((snd_mixer_open(&handle, 0)) < 0) {
        return 0;
    }
    if ((snd_mixer_attach(handle, _name)) < 0) {
        snd_mixer_close(handle);
        return 0;
    }
    if ((snd_mixer_selem_register(handle, NULL, NULL)) < 0) {
        snd_mixer_close(handle);
        return 0;
    }
    int ret = snd_mixer_load(handle);
    if (ret < 0) {
        snd_mixer_close(handle);
        return 0;
    }

    snd_mixer_selem_id_alloca(&sid);

    //sets simple-mixer index and name
    snd_mixer_selem_id_set_index(sid, 0);
    snd_mixer_selem_id_set_name(sid, _mix_name);

    elem = snd_mixer_find_selem(handle, sid);
    if (!elem) {
        snd_mixer_close(handle);
        return 0;
    }

    if (snd_mixer_selem_has_playback_switch(elem)) {
        int playback = 0;
        if(snd_mixer_selem_get_playback_switch(elem, 0, &playback) == 0) {
            snd_mixer_close(handle);
            return playback;
        }
    }

    snd_mixer_close(handle);
    return 0;
}

void print_status()
{
    int playback_switch = read_alsa_playback_switch();
    double vol = read_alsa_volume();
    printf("playbackSwitch:%d volume:%f\n", (playback_switch) ? 1 : 0, vol);
    fflush(stdout);
}

/*

Usage: hotdog-printALSAStatus [card name] [mixer name]

'card name' is 'hw:0' by default
'mixer name' is 'Master' by default

*/

void main(int argc, char **argv)
{
    if (argc >= 2) {
        _name = argv[1];
    }
    if (argc >= 3) {
        _mix_name = argv[2];
    }

    if (!setup()) {
        exit(1);
    }

    for(;;) {
        print_status();
        int result = read_alsa_event();
        if (!result) {
fprintf(stderr, "Unable to read alsa event\n");
        }
    }

    exit(0);
}

