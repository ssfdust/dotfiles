#!/bin/bash
git clone https://github.com/zagortenay333/Harmattan.git /tmp/Harmattan
cd /tmp/Harmattan
pwd
if [[ -d "$HOME/.harmattan-assets" ]];then
  echo 'already installed.'
else
  cp -a .harmattan-assets ~
fi
cp -f .harmattan-themes/Metro/Comfortable/normal-mode/.conkyrc ~/.conkyrc
sed -i "s/\(template6=\)\(\"\"\)/\1\"becfa2f59c1e2d3c3aaae02e59010048\"/" ~/.conkyrc
sed -i "s/\(template7=\)\(\"\"\)/\1\"1886760\"/" ~/.conkyrc
