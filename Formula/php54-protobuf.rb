require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Protobuf < AbstractPhp54Extension
  init
  desc "Fast PHP Protocol Buffers implementation"
  homepage "https://github.com/allegro/php-protobuf"
  head "https://github.com/allegro/php-protobuf.git"
  url "https://github.com/allegro/php-protobuf/archive/0.10.tar.gz"
  sha256 "442e83dd47f5052e7e0bd4a46ab190a46115781e3c520df8319779689920a411"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "3f828ff5b3e24bbe85b220b4ee731f965c911adcdff15ec3290aa3b49176aea8" => :el_capitan
    sha256 "963330d7bed30528c015a207ae7978dbecadb2a9c34ea9b44160a80e41adc3ea" => :yosemite
    sha256 "84a261c541f40c5ddb9225e52fd839247d5d2db983b1b5593e185e4372f09e06" => :mavericks
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/protobuf.so"
    write_config_file if build.with? "config-file"
  end
end
