require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Scrypt < AbstractPhp70Extension
  init
  desc "PHP wrapper for the scrypt hashing algorithm"
  homepage "https://github.com/DomBlack/php-scrypt"
  url "https://github.com/DomBlack/php-scrypt/archive/v1.4.2.tar.gz"
  sha256 "f187076caa8eeb0f5d9992fbc2045b5dff11652f5ce93ccdf3a792ac98b43622"
  head "https://github.com/DomBlack/php-scrypt.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "43067f9037e57e1bcd8ef776d418c899db596e552512c124cba0bb56a0ec151b" => :el_capitan
    sha256 "dc4864e1aa900f311e7adfe6aa7643a049d3eeee3c8e8a268b0fe2868bc1a7f7" => :yosemite
    sha256 "caf4b279d9fb64930208f4bd5007a639a87e48d0a1e788e4fff9d5b6e74cd609" => :mavericks
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
