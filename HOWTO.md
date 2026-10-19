# HOWTO — Mutational-Landscape-of-Neuroblastoma

This guide tells you how to run the pipeline, which inputs it uses and which outputs it makes. It also gives solutions to known problems.

## Overview

The pipeline is a Galaxy workflow. The workflow file is `Neuroblastoma_WGS_Pipeline.json`. The workflow finds and filters the variants in whole-genome sequencing (WGS) data of the neuroblastoma sample SRR11467550.

The workflow has these steps:

| Step | Tool | Function |
|---|---|---|
| 1 | Trimmomatic 0.39 | Removes the adapters and the low-quality bases from the reads |
| 2 | FastQC | Makes a quality report of the trimmed reads |
| 3 | BWA-MEM2 2.2.1 | Aligns the reads to the hg38 reference genome |
| 4 | Picard MarkDuplicates 3.1.1 | Marks the duplicate reads |
| 5 | FreeBayes 1.3.10 | Calls the variants |
| 6 | DeepVariant 1.5.0 | Calls the variants (second caller) |
| 7 | vcfvcfintersect | Keeps only the variants that the two callers find (window: 30 bp) |
| 8 | vcffilter | Keeps only the variants with `QUAL > 20 & DP > 10` |

There is no local driver script. You can run the full pipeline in Galaxy (procedure A). You can also use the toy dataset script to get a small chr20 dataset (procedure B).

## Repository contents

| Path | Contents |
|---|---|
| `Neuroblastoma_WGS_Pipeline.json` | The Galaxy workflow |
| `environment.yaml` | The Conda environment `neuroblastoma-wgs-env` for local tools |
| `Data/Raw/` | The SRA manifest, the Ensembl variant export and the toy dataset script (`ToyDataset`) |
| `Data/Processed/` | The results of enrichment, ontology and database queries (DAVID, PANTHER, ClinVar, cBioPortal) |
| `Data/Sequences/` | The protein sequences from STRING |
| `Outputs/Figures/` | The STRING networks, the g:Profiler results and the link to the Galaxy workflow |
| `Outputs/Tables/` | The COSMIC table and the chart of the genes with the most mutations |

The files in `Data/` and `Outputs/` are the research results. Do not change them.

## Procedure A: Run the full pipeline in Galaxy

### Prerequisites

- An account on a Galaxy server that has the hg38 reference genome, for example <https://usegalaxy.eu>.

### Procedure

1. Log in to Galaxy.
2. Import the workflow. Use one of these two methods:
   - Open the shared workflow: <https://usegalaxy.eu/u/m-yp/w/neuroblastoma-wgs-pipeline-imported-from-uploaded-file>. Then click **Import**.
   - Go to **Workflows** > **Import**. Then upload the file `Neuroblastoma_WGS_Pipeline.json`.
3. Get the reads of SRR11467550 into your history. Use the Galaxy tool **Faster Download and Extract Reads in FASTQ** (fasterq-dump). Set the accession to `SRR11467550`.
4. Make sure that the reads are in a **paired** collection (forward and reverse).
5. Run the workflow. For the input **Paired_Reads**, select the paired collection.
6. When the workflow is complete, download the output of the step **Filter High-Quality Variants**.

## Procedure B: Make the chr20 toy dataset locally

The script `Data/Raw/ToyDataset` downloads the reads of SRR11467550, aligns them to GRCh38, and keeps only the reads on chromosome 20. The GNAS gene is on chromosome 20.

### Prerequisites

- Linux or macOS with Bash.
- Conda or Mamba.
- A FASTA file of the GRCh38 reference genome, with the name `reference_grch38.fa`, in the directory where you run the script.
- Enough disk space and time. The script downloads the full WGS run before it removes the reads that are not on chromosome 20.

### Procedure

1. Clone the repository:

   ```bash
   git clone https://github.com/M-YP/Mutational-Landscape-of-Neuroblastoma.git
   cd Mutational-Landscape-of-Neuroblastoma
   ```

2. Make the Conda environment and activate it:

   ```bash
   conda env create -f environment.yaml
   conda activate neuroblastoma-wgs-env
   ```

3. Make the BWA-MEM2 index of the reference genome:

   ```bash
   bwa-mem2 index reference_grch38.fa
   ```

4. Run the script:

   ```bash
   bash Data/Raw/ToyDataset
   ```

5. Find the output files in the directory `chr20_reads/`:
   - `SRR11467550_chr20_R1.fastq.gz`
   - `SRR11467550_chr20_R2.fastq.gz`

You can use these two files as a small input for procedure A.

## Expected outputs

| Source | Output |
|---|---|
| Galaxy step 2 (FastQC) | Quality report (HTML and text) |
| Galaxy step 4 (Picard) | BAM file with marked duplicates, and duplicate metrics |
| Galaxy steps 5 and 6 | One VCF file from each variant caller, and the DeepVariant HTML report |
| Galaxy step 8 | The VCF file with the high-quality variants. This is the final output. |
| Procedure B | Two compressed FASTQ files of the chromosome 20 reads |

## Troubleshooting

| Problem | Possible cause | Solution |
|---|---|---|
| The workflow does not accept the input. | The reads are not in a paired collection. | Put the forward and reverse reads into one paired collection. |
| Galaxy cannot find a tool or a tool version. | The Galaxy server does not have the tool installed. | Use usegalaxy.eu, or ask the administrator of your server to install the tool. |
| The script stops with a region error from `samtools view`. | The reference genome has only one of the names `chr20` and `20`. | In the script, remove the chromosome name that is not in your reference. |
| BWA-MEM2 stops with an index error. | The reference genome has no index. | Do step 3 of procedure B. |
| The disk becomes full. | The script downloads the full WGS run. | Use a disk with more free space, or set `OUT_DIR` in the script to a larger disk. |

## Contact

To report a problem or to ask a question, open an issue: <https://github.com/M-YP/Mutational-Landscape-of-Neuroblastoma/issues>
