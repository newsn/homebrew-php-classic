require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Gmagick < AbstractPhp55Extension
  init
  desc "Provides a wrapper to the GraphicsMagick library."
  homepage "https://pecl.php.net/package/gmagick"
  url "https://pecl.php.net/get/gmagick-1.1.7RC2.tgz"
  sha256 "8e51c8343d6e6d556d7b17417ce338c6ed2b0893869f1494410dfe6ba5105475"

  bottle do
    rebuild 1
    sha256 "d257844dd7df408384820f20684ccbeb103ac14f94556091e935c208f054568a" => :el_capitan
    sha256 "66833fbebb1755acdcea3dfc30c69187dbbb2f762cf1e5229b95d8357e083780" => :yosemite
    sha256 "410d902752fe549f7b863a46ffec55a59fb5a481780d2b2f49a38d7f1b803465" => :mavericks
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
