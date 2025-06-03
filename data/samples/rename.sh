for f in *_R1_001.fastq.gz; do
  newname=$(echo $f | sed 's/_S[0-9]*_L001_R1_001/.1/')
  mv "$f" "$newname"
done

for f in *_R2_001.fastq.gz; do
  newname=$(echo $f | sed 's/_S[0-9]*_L001_R2_001/.2/')
  mv "$f" "$newname"
done
