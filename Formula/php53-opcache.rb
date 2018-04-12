require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Opcache < AbstractPhp53Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://github.com/zend-dev/ZendOptimizerPlus"
  url "https://github.com/zendtech/ZendOptimizerPlus/archive/v7.0.5.tar.gz"
  sha256 "2654d9611e386cc59887d4e8cfba2c010ed4480c7c9c5094ad99fdcf858d94ee"

  head "https://github.com/zendtech/ZendOptimizerPlus.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 2
    sha256 "ecc8bb4ce189569a856f664bc1c5342b5d2d39df9b7c5198718d738c03ead7dd" => :sierra
    sha256 "6e9b284e1eeffdf7552681868d7ab51888b38fa05abf7a922c40aecfcd0ec071" => :el_capitan
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
