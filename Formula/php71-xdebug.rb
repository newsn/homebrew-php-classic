require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Xdebug < AbstractPhp71Extension
  init
  desc "Provides debugging and profiling capabilities."
  homepage "https://xdebug.org"
  url "https://xdebug.org/files/xdebug-2.6.0.tgz"
  sha256 "b5264cc03bf68fcbb04b97229f96dca505d7b87ec2fb3bd4249896783d29cbdc"
  head "https://github.com/xdebug/xdebug.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "b3c4c522895f6f1a792284214810cbac38412a1d5f04ba2b84afabbb8de031fe" => :high_sierra
    sha256 "b8a301da004ff894ee97da5292655490c2492697f03b0675ca109e01a2e6cf4a" => :sierra
    sha256 "e36f300087b463689fe1b6c427f0ca5c93db2a4e5e578e8692ff064b54a5219f" => :el_capitan
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
