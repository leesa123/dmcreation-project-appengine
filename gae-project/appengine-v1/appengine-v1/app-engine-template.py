# Copyright 2016 Google Inc. All rights reserved.
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

"""Creates the App Engine."""


def GenerateConfig(context):
  """Creates the App Engine with multiple templates."""

  resources = [{
      'name': 'app-engine-fir',
      'type': 'gae-template.py',
      'properties': {
        'project': context.properties['project'],
        'zone': context.properties['zone'],
        'runtime': context.properties['runtime'],
        'version': context.properties['version'],
        'path': context.properties['path'],
        'deployment_type': context.properties['deployment_type']
      }

  }]
  return {'resources': resources}
