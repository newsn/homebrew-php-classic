require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Svm < AbstractPhp54Extension
  init
  desc "Support Vector Machine Library"
  homepage "http://php.net/manual/en/book.svm.php"
  url "https://github.com/ianbarber/php-svm/archive/0.1.9.tar.gz"
  sha256 "c3dabf7220766193fcb87514559e89c1a9ec0017f510fc58cb98b3ac52819734"
  head "https://github.com/ianbarber/php-svm.git"

  bottle do
    cellar :any
    sha256 "c079d2787028aa4b469d1bbf9b3bef7e9394c64406cb052a0db1d53ab1828f01" => :el_capitan
    sha256 "6579c189db2865acfca64186e9d8401e690ea886593155d7079515446692eb18" => :yosemite
    sha256 "8dd2d44c60e733b7bdda485f7810c577f9560d68d5097fb20a3af183fc07eef3" => :mavericks
  end

  depends_on "libsvm"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize

    ENV["CFLAGS"] = "-Wno-return-type"

    args = []
    args << "--with-svm==#{Formula["libsvm"].opt_prefix}"
    args << "--prefix=#{prefix}"
    args << phpconfig

    system "./configure", *args
    system "make"
    prefix.install "modules/svm.so"
    write_config_file if build.with? "config-file"
  end
end
