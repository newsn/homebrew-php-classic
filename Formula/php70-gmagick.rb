require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gmagick < AbstractPhp70Extension
  init
  desc "Provides a wrapper to the GraphicsMagick library."
  homepage "https://pecl.php.net/package/gmagick"
  url "https://pecl.php.net/get/gmagick-2.0.2RC2.tgz"
  sha256 "7656bd9042c2aae1325b1cb49e55d9e8ec31b911decec33b6f176195ee1d515a"

  bottle do
    sha256 "3c109297742e0beb662ee0cb6252262cf570218229b3350ecb54325c205bda60" => :el_capitan
    sha256 "2c49ce07ee9eda516b08975653bbfa44fcea4dac4ea9b059c94210a46be8b8cb" => :yosemite
    sha256 "afef9524b1cd47e563bf5b4181da4d5590e9a12d262fa7842fc6094eff481e72" => :mavericks
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
