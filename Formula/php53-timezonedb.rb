require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Timezonedb < AbstractPhp53Extension
  init
  desc "Timezone Database to be used with PHP's date & time functions"
  homepage "https://pecl.php.net/package/timezonedb"
  url "https://pecl.php.net/get/timezonedb-2017.2.tgz"
  sha256 "e96ea4045a2886d68d15ad64e8d0ace1dd5287b08226e422bc7befb27944927a"
  head "https://svn.php.net/repository/pecl/timezonedb/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "25684dded073502b1021d59aaa3fdc6131860424713cc39ba7ec493416d642aa" => :sierra
    sha256 "c8473efa4327257e3eab05f1b4cee6d432d5c2a1e16cc45242f5ca5db13f68d3" => :el_capitan
    sha256 "79abdadcc94ddff6cf064f6d7f4f67eced1c3533bf0dd5f485ec44866c5dbc13" => :yosemite
  end

  def install
    Dir.chdir "timezonedb-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/timezonedb.so"
    write_config_file if build.with? "config-file"
  end
end
