require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Ref < AbstractPhp71Extension
  init
  desc "Soft and Weak references support for PHP"
  homepage "https://github.com/pinepain/php-ref"
  url "https://github.com/pinepain/php-ref/archive/v0.5.0.tar.gz"
  sha256 "0fd928fd8314f836a97e3833d6c5e15658202d05fe3a0725d793f6e06394cd97"
  head "https://github.com/pinepain/php-ref.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "98110186a0c3bce0b20360635a8f556a1fbace0efceb1a9fa13db2f9c6be5ae4" => :high_sierra
    sha256 "b6b3f4040c5a2450d7bc02ba82236511accd62e1f9a9ec723503c79e53621bb6" => :sierra
    sha256 "65cd8065477c5832c340592adb17d5eab4a8ae91b411d1b8a0d394fd8da23512" => :el_capitan
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig

    system "make"
    prefix.install "modules/ref.so"
    write_config_file if build.with? "config-file"
  end
end
