require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Uv < AbstractPhp70Extension
  init
  desc "interface to libuv library"
  homepage "https://github.com/bwoebi/php-uv"
  url "https://github.com/bwoebi/php-uv/archive/v0.1.1.tar.gz"
  sha256 "e576df44997a0b656deb4a1c2bfd1879fb3647419b0724bd6e87c7ddf997e2c1"
  head "https://github.com/bwoebi/php-uv.git"

  bottle do
    sha256 "fee2662c2504e5268457d7bf1ba07e254529f5ff12f5b73489004ee64213cf4c" => :sierra
    sha256 "f35e5d417a297e23f5bdf095f2a8365352019b473ddc47fc9793c35166a42e75" => :el_capitan
    sha256 "28792117b9293979331d1692dda5fcb21227ef335f7f2953e49ec1ac0e6aebf5" => :yosemite
  end

  depends_on "libuv"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-uv=#{Formula["libuv"].opt_prefix}"
    system "make"
    prefix.install "modules/uv.so"
    write_config_file if build.with? "config-file"
  end
end
