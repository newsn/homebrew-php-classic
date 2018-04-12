require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Pthreads < AbstractPhp55Extension
  init ["with-thread-safety"]
  desc "Threading API"
  homepage "https://pecl.php.net/package/pthreads"
  url "https://pecl.php.net/get/pthreads-2.0.10.tgz"
  sha256 "8bdf8d8918680421ca0ced1e62292eeb626f800a808d0a3b6812841756588cf6"
  head "https://github.com/krakjoe/pthreads.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "25c6b7ba86efe885305d1c6f54afea6fb6897c9606e502bdf77df47e5b35c2a9" => :el_capitan
    sha256 "f72c4ac21cd8bcb951513a7fb63ccab53a132bcc77c208668d386c4d825b38f3" => :yosemite
    sha256 "bb8ea58d1d628d44958b5daad170210c2c449eb4f6012f3d78fde79f68ddd1b9" => :mavericks
  end

  def install
    Dir.chdir "pthreads-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/pthreads.so"
    write_config_file if build.with? "config-file"
  end
end
