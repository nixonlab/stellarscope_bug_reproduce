#! /bin/bash

com=$(cd stellarscope_devmode.git && git rev-parse --short HEAD)
testdir=testdata
outdir=output.$com.rep1

if [[ -d $outdir ]] ; then
    i=1
    while [[ -d ${outdir%.*}.rep$i ]] ; do
        let i++
    done
    outdir=${outdir%.*}.rep$i
fi

echo "Output written to $outdir"
mkdir -p ${outdir}

# stellarscope\
#  assign\
#  --devmode\
#  --updated_sam\
#  --outdir ${outdir}\
#  --barcodefile ${testdir}/barcodes.tsv\
#  --pooling_mode celltype\
#  --exp_tag celltype\
#  --celltypefile ${testdir}/clusters_azimuth_l2.withspaces.tsv\
#  --use_every_reassign_mode\
#  ${testdir}/pseudo500.allHML2.bam\
#  ${testdir}/retro.gtf\
#  2>&1 | tee ${outdir}/celltype.log


stellarscope\
 assign\
 --devmode\
 --updated_sam\
 --outdir ${outdir}\
 --barcodefile ${testdir}/barcodes.tsv\
 --pooling_mode pseudobulk\
 --exp_tag pseudobulk\
 --use_every_reassign_mode\
 ${testdir}/pseudo500.allHML2.bam\
 ${testdir}/retro.gtf\
 2>&1 | tee ${outdir}/pseudobulk.log


# stellarscope\
#  assign\
#  --devmode\
#  --updated_sam\
#  --outdir ${outdir}\
#  --barcodefile ${testdir}/barcodes.tsv\
#  --pooling_mode individual\
#  --exp_tag individual\
#  --use_every_reassign_mode\
#  ${testdir}/pseudo500.allHML2.bam\
#  ${testdir}/retro.gtf\
#  2>&1 | tee ${outdir}/individual.log


