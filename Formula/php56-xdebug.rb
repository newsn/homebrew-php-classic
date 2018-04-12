require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Xdebug < AbstractPhp56Extension
  init
  desc "Provides debugging and profiling capabilities for PHP"
  homepage "https://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.5.5.tgz"
  sha256 "72108bf2bc514ee7198e10466a0fedcac3df9bbc5bd26ce2ec2dafab990bf1a4"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "1e26ec6dc5dc4a17705591e5663f9b5de80a223f8d570ad3a8c3b9c7fa3fd01d" => :sierra
    sha256 "e42dd71ce840b01c1b66218895391461bbe72684d234fe09a5dc39fffb34490d" => :el_capitan
    sha256 "2c1060835cc78a9093e3b4479f192692560c2ca1dd3f2a3fe7e629e1e8de6227" => :yosemite
  end

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "xdebug-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-xdebug"
    system "make"
    prefix.install "modules/xdebug.so"
    write_config_file if build.with? "config-file"
  end
end
