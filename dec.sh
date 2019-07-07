KEY=$1
CURDIR=$(cd $(dirname $0); pwd)
RESERVE_DIR=$CURDIR/.encrypt
DECRYPT_CMD=$CURDIR/.encrypt/decrypt.sh
INCLUDE=$RESERVE_DIR/.include
LASTTIME=$(head -1 $RESERVE_DIR/.timestamp)
[ "LASTTIME" -ne "" ] || LASTTIME = 0 


cd $CURDIR
cat $INCLUDE | sort | uniq | while read dir; do 
rm .tmp_include
  find ./$dir >> .tmp_include; 
	cat .tmp_include | while read item; do 
	if [ -f $item ] ; then
		echo "file $item";
		#mt=$(stat -c %Y $item)
		#if ! [ -f $CURDIR/$item ] || [ $mt -gt $LASTTIME ]; then
		echo "decrypt file $(pwd)/$item";
		$DECRYPT_CMD $item "$KEY"			
		echo ""
		#fi
	fi
	[ -d $item ] && echo "dir $item";
	done
done
