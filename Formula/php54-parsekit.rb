require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Parsekit < AbstractPhp54Extension
  init
  homepage "https://pecl.php.net/package/parsekit"
  desc "PHP Opcode Analyser"
  url "https://pecl.php.net/get/parsekit-1.3.0.tgz"
  sha256 "447d5ec6412d6c8c6489b03e7333d3872944444610b74eafd608eddcb3bbaf08"
  head "https://github.com/php/pecl-php-parsekit.git"

  bottle do
    cellar :any
    sha256 "ae19e135eae58ecf94522e5e711c98f534ecfb531da8371ce7f53f48455c50e8" => :yosemite
    sha256 "a366b68500abd2dd552a10967bd46f67a0fb65b8b62559d3a3038b9736f32cf6" => :mavericks
    sha256 "6213e69f2a8108c0bafce5b5cfe04aaa22a88d502830750192b9b0d5a8cded14" => :mountain_lion
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
