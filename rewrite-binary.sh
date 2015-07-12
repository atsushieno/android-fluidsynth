#!/bin/bash

rpl -R -e libgthread-2.0.so.0 "libgthread-2.0.so\x00\x00" libfluidsynth.so 
rpl -R -e libglib-2.0.so.0 "libglib-2.0.so\x00\x00" libfluidsynth.so 
rpl -R -e libintl.so.8 "libintl.so\x00\x00" libfluidsynth.so 
rpl -R -e libiconv.so.2 "libiconv.so\x00\x00" libfluidsynth.so

