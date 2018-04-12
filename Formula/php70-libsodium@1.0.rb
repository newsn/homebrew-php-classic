require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70LibsodiumAT10 < AbstractPhp70Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/1.0.7.tar.gz"
  sha256 "b66c795fa39909eccbc4310e6e9700230e5ad9e8e9d7fcf79bb344dbf9d2f905"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    sha256 "10783c6ad63a6937b0efc6f8af156da5f7df6e918e0c80612b4211b12b8611cb" => :high_sierra
    sha256 "9fcb8ead9a0c706fd66f805d33879dd0393c8f655949bad15ca997c88a31ccf7" => :sierra
    sha256 "07c60eb2ea08e3cd95ff1fc39d7ed2b4f24abd8606039c028f07232c21ba776a" => :el_capitan
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
