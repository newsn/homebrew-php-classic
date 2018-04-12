require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Meminfo < AbstractPhp70Extension
  init
  desc "PHP extension to get insight about memory usage"
  homepage "https://github.com/BitOne/php-meminfo"
  url "https://github.com/BitOne/php-meminfo.git",
    :tag => "v1.0.0",
    :revision => "0e4f884d02b9af4321d9b5121b017194047fb10e"
  head "https://github.com/BitOne/php-meminfo.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "c3e159120f9ab0dc93588d22c6dd36d204f8ccaf1512c0ab51c4a0c74d976032" => :high_sierra
    sha256 "bd3ca428c5bc7d3a649e677702a82613a02968f387c3c92e044ec8f2352eeb60" => :sierra
    sha256 "ee9f935636cc5947360c83d13c1a530aa6f54c3ef5a41837dab1a48950171c36" => :el_capitan
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
