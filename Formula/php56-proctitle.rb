require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Proctitle < AbstractPhp56Extension
  init
  desc "Allows setting the current process name on Linux and BSD."
  homepage "https://pecl.php.net/package/proctitle"
  url "https://pecl.php.net/get/proctitle-0.1.2.tgz"
  sha256 "b9f84b1aebbee31cee627356438def1321d1f3bcd480341501315f35f0f9e272"
  head "https://github.com/MagicalTux/proctitle.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "93c104f85db2cce6c05962fd0de69404a09b6fe6a993275b90e4397fb1118ab4" => :el_capitan
    sha256 "d3b224c17f96178302461f745f49b1f8b67b13a41e03452b3ac3681fa028741b" => :yosemite
    sha256 "87c1eea11041e691cbc21876bd8676b9556437b006571c1f2c2cd66148965471" => :mavericks
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
