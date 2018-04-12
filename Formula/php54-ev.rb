require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Ev < AbstractPhp54Extension
  init
  desc "interface to libev library"
  homepage "https://pecl.php.net/package/ev"
  url "https://pecl.php.net/get/ev-1.0.3.tgz"
  sha256 "3c03fde9e72745e6ce6c32d680218389e0f4310908187f1529b7f227b295aeee"
  head "https://bitbucket.org/osmanov/pecl-ev.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "dfd0d9444425f5c19b51b87f019c89e11470ecc6015317bf10e39d0526342e56" => :el_capitan
    sha256 "a54acf2b92b5ad6a85e37c91baa7f55c76c06b63ff8fa3c61f0db316b4ff71fe" => :yosemite
    sha256 "2a3205d45040c5fb278b9c882216d37bf0a9ad5ea68b21224e790421abc0991b" => :mavericks
  end

  depends_on "libev"

  def install
    Dir.chdir "ev-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-libev=#{Formula["libev"].opt_prefix}"
    system "make"
    prefix.install "modules/ev.so"
    write_config_file if build.with? "config-file"
  end
end
