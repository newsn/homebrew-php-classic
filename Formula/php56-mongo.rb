require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongo < AbstractPhp56Extension
  init
  desc "Legacy MongoDB database driver."
  homepage "https://pecl.php.net/package/mongo"
  url "https://pecl.php.net/get/mongo-1.6.14.tgz"
  sha256 "586a0f55d29198010da5f4c932a183491f114db6e1b0ba8e40e7246b1a4a96d0"
  head "https://github.com/mongodb/mongo-php-driver-legacy.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "bef8bc101f2b06c1bb68e08f992129e837d446e2044cfcf9989b67c9f4a631d3" => :el_capitan
    sha256 "22c664f7af7e26730e15cd863598f9ae58eb6fce8d13c556fe0e8761a462bde5" => :yosemite
    sha256 "5b13fb613e68c7e2b8e5ee4b398142902b25324e70c99d1e2f9f258b82661345" => :mavericks
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
