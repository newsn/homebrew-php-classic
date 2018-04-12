require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Msgpack < AbstractPhp54Extension
  init
  desc "MessagePack serialization"
  homepage "https://pecl.php.net/package/msgpack"
  url "https://pecl.php.net/get/msgpack-0.5.7.tgz"
  sha256 "b8ee20cd0a79426c1abd55d5bbae85e5dcfbe0238abf9ce300685fbe76d94cdf"
  head "https://github.com/msgpack/msgpack-php.git"

  bottle do
    cellar :any
    sha256 "bf732a3f5cf5859844d195d86655213554b1bf95cfd58ce3a0b21e241f463603" => :yosemite
    sha256 "43692d6f1847233c12d3976b78b9e98fbe9761adaa66a606ff21504a61233c0e" => :mavericks
    sha256 "8e41d425ed831ba7cd54f2aa3073674b9bfb750451b7443b39f8972b8fc7cf60" => :mountain_lion
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
