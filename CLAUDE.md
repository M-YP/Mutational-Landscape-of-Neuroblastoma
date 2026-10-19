# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

- The pipeline is a Galaxy workflow: `Neuroblastoma_WGS_Pipeline.json`. It runs on usegalaxy.eu (the link is in `Outputs/Figures/Workflow Canvas`). The repository has no local driver script, no build and no tests.
- The steps are: Trimmomatic → FastQC → BWA-MEM2 (hg38) → Picard MarkDuplicates → FreeBayes and DeepVariant → vcfvcfintersect → vcffilter.
- `Data/Raw/ToyDataset` is a bash script (`extract_chr20_reads.sh`) with no file extension. It gets the chr20 reads of SRR11467550.
- `environment.yaml` is the Conda environment (`neuroblastoma-wgs-env`). It is not `environment.yml`.
- To edit the Galaxy workflow JSON, use the `galaxy-workflow` skill.

## Rules

- Do not change, rename, move or make again the files in `Data/` and `Outputs/`. They are fixed research results, and the numbers in README.md come from them. A hook blocks edits to these directories.
- Keep the `[cite: N]` markers in README.md. They refer to the source references.
- Do not change the research results in README.md (counts, p-values, gene names) unless the user asks.
- Do not commit data that can identify a patient.

## Known problems in the documents

HOWTO.md and CONTRIBUTING.md describe items that do not exist: `scripts/`, `run_pipeline.sh`, `config.yaml`. README.md refers to `environment.yml` and `figures/galaxy_workflow_canvas.png`, and these files also do not exist. Do not copy these references into new text. To find all differences between the documents and the repository, use `/check-docs`.

Tool versions in `environment.yaml` are not the same as in the Galaxy workflow. For example, FreeBayes is 1.3.6 in `environment.yaml` and 1.3.10 in the workflow, and `environment.yaml` has no DeepVariant. If you change a tool version in one file, update the other file too.

## Workflow

- Make a feature branch with a descriptive name (for example `fix-variant-filtering`). Open a pull request to `M-YP/Mutational-Landscape-of-Neuroblastoma`. Do not commit directly to `main`.
- For new shell scripts, use `set -euo pipefail` and put quotes around all variable expansions. Check them with `bash -n <script>`.
