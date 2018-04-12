require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71LibsodiumAT10 < AbstractPhp71Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/1.0.7.tar.gz"
  sha256 "b66c795fa39909eccbc4310e6e9700230e5ad9e8e9d7fcf79bb344dbf9d2f905"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    sha256 "3f6bc58dab3af209067b78178080cd70ee7ff0cb8c0c4dd3bafce1568f923030" => :high_sierra
    sha256 "2f6b03a3b148d30bbeebf8e48c163b46b7f1ab2561f3e759d446f0eeb1f08073" => :sierra
    sha256 "04e3083372da6bc9a695602ce97262cf3013cf50033e0992f0366057238f224e" => :el_capitan
  end

  depends_on "libsodium"

  def extension
    "libsodium"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/libsodium.so"
    write_config_file if build.with? "config-file"
  end
end
