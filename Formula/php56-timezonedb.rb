require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Timezonedb < AbstractPhp56Extension
  init
  desc "Timezone Database to be used with PHP's date & time functions"
  homepage "https://pecl.php.net/package/timezonedb"
  url "https://pecl.php.net/get/timezonedb-2017.2.tgz"
  sha256 "e96ea4045a2886d68d15ad64e8d0ace1dd5287b08226e422bc7befb27944927a"
  head "https://svn.php.net/repository/pecl/timezonedb/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "39fa33ff7fab0c375e29d3a3c9077025ffb1acc5d91cb9c1a1dd2f2eed596969" => :sierra
    sha256 "15c4b4b4168e2fbc9d0447a2dc1312bc28c76a8c25339aad25d828775ee6972e" => :el_capitan
    sha256 "bfe9756c29999304266fb85bc2712300ecca9531ef5c961d5488b9547cf6e08f" => :yosemite
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
