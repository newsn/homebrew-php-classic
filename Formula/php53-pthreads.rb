require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Pthreads < AbstractPhp53Extension
  init ["with-thread-safety"]
  desc "Threading API"
  homepage "https://pecl.php.net/package/pthreads"
  url "https://pecl.php.net/get/pthreads-2.0.10.tgz"
  sha256 "8bdf8d8918680421ca0ced1e62292eeb626f800a808d0a3b6812841756588cf6"
  head "https://github.com/krakjoe/pthreads.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "604e37fb076f39b042a3d1680b05192f591b127e41ddaf187c37c703908ce350" => :yosemite
    sha256 "5431e7c19859445bdd74b996212d710ff6423230bc73f69ac0340fe8bb474c1e" => :mavericks
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
