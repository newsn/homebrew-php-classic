require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Meminfo < AbstractPhp54Extension
  init
  desc "PHP extension to get insight about memory usage"
  homepage "https://github.com/BitOne/php-meminfo"
  url "https://github.com/BitOne/php-meminfo.git",
    :tag => "v0.3.0",
    :revision => "a9e0eefe0b9c88abd7215f688ec0b04d0d20f386"
  head "https://github.com/BitOne/php-meminfo.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "ce93df89c2462513652e48b8c20f84bbd424c4af805686487722d5510e42c66a" => :el_capitan
    sha256 "b9cf0dea73975f6ef14232e339cafced5caaa575dde061eefd2e81f5c7b141f5" => :yosemite
    sha256 "4545e551df994cca9e3f27258393380b04b01fd667f563060f23b10027a32b1f" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install %w[modules/meminfo.so]
    write_config_file if build.with? "config-file"
  end
end
