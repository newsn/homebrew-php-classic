require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Phalcon < AbstractPhp53Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.9.tar.gz"
  sha256 "3f06c2c140b502547920f83e4acb29e1da6261d22c6154ac40b3f81f09ee6b74"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "65bd3431b1782eb1925c583225d6e45d0aa555f3db71b1b32f164cf7a026bbcd" => :sierra
    sha256 "91ea4cd43f394ffef537fd00ba71f2c68c45238cbb3fd641cba4dfe8af068195" => :el_capitan
    sha256 "b20ba62803c621eb640ee26af0355db424145b4b31d937e5699cc22e6a34d376" => :yosemite
  end

  depends_on "pcre"

  def install
    if MacOS.prefer_64_bit?
      Dir.chdir "build/64bits"
    else
      Dir.chdir "build/32bits"
    end

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file if build.with? "config-file"
  end
end
