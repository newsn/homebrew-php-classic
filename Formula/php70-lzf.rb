require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Lzf < AbstractPhp70Extension
  init
  desc "handles LZF de/compression"
  homepage "https://pecl.php.net/package/lzf"
  url "https://pecl.php.net/get/LZF-1.6.3.tgz"
  sha256 "42ec458ea10128a801e8d39736b519ba81fa75d2a617d2777b7d6b3276601a5d"
  head "http://svn.php.net/repository/pecl/lzf/trunk/"

  bottle do
    cellar :any_skip_relocation
    rebuild 2
    sha256 "f8fec0b909bc04c45efa7400c62bce8442e6cd492b209c5bdaaf4a1f1c145c07" => :el_capitan
    sha256 "2d5add525c3125045e2208efae566273a324d3e37fc29069f152f926192a5e6e" => :yosemite
    sha256 "0ea8a7ef4d33c537c4a57aef41bf0ad78c41a2526128c995359ddf3c885e068e" => :mavericks
  end

  def install
    Dir.chdir "LZF-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/lzf.so"
    write_config_file if build.with? "config-file"
  end
end
