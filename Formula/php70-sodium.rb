require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Sodium < AbstractPhp70Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/2.0.10.tar.gz"
  sha256 "2eebf3772d7441449b47abfe8f52043b9c6d6b5aff66aebd339c5d459d7fca28"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    sha256 "4f1799e3aa98521642b96e59e7e0d289def3784af1d9e347d2dd80db964d2c19" => :high_sierra
    sha256 "32d5648ef83dc0a90e28141507faa53e77c98c9262e48979738e5c62282415e7" => :sierra
    sha256 "f5dd1184a0ad287691d1ab5f061cf807619758a81ab2ca0098bb553f3d63c6d3" => :el_capitan
  end

  depends_on "libsodium"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/sodium.so"
    write_config_file if build.with? "config-file"
  end
end
