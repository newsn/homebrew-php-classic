require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Thrift < AbstractPhp53Extension
  init
  desc "Apache Thrift is a software framework for scalable cross-language services development."
  homepage "https://thrift.apache.org/"
  url "https://github.com/apache/thrift/archive/0.9.2.tar.gz"
  sha256 "1eacc3d65b910fadf7969326285170d33cbe9fe30cc7bf421916f753edb3dabb"

  bottle do
    cellar :any_skip_relocation
    sha256 "5e30d11177a51c61a20d1ac736f594401f4239dc250297f0e9904180efc43c9e" => :el_capitan
    sha256 "79beb63a9c3debde7b793610c1ab4ef35a6036dfa02b5a503b1b0d28d9202740" => :yosemite
    sha256 "92117c2063c78420e38f7245ec4aed3b4fed95c1a2d9f40d030fc060d9b2616b" => :mavericks
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
