require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Yaz < AbstractPhp55Extension
  init
  desc "This extension implements a Z39.50/SRU client for PHP using the YAZ toolkit and the ZOOM framework."
  homepage "http://www.indexdata.com/phpyaz"
  url "https://pecl.php.net/get/yaz-1.1.9.tgz"
  sha256 "9dd4da2fd6042b37a1811972134f852c94a6f6b85ca4ec5ed5d766eb27a6c401"
  revision 1

  bottle do
    sha256 "8e36b829db86f164f9cfaddb4bd63e93a94b1f4d6b31d1f46ed18144780f018e" => :el_capitan
    sha256 "31335f538ae2395c97e594ee625cb41f4c8211d6e1dc44a998625c17de11613d" => :yosemite
    sha256 "c305aa5aba3e3988fb4a58af91500137ccfce3e48ac621451bc9bb24cb6ba4eb" => :mavericks
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
