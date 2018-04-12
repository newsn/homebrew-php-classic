require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Uv < AbstractPhp72Extension
  init
  desc "interface to libuv library"
  homepage "https://github.com/bwoebi/php-uv"
  url "https://github.com/bwoebi/php-uv/archive/v0.1.1.tar.gz"
  sha256 "e576df44997a0b656deb4a1c2bfd1879fb3647419b0724bd6e87c7ddf997e2c1"
  head "https://github.com/bwoebi/php-uv.git"
  revision 1

  bottle do
    sha256 "5c64d7d091d48e744437cbf22112e117dd5a9c43f748b890db5de28ba1e22c1a" => :high_sierra
    sha256 "33171601b5c3e40e51e1ed3b48ed18a825cbe269b25a4dbe56ad2dc14b282c52" => :sierra
    sha256 "8ff30422847e7fa583bc2fab21a31ac28763af12d14973a67b5cb73fe0d52669" => :el_capitan
  end

  depends_on "libuv"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-uv=#{Formula["libuv"].opt_prefix}"
    system "make"
    prefix.install "modules/uv.so"
    write_config_file if build.with? "config-file"
  end
end
