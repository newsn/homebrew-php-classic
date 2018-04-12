require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Dbus < AbstractPhp53Extension
  init
  desc "Extension for interaction with DBUS busses"
  homepage "https://pecl.php.net/package/dbus"
  url "https://pecl.php.net/get/dbus-0.1.1.tgz"
  sha256 "018ce17ceb18bd7085f7151596835b09603140865a49c76130b77e00bc7fcdd7"
  head "http://svn.php.net/repository/pecl/dbus/trunk/"

  bottle do
    rebuild 1
    sha256 "03aee7d7e19c4c0b509dd59923c427d00120b995d1a645db3189fe6548c4ce40" => :el_capitan
    sha256 "51a89eb5862f603889b9911f25ee0a48f7f6afbcd36ad95bd102669c6c22e436" => :yosemite
    sha256 "84723ab8f3f096df56a920091fc945874afde520a67ced9aa58419b81096ec5f" => :mavericks
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
