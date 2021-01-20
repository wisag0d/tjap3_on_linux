#!/bin/bash
#---
# This scripts will help you folder and song name,
# using MD5 replace song name.
# down below, it will change 
#
# single examples:
#   ./change_song_name.sh 星屑ストラック/
# all folder example:
#   for i in */ ; do ./change_song_name.sh "$i"; done
#---
DIRNAME=${1%/}
if [[ -d "$DIRNAME" ]]; then
  echo "found a folder '${DIRNAME}'"
else
  echo "$DIRNAME is not a folder."
  exit 1;
fi

SONG_NAME=$(ls "${DIRNAME}" | head -n1 | cut -d'.' -f1 | cut -d'_' -f1)
HASH_NAME=$(echo "${SONG_NAME}" | md5sum | awk '{print $1}')
NEW_DIRNAME=$(echo "${1//${SONG_NAME}/${HASH_NAME}}")
function PRINT() {
  echo "[$DIRNAME]: $1"
}

echo ===
PRINT "song name is ${SONG_NAME}"
PRINT "name after hash is ${HASH_NAME}"
PRINT "new folder name is ${NEW_DIRNAME}"
echo ---

IFS=$'\n'
PRINT "Change folder name, and go into folder."
echo "mv \"${DIRNAME}\" \"${NEW_DIRNAME}\""
mv "${DIRNAME}" "${NEW_DIRNAME}"
echo "cd \"${NEW_DIRNAME}\""
cd "${NEW_DIRNAME}"

PRINT "rename all files"
echo "IFS=$'\n'"
echo "rename \"${SONG_NAME}\" \"${HASH_NAME}\" $(ls -f *)"
rename "${SONG_NAME}" "${HASH_NAME}" $(ls -f *)

PRINT "replace old file name."
OGG_NAME=$(ls | grep -e '.ogg$' | head -n1)
for FN in $(ls | grep -e '.tja$'); do
  echo "export LANG=\"jp_JP.sjis\""
  export LANG="jp_JP.sjis"
  echo "sed -i \"s/^WAVE.*/WAVE:${OGG_NAME}/\" \"${FN}\""
  sed -i "s/^WAVE.*/WAVE:${OGG_NAME}/" "${FN}"
  echo "export LANG=\"zh_TW.UTF-8\""
  export LANG="zh_TW.UTF-8"
done

echo "cd .."
cd ..
