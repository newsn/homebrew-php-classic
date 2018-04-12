require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Proctitle < AbstractPhp54Extension
  init
  desc "Allows setting the current process name on Linux and BSD."
  homepage "https://pecl.php.net/package/proctitle"
  url "https://pecl.php.net/get/proctitle-0.1.2.tgz"
  sha256 "b9f84b1aebbee31cee627356438def1321d1f3bcd480341501315f35f0f9e272"
  head "https://github.com/MagicalTux/proctitle.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "8f9770cd40e079ef5cfdecd707e529e22820549c1942ef081740278027502f88" => :el_capitan
    sha256 "b00f208d1a7e5eab66de79f91dd2e20309340e8f07e9a8a72558102c600e93da" => :yosemite
    sha256 "264135d3e4ceb567526bc06ece0e300550ad0ca5a4aec0dd06bc1da91bd3317b" => :mavericks
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
