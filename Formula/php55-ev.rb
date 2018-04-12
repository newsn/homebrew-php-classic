require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Ev < AbstractPhp55Extension
  init
  desc "interface to libev library"
  homepage "https://pecl.php.net/package/ev"
  url "https://pecl.php.net/get/ev-1.0.3.tgz"
  sha256 "3c03fde9e72745e6ce6c32d680218389e0f4310908187f1529b7f227b295aeee"
  head "https://bitbucket.org/osmanov/pecl-ev.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "ce6cbc4a765d8944442b11155f44c18e89c1821cb007f8ad203aa8feb587814c" => :el_capitan
    sha256 "c8e73d257afa307d9ed2c4fec825073a7e505afcdb48d9c21291ea75d372229a" => :yosemite
    sha256 "55779684f2b82ebed9373e818edf57971b35c358e333a124222581fb6ad2d726" => :mavericks
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
