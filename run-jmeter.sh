#!/bin/bash

# First argument is JMeter installation path
JMETER_HOME=$1
echo "JMETER_HOME=$JMETER_HOME"

# Test parameters
THREADS_SAMPLE=10
echo "THREADS_SAMPLE=$THREADS_SAMPLE"

RAMPUP=10
echo "RAMPUP=$RAMPUP"

TESTDURATION=300
echo "TESTDURATION=$TESTDURATION"

echo "Starting JMeter Load test.."

# Run JMeter in non-GUI mode with properties
"$JMETER_HOME/bin/jmeter" -n \
  -t ORANGEHRM_WEB_APP_10102023_scripted.jmx \
  -Jthreads_sample=$THREADS_SAMPLE \
  -Jrampup=$RAMPUP \
  -Jtestduration=$TESTDURATION
