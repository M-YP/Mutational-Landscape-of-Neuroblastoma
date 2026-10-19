---
name: check-docs
description: Compare README.md, HOWTO.md and CONTRIBUTING.md with the repository and report each reference that is not correct (missing files, script names, commands, tool versions). Use before a documentation change or when the user asks if the documents are correct.
disable-model-invocation: true
---

# Check the documents against the repository

Do not edit files. Only report the problems. The user decides what to fix.

1. List the files in the repository: `git ls-files`.
2. Read README.md, HOWTO.md and CONTRIBUTING.md. If $ARGUMENTS gives file names, read only those files.
3. Find each reference to a path, file name, script, command, config file, Conda environment name or URL. For each reference, make sure that the item exists:
   - Paths and files: compare with the list from step 1. Note: `environment.yaml` is the correct name. `Data/Raw/ToyDataset` is the chr20 extraction script.
   - Conda environment name: compare with `name:` in `environment.yaml`.
   - Workflow steps: compare with the step labels in `Neuroblastoma_WGS_Pipeline.json`.
4. Compare the tool versions in `environment.yaml` with the `tool_version` values in `Neuroblastoma_WGS_Pipeline.json`. Galaxy versions have a `+galaxyN` suffix. Compare only the part before the suffix. Report tools that are in the workflow but not in `environment.yaml`.
5. Find broken Markdown: code blocks that do not close, and links in the form `[url](url)` inside code blocks.

Do not report the `[cite: N]` markers. They are correct.

## Output

Give one table:

| # | File:line | Text | Problem | Suggested fix |
|---|---|---|---|---|

After the table, give the number of problems for each file.
