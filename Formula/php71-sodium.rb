require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Sodium < AbstractPhp71Extension
  init
  desc "Modern and easy-to-use crypto library"
  homepage "https://github.com/jedisct1/libsodium-php"
  url "https://github.com/jedisct1/libsodium-php/archive/2.0.10.tar.gz"
  sha256 "2eebf3772d7441449b47abfe8f52043b9c6d6b5aff66aebd339c5d459d7fca28"
  head "https://github.com/jedisct1/libsodium-php.git"

  bottle do
    cellar :any
    sha256 "9499cc89bae1f6c8f238ef6aa1e60817eef6a66ad7464c9bdab239a182ceff40" => :high_sierra
    sha256 "19b6022421c2646878a06a6932e48672d8225ae6d3893fe70412388eb56535da" => :sierra
    sha256 "f72fce2898c192c2e767d4b73a8f1d105843217aee999126f8b42810458cb26b" => :el_capitan
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
