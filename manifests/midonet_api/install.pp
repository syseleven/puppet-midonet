# == Class: midonet::midonet_api::install
# Check out the midonet::midonet_api class for a full understanding of
# how to use the midonet_api resource
#
# === Authors
#
# Midonet (http://midonet.org)
#
# === Copyright
#
# Copyright (c) 2015 Midokura SARL, All Rights Reserved.
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
#
class midonet::midonet_api::install inherits midonet::midonet_api{

    require midonet::repository
    require midonet::midonet_api::augeas

    if $midonet::midonet_api::install_java {
        $require = Class['java']
        if ! defined(Class['java']) {
          class {'java':
            distribution => 'jre',
            require      => Exec['update-midonet-repos']
          }
        }
    } else {
        $require = undef
    }


    class {'tomcat':
      install_from_source => false,
      require             => [$require,
                              Exec['update-midonet-repos']]
    } ->

    package {'midonet-api':
      ensure  => present,
    }
}
