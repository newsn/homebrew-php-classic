require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pthreads < AbstractPhp56Extension
  init ["with-thread-safety"]
  desc "Threading API"
  homepage "https://pecl.php.net/package/pthreads"
  url "https://pecl.php.net/get/pthreads-2.0.10.tgz"
  sha256 "8bdf8d8918680421ca0ced1e62292eeb626f800a808d0a3b6812841756588cf6"
  head "https://github.com/krakjoe/pthreads.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "d9e0dd0b63d9b1f9a0f62525610bc8b0cf015e964be7037e93fc3e2fe804c3ae" => :el_capitan
    sha256 "598b3daa4ff0795210948319fe1d9fed126b28562ab3f059bd560baae0b2ad29" => :yosemite
    sha256 "031eb35b688124b7f62d543f36602b2b9493496457e9fc45d338d2de966bb25c" => :mavericks
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
