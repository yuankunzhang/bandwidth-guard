# Bandwidth Guard for Shadowsocks

The idea is inspired by [this post](http://k162.space/vnstat/).

Bandwidth Guard is used to monitor network traffic, and, force stop shadowsocks once bandwidth limitation is exceeded. It is implemented for Shadowsocks-libev but can easily modified for other Shadowsocks variants.

## Usage

First you need to install and start vnstat. Run the following commands as root:

```shell
$ apt install vnstat vnstati
$ svnstat -u -i eth0
$ systemctl enable vnstat
```

Next, create a cron job for Bandwidth Guard.

```shell
$ crontab -e

# add this line
@hourly /path/to/bandwidth_guard.pl >> /var/log/bandwidth_guard.log 2>&1
```

And fuch the GFW.
