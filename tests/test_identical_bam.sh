echo "INFO: This (dummy) maps qualities against themselves (i.e. in == out) sa BAM and should there not produce any output"
bam=example/Col0_C1.100k.bam
csv=example/qmap_dummy.csv
quad=./quad
diff -u \
     <(samtools view $bam | grep -v '^@PG') \
     <($quad -q $csv -i $bam -o - --out-fmt b | samtools view - | grep -v '^@PG')


