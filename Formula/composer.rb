require File.expand_path("../../Abstract/abstract-php-phar", __FILE__)

class Composer < AbstractPhpPhar
  desc "Dependency Manager for PHP"
  homepage "https://getcomposer.org"
  url "https://getcomposer.org/download/1.6.3/composer.phar"
  sha256 "52cb7bbbaee720471e3b34c8ae6db53a38f0b759c06078a80080db739e4dcab6"
  head "https://getcomposer.org/composer.phar"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "cd7d7688f5c54609012418e9f3f6e8e19d66428dbb3ef959f52b0257770571a3" => :high_sierra
    sha256 "cd7d7688f5c54609012418e9f3f6e8e19d66428dbb3ef959f52b0257770571a3" => :sierra
    sha256 "cd7d7688f5c54609012418e9f3f6e8e19d66428dbb3ef959f52b0257770571a3" => :el_capitan
  end

  depends_on PharRequirement

  test do
    system "#{bin}/composer", "--version"
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
      $arg_prefix = preg_match('/--(no-)?ansi/', $arg_string) ? '' : '--ansi ';
      $arg_string = $arg_prefix . $arg_string;
      passthru("/usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/#{@real_phar_file} $arg_string", $return_var);
      exit($return_var);
    EOS
  end

  def caveats
    <<-EOS
      composer no longer depends on the homebrew php formulae, since the last couple of macOS releases
      contain a php version compatible with composer. If you were previously relying on the composer
      formula to install php, please `brew install php71` or other appropriate Homebrew PHP version.
    EOS
  end
end
