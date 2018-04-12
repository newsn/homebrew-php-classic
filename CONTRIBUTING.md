# Contributing

First time contributing to Homebrew? Read the main Contribution Guide: [Contribution](https://github.com/Homebrew/homebrew-core/blob/master/CONTRIBUTING.md#contributing-to-homebrew)

The following kinds of brews are allowed:

- PHP Extensions: they may be built with PECL, but installation via Homebrew is sometimes much easier.
- PHP Utilities: php-version, php-build fall under this category.
- Common PHP Web Applications: phpMyAdmin goes here. Note that WordPress would not qualify because it requires other migration steps, such as database migrations etc.
- PHP Frameworks: these are to be reviewed on a case-by-case basis. Generally, only a recent, stable version of a popular framework will be allowed.

If you have any concerns as to whether your formula belongs in PHP, just open a pull request with the formula and we'll take it from there.

## Things to note

Phars are generally favoured wherever possible.

You can generate a SHA (SHA256 favoured) for your formula by doing the following:

`curl -LO http://path/to/your/file.phar`

`shasum -a 256 file.phar`

You don't need to add a `bottle` section, as the brew bot will generate the bottles and add that in later.

## File structure

Please look at existing formulas for examples of how to structure yours.
There are abstract classes such as `AbstractPhpPhar` you should extend which will help take care of a lot of boilerplate stuff for you.

## PHP Extension definitions

PHP Extensions MUST be prefixed with `phpVERSION`. For example, instead of the `Solr` formula for PHP56 in `solr.rb`, we would have `Php56Solr` inside of `php56-solr.rb`. This is to remove any possible conflicts with mainline Homebrew formulae.

The template for the `php56-example` pecl extension would be as follows. Please use it as an example for any new extension formulae:

```ruby
require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Example < AbstractPhp56Extension
  init
  desc "Concise description of example package"
  homepage "https://pecl.php.net/package/example"
  url "https://pecl.php.net/get/example-1.0.tgz"
  sha256 "SOMEHASHHERE"
  version "1.0"
  head "https://svn.php.net/repository/pecl/example/trunk", :using => :svn

  def install
    Dir.chdir "example-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/example.so"
    write_config_file unless build.include? "without-config-file"
  end
end
```

Before finalizing the extension, run the command `brew audit --strict --online ` to check that your formula respects Homebrew best practice and syntax.

Defining extensions inheriting AbstractPhp(54,55,56,70,71). Extension will provide a `write_config_file` which add `ext-{extension}.ini` to `conf.d`, don’t forget to remove it manually upon extension removal. Please see [abstract-php-extension.rb](Abstract/abstract-php-extension.rb) for more details.

Please note that your formula installation may deviate significantly from the above; caveats should more or less stay the same, as they give explicit instructions to users as to how to ensure the extension is properly installed.

The ordering of formula attributes, such as the `desc`, `homepage`, `url`, `sha256`, etc. should follow the above order for consistency. The `version` is only included when the URL does not include a version in the filename. `head` installations are not required.

All official PHP extensions should be built for all stable versions of PHP included in `homebrew-php`. These versions are `5.5`, `5.6`, `7.0`, and `7.1`.
