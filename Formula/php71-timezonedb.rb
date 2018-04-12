require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Timezonedb < AbstractPhp71Extension
  init
  desc "Timezone Database to be used with PHP's date & time functions"
  homepage "https://pecl.php.net/package/timezonedb"
  url "https://pecl.php.net/get/timezonedb-2017.2.tgz"
  sha256 "e96ea4045a2886d68d15ad64e8d0ace1dd5287b08226e422bc7befb27944927a"
  head "https://svn.php.net/repository/pecl/timezonedb/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "e60946b4b30503dd5910d27dedb5a2f0611dda756fd007a551cbb4c01063a63a" => :sierra
    sha256 "9503a39428961822771367f5a878d4124b7cbd379de4b203e489bfc02ca76f5e" => :el_capitan
    sha256 "0d597232de588323176e479201b1c171037690e1f7b0db419d54404895324d3a" => :yosemite
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
