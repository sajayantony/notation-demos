#!/bin/bash
# MiIT License
# 
# Copyright (c) 2023 Sajay Antony
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


. $(dirname ${BASH_SOURCE})/util.sh

desc "Build the demo image"
run "docker build -t notation-demo ."

desc "Create docker network"
run "docker network create notation-network"

desc "Setup a demo registry on port 5000"
run "docker run \\
    --network=notation-network \\
    -d -p 5000:5000 --name 'notation-registry' \\
    ghcr.io/project-zot/zot-minimal-linux-amd64:latest"

run "docker run --rm -it --network=notation-network \\
    -v $(pwd):/notation-demos \\
    -e DEMO_RUN_FAST=${DEMO_RUN_FAST} \\
    -e DEMO_AUTO_RUN=${DEMO_AUTO_RUN} \\
    notation-demo"

