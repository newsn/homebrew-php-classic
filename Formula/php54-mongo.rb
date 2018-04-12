require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Mongo < AbstractPhp54Extension
  init
  desc "Legacy MongoDB database driver."
  homepage "https://pecl.php.net/package/mongo"
  url "https://pecl.php.net/get/mongo-1.6.14.tgz"
  sha256 "586a0f55d29198010da5f4c932a183491f114db6e1b0ba8e40e7246b1a4a96d0"
  head "https://github.com/mongodb/mongo-php-driver-legacy.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "109cc7fd7e2d4719f0d12b2644aaae3c871fda11bdd165b52b09b87b2b00121f" => :el_capitan
    sha256 "5fa2735517d9b1b54366c76e4a9486bc5d82b0b4633a83babc8acadb1bab5955" => :yosemite
    sha256 "0beec0892ad5a0ee3516494c1fc704fd52e07194e14b8833baa40069bd74e527" => :mavericks
  end

  def install
    Dir.chdir "mongo-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/mongo.so"
    write_config_file if build.with? "config-file"
  end
end
