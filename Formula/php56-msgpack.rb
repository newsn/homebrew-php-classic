require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Msgpack < AbstractPhp56Extension
  init
  desc "MessagePack serialization"
  homepage "https://pecl.php.net/package/msgpack"
  url "https://pecl.php.net/get/msgpack-0.5.7.tgz"
  sha256 "b8ee20cd0a79426c1abd55d5bbae85e5dcfbe0238abf9ce300685fbe76d94cdf"
  head "https://github.com/msgpack/msgpack-php.git"

  bottle do
    cellar :any
    sha256 "506c798f278a6cf6fb12a244b7007f9876bbea8de790398b22bb27549e3aafb5" => :yosemite
    sha256 "c43775467f9bf3d1a6aabee6f2800502b0e249415e2e2297773987a987cc324e" => :mavericks
    sha256 "9bfe17a657838993f4e682b91144583069c042b1ff7ce21172b8487fdb5098f0" => :mountain_lion
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
