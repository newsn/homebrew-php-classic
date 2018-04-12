require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mongo < AbstractPhp55Extension
  init
  desc "Legacy MongoDB database driver."
  homepage "https://pecl.php.net/package/mongo"
  url "https://pecl.php.net/get/mongo-1.6.14.tgz"
  sha256 "586a0f55d29198010da5f4c932a183491f114db6e1b0ba8e40e7246b1a4a96d0"
  head "https://github.com/mongodb/mongo-php-driver-legacy.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "028bed8264633fb6e140f275650f4891d77e0d0108110b3157ce46ced8d95e61" => :el_capitan
    sha256 "30b661227951f09507bfb2eaa370e1933cfa140d2682c97a387542dfcf3f5e61" => :yosemite
    sha256 "9e9fc0871ab9bf8f3cb5f24497cb5017c26a809c70f88333d0e5479b2ffc5c56" => :mavericks
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
