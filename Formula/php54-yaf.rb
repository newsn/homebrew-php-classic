require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Yaf < AbstractPhp54Extension
  init
  desc "Yaf is a PHP framework similar to zend framework, which is written in c and built as PHP extension"
  homepage "https://pecl.php.net/package/yaf"
  url "https://pecl.php.net/get/yaf-2.3.3.tgz"
  sha256 "fb59db901008b157d11c255f1a1492ccd02df2e2ab9869aa4f9fa9fc73272298"
  head "https://svn.php.net/repository/pecl/yaf/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "4fc1ba1330e0847bd39c75f652cb26e07d81895e746ff9b256883e0566b9aef7" => :el_capitan
    sha256 "9b0a3a835c4af945b22491be9f7112cb7733b14aa4685a764db84b3a5ea0fc4f" => :yosemite
    sha256 "f384109cd36a659db1a761d3d0327a52da12c93619075f20a893ac68ed9be933" => :mavericks
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
