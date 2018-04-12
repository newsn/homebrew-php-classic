require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Parsekit < AbstractPhp56Extension
  init
  homepage "https://pecl.php.net/package/parsekit"
  desc "PHP Opcode Analyser"
  url "https://pecl.php.net/get/parsekit-1.3.0.tgz"
  sha256 "447d5ec6412d6c8c6489b03e7333d3872944444610b74eafd608eddcb3bbaf08"
  head "https://github.com/php/pecl-php-parsekit.git"

  bottle do
    cellar :any
    sha256 "6b547fac5a93aa5a1f1c447042c5d124a66b73f0e45bc1cf97fe8c85317c6cb2" => :yosemite
    sha256 "52bdb6a53b34bf8f02aeac9c50da12ed8f6e51b23e0b737a3950369c8b9c7be6" => :mavericks
    sha256 "730c115901757abaddbabc3205194ca0a75e33d18a67bbf91e79688a5fb63d92" => :mountain_lion
  end

  patch do
    # Fix incompatibility issues with parsekit 1.3.0
    # and PHP 5.4 (https://bugs.php.net/61187)
    url "https://gist.githubusercontent.com/SteelPangolin/5252ea888d09c51b7d35/raw/298c52816c6d8794aecf14416db20c29fadbde0d/parsekit"
    sha256 "dab4d3918b3c64360773de724076d6def0a1a89abf36e019c27c81b850955712"
  end

  patch do
    # Fix incompatibility issues with parsekit 1.3.0
    # and PHP 5.6 (https://bugs.php.net/67854)
    url "https://gist.githubusercontent.com/SteelPangolin/864f0ddf7291eaa7eccf/raw/6a8a7d6ae44a2d8c43ce205b1a41dc6f23cab0ea/php-pecl-parsekit-1.3-php56-variadic-fix.patch"
    sha256 "f5ff3c7001f295630853f65bd5d5918572252f8cc5130bbeb7a3b0f8c1163d3f"
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
