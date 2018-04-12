require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Timezonedb < AbstractPhp70Extension
  init
  desc "Timezone Database to be used with PHP's date & time functions"
  homepage "https://pecl.php.net/package/timezonedb"
  url "https://pecl.php.net/get/timezonedb-2017.2.tgz"
  sha256 "e96ea4045a2886d68d15ad64e8d0ace1dd5287b08226e422bc7befb27944927a"
  head "https://svn.php.net/repository/pecl/timezonedb/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "bcd9762dadd884a7c4380b98b850f05d8d5a8af97b88cec08ee2d3932faefdb0" => :sierra
    sha256 "0df3aeb24eea1f0f564e30e83e6ca958bf72d006280efac19e83fdd2c263a453" => :el_capitan
    sha256 "a4e4ea4d28fa5776ede810004d8aa49637737d9bb3638ecb93ad870ab3193214" => :yosemite
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
