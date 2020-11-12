#!/bin/bash

targetfile=bd.zip


# Start 26 processes for cracking mixalpha-numeric equal to 6 digits
eval echo\ 11{a..z}AAA\; | xargs -I % -P 26 fcrackzip -c Aa1 -b -p % --verbose -u $targetfile
