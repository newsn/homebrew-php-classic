require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Propro < AbstractPhp53Extension
  init
  desc "Reusable split-off of pecl_http's property proxy API."
  homepage "https://pecl.php.net/package/propro"
  url "https://github.com/m6w6/ext-propro/archive/release-1.0.2.tar.gz"
  sha256 "35b1d0881927049b3c7a14dc28306e2788f9b2bc937b1ef18e533a3bef8befce"
  revision 2

  bottle do
    cellar :any_skip_relocation
    sha256 "3c45d0280d1ae3d7abefaec0eb64339d855105a772559037bde9fb5204633181" => :el_capitan
    sha256 "271efc90b53d5fabdf300b6c2f389ab90fb27b0105393202d0eacec5d99c3934" => :yosemite
    sha256 "d89a3e71dfaf3a9cef70660ec3e998798fc5461e04d932e9520f508268545258" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    include.install %w[php_propro.h src/php_propro_api.h]
    prefix.install "modules/propro.so"
    write_config_file if build.with? "config-file"
  end
end
