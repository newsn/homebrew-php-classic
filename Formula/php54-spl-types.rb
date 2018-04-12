require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54SplTypes < AbstractPhp54Extension
  init
  desc "SPL Types is a collection of special typehandling classes."
  homepage "https://pecl.php.net/package/SPL_Types"
  url "https://pecl.php.net/get/SPL_Types-0.4.0.tgz"
  sha256 "b44101401b2664822fd17e6f491d912203496108ff9d0b86b043bff67c5f724f"

  bottle do
    cellar :any_skip_relocation
    sha256 "6d1baad8ddcaf4ea2f5ede1460174dcc29e1f6b518478f2f0020abdef68c19d8" => :el_capitan
    sha256 "d202ec249b3f8ae2cb9810a97c6aeeb6798d369c6a48882b043a13331f45cf4a" => :yosemite
    sha256 "be66a4d148f9855fba42e215417187383b515af25fd9478e127c2dcab3796fb1" => :mavericks
  end

  def install
    Dir.chdir "SPL_Types-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/spl_types.so"
    write_config_file if build.with? "config-file"
  end

  def extension
    "spl_types"
  end
end
