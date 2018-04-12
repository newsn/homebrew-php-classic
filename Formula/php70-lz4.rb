require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Lz4 < AbstractPhp70Extension
  init
  desc "Handles LZ4 de/compression"
  homepage "https://github.com/kjdev/php-ext-lz4"
  url "https://github.com/kjdev/php-ext-lz4/archive/0.2.3.tar.gz"
  sha256 "f484c8229b3c5af1385ce11e4b37999702757bad9bdb2eab8bfe48fa3f159904"
  head "https://github.com/kjdev/php-ext-lz4.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f335c9f58c5621848c7d2c3f5729364fb2045204507ccdb50b82413249ad869d" => :el_capitan
    sha256 "f1930b33464d83b322b1f48b10cd80376f2ae9109a1337189ed184d165bf67fe" => :yosemite
    sha256 "f7cde47d11347815ab81d93e04ee357a80a76ede0e2335306f7cb7a7cd4088e7" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/lz4.so"
    write_config_file if build.with? "config-file"
  end
end
