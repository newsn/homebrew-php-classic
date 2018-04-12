require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Ref < AbstractPhp72Extension
  init
  desc "Soft and Weak references support for PHP"
  homepage "https://github.com/pinepain/php-ref"
  url "https://github.com/pinepain/php-ref/archive/v0.5.0.tar.gz"
  sha256 "0fd928fd8314f836a97e3833d6c5e15658202d05fe3a0725d793f6e06394cd97"
  head "https://github.com/pinepain/php-ref.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "32c786c1f4e4410a031c875f25aa78e5ebb013fa15c705c6d62bcc782f81b121" => :high_sierra
    sha256 "4486f1171fc14f4f1e64b96305a74372ffb2c00f1d3da9733a1c00f3602249a6" => :sierra
    sha256 "5b789bbb7bccd0bd8a6553185d18742d75c03d6aea704e221c394687d8ae5b0f" => :el_capitan
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/ref.so"
    write_config_file if build.with? "config-file"
  end
end
