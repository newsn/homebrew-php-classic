require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Mongodb < AbstractPhp55Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.4.0.tgz"
  sha256 "b970fce679b7682260eacdd1dbf6bdb895ea56e0de8a2ff74dc5af881e4d7d6a"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "c01f9ef94d52e4477894f77c521ad1e8318138facbeb48e4702ac01b044ca7d3" => :high_sierra
    sha256 "d58c7267574fa2d00449e92eabea532e607f4a1f78d3623341d9955b64112768" => :sierra
    sha256 "7570bf6df825190db555a3cc775591affd524fca0cbeae3331486df96257ffb3" => :el_capitan
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
