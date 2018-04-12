require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Thrift < AbstractPhp56Extension
  init
  desc "Apache Thrift is a software framework for scalable cross-language services development."
  homepage "https://thrift.apache.org/"
  url "https://github.com/apache/thrift/archive/0.9.2.tar.gz"
  sha256 "1eacc3d65b910fadf7969326285170d33cbe9fe30cc7bf421916f753edb3dabb"

  bottle do
    cellar :any_skip_relocation
    sha256 "ca5be9cdbc737e94c338eba57b092687df42d8e83ec5897d78d9427b2f2362e8" => :el_capitan
    sha256 "25044cc8a2671779fac9a2a3a4889b53991f67159b6c06e6b95b708dc3d6d224" => :yosemite
    sha256 "a2585b1b890b304ce2fdab7604ae552fb9fa7b754415bc26df2b2ab6e75af13b" => :mavericks
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
