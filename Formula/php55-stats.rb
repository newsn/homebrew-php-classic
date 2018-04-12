require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Stats < AbstractPhp55Extension
  init
  desc "Extension with routines for statistical computation."
  homepage "https://pecl.php.net/package/stats"
  url "https://pecl.php.net/get/stats-1.0.3.tgz"
  sha256 "e032e02052acf2013f0578da823d60b0b2a89eb5e1dd1379cf0a65c090dffdfc"
  head "https://svn.php.net/repository/pecl/stats/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "476fde582d69af590139392d262dc01426893a82765fec6a3ff8669f2eec7d22" => :el_capitan
    sha256 "b272a90144dee6f6174fa6e5d41de376b1ca48964a9edca36833d4d9eec8f696" => :yosemite
    sha256 "5ae966beec346099d16f557fd30fcddf290f941f5fec1720811fdc7b3e96ebe6" => :mavericks
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
