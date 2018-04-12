require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Dbase < AbstractPhp54Extension
  init
  desc "dBase database file access functions"
  homepage "https://pecl.php.net/package/dbase"
  url "https://pecl.php.net/get/dbase-5.1.0.tgz"
  sha256 "20d6a40fb2efe4a06f503ec53512d02d71ceda87eac1f55208d7b5398f287a97"
  head "https://svn.php.net/repository/pecl/dbase/trunk/"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "3540c76a36b798b0122661e471ab90d6d60f8776e67120e0ff74998711b3b7ec" => :el_capitan
    sha256 "88438eec84398c90ee856315a349b052c8ced1b482d628c5d67ebd797bcb7e35" => :yosemite
    sha256 "bfb116837554c42ab364ccaf31674f762859c9235aaf0088ae98408a82f62c96" => :mavericks
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
