#!/bin/bash

# First argument is JMeter installation path
JMETER_HOME=$1
WORKSPACE=$(pwd)   # Jenkins job workspace

# Test parameters
THREADS_SAMPLE=10
RAMPUP=10
TESTDURATION=300

# Generate timestamp for unique results
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
RESULTS_FILE="results_${TIMESTAMP}.jtl"
REPORT_DIR="report_${TIMESTAMP}"

echo "JMETER_HOME=$JMETER_HOME"
echo "WORKSPACE=$WORKSPACE"
echo "THREADS_SAMPLE=$THREADS_SAMPLE"
echo "RAMPUP=$RAMPUP"
echo "TESTDURATION=$TESTDURATION"
echo "RESULTS_FILE=$RESULTS_FILE"
echo "REPORT_DIR=$REPORT_DIR"

# Validate JMX file exists
if [ ! -f "$WORKSPACE/ORANGEHRM_WEB_APP_10102023_scripted.jmx" ]; then
  echo "ERROR: JMX file not found in $WORKSPACE"
  ls -l "$WORKSPACE"   # list files for debugging
  exit 1
fi

echo "Starting JMeter Load test.."

# Force execution inside workspace
cd "$WORKSPACE"

# Run JMeter in non-GUI mode with properties
"$JMETER_HOME/bin/jmeter" -n \
  -t ORANGEHRM_WEB_APP_10102023_scripted.jmx \
  -Jthreads_sample=$THREADS_SAMPLE \
  -Jrampup=$RAMPUP \
  -Jtestduration=$TESTDURATION \
  -l "$RESULTS_FILE" \
  -e -o "$REPORT_DIR"

JMETER_EXIT=$?
echo "JMeter exit code: $JMETER_EXIT"

echo "Files created in workspace after JMeter run:"
ls -l "$WORKSPACE"