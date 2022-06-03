## Welcome to SURRO-seq official repository!
[![DOI](https://zenodo.org/badge/359693041.svg)](https://zenodo.org/badge/latestdoi/359693041)

## SURRO-seq scripts

This is some scripts for indel calling of SpCas9 for SURRO-seq. 


- extract_reads_from_BAM.py Filter the reads that match the reference sequence from the aligned BAM file.
- remove_synthesis_error.jl According to WT, remove the synthesis error.
- get_indel_profile.jl Print indel profile for each trap oligos.
- remove_sequencing_error.jl Remove sequencing errors according to indel profile.

## Acknowledgements

These scripts were developed by Pan xiaoguang and Luo yonglun for **Massively Targeted Evaluation of Therapeutic CRISPR Off-Targets in Cells** at the Qingdao-Europe advanced institue of life science
