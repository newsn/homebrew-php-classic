require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Stats < AbstractPhp72Extension
  init
  desc "Extension with routines for statistical computation."
  homepage "https://pecl.php.net/package/stats"
  url "https://pecl.php.net/get/stats-2.0.1.tgz"
  sha256 "994da82975364773248091bb3f83cc5f101db70e88c79af8a60bea8ad054dd06"
  head "https://git.php.net/repository/pecl/math/stats.git"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "9be64d7dfc829ed7b5dae464581324b33e12824ff06a647aa60a8f6429d748ed" => :high_sierra
    sha256 "11d879566b14e52fcfa26e711fc1a83233aa912d7f1ca6ea792a816c33b762da" => :sierra
    sha256 "c7550cee452bd30d790f224c4a3b6528073ca0957fd44dc6b3f4d43101e7a899" => :el_capitan
  end

  def install
    Dir.chdir "stats-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/stats.so"
    write_config_file if build.with? "config-file"
  end
end
