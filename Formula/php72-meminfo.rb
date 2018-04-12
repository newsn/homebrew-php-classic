require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Meminfo < AbstractPhp72Extension
  init
  desc "PHP extension to get insight about memory usage"
  homepage "https://github.com/BitOne/php-meminfo"
  url "https://github.com/BitOne/php-meminfo.git",
    :tag => "v1.0.0",
    :revision => "0e4f884d02b9af4321d9b5121b017194047fb10e"
  head "https://github.com/BitOne/php-meminfo.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "679d145dbab07d9475c94790306aadaa4b1bd9aeecb8b2a2e5675c3c3f80dc20" => :high_sierra
    sha256 "b220f7874a381b82bf793b544d7f0bbc292b62d125d6a36c8b99ebbf57a6d119" => :sierra
    sha256 "d8771b6a3eb6688b4caf30523b66f15aa05d68b51951bda6dc17d29f69ebff11" => :el_capitan
  end

  def install
    Dir.chdir "extension/php7" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w[modules/meminfo.so]
    write_config_file if build.with? "config-file"
  end
end
