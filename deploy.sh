#!/bin/bash

set -e

pushd thepuzzlebar  
rm -rf public* # remove public and public.tar
hugo -t tale-hugo || true
tar -c -f public.tar public
popd
scp thepuzzlebar/public.tar ahelium@thepuzzlebar.com:~/
rm thepuzzlebar/public.tar
ssh ahelium@thepuzzlebar.com 'sudo rm -rf /opt/site/public'
ssh ahelium@thepuzzlebar.com 'sudo tar --warning=no-timestamp -xf ~/public.tar -C /opt/site'
ssh ahelium@thepuzzlebar.com 'sudo systemctl restart caddy'

