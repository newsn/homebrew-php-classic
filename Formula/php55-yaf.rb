require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Yaf < AbstractPhp55Extension
  init
  desc "Yaf is a PHP framework similar to zend framework, which is written in c and built as PHP extension"
  homepage "https://pecl.php.net/package/yaf"
  url "https://pecl.php.net/get/yaf-2.3.3.tgz"
  sha256 "fb59db901008b157d11c255f1a1492ccd02df2e2ab9869aa4f9fa9fc73272298"
  head "https://svn.php.net/repository/pecl/yaf/trunk/"

  bottle do
    cellar :any_skip_relocation
    sha256 "905de50c6c680d37c07161ef7f3ce5a77b2225990e0eded39293f961ee124d4e" => :el_capitan
    sha256 "e365cc360489370ca9c0715aa7d03792f826d76cdfcb8f3bf0445f5c66307198" => :yosemite
    sha256 "7c5c9f18a189ab2ba844d15546d0205d918e53d20ebe25cc242ee97d7d25dda3" => :mavericks
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
