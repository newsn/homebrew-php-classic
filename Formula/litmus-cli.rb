require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class LitmusCli < AbstractPhpPhar
  init
  desc "Command-line interface for Litmus email testing service"
  homepage "https://git.dev-digitalmobil.com/klaus/litmus-cli"
  url "https://git.dev-digitalmobil.com/klaus/litmus-cli/builds/13076/artifacts/file/build/litmus-cli.phar"
  version "0.3.2"
  sha256 "d2bcfe00bf5adabfbaa9798f8accda0f8ced37c8cba282b1e588b75c9a656564"

  bottle :unneeded

  def phar_file
    "litmus-cli.phar"
  end

  def phar_bin
    "litmus-cli"
  end

  test do
    system "#{bin}/litmus-cli", "--version"
  end

  # The default behavior is to create a shell script that invokes the phar file.
  # Other tools, at least Ansible, expect the composer executable to be a PHP
  # script, so override this method. See
  # https://github.com/Homebrew/homebrew-php/issues/3590
  def phar_wrapper
    <<~EOS
      #!/usr/bin/env php
      <?php
      array_shift($argv);
      $arg_string = implode(' ', array_map('escapeshellarg', $argv));
      $arg_string .= preg_match('/--(no-)?ansi/', $arg_string) ? '' : ' --ansi';
      passthru("/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/#{@real_phar_file} $arg_string", $return_var);
      exit($return_var);
    EOS
  end
end
