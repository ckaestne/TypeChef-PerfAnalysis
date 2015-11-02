#!/bin/bash
kbuildflags() {
  name="$1"
  base="$(basename "$1")"
  extraFlag=""
  if grep -q "tests/python-use" <<< "$name"; then
    extraFlag="$extraFlag -DPYTHONPATH=\\\"python\\\" -DPYTHON=\\\"PYTHON_WOR\\\""
  fi
  if grep -q "util/exec_cmd" <<< "$name"; then
    extraFlag="$extraFlag -DPREFIX=\\\"\\\" -DPERF_EXEC_PATH=\\\"\\\""
  fi
 echo "$extraFlag"
}

