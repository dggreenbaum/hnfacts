# hnfacts
A BASH start up script to load granular facts derived from a hostname into facter.

## Why
You put a lot of effort into your host name scheme and want to easilly use the parts of your FQDN to make decisions within Puppet.

## How
Download the script and put in in /etc/profile.d/

    wget -O /etc/profile.d/hnfacts.sh https://raw.githubusercontent.com/dggreenbaum/hnfacts/master/hnfacts.sh

Edit /etc/hnfacts.conf (create it if necessary). This file defines the names of your facts. Each line specifies the name of the next part of your FQDN from left to right.

E.G. for foo.bar.baz

    # /etc/hnfacts.conf
    subdomain
    domain
    tld

Now at the console after re logging in or a reboot:

    [dggreenbaum@foo]$ facter subdomain
    foo
    [dggreenbaum@foo]$ facter tld
    baz
