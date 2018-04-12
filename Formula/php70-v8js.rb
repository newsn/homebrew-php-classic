require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70V8js < AbstractPhp70Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "https://pecl.php.net/package/v8js"
  url "https://pecl.php.net/get/v8js-2.1.0.tgz"
  sha256 "2f1b990f91b8ee278a7f29e0f9dadfa694516d489493f1f05bcfb208a16fc33c"

  bottle do
    cellar :any
    sha256 "d2b6de003da812dc6d110d2457422a7bd94ebcc35a823cec5d12d6f9e56033de" => :high_sierra
    sha256 "2ce1061e4267d15836a10a06b8798d99b73c9ffcffe0adf3fd0afa3ead3cb8af" => :sierra
    sha256 "978fcb275491244e02502147251f1d8ddd95eced823724570684747f8e4bb869" => :el_capitan
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
