require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Proctitle < AbstractPhp55Extension
  init
  desc "Allows setting the current process name on Linux and BSD."
  homepage "https://pecl.php.net/package/proctitle"
  url "https://pecl.php.net/get/proctitle-0.1.2.tgz"
  sha256 "b9f84b1aebbee31cee627356438def1321d1f3bcd480341501315f35f0f9e272"
  head "https://github.com/MagicalTux/proctitle.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "e0112adb7308cf07c61e5dff0febe4abd3d192d351d8a7865aea2a3797860bab" => :el_capitan
    sha256 "745681a9079914a80a7981880b98f5956b0edf6efd7e0a915e1aa5499fd227f8" => :yosemite
    sha256 "6536d504403e783230d6f41ead9097caf2746e6a05697c48d9990823b5f8be3f" => :mavericks
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
