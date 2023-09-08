#! /bin/bash

# current list of users
# Manchester United matches:
# 4 2202811_Jeremiah
# 3 2201291_NeamHengChongTimothy
# 2 2201046_QuekJooWee
# 1 2200599_XavierOng
# 0 1902943_AaronTi
# Liverpool matches:
# 6 2203244_Kovi
# 5 2202525_Sameerah
# 4 2202045_Vianiece
# 3 2201543_BryanKohKaiXuan
# 2 2201319_Russel
# 1 2200855_LeeJunLiang
# 0 2200521_ChuaYueDa


ctrlc_count=0
j=0
k=0
declare -A manchested
declare -A liverpool

trap ctrlc SIGINT

function ctrlc
{
    let ctrlc_count++
    echo
    if [[ $ctrlc_count == 1 ]]; then
        echo "Stop that."
        echo "Manchester United matches:"
        for key in "${!manchested[@]}"; do
            echo "$key ${manchested[$key]}"
        done
        echo "Liverpool matches:"
        for key in "${!liverpool[@]}"; do
            echo "$key ${liverpool[$key]}"
        done

    else
        echo "That's it.  I quit."

        echo "Manchester United matches:"
        for key in "${!manchested[@]}"; do
            echo "$key ${manchested[$key]}"
        done
        echo "Liverpool matches:"
        for key in "${!liverpool[@]}"; do
            echo "$key ${liverpool[$key]}"
        done
        exit
    fi
}

# this changes depending on directory
cd ../w02lab2-part2/inf2002-lab02-2023
# downloads the repos and puts them in a folder named after the user
# search for the song in all the files

for i in *.txt; do 
    # curl this and get "manchester united" and "liverpool"
    gitweb=$(tail -1 $i)
    user=$(echo $i | cut -d'.' -f1)

    curlrepostring=$(curl -s "$gitweb"  | grep -o href.*/team.txt | cut -d\" -f2 | awk '{print "https://github.com"$1}' 2>/dev/null)
    
    curlstring=$(curl -s "$curlrepostring"  | python3 -c "import sys, json; print(json.load(sys.stdin)['payload']['blob']['rawLines'][0])" 2>/dev/null)

    if echo $curlstring | grep -q -P "Manchester United"; then
        manchested[$j]="$user"
        j=$((j+1))
    elif echo $curlstring | grep -q -P "Liverpool"; then
        liverpool[$k]="$user"
        k=$((k+1))
    else
        echo "$i no match"
    fi
done

echo "Manchester United matches:"
for key in "${!manchested[@]}"; do
    echo "$key ${manchested[$key]}"
done
echo "Liverpool matches:"
for key in "${!liverpool[@]}"; do
    echo "$key ${liverpool[$key]}"
done