require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Mongodb < AbstractPhp72Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.4.0.tgz"
  sha256 "b970fce679b7682260eacdd1dbf6bdb895ea56e0de8a2ff74dc5af881e4d7d6a"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "b5f7e323756b9cab55e5cac429e91cbf5ef778f30c88eb21571a019e45f0bd86" => :high_sierra
    sha256 "5c2e07155a503ba5bb6d68e4c95c8df20468534ea976bba3a1614be2ec959454" => :sierra
    sha256 "1fe320391ed26d2385baa2e7f81a7de7fe7ec299692965ef8c23881c410f4d98" => :el_capitan
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
