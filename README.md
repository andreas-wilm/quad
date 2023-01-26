Maps base qualities in a BAM file as defined in a base quality
mapping file (CSV)


# Input

1. A BAM file
1. A CSV file should contain base quality values as int in the form: `from,to`

# Compilation

Requirement: a Nim compiler and the packages:

- [hts](https://github.com/brentp/hts-nim)
- [csvtools](https://github.com/andreaferretti/csvtools)
- [cligen](https://github.com/c-blake/cligen)

To compile use: `nim c quad.nim`

Note: `libhts.so` needs to be found in your `LD_LIBRARY_PATH`.

# Binaries

To avoid the hassle of compilation altogether, use the statically
compiled binary (Linux only), provided in the release packages.

Binaries were built with [Brent Pedersen's
`hts_nim_static_builder`](https://github.com/brentp/hts-nim#static-builds):

`hts_nim_static_builder -s quad --deps "hts@>=0.3.23" --deps "cligen@>=1.4.1" --deps "csvtools@>=0.2.1"`

#  Example execution

`./quad -q example/qmap_even2.csv -i example/Col0_C1.100k.bam -o out.bam`


When stdout (-) is used for output the format changes automatically to SAM.
The output format can be changed with `--out-fmt`


# License

MIT License. See LICENSE file
