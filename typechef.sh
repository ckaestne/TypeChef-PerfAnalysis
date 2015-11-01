#!/bin/bash -e
#!/bin/bash -vxe


javaOpts=''
javaOpts='$javaOpts -Xmx2G -Xms128m -Xss10m'

# For Java compiled stuff!
basePath=.

mainClass="de.fosd.typechef.Frontend"


inp=$1
shift
outBase="$(dirname $inp)/$(basename $inp .c)"
outDbg="$outBase.dbg"
outErr="$outBase.err"
outTime="$outBase.time"




# Beware: the embedded for loop requotes the passed argument. That's dark magic,
# don't ever try to touch it. It simplifies your life as a user of this program
# though!
echo "==Analyzing $inp"
#date
#echo $typechefFlags "$@"

bash -c "time ../TypeChef/typechef.sh \
  $(for arg in $typechefFlags "$@"; do echo -n "\"$arg\" "; done) \
  '$inp' 2> '$outErr' |tee '$outDbg'" \
  2> "$outTime" || true

cat "$outErr" 1>&2
