require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Runkit < AbstractPhp55Extension
  init
  desc "Extension to modify consts/functions/classes"
  homepage "http://php.net/manual/en/book.runkit.php"
  url "https://github.com/zenovich/runkit/archive/27f33f55eae4459448fc39fac49daba26bb6b575.tar.gz"
  sha256 "4b19ca9d4003eac6af51dd3b6b8e4365a74351a4fd248f2fe5c546b656a16a99"
  head "https://github.com/zenovich/runkit.git"
  version "5e179e9"

  bottle do
    cellar :any_skip_relocation
    sha256 "b41681ee9295a4dbd2bd1487c191884b2ac5e6cd5d89f4f1988bd573538e5439" => :el_capitan
    sha256 "107f55e1ecc78478c27f7ab295070600ae65c5bd411d86087e9932ebfae5336f" => :yosemite
    sha256 "38f85b0f1a602353fb7012ed162df66f7885e6de51117a00d5fdcbe12d83730f" => :mavericks
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
