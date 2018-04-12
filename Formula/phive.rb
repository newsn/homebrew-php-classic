require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Phive < AbstractPhpPhar
  init
  desc "Installation and verification of phar distributed PHP applications"
  homepage "https://phar.io"
  url "https://github.com/phar-io/phive/releases/download/0.9.0/phive-0.9.0.phar"
  sha256 "99e8bb7fc7af21b5d37aabdd253ad4afec16800bc6cbb82d0786cf7ecf7ec1de"
  head "https://phar.io/releases/phive.phar"

  bottle :unneeded

  def phar_bin
    "phive"
  end

  def phar_file
    "phive-#{version}.phar"
  end

  test do
    system bin/"phive", "version"
  end

  def phar_wrapper
    <<~EOS
      #!/usr/bin/env php
      <?php
      array_shift($argv);
      $arg_string = implode(' ', array_map('escapeshellarg', $argv));
      passthru("/usr/bin/env php -d detect_unicode=Off #{libexec}/#{@real_phar_file} $arg_string", $return_var);
      exit($return_var);
    EOS
  end
end
