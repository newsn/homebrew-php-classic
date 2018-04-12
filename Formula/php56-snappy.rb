require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Snappy < AbstractPhp56Extension
  init
  desc "Snappy Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-snappy"
  url "https://github.com/kjdev/php-ext-snappy/archive/db3abe6ef6b0e74c8deed0f285cdc9d8cff094ef.tar.gz"
  sha256 "4d1acaad08eacaa108618c6c765fe2d8da82c2f09f8996036e8bccb5438ebd61"
  version "0.1.0"

  bottle do
    cellar :any_skip_relocation
    sha256 "26dd9dd91d28c3e14fa97bb2b20cac212d7fa5194a68c0cf65eefea9faba55a7" => :el_capitan
    sha256 "0b7d05acb9dc67979ad0391931c42e16de489d976b6b63e6f667d22a38508b24" => :yosemite
    sha256 "b47fb6352f2206ed37f874e7bc9409d614092c5052b64e1809cc0a071c7ac9dd" => :mavericks
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
