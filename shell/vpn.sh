#!/bin/bash
GATEWAY="vpn-se2.it.epicgames.com"
ESC="$(printf '\033')"
NORMAL="${ESC}[0m"
YELLOW="${ESC}[1;33m"
CYAN="${ESC}[36m"
box()
{
  # "c 1 c" is to add 4 chars to t length.
  t="c $1 c"
  # c is $2 or '='
  c=${2:-=}
  # substitute all chars in t with $c
  border=${YELLOW}${t//?/$c}${NORMAL}
  c=${YELLOW}$c${NORMAL}
  echo $border
  echo "$c ${CYAN}$1${NORMAL} $c"
  echo $border
}
box "Initiating VPN pre-logon to gateway: $GATEWAY"
eval $(/usr/lib/gp-saml-gui/gp_saml_gui.py --gateway $GATEWAY --clientos=Windows)
box "Pre-logon successful | Cookie: $COOKIE"
eval $(echo $COOKIE | sudo openconnect --protocol=gp --user=$USER --os=win --usergroup=gateway:prelogin-cookie --passwd-on-stdin $GATEWAY)
