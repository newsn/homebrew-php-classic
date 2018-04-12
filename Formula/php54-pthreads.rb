require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Pthreads < AbstractPhp54Extension
  init ["with-thread-safety"]
  desc "Threading API"
  homepage "https://pecl.php.net/package/pthreads"
  url "https://pecl.php.net/get/pthreads-2.0.10.tgz"
  sha256 "8bdf8d8918680421ca0ced1e62292eeb626f800a808d0a3b6812841756588cf6"
  head "https://github.com/krakjoe/pthreads.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "677a515578649f25e92a30a84137d74dc35883d7929646436288bd44b5da3944" => :el_capitan
    sha256 "0e4c04ff027ab96c7f09d7b58a5ea9fb5b34f2499924ad3fd0004cffb5218a25" => :yosemite
    sha256 "7c5ba48cdabdf138c5de7f024dc137e208a580eda72176403142dc29cebdcc84" => :mavericks
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
