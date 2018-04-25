#! /bin/bash

TOP_DIR=$(pwd)
OUT_PATH=./out
BUILDROOT_PATH=$(pwd)/buildroot/
CLEAN_CMD=cleanthen
PRODUCT_PATH=$(pwd)/device/rockchip/rk3288

#define build err exit function
check_err_exit(){
  if [ $1 -ne "0" ]; then
     echo -e $MSG_ERR
     cd $TOP_DIR
     exit 2
  fi
}

echo "build rootfs"
cd $BUILDROOT_PATH
make -j8
check_err_exit $?
cd ..

echo "arm-linux-gnueabihf-gcc envsetup..."
logfile="/dev/null"
check_cmd(){
    "$@" >> $logfile 2>&1
}
check_cc(){
  check_cmd arm-linux-gnueabihf-gcc -v
}
check_cc
if [ $? -eq 127 ];then
  source envsetup.sh
fi
shopt -s expand_aliases
alias arm-linux-gnueabihf-gcc='arm-linux-gnueabihf-gcc -s -O2'
#alias arm-linux-gnueabihf-gcc='arm-linux-gnueabihf-gcc -g -rdynamic -O2'

FILE='.rkmkdirs_first'
find $TOP_DIR -path $TOP_DIR/buildroot -prune -o -name rk_make_first.sh -print | sort -r > $FILE
while read line;do
        #echo "Line # $k: $line"
        mk_path=$(echo $line | sed -r 's@^(/.*/)[^/]+/?@\1@g')
        cd $mk_path
        source $mk_path/rk_make_first.sh $1 $CLEAN_CMD
        cd $TOP_DIR
        #echo $mk_path
        #echo $(pwd)
done < $FILE
[ -d $FILE ] && rm -rf $FILE

FILE='.rkmkdirs'
find $TOP_DIR -path $TOP_DIR/buildroot -prune -o -name rk_make.sh -print | sort -r > $FILE
while read line;do
        #echo "Line # $k: $line"
	mk_path=$(echo $line | sed -r 's@^(/.*/)[^/]+/?@\1@g')
        cd $mk_path
	source $mk_path/rk_make.sh $1 $CLEAN_CMD
	cd $TOP_DIR
	#echo $mk_path
	#echo $(pwd)
done < $FILE
[ -d $FILE ] && rm -rf $FILE

cd $PRODUCT_PATH
source $PRODUCT_PATH/mk-kernel.sh
cd $TOP_DIR

echo -e "\e[36m build all Done \e[0m"
