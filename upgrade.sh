#!/bin/bash -e

export GH_TOKEN="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"
DRONE_TAG=v0.0.3

rm -v *.a *.tar.gz *.h || echo ok

gh release download ${DRONE_TAG} -p "*.tar.gz" -R r9vpn/openvpn3 --clobber

ls *.tar.gz | xargs -n1 -t tar -xzvf

rm -v *.tar.gz
ls -l

git add .
git commit -a -m${DRONE_TAG}
git tag v0.0.1
git push origin main --tags