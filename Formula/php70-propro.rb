require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Propro < AbstractPhp70Extension
  init
  desc "Reusable split-off of pecl_http's property proxy API."
  homepage "https://pecl.php.net/package/propro"
  url "https://github.com/m6w6/ext-propro/archive/release-2.0.1.tar.gz"
  sha256 "0f310cf0ea11950ff48073537b87b99826ad653c8405556fa42475504c263b64"
  head "https://github.com/m6w6/ext-propro.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "5ee7b33aea305cef8dc7abcf095b0bd14caa587c92d7010d6b8a54377f22f901" => :sierra
    sha256 "9c89a5d5b1fbf1d44482c29b46f3a5e09d05289f9f38cd1753718d6d61d0363f" => :el_capitan
    sha256 "28815dd57288f3aa81a0c8bb9fb011598632025aff444ee2864bf6c0c8e356eb" => :yosemite
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    include.install %w[php_propro.h src/php_propro_api.h]
    prefix.install "modules/propro.so"
    write_config_file if build.with? "config-file"
  end
end
