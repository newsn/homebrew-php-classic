require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Proctitle < AbstractPhp53Extension
  init
  desc "Allows setting the current process name on Linux and BSD."
  homepage "https://pecl.php.net/package/proctitle"
  url "https://pecl.php.net/get/proctitle-0.1.2.tgz"
  sha256 "b9f84b1aebbee31cee627356438def1321d1f3bcd480341501315f35f0f9e272"
  head "https://github.com/MagicalTux/proctitle.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "626e491889b57d14a696f3417f3b54ee4b7b7883d3f7fd945fb7cf1a02949805" => :el_capitan
    sha256 "2d88ea8743b6c39b37eeeff18290f52a4c37dbe805e22b58d5d3200005197970" => :yosemite
    sha256 "2454f2fdab1486ed58bec4f8fbf6f2ec5d66a3e87afe3454548204c8b66f0a58" => :mavericks
  end

  def install
    Dir.chdir "proctitle-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w[modules/proctitle.so]
    write_config_file if build.with? "config-file"
  end
end
