require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Msgpack < AbstractPhp72Extension
  init
  desc "MessagePack serialization"
  homepage "https://pecl.php.net/package/msgpack"
  url "https://pecl.php.net/get/msgpack-2.0.2.tgz"
  sha256 "b04980df250214419d9c3d9a5cb2761047ddf5effe5bc1481a19fee209041c01"
  head "https://github.com/msgpack/msgpack-php.git"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "f091d9a0e52fc1339ef54e2b7b220e575b31c107b288c6b15098875d9a83d81f" => :high_sierra
    sha256 "98cf09b49d1199001be011ee36e96750f986dc67c559c1e3618b1fd75796d936" => :sierra
    sha256 "cfbfa66f2fe7ec1d35587410ddbf22c992ad1eda2a2f7ed2824e5202a7f2567d" => :el_capitan
  end

  def install
    Dir.chdir "msgpack-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/msgpack.so"
    write_config_file if build.with? "config-file"
  end
end
