rule cutadapt_trim:
    input:
        ["data/samples/{sample}.1.fastq.gz", "data/samples/{sample}.2.fastq.gz"],
    output:
        fastq1="data/trimmed/trimmed_{sample}.1.fastq",
        fastq2="data/trimmed/trimmed_{sample}.2.fastq",
        qc="data/trimmed/trimmed_{sample}.qc.txt",
    params:
        # https://cutadapt.readthedocs.io/en/stable/guide.html#adapter-types
        adapters="-a AGATCGGAAGAGC -A AGATCGGAAGAGC",
        # https://cutadapt.readthedocs.io/en/stable/guide.html#
        extra="--minimum-length 100 -q 30 --pair-filter=any",
    log:
        "logs/cutadapt/{sample}.log",
    threads: 1  # set desired number of threads here
    resources:
        time="24:00:00",
        mem_mb=8000
    wrapper:
        "v1.32.1/bio/cutadapt/pe"

