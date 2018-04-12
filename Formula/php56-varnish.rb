require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Varnish < AbstractPhp56Extension
  init
  desc "Varnish Cache bindings"
  homepage "https://pecl.php.net/package/varnish"
  url "https://pecl.php.net/get/varnish-1.2.1.tgz"
  sha256 "13d2a4b63197d66854850c5aef50353d87ce3ed95798ba179fb59e289030183a"

  bottle do
    cellar :any
    sha256 "8e807c6146257e2db63f3129005d41c81d110b399af1af93fb38d50c22b77fc5" => :el_capitan
    sha256 "db70947a3e14d82db79d4b9de20cb0f92a8075dff6434f2f1c879cf1ac94de87" => :yosemite
    sha256 "717a0e8012cc0df42449ad7297562d039861d8b1fd781215a69ff7efa2de0e63" => :mavericks
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
