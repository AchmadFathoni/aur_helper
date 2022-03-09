#!/bin/bash

a="satu dua tiga"
echo $a | cut -d " " -f 1
cut -d " " -f 1 <<< $a
