require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Scrypt < AbstractPhp56Extension
  init
  desc "A PHP wrapper fo the scrypt hashing algorithm"
  homepage "https://github.com/DomBlack/php-scrypt"
  url "https://github.com/DomBlack/php-scrypt/archive/v1.2.tar.gz"
  sha256 "80de804217c5ed5dff189c82771d055a13e6abc64db35cbe6e29878cbc0eb827"
  head "https://github.com/DomBlack/php-scrypt.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "661f29a890c02ce0328de213758d41783ec4b9214d1058aff9ae896345ae7956" => :el_capitan
    sha256 "a456712132a9511073390a1958de31ffc5f66eb9754bcd0c679165318b9f17b9" => :yosemite
    sha256 "82aac71f586c727b747a84d62ec43061fd6e92cf5d0984075c9cbf77c10766db" => :mavericks
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
