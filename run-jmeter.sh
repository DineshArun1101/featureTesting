#!/bin/bash

JMETER_HOME=$1
WORKSPACE=$(pwd)   # Jenkins job workspace

THREADS_SAMPLE=1
RAMPUP=1
TESTDURATION=1

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
RESULTS_FILE="$WORKSPACE/results_${TIMESTAMP}.jtl"
REPORT_DIR="$WORKSPACE/report_${TIMESTAMP}"

echo "Starting JMeter Load test.."

cd "$WORKSPACE"

"$JMETER_HOME/bin/jmeter" -n \
  -t ORANGEHRM_WEB_APP_10102023_scripted.jmx \
  -Jthreads_sample=$THREADS_SAMPLE \
  -Jrampup=$RAMPUP \
  -Jtestduration=$TESTDURATION 
