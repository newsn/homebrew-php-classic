require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Ds < AbstractPhp70Extension
  init
  desc "Data Structures for PHP"
  homepage "https://github.com/php-ds/extension"
  url "https://github.com/php-ds/extension/archive/v1.2.4.tar.gz"
  sha256 "c080bb08445fe690da2271ff866602cf27cadee529ab1a1edbf4aa7a1d6e104c"
  head "https://github.com/php-ds/extension.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "276d01f139891bf0bf2ed730532ea1bd8f3f7851812d4b632d1aa5d2a7781290" => :high_sierra
    sha256 "2c951fc9321b29dfaa07d086521c75b8e7cdae9cd93908bc04eb8bc58550e8e9" => :sierra
    sha256 "8d5cc829a6792825a3ce437b430570f4a63536c64db23a15cc993f90e4c0e78b" => :el_capitan
  end

  def install
    safe_phpize

    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"

    prefix.install "modules/ds.so"
    write_config_file if build.with? "config-file"
  end
end
