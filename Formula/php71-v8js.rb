require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71V8js < AbstractPhp71Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "https://pecl.php.net/package/v8js"
  url "https://pecl.php.net/get/v8js-2.1.0.tgz"
  sha256 "2f1b990f91b8ee278a7f29e0f9dadfa694516d489493f1f05bcfb208a16fc33c"

  bottle do
    cellar :any
    sha256 "82cbf16436c9c98649c06479735a1d5a3739e067efb397cc768c8d6d002e8c48" => :high_sierra
    sha256 "b3a3c86ca8b569f6a12744a0f19acda093bdc1f4e1bb52e48456d35a988de6fe" => :sierra
    sha256 "f41a474d23f73a8263499fd4ea6af15f10610b37b2c5ce0213fba2b47bc24e22" => :el_capitan
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
