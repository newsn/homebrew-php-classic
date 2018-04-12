require "formula"
require File.join(File.dirname(__FILE__), "../Requirements/php-meta-requirement")
require File.join(File.dirname(__FILE__), "../Requirements/phar-requirement")

class AbstractPhpPhar < Formula
  def initialize(*)
    super
  end

  def self.init
    depends_on PhpMetaRequirement
    depends_on PharRequirement
  end

  def phar_file
    class_name = self.class.name.split("::").last
    class_name.downcase + ".phar"
  end

  def phar_bin
    class_name = self.class.name.split("::").last
    class_name.downcase
  end

  def phar_wrapper
    <<~EOS
      #!/usr/bin/env bash
      /usr/bin/env php -d allow_url_fopen=On -d detect_unicode=Off #{libexec}/#{@real_phar_file} "$@"
    EOS
  end

  def install
    if phar_file == phar_bin
      @real_phar_file = phar_file + ".phar"
      File.rename(phar_file, @real_phar_file)
    else
      @real_phar_file = phar_file
    end

    libexec.install @real_phar_file
    (libexec/phar_bin).write phar_wrapper
    chmod 0755, (libexec/phar_bin)
    bin.install_symlink (libexec/phar_bin)
  end

  test do
    which phar_bin
  end
end
