#!/bin/sh

set -e

usage() {
  cat <<EOT

yshurik/stunnel is a light utility container for creating secure tunnels.
It uses the easiest way to configure authentication is with PSK (Pre-Shared Key)

Usage: docker run [DOCKER_OPTIONS] yshurik/stunnel-psk -c <connect-port> [-s]

OPTIONS:

  -c  Required; to connect to, in the form <host>:<port>.

  -s  Optional; specifies that the endoint is a server.

EOT
}

while getopts ":hsc:" opt; do
  case $opt in
    h) usage;;
    c) CONNECT=$OPTARG;;
    s) CLIENT=no;;
    -) break;;
    \?) printf '\nUnknown: -%s\n' ${OPTARG} 1>&2; exit 1;;
    :) printf '\nOption: -%s requires an argument\n' ${OPTARG} 1>&2; exit 1;;
  esac
done

shift $(($OPTIND - 1))

[[ -z ${CONNECT} ]] &&\
  printf '\nMissing required: -c <host:port>\n' 1>&2 &&\
  usage && exit 1

ACCEPT=${ACCEPT:-$(getent hosts ${HOSTNAME} | awk '{print $1}'):13000}
CLIENT=${CLIENT:-yes}

mkdir -p /etc/stunnel.d

cat << EOF > /stunnel.conf
syslog = no
delay = yes
foreground=yes

[backend]
ciphers = PSK
PSKsecrets = /psk.txt
client = ${CLIENT}
accept = ${ACCEPT}
connect = ${CONNECT}
EOF

printf 'Tunnel: %s --> %s\n' ${ACCEPT} ${CONNECT}

exec /usr/bin/stunnel /stunnel.conf
