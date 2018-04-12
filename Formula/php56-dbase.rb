require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Dbase < AbstractPhp56Extension
  init
  desc "dBase database file access functions"
  homepage "https://pecl.php.net/package/dbase"
  url "https://pecl.php.net/get/dbase-5.1.0.tgz"
  sha256 "20d6a40fb2efe4a06f503ec53512d02d71ceda87eac1f55208d7b5398f287a97"
  head "https://svn.php.net/repository/pecl/dbase/trunk/"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "ccf00e01e4ea133e945554456fd663d25ebb6a7da13cf067120838b5e09bff38" => :el_capitan
    sha256 "71ed788a7ee0bce72715bf718672dc70e8cadca507a5a8810a2784baa97bda4a" => :yosemite
    sha256 "45b6937effc43b105ab0b9efecd31d3dac46f467177de0e471af9219601d6fb6" => :mavericks
  end

  def install
    Dir.chdir "dbase-5.1.0"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}"

    system "make"
    prefix.install "modules/dbase.so"
    write_config_file if build.with? "config-file"
  end
end
