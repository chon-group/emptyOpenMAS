#!/bin/bash

if [ -z "$1" ]
then
    echo "You need indicate a UUID to callBack"
    echo " example: ./OpenMAS.sh 4fa64a29-a0ec-4f3e-a188-5b1f9248d79c"
else
    echo 'callBack("'$1'").' > _planLibrary/_onFly.asl
    java -jar jasonEmbedded.jar tempMAS.mas2j -console
fi