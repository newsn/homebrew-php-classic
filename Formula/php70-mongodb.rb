require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Mongodb < AbstractPhp70Extension
  init
  desc "MongoDB driver for PHP."
  homepage "https://pecl.php.net/package/mongodb"
  url "https://pecl.php.net/get/mongodb-1.4.0.tgz"
  sha256 "b970fce679b7682260eacdd1dbf6bdb895ea56e0de8a2ff74dc5af881e4d7d6a"
  head "https://github.com/mongodb/mongo-php-driver.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f745dfeb6da08ec69893c49d4935fcd6f9edfd4dffebea58bd7e05fa245d2ae3" => :high_sierra
    sha256 "72d2ddb604e092cf2a7fa8e1080d9b31d87c4b4467cef973763618e464d56fab" => :sierra
    sha256 "e8e44f889979938916f630e33bdb184f01366ddbea7e60380f4a8fac77fd7b2e" => :el_capitan
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
