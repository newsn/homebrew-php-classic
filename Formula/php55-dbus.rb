require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Dbus < AbstractPhp55Extension
  init
  desc "Extension for interaction with DBUS busses"
  homepage "https://pecl.php.net/package/dbus"
  url "https://pecl.php.net/get/dbus-0.1.1.tgz"
  sha256 "018ce17ceb18bd7085f7151596835b09603140865a49c76130b77e00bc7fcdd7"
  head "http://svn.php.net/repository/pecl/dbus/trunk/"

  bottle do
    rebuild 1
    sha256 "b54098db44cb323c78bc4e0b37b606e0d7f148bbed2b6d51907b1fe24059c036" => :el_capitan
    sha256 "03ff592c7a960b76986805ba7b4dbf44b99226162a5dfabb3d7aba57afaf755b" => :yosemite
    sha256 "c7063400541c4ba9ccedbe9c6063604d76c78164aa9d6bb1bb244269becf227c" => :mavericks
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
