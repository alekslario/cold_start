#!/bin/bash

k6 run -e FUNCTION_URL="$(terraform output -raw function_url)" test.js