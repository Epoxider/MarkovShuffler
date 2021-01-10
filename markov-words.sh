PREVWORD1="^"
PREVWORD2="^^"
PREVWORD3="^^^"
cat <&0 | tr "[:upper:]" "[:lower:]" | tr -c "a-zA-Z" '\n' | grep -E '(^[aio]$|[a-z][a-z]+)' | grep '[aeiouy]' | while read WORD
do
    echo "$PREVWORD3 $PREVWORD2 $PREVWORD1 $WORD"
    PREVWORD3=$PREVWORD2
    PREVWORD2=$PREVWORD1
    PREVWORD1=$WORD
done
