#!/bin/bash

JMETER_HOME=$1

THREADS_SAMPLE=20
RAMPUP=1
TESTDURATION=30

# Timestamp
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Main Result Folder
RESULT_DIR="results_$TIMESTAMP"

# Create folders
mkdir -p "$RESULT_DIR"

# Files
JTL_FILE="$RESULT_DIR/results.jtl"
LOG_FILE="$RESULT_DIR/jmeter.log"
HTML_REPORT="$RESULT_DIR/html-report"

echo "======================================="
echo "Starting JMeter Load Test"
echo "Result Folder : $RESULT_DIR"
echo "======================================="

"$JMETER_HOME/bin/jmeter.bat" -n \
  -t ORANGEHRM_WEB_APP_10102023_scripted.jmx \
  -l "$JTL_FILE" \
  -j "$LOG_FILE" \
  -e \
  -o "$HTML_REPORT" \
  -Jthreads_sample=$THREADS_SAMPLE \
  -Jrampup=$RAMPUP \
  -Jtestduration=$TESTDURATION

EXIT_CODE=$?

echo "======================================="
echo "JMeter Exit Code = $EXIT_CODE"
echo "======================================="

echo "REPORT_FOLDER=$RESULT_DIR" > report-location.properties

if [ $EXIT_CODE -ne 0 ]; then
    echo "JMeter Test Failed"
    exit $EXIT_CODE
fi

echo "Results stored in : $RESULT_DIR"
echo "======================================="

echo "Test Execution Completed"