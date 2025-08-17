find . -maxdepth 1 -type l -exec rm {} +

find /mnt/60CE72AACE72785C/Users/Haarit/Desktop -maxdepth 1 -type d -print0 | xargs -0 -I {} sh -c '
dir="{}"
base=$(basename "$dir")
ln -s "$dir" ~/Desktop/"$base"
'

ln -s /mnt/60CE72AACE72785C ~/Desktop/Acer
ln -s /mnt/14EC5760EC573AE6 ~/Desktop/Haarit


ln -s /mnt/14EC5760EC573AE6/Academics   ~/Desktop/Acads
