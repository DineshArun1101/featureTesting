#!/bin/bash

JMETER_HOME=$1
WORKSPACE=$(pwd)

THREADS_SAMPLE=1
RAMPUP=1
TESTDURATION=1

echo "Starting JMeter Load test.."

cd "$WORKSPACE"

"$JMETER_HOME/bin/jmeter" -n \
  -t ORANGEHRM_WEB_APP_10102023_scripted.jmx \
  -Jthreads_sample=$THREADS_SAMPLE \
  -Jrampup=$RAMPUP \
  -Jtestduration=$TESTDURATION \
  -j "$WORKSPACE/jmeter.log"

echo "=== JMeter log output ==="
cat "$WORKSPACE/jmeter.log"
