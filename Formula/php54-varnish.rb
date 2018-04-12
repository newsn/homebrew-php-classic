require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Varnish < AbstractPhp54Extension
  init
  desc "Varnish Cache bindings"
  homepage "https://pecl.php.net/package/varnish"
  url "https://pecl.php.net/get/varnish-1.2.1.tgz"
  sha256 "13d2a4b63197d66854850c5aef50353d87ce3ed95798ba179fb59e289030183a"

  bottle do
    cellar :any
    sha256 "8f519f6a2a6d9c117f3b1b5b4a2943e2fb62cb910850fffb6ad11a5687d30dea" => :el_capitan
    sha256 "8aab7391a62de89fb2fc9b1575cc996bc03932aed0276d50dc1c5b9ec9632be2" => :yosemite
    sha256 "9c84d29678476beeb18c91ebc752009294e506f12bbdf7d88c99f082c349e481" => :mavericks
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
