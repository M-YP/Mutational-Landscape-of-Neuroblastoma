# Contributing to Mutational Landscape of Neuroblastoma

Thanks for your interest in improving this project. We welcome contributions that improve the reproducibility, clarity, and biological insight of the neuroblastoma mutation analysis pipeline.

## How to contribute

You can contribute in several ways:

- Report bugs or reproducibility issues.
- Suggest improvements to the pipeline or analysis workflow.
- Add or refine documentation.
- Improve shell scripts, parameter handling, or quality of outputs.
- Help identify clinically relevant variants, IDRs, DMRs, neoantigens, or biomarker workflows.

## Before you start

1. Check whether a related issue already exists.
2. Discuss larger changes in an issue before implementing them.
3. Keep changes focused and easy to review.
4. Prefer reproducible, scriptable workflows over ad hoc one-off commands.

## Repository workflow

- Fork the repo if you are not a direct collaborator.
- Create a feature branch from the default branch.
- Keep branch names descriptive, for example:
  - `fix-variant-filtering`
  - `docs-analysis-workflow`
  - `add-neoantigen-summary`
- Submit a pull request with a clear description of the problem and the fix.

## Coding and workflow guidelines

The pipeline is a Galaxy workflow (`Neuroblastoma_WGS_Pipeline.json`). The repository also contains a shell script (`Data/Raw/ToyDataset`) and a Conda environment (`environment.yaml`). Keep all of them portable and easy to run in a Unix-like environment.

If you change a tool version in the workflow, also change it in `environment.yaml`.

- Write clear, maintainable shell scripts.
- Use descriptive variable names and comments where logic is non-obvious.
- Prefer explicit, reproducible commands over hidden defaults.
- Validate paths, inputs, and outputs before running heavy analyses.
- Keep scripts idempotent when possible.
- Do not commit sensitive or patient-identifying data.
- Avoid hard-coded local paths that will not work for other contributors.

Recommended shell practices:

- Use `set -euo pipefail` where appropriate.
- Quote variable expansions and file paths.
- Handle missing dependencies and invalid inputs with clear error messages.
- Keep scripts modular so components can be reused and tested independently.

## Documentation

When changing how the pipeline works, update the relevant documentation so others can reproduce the process:

- README instructions
- Script comments
- Parameter descriptions
- Examples for input/output file formats

## Validation

Before opening a pull request:

- Check that the modified script(s) still run in the expected environment.
- Confirm that outputs are generated as expected.
- Run any relevant syntax checks such as:

```bash
bash -n path/to/script.sh
```

If the workflow depends on a specific dataset, use a small, non-sensitive example where possible.

## Pull request checklist

Before submitting a PR, confirm that:

- The change is clearly described.
- The scope is narrow and well justified.
- Relevant documentation has been updated.
- Inputs, outputs, and assumptions are clearly stated.
- The workflow still runs in a clean environment.
- No temporary files or debugging artifacts remain.

## Questions

If you are unsure whether a contribution fits the project, open an issue first and describe the planned change. This helps keep the pipeline consistent and reduces duplicated work.

Thank you for helping improve the neuroblastoma mutation analysis workflow.
