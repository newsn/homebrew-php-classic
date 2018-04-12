require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Svm < AbstractPhp56Extension
  init
  desc "Support Vector Machine Library"
  homepage "http://php.net/manual/en/book.svm.php"
  url "https://github.com/ianbarber/php-svm/archive/0.1.9.tar.gz"
  sha256 "c3dabf7220766193fcb87514559e89c1a9ec0017f510fc58cb98b3ac52819734"
  head "https://github.com/ianbarber/php-svm.git"

  bottle do
    cellar :any
    sha256 "cbcecf5cc71f5c1820d91b6c560ecb258556269e180bf6b10d1ee8869b1bb8cf" => :el_capitan
    sha256 "2ec0cdd0ee8da5453c010160c1afb9ab58398b575af59e8d1ebd52d605f30da0" => :yosemite
    sha256 "a60cb58c50ad589f5d38a25b0ee52d04f4a723bedd80923ae7a93e3100a743ff" => :mavericks
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
