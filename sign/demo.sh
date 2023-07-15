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

clear
. $(dirname ${BASH_SOURCE})/../util.sh

desc "Let's push a simple artifact"
run "echo 'Hello World' > hello.txt"

desc "Lets push the file to the registry"
run "oras push localhost:5000/hello:latest \\
    --artifact-type application/example hello.txt"

desc "Let's generate a test cert"
run "notation cert generate-test --default 'wabbit-networks.io'"

desc "Let's view the keys"
run "notation key ls" 
run "notation cert ls"

export IMAGE=localhost:5000/hello@$(oras manifest get --descriptor localhost:5000/hello:latest | jq -r .digest)

run 'export IMAGE=localhost:5000/hello@$(oras manifest get --descriptor localhost:5000/hello:latest | jq -r .digest)'


desc "Let's sign the image: $IMAGE"
run "notation sign \$IMAGE"

desc "Let's view the signature"
run "notation ls \$IMAGE"

desc "Let's inspect the signature"
run "notation inspect \$IMAGE"