require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Snappy < AbstractPhp53Extension
  init
  desc "Snappy Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-snappy"
  url "https://github.com/kjdev/php-ext-snappy/archive/db3abe6ef6b0e74c8deed0f285cdc9d8cff094ef.tar.gz"
  sha256 "4d1acaad08eacaa108618c6c765fe2d8da82c2f09f8996036e8bccb5438ebd61"
  version "0.1.0"

  bottle do
    cellar :any_skip_relocation
    sha256 "bc225ccd6ff9687c5204674282a62956ca1de1b977e2975914eb9de4b001eb92" => :el_capitan
    sha256 "b5b5361fa34017d13dd35a5080027e36afa05fbd833645a978e46d501abd62f9" => :yosemite
    sha256 "1ad43d691df79e94689fbe1acd1778517e7624648560ddd0404eb1e5f346dadb" => :mavericks
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
