require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Gmagick < AbstractPhp53Extension
  init
  desc "Provides a wrapper to the GraphicsMagick library."
  homepage "https://pecl.php.net/package/gmagick"
  url "https://pecl.php.net/get/gmagick-1.1.7RC2.tgz"
  sha256 "8e51c8343d6e6d556d7b17417ce338c6ed2b0893869f1494410dfe6ba5105475"

  bottle do
    rebuild 1
    sha256 "9c759a4162288a21363f71ef729ae6ecca94ec809a3907dc7b92d0a1fa58ead3" => :el_capitan
    sha256 "dc2a71a36d0f02747c4084c888f299d9fb47bc1e5cc126c971c2f3ac08dac588" => :yosemite
    sha256 "e3146f900b55fcd28bbd9bb7485ed8f740760ab3d5cb13e40f0202836c762839" => :mavericks
  end

  depends_on "graphicsmagick"

  def install
    Dir.chdir "gmagick-#{version}"

    ENV.universal_binary if build.universal?

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig
    args << "--with-gmagick=#{Formula["graphicsmagick"].opt_prefix}"

    safe_phpize
    system "./configure", *args

    system "make"
    prefix.install "modules/gmagick.so"
    write_config_file if build.with? "config-file"
  end
end
