# Shell_compress
Compress &amp; Uncompress in Unix-liked OS

* Common Compress Tools

    * compress and its object file is .z in extension name.

    * gzip and its object file is .gz in extension name.

    * bzip2 and its object file is .bz2 in extension name.
    
* Common Usage for sed

   https://blog.codylab.com/sed-substitute-s-command/

   https://charleslin74.pixnet.net/blog/post/419884144

* Script

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

  * (a) sed 's/\.Z$//'
  
         use sed 's/ replaced / replace /' cmd to do string replacement.
  
  * (b) $zlist \"$arg\"
  
         "bzlist \"$arg\""  
         the inside-backslash is to escape. 
  
  * (c) >&2
  
          1 means stdout
          2 means stderr
          
          & is reference to file_val
  
          command > output is just a shortcut for command 1> output ; You can use &[FILE_DESCRIPTOR] to reference a file descriptor value; 

          Using 2>&1 will redirect stderr to whatever value is set to stdout (and 1>&2 will do the opposite).
  
  * (d) -z
  
          When -z is used, a zero byte (the ascii ' NUL ' character) is added between the lines (instead of a new line).
  
  * (e) eval


* Execution

        $ compress < file name >
        
        $ zcat < file name >
        
        $ zgrep < word_u_wanna_search_for > < file name >

        $ ls -l < file name>*

* Related Info
 
  * Link, 軟連結與硬連結
  
   為了適當作業，腳本有三個名稱，如何產生彼此之間可以互相合作的關係，可藉由呼叫連結符號，他們是一種儲存著目的檔案的特殊檔案，亦可使用硬連結，是實際儲存著和被連結的檔案擁有相同的 inode，如上腳本為 zcat，經由連結符號 ln -s ，利用連結符號將 zmore 和 zgrep 都指向 zcat，一旦完成連結，這三種指令就擁有相同內容了。
   
        $ ln -s zcat zmore
        $ ln -s zcat zgrep


