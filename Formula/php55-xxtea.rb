require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Xxtea < AbstractPhp55Extension
  init
  desc "XXTEA encryption algorithm extension for PHP."
  homepage "https://pecl.php.net/package/xxtea"
  url "https://pecl.php.net/get/xxtea-1.0.11.tgz"
  sha256 "5b1e318d3e70b27ad017d125d09ba3cf7bb3859e11be864a7bc3ddba421108af"
  head "https://github.com/xxtea/xxtea-pecl.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "95c992046b51cb7cb2e2cc19d75b1b06824a70f5a2bbb633c0c611f4b9914aeb" => :el_capitan
    sha256 "a7f35485af4cf128ad9c7c175a7546eb8036a4500c9a57d10fb60f01f67da6e7" => :yosemite
  end

  def install
    Dir.chdir "xxtea-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/xxtea.so"
    write_config_file if build.with? "config-file"
  end
end
