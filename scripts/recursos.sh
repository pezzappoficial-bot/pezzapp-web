#!/usr/bin/env bash
# Descarga la letra Nunito (OFL) y three.js (MIT) y comprueba que son los esperados.
set -euo pipefail
cd "$(dirname "$0")/../sitio"

bajar() { # url destino sha256
  curl -fsSL --retry 4 -o "$2" "$1"
  echo "$3  $2" | sha256sum -c -
}

G=https://fonts.gstatic.com/s/nunito/v32
bajar "$G/XRXI3I6Li01BKofiOc5wtlZ2di8HDLshRTM.ttf" fuentes/nunito_400.ttf 9ecbdba35fa74f10a1a916c31649b802a12deb9e66c7b1fe4650afcfd4d16971
bajar "$G/XRXI3I6Li01BKofiOc5wtlZ2di8HDFwmRTM.ttf" fuentes/nunito_700.ttf 1a025dfce6e6e03bbe31ba82277ec5ed96df8b8dd58b3df6267269490b90b1dc
bajar "$G/XRXI3I6Li01BKofiOc5wtlZ2di8HDDsmRTM.ttf" fuentes/nunito_800.ttf c5776505c7b3df3c3ca763477b795d6bbc6517760bede0462ab77d1fb44954a6
bajar "$G/XRXI3I6Li01BKofiOc5wtlZ2di8HDBImRTM.ttf" fuentes/nunito_900.ttf 9caa6d5464d4438c3092a05d47952099e208862cacd5f655acb64012a1a15e78

T=$(mktemp -d)
bajar https://registry.npmjs.org/three/-/three-0.128.0.tgz "$T/three.tgz" df6a5d06dcd9a361831669f1b6dd081b2a43f9933d7b16de532417cc8d7c6153
tar -xzf "$T/three.tgz" -C "$T" package/build/three.min.js package/LICENSE
cp "$T/package/build/three.min.js" pez/three.min.js
cp "$T/package/LICENSE" pez/LICENSE-three.txt
rm -rf "$T"
