#!bin/bash/
#vivycompressor

# zcat, zmore, zgrep-- 此腳本使用三組符號（軟連結）或是硬連結

Z='compress'; uz='uncompress'; zlist=''
gz='gzip'; ugz='ungzip'; gzlist=''
bz='bzip2'; ubz='unbzip2' ; blist=''

# 隔離檔案名稱
# 藉由副檔名檢查是否為壓縮檔
# 對所有檔案逐一解壓縮
# 完成後，再對所有解壓縮檔案進行壓縮

for arg
do
 if [ -f "$arg" ]; then
    case "$arg" in
        *.Z) $uz "$arg" # to uncompress file
		arg="$(echo $arg | sed 's/\.Z$//')" # (a)
		zlist="$zlist \"$arg\"" # (b)
	     ;;
	*.gz) $ugz "$arg"
	      arg="$(echo $arg | sed 's/\.gz$//')"
	      gzlist="$gzlist \"$arg\""
             ;;
	*.bz2) $ubz "$arg"
	       arg="$(echo $arg | sed 's/\.bz2$//')"
	       bzlist="bzlist \"$arg\""
	     ;;
    esac
 fi

 newargs = "${newargs:-""} \"$arg\""

done

case $0 in
	*zcat*) eval cat $newargs ;;
	*zmore*) eval more $newargs ;;
	*zgrep*) eval grep $newargs ;;
	*) echo "$0 has an unkown file extention name." >&2  # (c)
		exit 1

esac

if [ ! -z "$zlist"]; then
    eval $Z $zlist

fi 

if [ ! -z "$gzlist" ]; then
    eval $gz $gzlist
fi

if [ ! -z "$bzlist"]; then
    eval $bz $bzlist
fi

exit 0

