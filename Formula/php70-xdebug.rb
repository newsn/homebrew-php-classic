require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Xdebug < AbstractPhp70Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  url "https://xdebug.org/files/xdebug-2.6.0.tgz"
  sha256 "b5264cc03bf68fcbb04b97229f96dca505d7b87ec2fb3bd4249896783d29cbdc"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "068bbf7c91222e0c97fd9d1116985bade3026b0abb65ce867f2d7643c95db4df" => :high_sierra
    sha256 "6379dec9cc24c759b21635a91a4f463c2739996d680ef49cdfce4ec1a92b30af" => :sierra
    sha256 "e8df7a194894775e696f45cba1cc9d30947185f95fa2a9dc46dd236d5bcf382b" => :el_capitan
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
