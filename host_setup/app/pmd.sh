#!/bin/bash

PROJECT=my-project-name

~/pmd/bin/run.sh pmd \
  -format html \
  -dir "~/src/$PROJECT" \
  -reportfile "~/src/$PROJECT/pmd-report.html" \
  -rulesets java-{basic,empty,j2ee,javabeans,sunsecure,strings,unnecessary,unusedcode}

