#!/bin/bash

JMETER_HOME=$1
REPORT_NAME=$2

THREADS_SAMPLE=20
RAMPUP=1
TESTDURATION=30

# Result Folder
RESULT_DIR="results-history/results_${REPORT_NAME}"

# Create folder
mkdir -p "$RESULT_DIR"

# Files
JTL_FILE="$RESULT_DIR/results.jtl"
LOG_FILE="$RESULT_DIR/jmeter.log"
HTML_REPORT="$RESULT_DIR/html-report"

echo "======================================="
echo "Starting JMeter Load Test"
echo "Threads        : $THREADS_SAMPLE"
echo "Rampup         : $RAMPUP"
echo "Duration       : $TESTDURATION"
echo "Report Name    : $REPORT_NAME"
echo "Result Folder  : $RESULT_DIR"
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

if [ $EXIT_CODE -ne 0 ]; then
    echo "JMeter Test Failed"
    exit $EXIT_CODE
fi

echo "Results stored in : $RESULT_DIR"
echo "HTML Report       : $HTML_REPORT/index.html"
echo "======================================="

echo "Test Execution Completed"