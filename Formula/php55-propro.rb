require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Propro < AbstractPhp55Extension
  init
  desc "Reusable split-off of pecl_http's property proxy API."
  homepage "https://pecl.php.net/package/propro"
  url "https://github.com/m6w6/ext-propro/archive/release-1.0.2.tar.gz"
  sha256 "35b1d0881927049b3c7a14dc28306e2788f9b2bc937b1ef18e533a3bef8befce"

  bottle do
    cellar :any_skip_relocation
    sha256 "79f134603fca18ad75fdb6ea466154c0b4e28caf8c1f707387f9278bc9eed9c7" => :el_capitan
    sha256 "ccc1342447d47c7b301d8281b286b3deaf3b3d3a456edb3d3ce44879c0d2f489" => :yosemite
    sha256 "d3b9bf5008d527ca01f1e7576911d80b337d00b13df30b02c8dba5770b6dc54c" => :mavericks
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
