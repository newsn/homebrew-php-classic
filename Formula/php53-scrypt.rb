require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Scrypt < AbstractPhp53Extension
  init
  desc "A PHP wrapper fo the scrypt hashing algorithm"
  homepage "https://github.com/DomBlack/php-scrypt"
  url "https://github.com/DomBlack/php-scrypt/archive/v1.2.tar.gz"
  sha256 "80de804217c5ed5dff189c82771d055a13e6abc64db35cbe6e29878cbc0eb827"
  head "https://github.com/DomBlack/php-scrypt.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "faf9eda4edcc15d161c2d0177c040b7a15d0d047a32f5f78da9fb6dc947a4448" => :el_capitan
    sha256 "0ce245602613479e00998f1bb3e4a17afa6d135991b494b324f179afde1aa392" => :yosemite
    sha256 "9b1562e297b88d64e034b13cf88aeee6cb75fd6d7f19baa22adeb58c2f36576f" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?
    ENV["CFLAGS"] = "-arch i386 -arch x86_64"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-scrypt"
    system "make"
    prefix.install "modules/scrypt.so"

    write_config_file if build.with? "config-file"
  end
end
