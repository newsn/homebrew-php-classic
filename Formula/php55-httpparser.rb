require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Httpparser < AbstractPhp55Extension
  init
  desc "The C http parser from Ruby's Mongrel web server"
  homepage "https://github.com/dhotson/httpparser-php"
  url "https://github.com/dhotson/httpparser-php/archive/v0.1.0.tar.gz"
  sha256 "9ba699a116696bb3695b7bff7b5ffd2be4b5cbe6746d1814c628c141eb1ff381"
  head "https://github.com/dhotson/httpparser-php.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "433755a1d55ff38733ac50f529a7754f598f61e626ab27dd55ee05a09e6e800a" => :yosemite
    sha256 "2eb290d020d64b70fe310c281fccd33baea999f222e13a17b9b04a0a222993fb" => :mavericks
  end

  def extension
    "httpparser"
  end

  def install
    Dir.chdir "ext"

    ENV.universal_binary if build.universal?

    safe_phpize

    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"

    prefix.install ["modules/httpparser.so"]
    write_config_file if build.with? "config-file"
  end
end
