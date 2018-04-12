require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Protobuf < AbstractPhp56Extension
  init
  desc "Fast PHP Protocol Buffers implementation"
  homepage "https://github.com/allegro/php-protobuf"
  head "https://github.com/allegro/php-protobuf.git"
  url "https://github.com/allegro/php-protobuf/archive/5839c25f1472736637e8c0484e542135f5636146.tar.gz"
  sha256 "df0ab827f6a522f0a09c6fbde6bae1d9c210ba82af4295f19f43c4ca096c1ca0"
  version "5839c25"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "043dccfb1da3e3f9cf303511d19e96ee9dfbbfa4cd8c25018f2ef5356073557c" => :el_capitan
    sha256 "633d0171ed34a8e4cd15d7f5a756faf924f5dac0178807d6d5e32c92c582bf29" => :yosemite
    sha256 "fdf187e3c88665af8d92a290ad3ca4682d9a0d5e41d1f52333eb9baff7c570ef" => :mavericks
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/protobuf.so"
    write_config_file if build.with? "config-file"
  end
end
