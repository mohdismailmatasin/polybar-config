#! /bin/bash

bar="▁▂▃▄▅▆▇█"
dict="s/;//g;"

i=0
while [ $i -lt ${#bar} ]
do
    dict="${dict}s/$i/${bar:$i:1}/g;"
    i=$((i=i+1))
done

config_file="/tmp/polybar_cava_config"
echo "
[general]
bars = 10

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
" > $config_file

COLOR="%{F#89b4fa}"
RESET="%{F-}"

cava -p $config_file | while read -r line; do
    printf "%s%s%s\n" "$COLOR" "$(echo $line | sed $dict)" "$RESET"
done
