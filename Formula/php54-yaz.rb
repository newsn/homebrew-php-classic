require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Yaz < AbstractPhp54Extension
  init
  desc "This extension implements a Z39.50/SRU client for PHP using the YAZ toolkit and the ZOOM framework."
  homepage "http://www.indexdata.com/phpyaz"
  url "https://pecl.php.net/get/yaz-1.1.9.tgz"
  sha256 "9dd4da2fd6042b37a1811972134f852c94a6f6b85ca4ec5ed5d766eb27a6c401"
  revision 1

  bottle do
    sha256 "59704b19c95435e6de9f9c51ace3253b423e3be6809f1f18dbca1e8c31bf6bd1" => :el_capitan
    sha256 "062e28bd4475279d48db155c90f60171c665284f08373310e618fdc63aeeb05b" => :yosemite
    sha256 "efb41289705af662e5d73b48eaf0c63d7ec2ec6a6e8f31c2e12cbc71ecaec571" => :mavericks
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
