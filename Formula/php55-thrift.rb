require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Thrift < AbstractPhp55Extension
  init
  desc "Apache Thrift is a software framework for scalable cross-language services development."
  homepage "https://thrift.apache.org/"
  url "https://github.com/apache/thrift/archive/0.9.2.tar.gz"
  sha256 "1eacc3d65b910fadf7969326285170d33cbe9fe30cc7bf421916f753edb3dabb"

  bottle do
    cellar :any_skip_relocation
    sha256 "7f23d703c1962f389a7d004b25beeb0bda26d524b77040c47807eb71d55844c9" => :el_capitan
    sha256 "7a0f1b383c5a27a91a132e717df19cd91fc2681b08839d548cd0724903e2ad68" => :yosemite
    sha256 "25811800ad1ad9411e0a32aa11fb91b862fd7a6e019b0615907b965a719fd0d6" => :mavericks
  end

  def module_path
    prefix / "thrift_protocol.so"
  end

  def install
    Dir.chdir "lib/php/src/ext/thrift_protocol"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/thrift_protocol.so"
    write_config_file if build.with? "config-file"
  end
end
