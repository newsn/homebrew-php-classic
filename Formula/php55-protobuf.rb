require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Protobuf < AbstractPhp55Extension
  init
  desc "Fast PHP Protocol Buffers implementation"
  homepage "https://github.com/allegro/php-protobuf"
  head "https://github.com/allegro/php-protobuf.git"
  url "https://github.com/allegro/php-protobuf/archive/0.10.tar.gz"
  sha256 "442e83dd47f5052e7e0bd4a46ab190a46115781e3c520df8319779689920a411"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "b89099125ed51260efbabf6acb6393c1e8893bf1f1061f7876b41da0767253bf" => :el_capitan
    sha256 "43903ee89b336e91da14668887e6e82f5d0d4a704a6315bcfaf6649f33572df6" => :yosemite
    sha256 "897e890a89fe1fe2b9341c41f7a709999f6b77e997e0203d1a92765adba9777b" => :mavericks
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/protobuf.so"
    write_config_file if build.with? "config-file"
  end
end
