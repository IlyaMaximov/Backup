#!/bin/bash
DIRNAME=$1
eval "ARCHIVENAME=\${$#}"
mkdir "$DIRNAME/$ARCHIVENAME"
shift
while [ $# -gt 1 ]
do
for FILE in `find $DIRNAME -type f -name "*.$1"`
do

PREVPATH=${FILE%/*.$1}
EXTENSION=${FILE#$PREVPATH/}
FILENAME=${EXTENSION%.$1}
EXTENSION=${EXTENSION#$FILENAME}
if [ ! -f "$DIRNAME/$ARCHIVENAME/$FILENAME$EXTENSION" ]
then cp $FILE "$DIRNAME/$ARCHIVENAME/"
else 
i=1
while [ -f "$DIRNAME/$ARCHIVENAME/$FILENAME$i$EXTENSION" ]
do
i=$((i+1))
done
cp $FILE "$DIRNAME/$ARCHIVENAME/$FILENAME$i$EXTENSION"

fi
done
shift
done
tar -cf "$DIRNAME/$ARCHIVENAME.tar" -P --absolute-names "$DIRNAME/$ARCHIVENAME/"
rm -r "$DIRNAME/$ARCHIVENAME/"
echo "done"


