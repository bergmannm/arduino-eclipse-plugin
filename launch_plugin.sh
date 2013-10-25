#!/bin/bash

file_x86="./it.baeyens.arduino.product/target/products/it.baeyens.arduino.product/linux/gtk/x86/opt/eclipseArduino/eclipse"
file_x86_64="./it.baeyens.arduino.product/target/products/it.baeyens.arduino.product/linux/gtk/x86_64/opt/eclipseArduino/eclipse"
file=""

echo "Trying to build and launch the Arduino Eclipse Plugin"

echo "First we build with Maven. This may download a lot and take some time (it is downloading all Eclipse CDT for you)"
mvn --version
if [[ $? -ne 0 ]] ; then
    echo "Maven not installed"
    exit 1
fi

#This is the actual build
mvn verify
if [[ $? -ne 0 ]] ; then
    echo "Problem in build"
    exit 1
fi


echo "Now we find the Eclipse executable (with our plugin pre-packaged) and launch it"
#Find an executable if we made it successfully
if [[ -x "$file_x86" ]]
then
    #echo "File '$file_x86' is executable"
    file=$file_x86
fi

if [[ -x "$file_x86_64" ]]
then
    #echo "File '$file_x86_64' is executable"
    file=$file_x86_64
fi



if [[ -x "$file" ]]
then
    echo "Executing $file"
    echo "Execute the executable above directly if you don't want to rebuild subsequently"
    eval $file
    exit 0;
else
    echo "Did not find an Eclipse executable built....."
    exit 1;
fi

