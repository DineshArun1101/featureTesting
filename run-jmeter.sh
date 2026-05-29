#!/bin/bash

# First argument is JMeter installation path
JMETER_HOME=$1
echo "JMETER_HOME=$JMETER_HOME"

WORKSPACE=$(pwd)   # Jenkins job workspace

# Test parameters
THREADS_SAMPLE=10
echo "THREADS_SAMPLE=$THREADS_SAMPLE"

RAMPUP=10
echo "RAMPUP=$RAMPUP"

TESTDURATION=300
echo "TESTDURATION=$TESTDURATION"

# Generate timestamp for unique results
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
RESULTS_FILE="$WORKSPACE/results_${TIMESTAMP}.jtl"
REPORT_DIR="$WORKSPACE/report_${TIMESTAMP}"

echo "Starting JMeter Load test.."


# Run JMeter in non-GUI mode with properties
"$JMETER_HOME/bin/jmeter" -n \
  -t "$WORKSPACE/ORANGEHRM_WEB_APP_10102023_scripted.jmx" \
  -Jthreads_sample=$THREADS_SAMPLE \
  -Jrampup=$RAMPUP \
  -Jtestduration=$TESTDURATION \
  -l $RESULTS_FILE \
  -e -o $REPORT_DIR
