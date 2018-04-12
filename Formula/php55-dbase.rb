require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Dbase < AbstractPhp55Extension
  init
  desc "dBase database file access functions"
  homepage "https://pecl.php.net/package/dbase"
  url "https://pecl.php.net/get/dbase-5.1.0.tgz"
  sha256 "20d6a40fb2efe4a06f503ec53512d02d71ceda87eac1f55208d7b5398f287a97"
  head "https://svn.php.net/repository/pecl/dbase/trunk/"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "ad65dc45072b00ea5d8339559502250bd558d593ec94e891ba1f5fbe45f02cd1" => :el_capitan
    sha256 "bec180163e48f095bf8080b5656d7a72b5580b84bc6756306bb02fef2c7daac1" => :yosemite
    sha256 "a28f864d18858659866cc90ccc4b08539d44df3a92f1b75c2e8d511f3fffdb95" => :mavericks
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
