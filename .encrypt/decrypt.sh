cat $1 | openssl  enc -d -aes-128-ecb  -nosalt  -k  "$2" #-nopad 
