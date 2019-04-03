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
import logging
"""Creates the App Engine."""

def GenerateConfig(context):
    """Creates the App Engine with single templates."""
    resources = []

    AppendResourceOb(context, resources)

    return {'resources': resources}

def AppendResourceOb(context, resources):
    """Add Json objectd to Resource List."""
    deployment_type = context.properties['deployment_type']
    
    if deployment_type == 'F':
            resources.append({
                'name': context.properties['version'],
                'type': 'appengine.v1.version',
                'properties': {
                    'deployment': {
                        'files': {
                            'main.py': {
                                'source_url': context.properties['path']
                            }
                        }
                    },
                    'servicesId': 'default',
                    'appsId': context.properties['project'],
                    'handlers': [{
                        'script': {
                           'scriptPath': 'main.app'
                        },
                        'securityLevel': 'SECURE_OPTIONAL',
                        'urlRegex': '/'
                    }],
                    'runtime': context.properties['runtime'],
                    'threadsafe': True,
                    'zones': [
                         context.properties['zone']
                    ]
                }
            })
    elif deployment_type == 'CT':
            resources.append({
                'name': context.properties['version'],
                'type': 'appengine.v1.version',
                'properties': {
                    'deployment': {
                        'container': {
                            'image': context.properties['path']
                        }
                    },
                    'servicesId': 'default',
                    'appsId': context.properties['project'],
                    'handlers': [{
                        'script': {
                           'scriptPath': 'main.app'
                        },
                        'securityLevel': 'SECURE_OPTIONAL',
                        'urlRegex': '/'
                    }],
                    'runtime': context.properties['runtime'],
                    'threadsafe': True,
                    'zones': [
                         context.properties['zone']
                    ],
                    'env': 'flex'
                }
            })
    elif deployment_type == 'Z':
            print("Z");
    elif deployment_type == 'CBO':
            print("CBO");
    else:
        logging.log(50, 'deployment_type error')
        exit()
