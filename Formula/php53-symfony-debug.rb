require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53SymfonyDebug < AbstractPhp53Extension
  init
  desc "Symfony debug component"
  homepage "http://symfony.com/doc/current/components/debug"
  url "https://github.com/symfony/debug/archive/v2.7.5.tar.gz"
  sha256 "60e9e5e84d01a80c3028bde183eeaf1adb85cdd0761a23076dc3852e84afa52e"
  head "https://github.com/symfony/Debug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "7f0061ae68a0c30b8fa8a50d88b6bb75414e3473dc648f541c9512549d1d294f" => :el_capitan
    sha256 "4e1ad4c1c9d0593395c48c0ef5587603ba0d7c6a2f2829b191a7cda1f5986462" => :yosemite
    sha256 "88133c58628d6102211b0b872daaa49a97acb57126218f759d3c5837c5a80480" => :mavericks
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
