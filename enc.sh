INPUT=$1
INPUT=$(cd $INPUT; pwd)
KEY=$2
CURDIR=$(cd $(dirname $0); pwd)
RESERVE_DIR=$CURDIR/.encrypt
ENCRYPT_CMD=$CURDIR/.encrypt/encrypt.sh
DECRYPT_CMD=$CURDIR/.encrypt/decrypt.sh
INCLUDE=$RESERVE_DIR/.include
LASTTIME=$(head -1 $RESERVE_DIR/.timestamp)
[ "LASTTIME" -ne "" ] || LASTTIME=0 
echo $LASTTIME


cd $INPUT
cat $INCLUDE | sort | uniq | while read dir; do 
rm .tmp_include
  find ./$dir >> .tmp_include; 
	cat .tmp_include | while read item; do 
	if [ -f $item ] ; then
		echo "file $item";
		mt=$(stat -c %Y $item)
		echo $mt;
		echo $LASTTIME;
		if ! [ -f $CURDIR/$item ] || [ $mt -gt $LASTTIME ]; then
			echo "encrypt file $item";
			$ENCRYPT_CMD $item "$KEY" > $CURDIR/$item;			
			echo ""
		fi
	fi
	if [ -d $item ] ; then
		echo "dir $item";
		mkdir -p $CURDIR/$item;
	fi
	done
done
