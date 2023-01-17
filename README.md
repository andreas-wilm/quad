Reads a BAM file maps base qualities as defined in a base quality
mapping file (CSV)


# Input

CSV file should contain base quality values as int in the form: `from,to`

# Compilation

Requirement: a Nim compiler and the packages:

- [hts](https://github.com/brentp/hts-nim)
- [csvtools](https://github.com/andreaferretti/csvtools)
- [cligen](https://github.com/c-blake/cligen)

To compile use: `nim c quad.nim`

Note: `libhts.so` needs to be found in your `LD_LIBRARY_PATH`.

# Binaries

To avoid the hassle of installation use the provided statically
compiled binary (Linux only), which was build with [Brent Pedersens
`hts_nim_static_builder`](https://github.com/brentp/hts-nim#static-builds):

`hts_nim_static_builder -s quad --deps "hts@>=0.3.23" --deps "cligen@>=1.4.1" --deps "csvtools@>=0.2.1"`

#  Example execution

`./quad -q example/qmap_even2.csv -i example/Col0_C1.100k.bam -o out.bam`


By default SAM is written. The output format can be changed to BAM with `--out-fmt b`


# License

See LICENSE file
