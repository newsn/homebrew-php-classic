require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Xdebug < AbstractPhp55Extension
  init
  desc "Provides debugging and profiling capabilities for PHP"
  homepage "https://xdebug.org"
  url "https://pecl.php.net/get/xdebug-2.5.5.tgz"
  sha256 "72108bf2bc514ee7198e10466a0fedcac3df9bbc5bd26ce2ec2dafab990bf1a4"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "77fcaac9187b1b5d4c7fbecb1c062064e958a5906bffa6b992d06b315d8a3a14" => :sierra
    sha256 "acf0ef44871f5583eb0a0fb21f6744ee49807872209ce644ae95bbc277a29c3a" => :el_capitan
    sha256 "3595361cae200e9d8fb3e3e5eff84e3dcfe9e491ad3b215d12df43c184724d67" => :yosemite
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
