require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Yaz < AbstractPhp56Extension
  init
  desc "This extension implements a Z39.50/SRU client for PHP using the YAZ toolkit and the ZOOM framework."
  homepage "http://www.indexdata.com/phpyaz"
  url "https://pecl.php.net/get/yaz-1.1.9.tgz"
  sha256 "9dd4da2fd6042b37a1811972134f852c94a6f6b85ca4ec5ed5d766eb27a6c401"
  revision 1

  bottle do
    sha256 "7128b74519c2196ba51c3a686364d3b6739d865a9ae546e59cb2a2004261a219" => :el_capitan
    sha256 "b2a6c44c75e1374ea47ec3c752ffa964720158079e2ff489f8822ea51c7d703c" => :yosemite
    sha256 "6b9991268ff066eae430f044c4089c9a23bc0cd44905479793541ac7b7799c99" => :mavericks
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
