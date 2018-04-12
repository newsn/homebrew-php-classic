require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Yaf < AbstractPhp56Extension
  init
  desc "Yaf is a PHP framework similar to zend framework, which is written in c and built as PHP extension"
  homepage "https://pecl.php.net/package/yaf"
  url "https://pecl.php.net/get/yaf-2.3.3.tgz"
  sha256 "fb59db901008b157d11c255f1a1492ccd02df2e2ab9869aa4f9fa9fc73272298"
  head "https://svn.php.net/repository/pecl/yaf/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "5634fb8c7478c0a152887344134f6fcc6da759fe0cdaefd9016aa134c8d7b5da" => :el_capitan
    sha256 "768821370e69deb296f787529f88deaf53caf868d8f46fed768b38a98b1fa62b" => :yosemite
    sha256 "6f53e8a1bcfe463635f99356b25efa6f9951b413abc3e6eb5b6f6390a2e2eb55" => :mavericks
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
