# Unravelling the Mutational Landscape of Neuroblastoma: GNAS as a Candidate Biomarker for Immunotherapeutic Development

**Author:** Maryam Yazdanparast  
**Affiliation:** Independent Researcher

---

## Project Overview

Neuroblastoma (NBL) is a complex and heterogeneous paediatric malignancy. High-risk forms frequently display resistance to current multimodal therapies and present an immunologically "cold" microenvironment. 

This project establishes a standardized, reproducible next-generation sequencing (NGS) analysis pipeline to explore under-characterized genomic alterations in high-risk neuroblastoma. By interrogating whole-genome sequencing (WGS) data from patient sample `SRR11467550` (NCBI SRA), the workflow identifies novel neoantigen candidates and biomarkers for immunotherapeutic development—specifically targeting intrinsically disordered proteins/regions (IDPs/IDRs), differentially methylated regions (DMR), and critical regulatory hubs[cite: 3, 4].

---

## Key Research Objectives

* **Pipeline Standardization:** Develop a reproducible framework for mutation calling and functional variant profiling in neuroblastoma[cite: 3, 4].
* **Immunotherapy Biomarker Discovery:** Systematically prioritize neoantigens and translational markers, including IDRs and DMRs[cite: 3, 4].
* **Uncovering Overlooked Variants:** Capture under-characterized, non-coding, and unannotated variants that escape standard clinical panels but possess high functional pathogenicity[cite: 3, 4].

---

## Mutational Landscape Highlights (Sample: SRR11467550)

* **Extensively Unannotated Genome:** Out of **11,449 mutated genes** identified in this case, **10,745 (94%) are completely absent from ClinVar**[cite: 3, 4].
* **Novel Pathogenic Burden:** Out of 2,734 genes carrying high-impact variants, only 195 are registered in ClinVar (<10%)[cite: 3, 4]. The leading 29 genes with the highest variant counts (70–138 mutations) have no prior records in ClinVar[cite: 3, 4].
* **Functional & Pathway Enrichment (g:Profiler & KEGG):**
  * **Top Biological Functions:** Protein binding and organelle organisation[cite: 3, 4].
  * **Top Enriched Pathway:** Nucleocytoplasmic transport[cite: 3, 4].
  * **Cellular Compartments:** 931 mutated genes localize to the plasma membrane and 535 to extracellular exosomes, pointing to surface and immunogenic targets[cite: 3, 4].

---

## Focus on GNAS: A Critical Loss-of-Function Regulatory Hub

`GNAS` is identified as the central mutational hub carrying an unprecedented accumulation of high-impact variants[cite: 3, 4].

### 1. High-Impact Splice-Site Disruption
* A total of **117 variants** were mapped in `GNAS`, dominated by severe splice disruptions:
  * **30** splice donor variants
  * **21** splice acceptor variants
  * **7** splice region variants
  * **2** frameshift variants[cite: 4]
  * **52** intron variants[cite: 4]
* **Loss-of-Function (LoF):** 6 high-impact somatic variants cause definitive LoF and severe mRNA processing impairment, driving isoform switching and functional silencing[cite: 4].
* **Population Specificity:** According to gnomAD, **75 GNAS variants** (including all splice-disrupting mutations) are completely absent from the general population ($AF < 0.01$ or NA), confirming they are disease-specific drivers[cite: 4].
* **Phenotypic Switch:** Loss of functional Gsα signaling links to an **adrenergic-to-mesenchymal transition**, consistent with aggressive, metastatic, and chemo-resistant phenotypes[cite: 4].

### 2. Network Topology & Comparison (STRING Analysis)

| Metric | GNAS Network | B4GALNT1 (GD2 Biosynthesis) | MYCN (Proto-oncogene) |
| :--- | :---: | :---: | :---: |
| **Average Node Degree** | **5.82**[cite: 4] | 5.64[cite: 4] | 6.18[cite: 4] |
| **PPI Enrichment p-value** | **$6.45 \times 10^{-7}$**[cite: 4] | $1.06 \times 10^{-7}$[cite: 4] | $4.61 \times 10^{-4}$[cite: 4] |
| **Mutational Pattern** | **Hub-Concentrated:** Only 2 of 10 interactors mutated[cite: 3, 4] | **Pathway-Dispersed:** 8 of 10 interactors mutated[cite: 3, 4] | **Coordinated:** 9 of 10 interactors mutated[cite: 4] |

The highly significant enrichment p-value ($6.45 \times 10^{-7}$) demonstrates that `GNAS` mutations reflect coordinated biological disruption rather than random background noise[cite: 4].

---

## Therapeutic Implications & Synthetic Lethality

Direct small-molecule activation of GNAS is hindered by its "undruggable" structure (lacking deep hydrophobic pockets), complex imprinting (Gsα, XLαs, NESP55), and risk of systemic toxicity[cite: 4]. Therefore, multimodal indirect strategies are proposed[cite: 4]:
1. **Synthetic Lethality:** Exploiting collateral vulnerabilities in transcriptional kinases, specifically **CDK9** and **CDK12/13** inhibitors[cite: 4].
2. **Pathway Reactivation:** Repurposing **cAMP-elevating agents** to bypass Gsα inactivation and restore downstream adenylyl cyclase signaling, overcoming multidrug resistance[cite: 4].

---

## Computational Workflow

The pipeline is implemented using standard bioinformatics tools and deployed on a cloud-based Galaxy infrastructure[cite: 3, 4]:

### Data Retrieval & API Access
Raw paired-end sequencing data can be retrieved programmatically using the ENA/SRA REST API:
```bash
# Query run metadata via ENA API
curl -s "[https://www.ebi.ac.uk/ena/portal/api/filereport?accession=SRR11467550&result=read_run&fields=run_accession,fastq_ftp&format=json](https://www.ebi.ac.uk/ena/portal/api/filereport?accession=SRR11467550&result=read_run&fields=run_accession,fastq_ftp&format=json)"

# Or directly dump reads via SRA-toolkit
fasterq-dump SRR11467550 --split-files --threads 4
## Computational Workflow Architecture

The end-to-end WGS variant discovery and filtering pipeline was designed and executed within Galaxy, ensuring modularity and complete reproducibility:

![Galaxy Workflow Architecture](figures/galaxy_workflow_canvas.png)

### Reproducing the Environment (Conda)

You can reproduce the exact computational environment using Conda/Mamba:

```bash
# Clone the repository
git clone [https://github.com/](https://github.com/)<your-username>/Mutational-Landscape-of-Neuroblastoma.git
cd Mutational-Landscape-of-Neuroblastoma

# Create and activate environment
conda env create -f environment.yml
conda activate neuroblastoma-wgs-env
