require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Phalcon < AbstractPhp54Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/phalcon-v2.0.13.tar.gz"
  sha256 "0a1bd6afe902c6f2f68cf5e2f2785503f5ad95d1d2cf1b66c77154c483a08a35"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "5c52e13f8393d117816f8c1c19cf3430bfb28b2bd5742eec7e9c77ccabb8439a" => :sierra
    sha256 "322d12d36deb99ad626b68f5689c3ab24a448534ab9be11b1c7e1760647f4472" => :el_capitan
    sha256 "d3048e742898d7acf472c47d83eaeab7f306628a53c37b4bea35840582a15517" => :yosemite
  end

  depends_on "pcre"

  def install
    if MacOS.prefer_64_bit?
      Dir.chdir "build/64bits"
    else
      Dir.chdir "build/32bits"
    end

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file if build.with? "config-file"
  end
end
