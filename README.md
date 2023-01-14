Reads a BAM file maps base qualities as defined in a base quality
mapping file (CSV) and writes SAM


# Input

CSV file should contain base quality values as int in the form: `from,to`

# Compilation

Requirement: nim compiler and htsnim installed

`nim c -d:nimDebugDlOpen  quad.nim`

#  Example execution

`./quad -q example/qmap_even2.csv -b example/Col0_C1.100k.bam`
