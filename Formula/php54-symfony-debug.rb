require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54SymfonyDebug < AbstractPhp54Extension
  init
  desc "Symfony debug component"
  homepage "http://symfony.com/doc/current/components/debug"
  url "https://github.com/symfony/debug/archive/v2.7.5.tar.gz"
  sha256 "60e9e5e84d01a80c3028bde183eeaf1adb85cdd0761a23076dc3852e84afa52e"
  head "https://github.com/symfony/Debug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "220421c12f979d2d88aac1373540b0c9471f91aa3478feebc6d1fb8f51b5a7fd" => :el_capitan
    sha256 "bb85c90a13ee7cfd83f868de482927438308e7eb07740c065efaaec74182e07e" => :yosemite
    sha256 "8f30a3c9e9bf547b7b8f500705e9f54338702c52c526923e6610fdf8e5336f5b" => :mavericks
  end

  def extension
    "symfony_debug"
  end

  def install
    ENV.universal_binary if build.universal?

    Dir.chdir "Resources/ext" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}",
             phpconfig
      system "make"
      prefix.install %w[modules/symfony_debug.so]
    end
    write_config_file if build.with? "config-file"
  end
end
