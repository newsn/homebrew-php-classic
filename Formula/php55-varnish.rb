require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Varnish < AbstractPhp55Extension
  init
  desc "Varnish Cache bindings"
  homepage "https://pecl.php.net/package/varnish"
  url "https://pecl.php.net/get/varnish-1.2.1.tgz"
  sha256 "13d2a4b63197d66854850c5aef50353d87ce3ed95798ba179fb59e289030183a"

  bottle do
    cellar :any
    sha256 "6c78c34e5e00eac0d41554b00feed1aad7345129670afc64d62fa661e41c6627" => :el_capitan
    sha256 "5a7f3297f8421b435ddb80129fab1686d7b0088df66c80f7b05d4d1a97d6142a" => :yosemite
    sha256 "e716c2fa9bd20bfa3913bf30ba207698c5b15345a29304fc3c8f71cee44d23be" => :mavericks
  end

  depends_on "varnish"

  def install
    Dir.chdir "varnish-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize

    args = []
    args << "--with-varnish=#{Formula["varnish"].opt_prefix}"
    args << "--prefix=#{prefix}"
    args << phpconfig

    system "./configure", *args
    system "make"
    prefix.install "modules/varnish.so"
    write_config_file if build.with? "config-file"
  end
end
