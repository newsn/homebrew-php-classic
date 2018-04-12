require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54V8js < AbstractPhp54Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "http://pecl.php.net/package/v8js"
  url "https://pecl.php.net/get/v8js-0.6.4.tgz"
  sha256 "88af2c98482374a36b24e317df4684b9eecc92d4883022fc8036a16f2641ca43"

  bottle do
    cellar :any
    sha256 "ea2e7001c0769db3f8988bf654dff91ecd45d1ed4d0970df5d159018ed6058dc" => :sierra
    sha256 "c9aed6bbcce291004a07aeb15dbec2b5cb5bdc7412507872f0c0cac688dfb3a7" => :el_capitan
    sha256 "5072074d32f087472950918e15ca817aa4b5f348a45b198f4d9e2b625ec72b3e" => :yosemite
  end

  depends_on "v8"

  def install
    Dir.chdir "v8js-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/v8js.so"
    write_config_file if build.with? "config-file"
  end
end
