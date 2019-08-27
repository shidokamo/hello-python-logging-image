# Copyright 2017 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM gcr.io/google-containers/debian-base-amd64:v1.0.0

COPY requirements.txt /

# 1. Install & configure dependencies.
# 2. Install fluentd via ruby.
# 3. Remove build dependencies.
# 4. Cleanup leftover caches & files.
RUN BUILD_DEPS="curl ca-certificates" \
    && clean-install $BUILD_DEPS \
                     python3 \
    && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python3 get-pip.py \
    && python3 -m pip install -r requirements.txt \
    && apt-get purge -y --auto-remove \
                     -o APT::AutoRemove::RecommendsImportant=false \
                     $BUILD_DEPS \
    && rm -rf /tmp/* \
              /var/lib/apt/lists/* \
              /var/log/* \
              /var/tmp/*

# Copy the Fluentd configuration file for logging Docker container logs.
COPY hello.py /hello.py

# Start Fluentd to pick up our config that watches Docker container logs.
CMD LOD_INTERVAL=1 python3 /hello.py
