# chef-nsswitch

Chef cookbook to manage the Name Service Switch (`/etc/nsswitch.conf`).

## Supported Platforms

* Ubuntu (tested on 14.04)
* CentOS (tested on 6.5)

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>passwd</tt></td>
    <td>String</td>
    <td>User passwords, used by <tt>getpwent(3)</tt> functions</td>
    <td><tt>files</tt></td>
  </tr>
  <tr>
    <td><tt>group</tt></td>
    <td>String</td>
    <td>Groups of users, used by <tt>getgrent(3)</tt> functions</td>
    <td><tt>files</tt></td>
  </tr>
  <tr>
    <td><tt>shadow</tt></td>
    <td>String</td>
    <td>Shadow user passwords, used by <tt>getspnam(3)</tt></td>
    <td><tt>files</tt></td>
  </tr>
  <tr>
    <td><tt>hosts</tt></td>
    <td>String</td>
    <td>Host names and numbers, used by <tt>gethostbyname(3)</tt> and similar functions</td>
    <td><tt>files dns</tt></td>
  </tr>
  <tr>
    <td><tt>networks</tt></td>
    <td>String</td>
    <td>Network names and numbers, used by <tt>getnetent(3)</tt> functions</td>
    <td><tt>files</tt></td>
  </tr>
  <tr>
    <td><tt>protocols</tt></td>
    <td>String</td>
    <td>Network protocols, used by <tt>getprotoent(3)</tt> functions</td>
    <td><tt>db files</tt></td>
  </tr>
  <tr>
    <td><tt>services</tt></td>
    <td>String</td>
    <td>Network services, used by <tt>getservent(3)</tt> functions</td>
    <td><tt>db files</tt></td>
  </tr>
  <tr>
    <td><tt>ethers</tt></td>
    <td>String</td>
    <td>Ethernet numbers</td>
    <td><tt>db files</tt></td>
  </tr>
  <tr>
    <td><tt>rpc</tt></td>
    <td>String</td>
    <td>Remote procedure call names and numbers, used by <tt>getrpcbyname(3)</tt> and similar functions</td>
    <td><tt>db files</tt></td>
  </tr>
  <tr>
    <td><tt>netgroup</tt></td>
    <td>String</td>
    <td>Network-wide list of hosts and users, used for access rules</td>
    <td><tt>nis</tt></td>
  </tr>
  <tr>
    <td><tt>automount</tt></td>
    <td>String</td>
    <td>NFS automounter maps</td>
    <td><tt>files</tt></td>
  </tr>
  <tr>
    <td><tt>aliases</tt></td>
    <td>String</td>
    <td>Mail aliases, used by <tt>getaliasent(3)</tt> and related functions</td>
    <td><tt>files</tt></td>
  </tr>
</table>

## Usage

### nsswitch::default

Include `nsswitch` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[nsswitch::default]"
  ]
}
```

Configure the attributes as desired:

```json
{
  "default_attributes": {
    "nsswitch": {
      "passwd": "compat",
      "shadow": "compat"
    }
  }
}
```

See the `nsswitch.conf(5)` man page for details of the allowed values.

**Note**: If you are using a cookbook like `nis`, the appropriate `nsswitch`
attributes will be set by that cookbook.  You do not need to specify these
attributes manually.

## Testing

Be sure that you've run `bundle` before attempting to run any of the
following commands.

Unit tests can be run with RSpec:

```bash
$ cd nsswitch
$ rspec
```

While developing, however, you'll want to run Guard to have it
automatically run the unit tests each time a file is changed:

```bash
$ cd nsswitch
$ guard
```

To run integration tests:

```bash
$ cd nsswitch
$ kitchen test
```

You'll need to have VirtualBox and Vagrant installed.

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
