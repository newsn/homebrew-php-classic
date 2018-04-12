require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Propro < AbstractPhp72Extension
  init
  desc "Reusable split-off of pecl_http's property proxy API."
  homepage "https://pecl.php.net/package/propro"
  url "https://github.com/m6w6/ext-propro/archive/release-2.0.1.tar.gz"
  sha256 "0f310cf0ea11950ff48073537b87b99826ad653c8405556fa42475504c263b64"
  head "https://github.com/m6w6/ext-propro.git"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "a05c153629f8c849f91c732d299fc72972ffa52fc6b357d7d56379ff300849dd" => :sierra
    sha256 "2503fb7fe2093265d0d43daf794ed947b6ed9d993f466625bd96fde2637b956a" => :el_capitan
    sha256 "01994cc753bf87c601cfba56df261149d36e785ddc4ec1bdd21af3fd4f869a34" => :yosemite
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    include.install %w[php_propro.h src/php_propro_api.h]
    prefix.install "modules/propro.so"
    write_config_file if build.with? "config-file"
  end
end
