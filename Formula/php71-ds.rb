require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Ds < AbstractPhp71Extension
  init
  desc "Data Structures for PHP"
  homepage "https://github.com/php-ds/extension"
  url "https://github.com/php-ds/extension/archive/v1.2.4.tar.gz"
  sha256 "c080bb08445fe690da2271ff866602cf27cadee529ab1a1edbf4aa7a1d6e104c"
  head "https://github.com/php-ds/extension.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "c89e61dc09f33d2edafd9b135cb04b6159f17122ee668c6a10b50892b216d80a" => :high_sierra
    sha256 "13abcef229a9f1e73fcfc0dd76cf817de6398a81c23dc8de6a6ce37d51f7a411" => :sierra
    sha256 "ec2b0ea8b63c2d4349e87e8a87e9985a01c415143c812327dc39313019eb1fb2" => :el_capitan
  end

  def install
    safe_phpize

    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"

    prefix.install "modules/ds.so"
    write_config_file if build.with? "config-file"
  end
end
