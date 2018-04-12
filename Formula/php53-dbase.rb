require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Dbase < AbstractPhp53Extension
  init
  desc "dBase database file access functions"
  homepage "https://pecl.php.net/package/dbase"
  url "https://pecl.php.net/get/dbase-5.1.0.tgz"
  sha256 "20d6a40fb2efe4a06f503ec53512d02d71ceda87eac1f55208d7b5398f287a97"
  head "https://svn.php.net/repository/pecl/dbase/trunk/"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "c1820be47e469d8683c1fa4ad2f61f2399ec53c5b7e51d4ca7ec21faecc6ebfd" => :el_capitan
    sha256 "ba763e39af1dbf3a25842d857f9f399cbd88889cb6cb22a50edf4b37dd198e2b" => :yosemite
    sha256 "97f7f6642e6fca647fffa989ca14967b096d6b87783a6dd88a0459bd2633c666" => :mavericks
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
