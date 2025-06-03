rule fastqc:
    input:
        ["data/trimmed/{sample}.1.fastq", "data/trimmed/{sample}.2.fastq"]
    output:
        ["data/fastqc/{sample}.1_fastqc.html","data/fastqc/{sample}.2_fastqc.html"]
    params:
    threads:1
    resources:
        mem_mb=16000,
        time="48:00:00"
    shell:
        "fastqc -o data/fastqc -t 1 {input}"

rule fastq_screen:
    input:
        ["data/trimmed/{sample}.1.fastq","data/trimmed/{sample}.2.fastq"]
    output:
        txt="data/fastqc/{sample}.fastq_screen.txt",
        png="data/fastqc/{sample}.fastq_screen.png"
    params:
        fastq_screen_config="config/fastq_screen.conf",
        subset=100000,
        aligner='bowtie2'
    threads: 8
    resources:
        mem_mb=16000,
        time="48:00:00"
    wrapper:
        "v2.0.0/bio/fastq_screen"

rule multiqc:
    input:
        expand("data/fastqc/trimmed_{sample}.1_fastqc.html", sample=SAMPLES),
        expand("data/fastqc/trimmed_{sample}.2_fastqc.html", sample=SAMPLES),
        expand("data/fastqc/trimmed_{sample}.fastq_screen.txt", sample=SAMPLES),
    output:
        "data/multiqc/multiqc_report.html"
    resources:
        mem_mb=4000,
        time="24:00:00"
    threads:1
    shell:
        "multiqc data/fastqc -o data/multiqc"
