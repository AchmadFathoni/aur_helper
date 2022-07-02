#!/bin/bash

while read p; do
    yay -S "$p" --rebuild --noconfirm
done <<< $(checkrebuild | cut -f2 | grep -v 'zoom')
