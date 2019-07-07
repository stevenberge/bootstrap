cat $1 | openssl  enc  -aes-128-ecb  -nosalt  -k "$2" 
