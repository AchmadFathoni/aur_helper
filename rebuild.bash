#!/bin/bash

while read p; do
    yay -S "$p" --rebuildall --noconfirm
done <<< $(checkrebuild | cut -f2)
