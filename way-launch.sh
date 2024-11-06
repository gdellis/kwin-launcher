#!/bin/sh

set -eu

# Remove the performance overlay, it meddles with some tasks
#  unset LD_PRELOAD
#
# function cleanup()
# {
#    # Flush fuse mounts beneath here
#     umount --recursive $NEW_XDG_RUNTIME_DIR  || true
#     rm -Rf $NEW_XDG_RUNTIME_DIR
#    echo done
# }
# # Create a new XDG_RUNTIME_DIR
# NEW_XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR/way-launcher
# trap cleanup EXIT
#
# mkdir $NEW_XDG_RUNTIME_DIR --mode 0700
#
# # Some things are (currently) shared, pulseaudio socket needs to be connected to the main session
# mkdir $NEW_XDG_RUNTIME_DIR/pulse --mode 0700
# ln -s $XDG_RUNTIME_DIR/pulse/native $NEW_XDG_RUNTIME_DIR/pulse/native
# ln -s $XDG_RUNTIME_DIR/pipewire* $NEW_XDG_RUNTIME_DIR/.

# ## Shadow kwin_wayland_wrapper so that we can pass args to kwin wrapper
# ## whilst being launched by plasma-session
# mkdir $NEW_XDG_RUNTIME_DIR/bin
# export PATH=$NEW_XDG_RUNTIME_DIR/bin:$PATH
# export XDG_RUNTIME_DIR=$NEW_XDG_RUNTIME_DIR
#
# waydroid session start

export s$(dbus-run-session)
kwin_wayland \
--width 1280 \
--height 800 \
--no-lockscreen \
--xwayland \
--exit-with-session "$@"

