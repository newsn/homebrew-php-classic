require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Opcache < AbstractPhp71Extension
  init
  desc "OPcache improves PHP performance"
  homepage "https://php.net/manual/en/book.opcache.php"
  revision 19

  bottle do
    cellar :any_skip_relocation
    sha256 "045836292eec26244f491a7c73602f304f0e8aea93ac87cce154623bd27a370d" => :high_sierra
    sha256 "0036cea2f176ebf385a12afe9883a16526612e65cea71397685649ab494c90d6" => :sierra
    sha256 "8dd2cdea1941d4af8db6f7d6fb369ea99d8fb1035076a974a78ccb2fb82fbfc2" => :el_capitan
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]

  depends_on "pcre"

  def extension_type
    "zend_extension"
  end

  def install
    Dir.chdir "ext/opcache"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/opcache.so"
    write_config_file if build.with? "config-file"
  end
end
