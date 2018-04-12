require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Yaf < AbstractPhp53Extension
  init
  desc "Yaf is a PHP framework similar to zend framework, which is written in c and built as PHP extension"
  homepage "https://pecl.php.net/package/yaf"
  url "https://pecl.php.net/get/yaf-2.3.3.tgz"
  sha256 "fb59db901008b157d11c255f1a1492ccd02df2e2ab9869aa4f9fa9fc73272298"
  head "https://svn.php.net/repository/pecl/yaf/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "ed137b28127b78aebb5f0d981ddad497cd8f6f0adb68fedaf0336dec7bb2cc02" => :el_capitan
    sha256 "588e04eee4265b4c7052dfdfa6487b9fe94b58f85eb4a1d792e49214559f00ca" => :yosemite
    sha256 "1d427ba5c7f274d87929c7525673e8861d5a3beaff34e8d15e27540ae50f5caa" => :mavericks
  end

  depends_on "pcre"

  def install
    Dir.chdir "yaf-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/yaf.so"
    write_config_file if build.with? "config-file"
  end
end
