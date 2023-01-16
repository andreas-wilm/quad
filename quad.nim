# Andreas Wilm <andreas.wilm@gmail.com>
# Copyright 2023
# License: MIT


# Reads a BAM file maps base qualities as defined in a base quality
# mapping file (CSV) and writes SAM


import std/strformat
import std/tables
import std/strutils

import csvtools
import hts


proc map_phred(phred_ascii: string, qmap: Table[int, int]): string =
  # take ascii encoded phred quality string and map qualities
  # according to qmap
  var mapped_phred: seq[char]
  for c in phred_ascii:
    var n = c # the output character
    let q = ord(c) - 33
    if q in qmap:
      n = chr(qmap[q] + 33)
    mapped_phred.add(n)
  return mapped_phred.join()


proc parse_qmap_file(qmap_file: string): Table[int, int] =
  # parse the quality mapping csv file and turn into a table.
  # file is expected to have a header.
  # values should be lsited as: qold,qnew

  var qmap = initTable[int, int]()
  type Q2Q = object
    key: int
    value: int

  for row in csv[Q2Q](qmap_file, skip_header = true):
    for v in [row.key, row.value]:
      doAssert(v >= 0 and v <= 93, fmt"Invalid quality {v} found in {qmap_file}")
    qmap[row.key] = row.value
  return qmap


proc main(qmap_file: string, bam_file: string, threads = 1): int =
  var
    ibam: Bam
    obam: Bam

  var qmap = parse_qmap_file(qmap_file)

  if not open(ibam, bam_file, index = false):
    # htsnim prints an error
    return 1

  # we use obam only for writing the header,
  # since we can't modify alignment records directly.
  # instead we parse and modify the bq string :(
  open(obam, "-", threads = threads, mode = "w")
  obam.write_header(ibam.hdr)
  #obam.close() can't close because it's stdout and we can't print anymore!?

  for aln in ibam:
    var aln_fields = aln.tostring.split("\t")
    var bq_ascii = aln_fields[10]
    aln_fields[10] = map_phred(bq_ascii, qmap)
    echo aln_fields.join("\t")
  return 0


when isMainModule:
  import cligen
  dispatch(main)
