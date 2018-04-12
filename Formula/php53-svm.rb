require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Svm < AbstractPhp53Extension
  init
  desc "Support Vector Machine Library"
  homepage "http://php.net/manual/en/book.svm.php"
  url "https://github.com/ianbarber/php-svm/archive/0.1.9.tar.gz"
  sha256 "c3dabf7220766193fcb87514559e89c1a9ec0017f510fc58cb98b3ac52819734"
  head "https://github.com/ianbarber/php-svm.git"

  bottle do
    cellar :any
    sha256 "53cd7d02afd4772f1a39ef4380d0ea5fb36aa5d7540d6a2b7087396a7443db74" => :el_capitan
    sha256 "9abe9607267af7a286d2761ac530402fee53f91c1b58ab362da72c2ead3ccce8" => :yosemite
    sha256 "3730810e8523c48372375cecf8fe9b80c98d2acb6ff3d971e3be034f00cc7bb5" => :mavericks
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
