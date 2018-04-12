require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55SymfonyDebug < AbstractPhp55Extension
  init
  desc "Symfony debug component"
  homepage "http://symfony.com/doc/current/components/debug"
  url "https://github.com/symfony/debug/archive/v2.7.5.tar.gz"
  sha256 "60e9e5e84d01a80c3028bde183eeaf1adb85cdd0761a23076dc3852e84afa52e"
  head "https://github.com/symfony/Debug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "e807291d094bd5fd9d3bebf51d7ac9d7da6377cb8d74df164bae354488d17ecb" => :el_capitan
    sha256 "e93bbb02da9b04ee7d2266245b6bafc0b5e2b0bedc7e18bbee917fa8b77f21f2" => :yosemite
    sha256 "43e2c706ffda814b287a9471ccf3f0fe457e1cbe3708acb8e423c93f0302f117" => :mavericks
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
