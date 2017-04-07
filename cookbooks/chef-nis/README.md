# chef-nis

Chef cookbook to configure a node for authentication via NIS.  By default, all
users listed in the NIS passwd file will be granted access to the host. However,
the cookbook allows access to be restricted to specific users, groups, or
members of one or more netgroups.

## Supported Platforms

* Ubuntu (tested on 12.04 and 14.04)
* CentOS (tested on 6.5)

## Dependencies

This cookbook depends on the following cookbooks:

* `nsswitch` (https://github.com/jeffshantz/chef-nsswitch)

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>domain</tt></td>
    <td>String</td>
    <td>The NIS domain to join</td>
    <td><tt>yourdomain.com</tt></td>
  </tr>
  <tr>
    <td><tt>servers</tt></td>
    <td>Array of hashes</td>
    <td>
      <p>
        Array of NIS servers for the domain.  If left empty, NIS will resort
        to a broadcast call to find a server for the domain.  Both the IP and
        hostname should be given for each server:
      </p>
      <pre><code>"nis": {
  "servers": [
    { 
      "hostname": "nis1.yourdomain.com",
      "ip": "1.1.1.1"
    },
    {
      "hostname": "nis2.yourdomain.com",
      "ip": "2.2.2.2"
    }
  ]
}</code></pre>
      <p>
        The IP address for each server will be used in <tt>/etc/yp.conf</tt> 
        since binding errors can occur if hostnames are used and DNS is not
        yet available.
     </p>
     <p>
       The hostname is added as a comment in <tt>/etc/yp.conf</tt> for each
       server listing, just to remind you which servers are which.  In the
       future, the recipe could be modified to automatically look up the 
       IP of the server given the hostname, but this was decided against
       in case of a DNS failure at the time the cookbook is deployed.
     </p>
    </td>
    <td><tt>[]</tt> <em>(no servers -- use broadcast)</em></td>
  </tr>
  <tr>
    <td><tt>restricted_to</tt></td>
    <td>Array of strings</td>
    <td>
      <p>
        Used to restrict access to the server by username and/or netgroup.  
        Users should be specified by username.  Netgroups should be 
        specified by <tt>@GROUPNAME</tt> syntax.  For example, to restrict 
        access to the server to the user <tt>jeff</tt> and all members of the
        netgroup <tt>Usysgrp</tt>, you would use the following in the node's
        configuration:
      </p>
      <pre><code>"nis": {
  "restricted_to": ["jeff", "@Usysgrp"]
}</code></pre>
      <p>
        For background information, see the <strong>Compatibility 
        mode (compat)</strong> section in <tt>man nsswitch.conf</tt> on a Linux
        system.
      </p>
    </td>
    <td><tt>[]</tt> <em>(unrestricted access)</em></td>
  </tr>
</table>

## Usage

### nis::default

Include `nis` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[nis::default]"
  ]
}
```

Configure your domain and NIS servers:

```json
{
  "default_attributes": {
    "nis": {
      "domain": "yourdomain.com",
      "servers": [
        { 
          "hostname": "nis1.yourdomain.com",
          "ip": "1.1.1.1"
        },
        {
          "hostname": "nis2.yourdomain.com",
          "ip": "2.2.2.2"
        }
      ],
      "restricted_to": [
        "jeff",
        "@Usysgrp"
      ]
    }
  }
}
```

If the NIS servers are not specified, then NIS will resort to a broadcast to
find an NIS server to which it can bind.

If `restricted_to` is not specified, all valid NIS users will have access to the
host.

## Testing

Be sure that you've run `bundle` before attempting to run any of the
following commands.

Unit tests can be run with RSpec:

```bash
$ cd nis
$ rspec
```

While developing, however, you'll want to run Guard to have it
automatically run the unit tests each time a file is changed:

```bash
$ cd nis
$ guard
```

To run integration tests:

```bash
$ cd nis
$ kitchen test
```

Note, however, that you will need to comment out the lines with `FIXME` comments
in the integration tests (within `test/integration`) as these apply to one
specific infrastructure and will not work in your infrastructure.

Also, you'll need to have VirtualBox and Vagrant installed.

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Author:: Jeff Shantz (<jeff@csd.uwo.ca>)

```text
Copyright:: 2014, Western University

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
