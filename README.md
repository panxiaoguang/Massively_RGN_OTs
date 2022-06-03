## Incite
[![DOI](https://zenodo.org/badge/359693041.svg)](https://zenodo.org/badge/latestdoi/359693041)

## SURRO-seq scripts

This is some scripts for indel calling of spCas9 of Gene Therapy oligos. 


- extract_reads_from_BAM.py Filter the reads that match the reference sequence from the aligned BAM file.
- remove_synthesis_error.jl According to WT, remove the synthesis error.
- get_indel_profile.jl Print indel profile for each trap oligos.
- remove_sequencing_error.jl Remove sequencing errors according to indel profile.

