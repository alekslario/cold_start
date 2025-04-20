#!/bin/bash

k6 run -e FUNCTION_URL="$(terraform output -raw url)" --vus 1 --iterations 10 test.js