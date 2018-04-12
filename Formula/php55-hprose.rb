require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Hprose < AbstractPhp55Extension
  init
  desc "High Performance Remote Object Service Engine"
  homepage "https://pecl.php.net/package/hprose"
  url "https://pecl.php.net/get/hprose-1.6.6.tgz"
  head "https://github.com/hprose/hprose-pecl.git"
  sha256 "29292d9ba15c3f838622bbf8f608a0fb4fb6bba6019f6e6bffe1eedb572881b8"

  bottle do
    cellar :any_skip_relocation
    sha256 "bc6dc2abdad10f92b48f4bcf60bcb4a42ccc734a1a35295e67f5b70e85643b39" => :high_sierra
    sha256 "d01dbfcad5d8d18d066a0a03ca2ab6aa019788cf85377f2e946aacf0ec73d0e4" => :sierra
    sha256 "a3e849a17c3a2a0aeac884bd79ef8e60b88b5f05c91717072b739c8f7070b9e7" => :el_capitan
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
