require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Timezonedb < AbstractPhp55Extension
  init
  desc "Timezone Database to be used with PHP's date & time functions"
  homepage "https://pecl.php.net/package/timezonedb"
  url "https://pecl.php.net/get/timezonedb-2017.2.tgz"
  sha256 "e96ea4045a2886d68d15ad64e8d0ace1dd5287b08226e422bc7befb27944927a"
  head "https://svn.php.net/repository/pecl/timezonedb/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "15d9ffb0a73734980b8a10b7716ad49d6a95eb1e67a0274b11ff752bd0328a38" => :sierra
    sha256 "0cd56cd09c668276e214ca896225c3052b78e5dbed2827c088924d92152dd82c" => :el_capitan
    sha256 "f29b7162ed5550091aa72ba2a91c67448a1bb5baaad8129909686996d3ca7396" => :yosemite
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
