require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Parsekit < AbstractPhp53Extension
  init
  homepage "https://pecl.php.net/package/parsekit"
  desc "PHP Opcode Analyser"
  url "https://pecl.php.net/get/parsekit-1.3.0.tgz"
  sha256 "447d5ec6412d6c8c6489b03e7333d3872944444610b74eafd608eddcb3bbaf08"
  head "https://github.com/php/pecl-php-parsekit.git"
  revision 2

  bottle do
    cellar :any_skip_relocation
    sha256 "976cf01ccf3dfd310098bbbdf4478b092bf628cca06199dd8652f3609b9d0c0f" => :el_capitan
    sha256 "2a0994a0a2f38ba7f7f5926c097797c01181ee512563d334b02598608c1e35ab" => :yosemite
    sha256 "30daa0fca50d2193614cbb8ef7ce824fd94009ab99e64449d2421ef4012deda1" => :mavericks
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
