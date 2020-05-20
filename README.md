# Shell_compress
Compress &amp; Uncompress in Unix-liked OS

# Common Tools

* compress and its object file is .z in extension name.

* gzip and its object file is .gz in extension name.

* bzip2 and its object file is .bz2 in extension name.

# Script

    #!bin/bash/
    #vivycompressor

    # zcat, zmore, zgrep-- 此腳本使用三組符號（軟連結）或是硬連結

    Z = 'compress'; uz = 'uncompress'; zlist = ''
    gz = 'gzip'; ugz = 'ungzip'; gzlist = ''
    bz = 'bzip2'; ubz = 'unbzip2' blist = ''

    # 隔離檔案名稱
    # 藉由副檔名檢查是否為壓縮檔
    # 對所有檔案逐一解壓縮
    # 完成後，再對所有解壓縮檔案進行壓縮

    for arg
    do
     if [ -f "$arg" ]; then
        case "$arg" in
            *.Z) $uz "$arg" # to uncompress file
            arg = "$(echo $arg | sed 's/\.Z$//')" # (a)
            zlist = "$zlist \"$arg\"" # (b)
             ;;
        *.gz) $ugz "$arg"
              arg = "$(echo $arg | sed 's/\.gz$//')"
              gzlist = "$gzlist \"$arg\""
                 ;;
        *.bz2) $ubz "$arg"
               arg = "$(echo $arg | sed 's/\.bz2$//')"
               bzlist = "bzlist \"$arg\""
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

    if [ ! -z "$zlist"]; then # (d)
        eval $Z $zlist # (e)

    fi 

    if [ ! -z "$gzlist" ]; then
        eval $gz $gzlist
    fi

    if [ ! -z "$bzlist"]; then
        eval $bz $bzlist
    fi

    exit 0


* Syntax

(to be wait for check...)

  * (a) sed 's/\.Z$//'
  
  * (b) $zlist \"$arg\"
  
  * (c) >&2
  
  * (d) -z
  
  * (e) eval


* Execution

        $ ln -s zcat zmore
        $ ln -s zcat zgrep


Related Info
 
軟連結與硬連結：
軟連

