require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Mongodb < AbstractPhp56Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.4.0.tgz"
  sha256 "b970fce679b7682260eacdd1dbf6bdb895ea56e0de8a2ff74dc5af881e4d7d6a"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "79dbc3eb08ac62e1c5066b203a79328c48c960c255ed044c73fd91c3204e41cf" => :high_sierra
    sha256 "347576d4106f738ed66d9eda0184e41f5884c1ede9c1d3781f62a740be0dc084" => :sierra
    sha256 "a8f28cac1aeaf559b08b2ac6d3cb509e5d2b94c10a70198ccb9cdaa05836a396" => :el_capitan
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
