require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Msgpack < AbstractPhp55Extension
  init
  desc "MessagePack serialization"
  homepage "https://pecl.php.net/package/msgpack"
  url "https://pecl.php.net/get/msgpack-0.5.7.tgz"
  sha256 "b8ee20cd0a79426c1abd55d5bbae85e5dcfbe0238abf9ce300685fbe76d94cdf"
  head "https://github.com/msgpack/msgpack-php.git"

  bottle do
    cellar :any
    sha256 "4b3ec4346cba9883c8e232724535157d11ec31991b26cae9fc75165acd2d4ea7" => :yosemite
    sha256 "1f5eca132f92e6e8de35cf6c7554f103eb76c1aaa2bcc9ac52101f1c5c5d2af2" => :mavericks
    sha256 "5fe0df514fa14924079fbb71c6230c524071de43dd7c98f44ea3eb15afaff4b8" => :mountain_lion
  end

  def install
    Dir.chdir "msgpack-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/msgpack.so"
    write_config_file if build.with? "config-file"
  end
end
