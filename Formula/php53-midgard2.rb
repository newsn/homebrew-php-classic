require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Midgard2 < AbstractPhp53Extension
  init
  desc "PHP5 API for Midgard persistent storage framework"
  homepage "http://www.midgard-project.org"
  url "https://github.com/midgardproject/midgard-php5/archive/12.09.1.tar.gz"
  sha256 "633ed2dce0c43222c13b2be1d2d044343f37e69cbdf727abc78ac53b6d871fe3"
  head "https://github.com/midgardproject/midgard-php5.git", :branch => "ratatoskr"

  bottle do
    rebuild 1
    sha256 "0aa14a61320b1a5f2b1aefb65375baf159cd245e08f4cefe67577e85fc8ddb35" => :el_capitan
    sha256 "88478c18023e421be218c277ba5e75de62a637d53a62b9c4349114c5212683f8" => :yosemite
    sha256 "9a19d07d3067f8557a66d7f14bef47b7f7e7220a8f5b6f64fd83562dbf746a7b" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "midgard2"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/midgard2.so"
    write_config_file if build.with? "config-file"
  end
end
