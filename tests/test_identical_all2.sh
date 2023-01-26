echo "INFO: This maps all qualities (below 50) to 2 and prints only bqs if something went wrong"

./quad -q example/qmap_all2.csv -i example/Col0_C1.100k.bam -o - | grep -v '^@SQ' | cut -f 11 | grep -v '^#*#$'


