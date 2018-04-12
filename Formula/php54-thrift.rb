require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Thrift < AbstractPhp54Extension
  init
  desc "Apache Thrift is a software framework for scalable cross-language services development."
  homepage "https://thrift.apache.org/"
  url "https://github.com/apache/thrift/archive/0.9.2.tar.gz"
  sha256 "1eacc3d65b910fadf7969326285170d33cbe9fe30cc7bf421916f753edb3dabb"

  bottle do
    cellar :any_skip_relocation
    sha256 "442c8726388cd2910636267dc9b391a48b2a21c6a0b844ecd1a3e8a06ab25b77" => :el_capitan
    sha256 "102276f5e80e1c618243a2d8ad6221855d28effcf53f220ae85b688a3ca095f8" => :yosemite
    sha256 "e13359c8bfb47d39f040a0769691977493644e99db479c70bc4c479b843449e6" => :mavericks
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
