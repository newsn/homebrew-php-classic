require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Protobuf < AbstractPhp53Extension
  init
  desc "Fast PHP Protocol Buffers implementation"
  homepage "https://github.com/allegro/php-protobuf"
  head "https://github.com/allegro/php-protobuf.git"
  url "https://github.com/allegro/php-protobuf/archive/0.10.tar.gz"
  sha256 "442e83dd47f5052e7e0bd4a46ab190a46115781e3c520df8319779689920a411"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "42d5f082298549122a516d69ad714987eb582c7138da8b7d33356568c62f93bf" => :el_capitan
    sha256 "b2a4a57cd721ec9c2d8f9e0e5543dad685b8a805c9936e1dd0b58a9e0e55493b" => :yosemite
    sha256 "ee49a5e1fbd86582aadf1e7ca65a6973629b58581f1f3aa839c95e18f77d4bec" => :mavericks
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/protobuf.so"
    write_config_file if build.with? "config-file"
  end
end
