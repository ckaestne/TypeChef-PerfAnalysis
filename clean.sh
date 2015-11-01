path=linux
cat filelist |while read i; do echo $path/$i; rm $path/$i.dbg; rm $path/$i.c.xml; rm $oath/$i.pi; done 
