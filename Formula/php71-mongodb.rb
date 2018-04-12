require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Mongodb < AbstractPhp71Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.4.0.tgz"
  sha256 "b970fce679b7682260eacdd1dbf6bdb895ea56e0de8a2ff74dc5af881e4d7d6a"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "6cd7b412a0891dd8cc5350baf2388069638aee92417653968f645329a72a7ac5" => :high_sierra
    sha256 "33f1124038b3166b573ac5e2818317de48a1acfd0c8abef0cc01c8679bbcda1b" => :sierra
    sha256 "42f3f99b08e640255c194902eeb56dc7014d259d15867d16fa5c0bcbc501b90a" => :el_capitan
  end

  def install
    Dir.chdir "mongodb-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-mongodb-ssl=darwin"
    system "make"
    prefix.install "modules/mongodb.so"
    write_config_file if build.with? "config-file"
  end
end
