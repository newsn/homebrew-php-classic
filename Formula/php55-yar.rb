require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Yar < AbstractPhp55Extension
  init
  desc "Light, concurrent RPC framework"
  homepage "https://pecl.php.net/package/yar"
  url "https://pecl.php.net/get/yar-1.2.3.tgz"
  sha256 "8f39e6174476e2eae6021f83b69bcf77ee22949654a43c9985dde1a3c7bcf66e"

  bottle do
    cellar :any_skip_relocation
    sha256 "a780041d4cf88644dfef39c7098f1c083b42ed91af57f9e9c9f52e7e2c58a2ac" => :el_capitan
    sha256 "4d594ee31f8f8f7e8468a9ba78e973907088797d7a9abdd66d66b4d67fe4008f" => :yosemite
    sha256 "cd97f7baae1bedb2183deec2d6a658d92fb4ea6337b7afcbe12e2ebdb32ec5a5" => :mavericks
  end

  def install
    Dir.chdir "yar-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/yar.so"
    write_config_file if build.with? "config-file"
  end
end
