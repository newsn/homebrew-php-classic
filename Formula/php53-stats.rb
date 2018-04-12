require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Stats < AbstractPhp53Extension
  init
  desc "Extension with routines for statistical computation."
  homepage "https://pecl.php.net/package/stats"
  url "https://pecl.php.net/get/stats-1.0.3.tgz"
  sha256 "e032e02052acf2013f0578da823d60b0b2a89eb5e1dd1379cf0a65c090dffdfc"
  head "https://svn.php.net/repository/pecl/stats/trunk/"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "d7acc1aea8e0b3f953aeb905ed3323a038795e39310bda8b928b4d9e05829ac0" => :el_capitan
    sha256 "55431563f5d1e3fcd52a6f36da00dcf14d8b33ab5887378f8e6a764752362fbf" => :yosemite
    sha256 "fdb914fac34f22106e4c0d2722826a66c7403f75d7557ded8594da2a06df8e0d" => :mavericks
  end

  def install
    Dir.chdir "stats-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/stats.so"
    write_config_file if build.with? "config-file"
  end
end
