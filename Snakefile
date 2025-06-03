import glob
import os

GTF_FILE = glob.glob("./*.gtf")[0] if glob.glob("./*.gtf") else ""

BOWTIE_INDICES = glob.glob("genome/*.bt2")
if BOWTIE_INDICES:
    BOWTIE_INDEX = os.path.splitext(os.path.splitext(BOWTIE_INDICES[0])[0])[0]
else:
    BOWTIE_INDEX = ""

configfile: "config/config.yaml"

SAMPLES, = glob_wildcards("data/samples/{sample}.1.fastq.gz")

include: "rules/trim.smk"
include: "rules/map.smk"
include: "rules/featurecounts.smk"
include: "rules/multiqc.smk"

rule all:
    input: [expand("data/mapped/{sample}_bowtie2.bam", sample=SAMPLES),expand("data/mapped/counts_{sample}.txt", sample=SAMPLES),"data/multiqc/multiqc_report.html"]
