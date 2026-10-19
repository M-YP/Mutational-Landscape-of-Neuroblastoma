---
name: galaxy-workflow
description: Use when you read or edit Neuroblastoma_WGS_Pipeline.json (the Galaxy .ga workflow), for example to change a tool version, a tool parameter, a step or a connection between steps.
---

# Edit the Galaxy workflow JSON

`Neuroblastoma_WGS_Pipeline.json` is a Galaxy workflow export (`format-version` 0.1). The file must stay importable into usegalaxy.eu.

## File structure

- `steps` is an object. Its keys are the step numbers as strings ("0", "1", ...). Each key must be the same as the `id` of its step.
- Step 0 is the `data_collection_input` (`Paired_Reads`). Steps 1 to 8 are tool steps.
- `input_connections` connects a step to an earlier step with `{"id": <step id>, "output_name": "<output name>"}`. The `output_name` must be in the `outputs` list of the earlier step.
- `tool_state` is a string that contains JSON. It is not a JSON object. Decode it, edit it, then encode it again as a string. Do not edit it as plain text.

## Change a tool version

Make these changes together:

1. Change `tool_id`. The version is the last part of the ID (for example `.../freebayes/freebayes/1.3.10+galaxy0`).
2. Change `content_id` to the same value as `tool_id`.
3. Change `tool_version`.
4. Change `tool_shed_repository.changeset_revision` to the revision that has the new version. If you do not know the revision, tell the user. Do not guess it.
5. If the version of the underlying tool changes, update the same tool in `environment.yaml`.

## Edit `tool_state` safely

```bash
python3 - <<'PY'
import json
p = "Neuroblastoma_WGS_Pipeline.json"
w = json.load(open(p))
s = w["steps"]["5"]
state = json.loads(s["tool_state"])
# edit state here
s["tool_state"] = json.dumps(state)
json.dump(w, open(p, "w"), indent=4)
PY
```

Before you write the file, look at its current indentation. Keep the same indentation, so that the diff stays small.

## Validate

```bash
python3 - <<'PY'
import json
w = json.load(open("Neuroblastoma_WGS_Pipeline.json"))
assert w["a_galaxy_workflow"] == "true"
for k, s in w["steps"].items():
    assert int(k) == s["id"], k
    if s["type"] == "tool":
        assert s["tool_id"] == s["content_id"], k
        assert s["tool_id"].endswith("/" + s["tool_version"]), k
        json.loads(s["tool_state"])
    for c in s["input_connections"].values():
        for c in (c if isinstance(c, list) else [c]):
            src = w["steps"][str(c["id"])]
            names = [o["name"] for o in src["outputs"]] or ["output"]
            assert c["output_name"] in names, (k, c)
print("OK")
PY
```

Tell the user to import the changed file into usegalaxy.eu to do a full check.
