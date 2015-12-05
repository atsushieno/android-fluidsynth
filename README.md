This is a build setup for Android build of fluidsynth.

Why? Because building fluidsynth for Android from the origin(al source)
is somewhat complicated.

fluidsynth depends on glib.
Building glib for Android is not easy because it has several components.

There is existing build system that makes it to build glib: cerbero.

But cerbero seems to be intended for almost only for their build system
and not flexible enough to build with custom configuration.
So I have somewhat revised version.

Next, setting up cerbero and passing appropriate configuration parameters
to build libraries for Android and laying out the outcome is messy.
Also, the resulting binaries need some binary fixups.
So this build script also takes care of it.

Usage
-----

"make prepare" to set up cerbero and its dependencies.

"make" to checkout and build fluidsynth and deps.

"make buildone-cerbero" to kick forced build. It is useful when hacking
fluidsynth that is checked out by cerbero.

Finally, as part of an attempt to build libfluidsynth.so that does not
depend on any other libraries, run ./build-single-lib.sh.

Missing
-------

There is no JNI bridge in Java because no one had implemented it.
I'm using Xamarin and my nfluidsynth project, so I don't need JNI interop.
Contributions are welcome.

Hacking
-------

This is the basic directory layout:

    build/
      sources/
        android_armv7/
          fluidsynth-*/
        android_x86/
          fluidsynth-*/

You would like to hack fluidsynth sources for your Android target.
For me it is `build/sources/android\_armv7/fluidsynth-1.1.6`.

The fluidsynth repo is particularly a fork to support OpenSLES and the most significant source is `fludsynth/src/drivers/fluid\_opensles.c` in the fluidsynth source tree (the one I mentioned above).

cerbero build operations, by default, **resets** the repo.
So if you edit fluidsynth sources to fix issues, it will be lost when you run "make".
To avoid that, make changes to external/cerbero/recipes/fluidsynth.recipe
to not point to specific commit hash but specify "master" or any current
branch to prevent the forcible reset.

Also, note that the sources you should make changes are of the target
specific architecture e.g. build/sources/android\_armv7/fluidsynth-1.1.16/
and not build/sources/local. It is ignored when you run "buildone".

Here is my workflow:

- make changes under build/sources/android_x86/fluidsynth-1.1.6
  (under android_x86, NOT under build/sources/local/fluidsynth:
  I don't want fullbuilds triggered by making changes there.)
- run make. It will build x86 and arm binaries (ndk-build for x86,
  binary-hack for arm)
- When I'm ready to commit and push the changes:
  - `cd build/sources/android_x86/fluidsynth-1.1.6`
  - `git diff > tmp.patch`
  - `mv tmp.patch ../../local/fluidsynth`
  - `patch -i tmp.patch -p1`
  - `cd ../../local/fluidsynth`
  - For the first time:
    - `git checkout master`
    - edit .git/config and point to my committable URL.
  - `git commit -a`
  - `git push origin master`
  - Make sure that the worktree has the latest git commits i.e.
    - `cd ../../android_x86_fluidsynth_1.1.6`
    - `git checkout master`
    - `git pull`
