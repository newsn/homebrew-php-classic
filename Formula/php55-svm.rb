require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Svm < AbstractPhp55Extension
  init
  desc "Support Vector Machine Library"
  homepage "http://php.net/manual/en/book.svm.php"
  url "https://github.com/ianbarber/php-svm/archive/0.1.9.tar.gz"
  sha256 "c3dabf7220766193fcb87514559e89c1a9ec0017f510fc58cb98b3ac52819734"
  head "https://github.com/ianbarber/php-svm.git"

  bottle do
    cellar :any
    sha256 "ee7d128ded9166def63057616f7cdb25e2e2fb5af58c66406582c85903783bc9" => :el_capitan
    sha256 "1e8a5f1c16d27fe4de680c76e9d614f0878038d69c1b1932525ee69365157c22" => :yosemite
    sha256 "1fca90d63d99120d915031917af646c1d1c17ea6bdc65eb1a225fb6cdb078bb1" => :mavericks
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
