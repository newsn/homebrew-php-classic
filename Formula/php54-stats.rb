require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Stats < AbstractPhp54Extension
  init
  desc "Extension with routines for statistical computation."
  homepage "https://pecl.php.net/package/stats"
  url "https://pecl.php.net/get/stats-1.0.3.tgz"
  sha256 "e032e02052acf2013f0578da823d60b0b2a89eb5e1dd1379cf0a65c090dffdfc"
  head "https://svn.php.net/repository/pecl/stats/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "cca332cf6e5ad6008510a31e5c2861f0741514374b56935fabe06037db0adf13" => :el_capitan
    sha256 "f72b0d69ee94a609b54183d15812be4947bd2713b33c18798345f4a6569b0f5a" => :yosemite
    sha256 "e661860210f4f4943bcd33827174eedeb9171d8a238c786e7fabf96bcd467e06" => :mavericks
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
