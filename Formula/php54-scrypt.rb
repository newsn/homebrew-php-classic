require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Scrypt < AbstractPhp54Extension
  init
  desc "A PHP wrapper fo the scrypt hashing algorithm"
  homepage "https://github.com/DomBlack/php-scrypt"
  url "https://github.com/DomBlack/php-scrypt/archive/v1.2.tar.gz"
  sha256 "80de804217c5ed5dff189c82771d055a13e6abc64db35cbe6e29878cbc0eb827"
  head "https://github.com/DomBlack/php-scrypt.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "805e4e067af32de01e3593b31db788c822dd08e9bc94336d7b623fcd8e4a9fb8" => :el_capitan
    sha256 "27aa937a6e6fe31f6dbf6c3744bcbed2d79f914a9df3786d3e77794784484893" => :yosemite
    sha256 "6cc17165ed6a8cb8979388554b336eaf9453374fc6c50bac4f6206c94347057a" => :mavericks
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
