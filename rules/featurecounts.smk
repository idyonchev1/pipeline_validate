rule featureCounts:
    input:
        bam="data/mapped/{sample}_bowtie2.bam"
    output:
        counts="data/mapped/counts_{sample}.txt",
        summary="data/mapped/counts_{sample}.txt.summary"
    params:
        annotations=GTF_FILE
    threads: 8
    resources:
        mem_mb=16000,
        time="48:00:00"
    shell:
        "featureCounts -p --countReadPairs -P -B -C -d 148 -D 479 -t exon -g gene_id -a {params.annotations} -o {output.counts} -T {threads} {input.bam}"
