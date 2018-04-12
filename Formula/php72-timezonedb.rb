require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Timezonedb < AbstractPhp72Extension
  init
  desc "Timezone Database to be used with PHP's date & time functions"
  homepage "https://pecl.php.net/package/timezonedb"
  url "https://pecl.php.net/get/timezonedb-2017.2.tgz"
  sha256 "e96ea4045a2886d68d15ad64e8d0ace1dd5287b08226e422bc7befb27944927a"
  head "https://svn.php.net/repository/pecl/timezonedb/trunk/"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "8eb6b90a23a3f1284eae4422a234c76f860f716c8f66cca8547cb93ddb8534a8" => :high_sierra
    sha256 "96e0907f0db603696c91fb7cb2aeb6d5622ae4a236f34f6318481d595e51709f" => :sierra
    sha256 "8a1794048d5e0817758b689f0b8cb40c2b266963e337303f54f9daf85ae07173" => :el_capitan
  end

  def install
    Dir.chdir "timezonedb-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/timezonedb.so"
    write_config_file if build.with? "config-file"
  end
end
