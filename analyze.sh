#!/bin/bash
#!/bin/bash -vxe

srcPath=$PWD/linux
filelistFile=filelist
openfeatureFile=open

##################################################################
# List of files to preprocess
##################################################################
if [ $# -eq 1 ]; then
  singlefile=$1
  rm $srcPath/$singlefile.dbg
else
  singlefile=""
fi

filesToProcess() {
  if [ -f $srcPath/$singlefile.c ]; then
    echo $singlefile
  else
    local listFile=$filelistFile
    cat $listFile
  fi  
}

#  -I $srcPath/include \
#  -I $srcPath/arch/x86/include \
#  -I $srcPath/include/uapi \
#  --platfromHeader=platform-ubuntu.h \
#  --systemIncludes=/usr/include \
#  --systemIncludes=/usr/lib/gcc/x86_64-linux-gnu/4.6.3/include \
#  --systemIncludes=/usr/lib/gcc/x86_64-linux-gnu/4.6.3/include-fixed \

typechefFlags="--bdd \
  --include=partialConf.h \
  --settingsFile=ubuntu.properties \
  -I $srcPath/tools/perf/util/include \
  -I $srcPath/tools/perf/util/arch/x86/include \
  -I $srcPath/tools/include \
  -I $srcPath/arch/x86/include/uapi \
  -I $srcPath/arch/x86/include \
  -I $srcPath/include/uapi \
  -I $srcPath/include \
  -I $srcPath/tools/perf/util \
  -I $srcPath/tools/perf \
  -I $srcPath/tools/lib \
  --openFeat $openfeatureFile \
  --writePI --recordTiming --lexdebug --errorXML --interface \
  --adjustLines --printIncludes "

#if [ ! -f pcs/kbuildparam.sh ]; then
#  echo "file pcs/kbuildparam.sh not found. run genKbuild.sh first"
#  exit
#fi
#source pcs/kbuildparam.sh

##################################################################
# Collect the required additional parameter. Then
# Actually invoke the typechef and analyze result.
##################################################################
filesToProcess|while read i; do
  if [ ! -f $srcPath/$i.dbg ]; then
    extraFlags=""
    touch $srcPath/$i.dbg
    . ./typechef.sh $srcPath/$i.c $extraFlags
    if [ "$1" =  "--one" ]
    then
        exit
    fi
  else
    echo "Skipping $srcPath/$i.c"
  fi
done


