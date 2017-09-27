#!/usr/bin/env python
# Copyright 2017 Petr Horacek
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import errno
import sys

lines = sys.stdin.readlines()

list_parsed = []
for l in lines:
    try:
        time, lnum, script, cmd = l.strip().split(' ', 3)
        time = float(time)
    except:
        continue
    list_parsed.append([time, lnum, script, cmd])

time_sum = 0
list_with_delta = []
for i, l in enumerate(list_parsed):
    if i == len(list_parsed) - 1:
        continue
    delta = list_parsed[i+1][0] - l[0]
    time_sum += delta
    relative = delta / time_sum
    list_with_delta.append([delta, l[1], l[2], l[3]])

list_with_relative = []
for delta, line, script, line in list_with_delta:
    relative = (delta / time_sum) * 100
    list_with_relative.append([relative, delta, line, script, line])

list_sorted = sorted(list_with_relative, key=lambda x: x[1], reverse=True)

for relative, delta, line_n, script, line in list_sorted:
    try:
        sys.stdout.write('[{:5.2f}% {:3.5f}s {}:{}] {}\n'.format(
            relative, delta, script, line_n, line))
    except IOError as e:
        if e.errno == errno.EPIPE:
            break
