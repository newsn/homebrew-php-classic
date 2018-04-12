require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Runkit < AbstractPhp53Extension
  init
  desc "Extension to modify consts/functions/classes"
  homepage "http://php.net/manual/en/book.runkit.php"
  url "https://github.com/zenovich/runkit/archive/27f33f55eae4459448fc39fac49daba26bb6b575.tar.gz"
  sha256 "4b19ca9d4003eac6af51dd3b6b8e4365a74351a4fd248f2fe5c546b656a16a99"
  head "https://github.com/zenovich/runkit.git"
  version "5e179e9"

  bottle do
    cellar :any_skip_relocation
    sha256 "a12a2f86946ab515566107cbd39020862d2b33614cad90bdfad786254053d781" => :el_capitan
    sha256 "1607911717759300ba47524a40deacb6982b1cb19d40453d9126f8edf2aefbca" => :yosemite
    sha256 "2f5cb09c5ea9d148d602e63b36e297c8f2cd71565374aadcef812d102d40705a" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/runkit.so"
    write_config_file if build.with? "config-file"
  end
end
