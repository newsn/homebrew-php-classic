require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55V8js < AbstractPhp55Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "http://pecl.php.net/package/v8js"
  url "https://pecl.php.net/get/v8js-0.6.4.tgz"
  sha256 "88af2c98482374a36b24e317df4684b9eecc92d4883022fc8036a16f2641ca43"

  bottle do
    cellar :any
    sha256 "5e8b22a5a55bcbfa46e2e1e4d4c93581e8b986593b73592dbc67a66909114b62" => :sierra
    sha256 "4a0ff1e8bd731a3f2ea055170c6f84ae09d1ae6974615fd1a89691b34745b536" => :el_capitan
    sha256 "78f75f1bcc7008ef169e727ea95049afd4cf841f67c08cd5f496b9bed2c95691" => :yosemite
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
