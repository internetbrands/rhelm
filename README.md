# rhelm

Ruby wrapper around the [helm](helm.sh) binary. Pronounced "realm", because English is weird like that.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rhelm'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rhelm

## Usage

Usage of Rhelm is simple:

1. Configure a Rhelm::Client object with appropriate kubeconfig or API/token information so that you can talk to your k8s cluster
2. Using the client object, invoke subcommands such as "install", "upgrade", "status", etc.

### Creating the client

```ruby

require 'rhelm/client'

# Using kubeconfig
cli = Rhelm::Client.new(kubeconfig: '/home/someone/.kube/config')

# Using explicit API and token details
cli = Rhelm::Client.new(kube_apiserver: 'http://localhost:8080/api', kube_token: 'verysecret')
```

#### Logging
You can also pass a `logger:` kwarg. It should be an object that responds to `error`, `warn`, `info`, and `debug`. If you don't specify `logger:` then a default will be provided that logs to STDOUT at log level `info` and above. See [Rhelm::Client::SimpleLogger](lib/rhelm/client/simple_logger.rb)


### Invoking a subcommand

Subcommands such as `helm install`, `helm pull`, etc. can be invoked in one of two ways:

* Via subcommand proxy:

```ruby

cli = Rhelm::Client.new(kubeconfig: '/home/someone/.kube/config')
# .install creates a proxy to the ::Install subcommand; .run runs it
cli.install(
  'my-mysql-release',
  'bitnami/mysql',
  values: 'my-values.yml'
).run
```

* Via direct subcommand object creation:

```ruby
subcommand = Rhelm::Subcommand::Install.new(
  'my-mysql-release',
  'bitnami/mysql',
  kubeconfig: '/home/someone/.kube/config',
  values: 'my-values.yml'
)
subcommand.run
```

The difference between creating subcommands via proxy and creating subcommand objects directly is that in the proxy case, client constructor kwargs (especially those related to authentication) will automatically propagate to all subcommands created by proxy.

Non-kwarg arguments (such as `my-mysql-release` and `bitnami/mysql` in the example above) are passed as arguments to the underlying command without modification.

For a complete list of subcommands, look at the subclasses of [Rhelm::Subcommand](lib/rhelm/subcommand).

### Responding to helm exit status and output

When `.run` is called, the command is invoked and its exit status and stdout/stderr are captured. These are submitted to a callback for handling. You can provide a callback (as a block) to the `.run` call like this:

```ruby
Rhelm::Client.new(kubeconfig: 'kube.cfg')
             .install('my-release-name',
                      'some-chart-dir').run do |lines, status|
  if status == 0
    logger.info("helm install worked great!")
  elsif /timeout/im.match(lines)
    raise MyTimeoutError, "helm install timed out, oh no!"
  else
    # Use the built-in error reporting code to get more details
    report_failure(lines, status)
  end
end
```

This callback technique allows us to evaluate certain "error" conditions for semantic meaning and return more meaningful results instead of raising an error. See [Rhelm::Subcommand::Status#exists?](lib/rhelm/subcommand/status.rb) for example.

For some commands like `install` and `upgrade` that are not instant, you may want to wait until the entire command is completed before evaluating status. To do this, specify `helm` options to wait for completion using the `wait: true` and `timeout: timeref` kwargs for your subcommand. Otherwise you'll just get the exit status of the `helm` command that was submitted to the server and you'll need to poll (with the `::Status` subcommand) to find out whether the helm command actually succeeded.

### Specifying the helm binary to be used

```ruby
cli = Rhelm::Client.new(program: '/path/to/a/specific/helm/binary')
```

By default `helm` (with no path specification) will be used.

### Version Info

You can ask a client about the version of the `helm` binary it is using.

```ruby
2.7.1 :001 > cli = Rhelm::Client.new
2.7.1 :002 > cli.helm_version
 => "v3.4.2"
2.7.1 :003 > cli.helm_commit
 => "23dd3af5e19a02d4f4baa5b2f242645a1a3af629"
2.7.1 :004 > cli.helm_go_version
 => "go1.15.5"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/internetbrands/rhelm.
