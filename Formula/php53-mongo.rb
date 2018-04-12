require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Mongo < AbstractPhp53Extension
  init
  desc "Legacy MongoDB database driver."
  homepage "https://pecl.php.net/package/mongo"
  url "https://pecl.php.net/get/mongo-1.6.14.tgz"
  sha256 "586a0f55d29198010da5f4c932a183491f114db6e1b0ba8e40e7246b1a4a96d0"
  head "https://github.com/mongodb/mongo-php-driver-legacy.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "714118f54d8bc2af72b296031f1e40f83b322b2748519ca60dc7ba4ecdc1c3b6" => :el_capitan
    sha256 "c204a3b21022c01e4da8a165d49269c8de20cdb0dff7461979dae8d40da89447" => :yosemite
    sha256 "9f19bf935f48670fb934e4b9ed8dfc8ceee738fc6fe9a1ca51d688b791ed38ff" => :mavericks
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
