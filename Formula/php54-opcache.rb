require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Opcache < AbstractPhp54Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://github.com/zend-dev/ZendOptimizerPlus"
  url "https://github.com/zendtech/ZendOptimizerPlus/archive/v7.0.5.tar.gz"
  sha256 "2654d9611e386cc59887d4e8cfba2c010ed4480c7c9c5094ad99fdcf858d94ee"

  head "https://github.com/zendtech/ZendOptimizerPlus.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 2
    sha256 "86c1e882a564882695c41f5f8a0a039969c6176bd3a6219426ad960d081a0278" => :sierra
    sha256 "5bd5c34d2c5f3edccbb3ae21c2f87515e504a74211b758a1648e344f9e08fab4" => :el_capitan
  end

  depends_on "pcre"

  def extension_type
    "zend_extension"
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/opcache.so"
    write_config_file if build.with? "config-file"
  end
end
