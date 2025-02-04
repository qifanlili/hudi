#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#

HUDI_FLINK_JAR=$1
$FLINK_HOME/bin/flink run -c \
org.apache.hudi.sink.compact.HoodieFlinkCompactor $HUDI_FLINK_JAR \
--path /tmp/hudi-flink-bundle-test \
--schedule

# validate
numCommits=$(ls /tmp/hudi-flink-bundle-test/.hoodie/*.commit | wc -l)
if [ $numCommits -gt 0 ]; then
  exit 0
else
  echo "::warning::compact.sh Failed to validate flink bundle: no commit file generated after running compaction."
  exit 1
fi
