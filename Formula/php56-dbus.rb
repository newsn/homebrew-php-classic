require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Dbus < AbstractPhp56Extension
  init
  desc "Extension for interaction with DBUS busses"
  homepage "https://pecl.php.net/package/dbus"
  url "https://pecl.php.net/get/dbus-0.1.1.tgz"
  sha256 "018ce17ceb18bd7085f7151596835b09603140865a49c76130b77e00bc7fcdd7"
  head "http://svn.php.net/repository/pecl/dbus/trunk/"

  bottle do
    rebuild 1
    sha256 "710dbaf6700047d10714a758333233fd801a6048a44cd187bb12f4550721578b" => :el_capitan
    sha256 "be9a633616809cbe71b0a8bf6c6ba0d7bc794ee2bc7cd454ec59a4f7e167bd3f" => :yosemite
    sha256 "4df2daf222f3fc9f46e11a91f1960aefcbfbf412ed262b711e56a8f4051b00ed" => :mavericks
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
