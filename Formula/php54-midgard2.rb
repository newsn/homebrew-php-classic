require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Midgard2 < AbstractPhp54Extension
  init
  desc "PHP5 API for Midgard persistent storage framework"
  homepage "http://www.midgard-project.org"
  url "https://github.com/midgardproject/midgard-php5/archive/12.09.1.tar.gz"
  sha256 "633ed2dce0c43222c13b2be1d2d044343f37e69cbdf727abc78ac53b6d871fe3"
  head "https://github.com/midgardproject/midgard-php5.git", :branch => "ratatoskr"

  bottle do
    rebuild 1
    sha256 "2132c200ff6de7f8b263fad70ecb68807223014663d6e13a95fb7081ce8e30c0" => :el_capitan
    sha256 "c788505799a1bb585863a6b4ec78cc0feeeb2810a8eebe167bc000a30b343648" => :yosemite
    sha256 "afbf1ac73eb3c6c4962c191d1717c2fc9b88569c95230d02a37e7387a891da23" => :mavericks
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
