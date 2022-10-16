#If running from tty1 start sway

set TTY1 (tty)
[ "$TTY1" = "/dev/tty1" ] \
&& export (/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator) \
&& set -x LANG zh_CN.UTF-8 \
&& set -x LANGUAGE zh_CN:en_US \
&& exec sway
