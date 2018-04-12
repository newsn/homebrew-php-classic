require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56SymfonyDebug < AbstractPhp56Extension
  init
  desc "Symfony debug component"
  homepage "http://symfony.com/doc/current/components/debug"
  url "https://github.com/symfony/debug/archive/v2.7.5.tar.gz"
  sha256 "60e9e5e84d01a80c3028bde183eeaf1adb85cdd0761a23076dc3852e84afa52e"
  head "https://github.com/symfony/Debug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "c49c66f133781d14712f06f4c7d3ff8a45b746fa3a405b85d692b75aaa4b3e70" => :el_capitan
    sha256 "62d02da227cdb4c252b756b3f94b8cafe512e1a6eed6158d56c1c86e16551dc2" => :yosemite
    sha256 "4a16673633e3ff214795e9184b1dd3d64633f7b62dc3517ebd6790a5eab5d51c" => :mavericks
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
