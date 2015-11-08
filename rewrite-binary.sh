#!/bin/bash

rpl -R -e libgobject-2.0.so.0 "libgobject-2.0.so\x00\x00" *.so 
rpl -R -e libgthread-2.0.so.0 "libgthread-2.0.so\x00\x00" *.so 
rpl -R -e libglib-2.0.so.0 "libglib-2.0.so\x00\x00" *.so 
rpl -R -e libintl.so.8 "libintl.so\x00\x00" *.so 
rpl -R -e libiconv.so.2 "libiconv.so\x00\x00" *.so
rpl -R -e libffi.so.6 "libffi.so\x00\x00" *.so
rpl -R -e libz.so.1 "libz.so\x00\x00" *.so
rpl -R -e libcharset.so.1 "libcharset.so\x00\x00" *.so
rpl -R -e libfluidsynth.so.1 "libfluidsynth.so\x00\x00" *.so
rpl -R -e libgio-2.0.so.0 "libgio-2.0.so\x00\x00" *.so
rpl -R -e libgmodule-2.0.so.0 "libgmodule-2.0.so\x00\x00" *.so

