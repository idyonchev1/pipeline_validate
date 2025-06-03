rule map_with_bowtie2:
    input:
        sample=["data/trimmed/trimmed_{sample}.1.fastq", "data/trimmed/trimmed_{sample}.2.fastq"]
    output:
        "data/mapped/{sample}_bowtie2.bam"
    log:
        "logs/bowtie2/{sample}.log",
    params:
        index=BOWTIE_INDEX
    threads: 4
    resources:
        mem_mb=16000,
        time="48:00:00"
    shell:
        """
        bowtie2 -x {params.index} -1 {input[0]} -2 {input[1]} -I 148 -X 479 --very-sensitive --end-to-end --no-discordant --no-mixed | samtools sort - > {output}
        samtools index {output}
        """
