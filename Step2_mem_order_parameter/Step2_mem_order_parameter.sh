#! /bin/bash -x

#Task: Measure order parameters along targer system
set -e
shopt -s expand_aliases
alias vmdd='vmd -dispdev text'

trajPrefix="Twe"
outmemType="pccl"
inDir="/Scr/delcck/Antigen/MemPeptide6/Analysis/$outmemType/"
inPsf="$trajPrefix.$outmemType.psf"
inTraj="$inDir$trajPrefix.$outmemType.dcd"
outN="$trajPrefix.$outmemType"

criptDir="/Scr/delcck/Antigen/MemPeptide6/Analysis/"
scriptName="measure_order_parameter.tcl"
outscriptN="$trajPrefix.$outmemType.temp.$scriptName"
outDir="/Scr/delcck/Antigen/MemPeptide6/Analysis/$outmemType/"

outName="$outDir$outN"

mkdir -p "$outDir"

sed "s|INDIR|$inDir|g;
s|INPSF|$inPsf|g;
s|INTRAJ|$inTraj|g;
s|OUTNAME|$outName|g;" "$scriptDir$scriptName"  > "$outscriptN"

vmdd < "$outscriptN"
