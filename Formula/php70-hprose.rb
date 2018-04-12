require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Hprose < AbstractPhp70Extension
  init
  desc "High Performance Remote Object Service Engine"
  homepage "https://pecl.php.net/package/hprose"
  url "https://pecl.php.net/get/hprose-1.6.6.tgz"
  head "https://github.com/hprose/hprose-pecl.git"
  sha256 "29292d9ba15c3f838622bbf8f608a0fb4fb6bba6019f6e6bffe1eedb572881b8"

  bottle do
    cellar :any_skip_relocation
    sha256 "871debcb7656eed8dd19d8b6d3ab7d8194e6c3e877a8fdd2e80603c0cf29c762" => :high_sierra
    sha256 "e2ddb76aa71edfbe2730a9d3763c696ef8c62836b4620b8447bdec558d43f9ba" => :sierra
    sha256 "35bcfcbca7d9e95d58bd24222ec43fbaca6f0f78f0987fb0b01720f6c9791d6e" => :el_capitan
  end

  def install
    Dir.chdir "hprose-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/hprose.so"
    write_config_file if build.with? "config-file"
  end
end
