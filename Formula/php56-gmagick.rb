require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Gmagick < AbstractPhp56Extension
  init
  desc "Provides a wrapper to the GraphicsMagick library."
  homepage "https://pecl.php.net/package/gmagick"
  url "https://pecl.php.net/get/gmagick-1.1.7RC2.tgz"
  sha256 "8e51c8343d6e6d556d7b17417ce338c6ed2b0893869f1494410dfe6ba5105475"

  bottle do
    rebuild 1
    sha256 "2b5c737246ba9b4b9cf28db8ff22acab08f295940e3ec3d81db06106ed903e04" => :el_capitan
    sha256 "f1e5b3914085c1d81afa5cf5b6f5af2ef21bb7ee8eead724de733cb0188567b0" => :yosemite
    sha256 "4a2afc54461304dcb64083676b5d2b6dec238df28c05cb524c1f80abfbcf3b6a" => :mavericks
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
