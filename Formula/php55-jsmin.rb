require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Jsmin < AbstractPhp55Extension
  init
  desc "PHP extension for minifying JavaScript."
  homepage "https://pecl.php.net/package/jsmin"
  url "https://pecl.php.net/get/jsmin-1.1.0.tgz"
  sha256 "9cf4180a816bac08300c45083410ca536200bd4940db0174026b9a825161f159"
  head "https://github.com/sqmk/pecl-jsmin.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 2
    sha256 "41328d52f924eb5fd920fb4ca5af852050e8c5653662e03ef88f9850a6d1dc3d" => :el_capitan
    sha256 "ec6fc371111b75ec29f492f915ff42a81cb5ce992bc6f0431d94ecf4e8b7851c" => :yosemite
    sha256 "7248655b324ac3769aa15cafc90d4dada869c3936043ea0e902b106e1319f634" => :mavericks
  end

  def install
    Dir.chdir "jsmin-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/jsmin.so"
    write_config_file if build.with? "config-file"
  end
end
