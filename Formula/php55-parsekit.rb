require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Parsekit < AbstractPhp55Extension
  init
  homepage "https://pecl.php.net/package/parsekit"
  desc "PHP Opcode Analyser"
  url "https://pecl.php.net/get/parsekit-1.3.0.tgz"
  sha256 "447d5ec6412d6c8c6489b03e7333d3872944444610b74eafd608eddcb3bbaf08"
  head "https://github.com/php/pecl-php-parsekit.git"

  bottle do
    cellar :any
    sha256 "c5b8fde36728ffae5af884ebd0d3837d57e6578f168a5d93bbbd4f969f4bdda9" => :yosemite
    sha256 "34080f494ccd497856252227a4dc5f51ce666910715a4526ab2d1b60604e7fca" => :mavericks
    sha256 "12c3bada1be25dc8d5ae06d1a1b21c261dc76c1a4a5c070741ecb02fbf13b076" => :mountain_lion
  end

  patch do
    # Fix incompatibility issues with parsekit 1.3.0
    # and PHP 5.4 (https://bugs.php.net/61187)
    url "https://gist.githubusercontent.com/SteelPangolin/5252ea888d09c51b7d35/raw/298c52816c6d8794aecf14416db20c29fadbde0d/parsekit"
    sha256 "dab4d3918b3c64360773de724076d6def0a1a89abf36e019c27c81b850955712"
  end

  def install
    Dir.chdir "parsekit-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/parsekit.so"
    prefix.install "examples"
    write_config_file if build.with? "config-file"
  end
end
