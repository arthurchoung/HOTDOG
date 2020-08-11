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

#include <ctype.h>
#include <alsa/asoundlib.h>

void write_alsa_volume(double volume)
{
    snd_mixer_t* handle;
    snd_mixer_elem_t* elem;
    snd_mixer_selem_id_t* sid;

    static const char* mix_name = "Master";
    static const char* card = "default";
    static int mix_index = 0;

    long pmin, pmax;
    long get_vol, set_vol;

    snd_mixer_selem_id_alloca(&sid);

    //sets simple-mixer index and name
    snd_mixer_selem_id_set_index(sid, mix_index);
    snd_mixer_selem_id_set_name(sid, mix_name);

    if ((snd_mixer_open(&handle, 0)) < 0) {
        return;
    }
    if ((snd_mixer_attach(handle, card)) < 0) {
        snd_mixer_close(handle);
        return;
    }
    if ((snd_mixer_selem_register(handle, NULL, NULL)) < 0) {
        snd_mixer_close(handle);
        return;
    }
    int ret = snd_mixer_load(handle);
    if (ret < 0) {
        snd_mixer_close(handle);
        return;
    }
    elem = snd_mixer_find_selem(handle, sid);
    if (!elem) {
        snd_mixer_close(handle);
        return;
    }

    long minv, maxv;

    snd_mixer_selem_get_playback_volume_range (elem, &minv, &maxv);

    long val = minv + (double)(maxv-minv)*volume;
    if(snd_mixer_selem_set_playback_volume(elem, 0, val) < 0) {
        snd_mixer_close(handle);
        return;
    }

    snd_mixer_close(handle);
}


int main(int argc, char **argv)
{
    if (argc != 1) {
        if (isdigit(argv[1][0]) || (argv[1][0] == '.')) {
            double vol = strtod(argv[1], NULL);
            if ((vol >= 0.0) && (vol <= 1.0)) {
                write_alsa_volume(vol);
                exit(0);
            }
        }
        fprintf(stderr, "Usage: %s [number between 0.0 and 1.0]\n", argv[0]);
        fprintf(stderr, "If there are no arguments, then it will read from stdin\n");
        exit(1);
    }
    for(;;) {
        char buf[256];
        if (!fgets(buf, 256, stdin)) {
            break;
        }
        if (isdigit(buf[0]) || (buf[0] == '.')) {
            double vol = strtod(buf, NULL);
            if ((vol >= 0.0) && (vol <= 1.0)) {
                write_alsa_volume(vol);
            }
        }
    }
    exit(0);
}

