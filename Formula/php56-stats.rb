require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Stats < AbstractPhp56Extension
  init
  desc "Extension with routines for statistical computation."
  homepage "https://pecl.php.net/package/stats"
  url "https://pecl.php.net/get/stats-1.0.3.tgz"
  sha256 "e032e02052acf2013f0578da823d60b0b2a89eb5e1dd1379cf0a65c090dffdfc"
  head "https://svn.php.net/repository/pecl/stats/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "d0399e8c5542bb7097c523a8f4e3953a29a9653e9073e96c8488c606a8aeb8dd" => :el_capitan
    sha256 "1f0eca75dce69254160857462e128313ef1331605be9f3f2469df033817d3d83" => :yosemite
    sha256 "2b895946a0310cf3818696c73bdcbea703b9dc423b719bd005f439ba22f984e2" => :mavericks
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
