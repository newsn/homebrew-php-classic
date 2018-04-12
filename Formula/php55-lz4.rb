require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Lz4 < AbstractPhp55Extension
  init
  desc "Extremely Fast Compression algorithm."
  homepage "https://cyan4973.github.io/lz4/"
  url "https://github.com/kjdev/php-ext-lz4/archive/0.2.2.tar.gz"
  sha256 "9e37b1ca39013dacd392e31a0f037f9adf2b6f710a733166b0d0168f23f99c3a"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "b44bbb9a7654c1725bee495c0cb48205d1f48b82db2b982dde919034b922f05c" => :el_capitan
    sha256 "c4d4fa6c690214565c79ab41289ee7059b93d13d69301cd45a44fb8a0ce37397" => :yosemite
    sha256 "71975165c55e1b2257f811205d05228e056786c6e5e93911aa82933c74204fad" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/lz4.so"
    write_config_file if build.with? "config-file"
  end
end
