#!/usr/bin/env just --justfile
# shellcheck shell=bash

default:
  @just --choose

dry-run wdl_file input_file: (validate wdl_file input_file)
  #!/usr/bin/env bash -i
  set -euxo pipefail;
  cromwell run "{{ wdl_file }}" \
    --inputs "{{ input_file }}" ;

run: clean
  #!/usr/bin/env bash -i
  set -euxo pipefail;
  cromwell --version

clean:
  #!/usr/bin/env bash -i
  set -euxo pipefail;
  declare -a dir_arr=(
    "{{ justfile_directory() }}/cromwell-executions"
    "{{ justfile_directory() }}/cromwell-workflow-logs"
    "${HOME}/workspaces/wdl-res"
  );
  for _dir in "${dir_arr[@]}"; do
    if [ -d "${_dir}" ]; then
      rm -rf "${_dir}";
    fi;
  done;

validate wdl_file input_file:
  #!/usr/bin/env bash -i
  set -euxo pipefail;
  womtool validate "{{ wdl_file }}" --inputs "{{ input_file }}";