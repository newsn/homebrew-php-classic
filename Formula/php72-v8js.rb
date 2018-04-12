require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72V8js < AbstractPhp72Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "https://pecl.php.net/package/v8js"
  url "https://pecl.php.net/get/v8js-2.1.0.tgz"
  sha256 "2f1b990f91b8ee278a7f29e0f9dadfa694516d489493f1f05bcfb208a16fc33c"
  head "https://github.com/phpv8/v8js.git"

  bottle do
    cellar :any
    sha256 "cd923ba5f773145ebaac5c4323c8d50f43ffa37f1232e7935f5c490052de2bc2" => :high_sierra
    sha256 "d8dcc1aa354236cf16385840a373c89a6b2bc5b42ab5da412b25f6353807f994" => :sierra
    sha256 "6ae0136e3fd9b32f3c34005ea21949c2b9d52ed4f28e25ea02eb1526fe407a60" => :el_capitan
  end

  depends_on "v8"

  def install
    Dir.chdir "v8js-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/v8js.so"
    write_config_file if build.with? "config-file"
  end
end
