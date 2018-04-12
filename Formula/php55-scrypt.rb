require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Scrypt < AbstractPhp55Extension
  init
  desc "A PHP wrapper fo the scrypt hashing algorithm"
  homepage "https://github.com/DomBlack/php-scrypt"
  url "https://github.com/DomBlack/php-scrypt/archive/v1.2.tar.gz"
  sha256 "80de804217c5ed5dff189c82771d055a13e6abc64db35cbe6e29878cbc0eb827"
  head "https://github.com/DomBlack/php-scrypt.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "c9814fa4801dc68bde8f61df729cd1af79fb0c0cc8a1c2fdbf01fc1125e54d4d" => :el_capitan
    sha256 "54019049fc59847be98da3c4cd09fb63fbd2f05add0657cb346a7adca6ba8cb7" => :yosemite
    sha256 "2f4635b0f4ad3f77bc98c6b4f8e92dee38a425b28dd72b4ffd662fef76f76a6b" => :mavericks
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
