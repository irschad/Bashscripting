#!/bin/bash
echo -n "Shall we sort the processes output by memory or CPU? Type your choice (memory/cpu): "
read sortbyparam
echo -n "How many lines of result do you want to be displayed? "
read num
if [ "$sortbyparam" == "memory" ]
then
    ps aux --sort -rss | grep $USER | head -n "$num"
elif [ "$sortbyparam" == "cpu" ]
then
    ps aux --sort -%cpu | grep $USER | head -n "$num"
else
        echo "Invalid input"
fi
