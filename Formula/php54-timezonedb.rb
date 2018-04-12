require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Timezonedb < AbstractPhp54Extension
  init
  desc "Timezone Database to be used with PHP's date & time functions"
  homepage "https://pecl.php.net/package/timezonedb"
  url "https://pecl.php.net/get/timezonedb-2017.2.tgz"
  sha256 "e96ea4045a2886d68d15ad64e8d0ace1dd5287b08226e422bc7befb27944927a"
  head "https://svn.php.net/repository/pecl/timezonedb/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "7c4a4ada8b92a5f3387ef8ac3a58f25605bba0ffe96fcba1351e854eab9f899c" => :sierra
    sha256 "ce09d7ff55eceed9b562fd1fca7b7d8b4b0ece1c6d0afb8ae1d8234c65dbdbf5" => :el_capitan
    sha256 "9bb737b4ff8442552ce0dada7b37cd0b847e50b4fcd0d5e8285c154b3b10689d" => :yosemite
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
