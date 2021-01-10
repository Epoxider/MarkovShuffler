
if [ $# -ne 2 ]; then
   echo "You must supply 2 arguments: $0 <input filename> <total words>" 1>& 2
   exit -1
fi

if [ ! -f "$1" ]; then
   echo "The file '$1' does not exist!" 1>& 2
   exit -1
fi

isnumber=`echo "$2" | grep -E ^[0-9]+$`

if [ "$isnumber" == '' ]; then
   echo "The second argument must be a number" 1>& 2
   exit -1
fi

if [ "$2" -le "0" ]; then
   echo "The second argument must be greater than 0" 1>& 2
   exit -1
fi
  
SHUF=$(command -v shuf)
if [ ! -x "$SHUF" ]; then
   if [ -x "./shuffle" ]; then
      SHUF="./shuffle"
   else
      echo "No shuffle program!" 1>& 2
      exit -1
   fi
fi

WORDS=$1

LINE=$(cat $WORDS | $SHUF | head -n 1)


lineArray=($LINE)
echo
echo -n "${lineArray[@]:1:3}"

for ((i=0; i<$2; i++));
do
   lastThree="${lineArray[@]:1:3}"
   LINE=$(grep "^$lastThree" "$WORDS" | $SHUF | head -n 1)
   lineArray=($LINE)
   echo -n " ${lineArray[@]:3:3}"
done
echo
