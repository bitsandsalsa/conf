#!/bin/bash

CPPCHECK_SRC_ROOT=$HOME/src/cppcheck-1.80
CPPCHECK_PROJ_DIR=$HOME/Documents/cppcheck
SRC_DIR=$HOME/src/foo

cd "$CPPCHECK_SRC_ROOT/cfg"
mkdir -p "$CPPCHECK_PROJ_DIR/build"
# rule files cannot be specified in the GUI
rule_files=$(for f in $CPPCHECK_SRC_ROOT/rules/*.xml; do echo -n "--rule-file=$f "; done)

cppcheck \
--cppcheck-build-dir="$CPPCHECK_PROJ_DIR/build" \
--enable=all \
-j 4 \
--library=gnu.cfg \
--library=posix.cfg \
--output-file="$CPPCHECK_PROJ_DIR/cppcheck-results.xml" \
$rule_files \
--xml \
--xml-version=2 \
"$SRC_DIR"

echo
echo == Statistics ==
for t in error warning style portability performance information; do
    echo -n "$t: "
    grep -c "severity=\"$t\"" "$CPPCHECK_PROJ_DIR/cppcheck-results.xml"
done
