require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Varnish < AbstractPhp53Extension
  init
  desc "Varnish Cache bindings"
  homepage "https://pecl.php.net/package/varnish"
  url "https://pecl.php.net/get/varnish-1.2.1.tgz"
  sha256 "13d2a4b63197d66854850c5aef50353d87ce3ed95798ba179fb59e289030183a"

  bottle do
    cellar :any
    sha256 "b25128913c68a4047043700a47bb8f12c3cd2442ddb7d7560289f69280927248" => :el_capitan
    sha256 "856f3de1e5992e7152fe6c3f0296ede47f6c27a39593b14cc875cb4b0e0f498b" => :yosemite
    sha256 "557479b3c1a98d55eb18b25760a927aac7dddf2b8c829d793ff211ffab580557" => :mavericks
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
