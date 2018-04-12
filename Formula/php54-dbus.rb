require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Dbus < AbstractPhp54Extension
  init
  desc "Extension for interaction with DBUS busses"
  homepage "https://pecl.php.net/package/dbus"
  url "https://pecl.php.net/get/dbus-0.1.1.tgz"
  sha256 "018ce17ceb18bd7085f7151596835b09603140865a49c76130b77e00bc7fcdd7"
  head "http://svn.php.net/repository/pecl/dbus/trunk/"

  bottle do
    rebuild 1
    sha256 "e4aa9f4a62eafcbf114aeee725c215d3e74a2bade8bc604ccdc062b2b49815e6" => :el_capitan
    sha256 "39f1227587fd9d97cf961198cb21711a63510c0c77ad1c2ad536b547de45031b" => :yosemite
    sha256 "e45619b58f3e818c71051a396abbad26855f45c218c8bbba712bbf9e19734d75" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "dbus"

  def install
    Dir.chdir "dbus-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/dbus.so"
    write_config_file if build.with? "config-file"
  end
end
