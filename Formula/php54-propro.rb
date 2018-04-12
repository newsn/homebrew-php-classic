require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Propro < AbstractPhp54Extension
  init
  desc "Reusable split-off of pecl_http's property proxy API."
  homepage "https://pecl.php.net/package/propro"
  url "https://github.com/m6w6/ext-propro/archive/release-1.0.2.tar.gz"
  sha256 "35b1d0881927049b3c7a14dc28306e2788f9b2bc937b1ef18e533a3bef8befce"

  bottle do
    cellar :any_skip_relocation
    sha256 "11d9e1387ffdb5a02f9131e044e07c13a644cfd7eee14d4cb708346565cd89ff" => :el_capitan
    sha256 "8044a4f804a66419b14fe09b6ab7d3f048aa4ceb7053bc86c1e23314cfdeab58" => :yosemite
    sha256 "66e1195e26c9eb5bb3226bd81530b384ca75c400d75d7d0e743aaf7268dc854f" => :mavericks
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
