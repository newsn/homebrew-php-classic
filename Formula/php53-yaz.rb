require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Yaz < AbstractPhp53Extension
  init
  desc "This extension implements a Z39.50/SRU client for PHP using the YAZ toolkit and the ZOOM framework."
  homepage "http://www.indexdata.com/phpyaz"
  url "https://pecl.php.net/get/yaz-1.1.9.tgz"
  sha256 "9dd4da2fd6042b37a1811972134f852c94a6f6b85ca4ec5ed5d766eb27a6c401"
  revision 1

  bottle do
    sha256 "1ad63d041204013fdcd8721517ddb40f3b8bcb645df1b10ec97d386d26be9705" => :el_capitan
    sha256 "a8a850fbc7eafd8d34792e29e128a920c0011f139c31f4680d7f712bc5a46772" => :yosemite
    sha256 "76e5968708f5c9aef63b2175c6d4081bbeefe5e3b608069ee5e6ddf378f86143" => :mavericks
  end

  depends_on "yaz"

  def install
    Dir.chdir "yaz-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/yaz.so"
    write_config_file if build.with? "config-file"
  end
end
