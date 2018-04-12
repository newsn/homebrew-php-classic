require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Msgpack < AbstractPhp70Extension
  init
  desc "MessagePack serialization"
  homepage "https://pecl.php.net/package/msgpack"
  url "https://pecl.php.net/get/msgpack-2.0.2.tgz"
  sha256 "b04980df250214419d9c3d9a5cb2761047ddf5effe5bc1481a19fee209041c01"
  head "https://github.com/msgpack/msgpack-php.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "3a92929d4b0b0edaf855be23be8ef3cb90b8484b04a330bf9ed52e8ccd0e9664" => :sierra
    sha256 "c4d0b15cfba3d18c1f8901ff27c00a616703969b147321212f9acb0d69964ff3" => :el_capitan
    sha256 "82452ff534006b66f77864f09135eace43d22fda4d994d6cfe3db54759577120" => :yosemite
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
