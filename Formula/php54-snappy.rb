require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Snappy < AbstractPhp54Extension
  init
  desc "Snappy Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-snappy"
  url "https://github.com/kjdev/php-ext-snappy/archive/db3abe6ef6b0e74c8deed0f285cdc9d8cff094ef.tar.gz"
  sha256 "4d1acaad08eacaa108618c6c765fe2d8da82c2f09f8996036e8bccb5438ebd61"
  version "0.1.0"

  bottle do
    cellar :any_skip_relocation
    sha256 "72bce2b968a281e125e81f2243dd91fc9c49e323a454db1e2e87ce2766141db1" => :el_capitan
    sha256 "9680b67b3b696327299d47af4cdf9cc242d9f256b9da90d3dbd047ca9ccd7432" => :yosemite
    sha256 "9ab0456a87076606df7126b6d9b4fbef0edbf4182c1cc2a6f4480510b333f54e" => :mavericks
  end

  depends_on "snappy"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/snappy.so"
    write_config_file if build.with? "config-file"
  end
end
