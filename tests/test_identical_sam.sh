echo "INFO: This (dummy) maps qualities against themselves (i.e. in == out) as SAM and should there not produce any output"

diff -u <(samtools view example/Col0_C1.100k.bam | grep -v '^@PG') <(./quad -q example/qmap_dummy.csv  -i example/Col0_C1.100k.bam -o - | grep -v '^@PG')

echo "FIXME: sequences with no reads mapped are removed" 1>&2

