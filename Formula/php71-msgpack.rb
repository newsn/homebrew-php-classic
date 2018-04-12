require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Msgpack < AbstractPhp71Extension
  init
  desc "MessagePack serialization"
  homepage "https://pecl.php.net/package/msgpack"
  url "https://pecl.php.net/get/msgpack-2.0.2.tgz"
  sha256 "b04980df250214419d9c3d9a5cb2761047ddf5effe5bc1481a19fee209041c01"
  head "https://github.com/msgpack/msgpack-php.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "a3a97f3bec4051ec66cb12ffe6af94809512b285faf4d6ab7756ef4682e6739b" => :sierra
    sha256 "9d5f32787550253f52cf8426369cdef0d72db221726cdf0e2d48d3fa51bf5399" => :el_capitan
    sha256 "71a7e72cacb46402b15550bf3a6a75cbf2f08349ca43aa8ac790c6610df0fde3" => :yosemite
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
