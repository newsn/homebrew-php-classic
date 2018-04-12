require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Libvirt < AbstractPhp56Extension
  init
  desc "PHP bindings for libvirt virtualization toolkit"
  homepage "http://libvirt.org/php"
  url "http://libvirt.org/sources/php/libvirt-php-0.4.8.tar.gz"
  sha256 "75508ab420c45fface8cdd8328053eee2207f8ff2aab572627ba8f30aacaef35"

  bottle do
    cellar :any
    rebuild 1
    sha256 "b0fdda922b7b79352a714bd92784caa045f805294c8cba7169726b0c93d25b68" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "libvirt"

  def install
    ENV.universal_binary if build.universal?

    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "src/libvirt-php.so" => "libvirt.so"
    write_config_file if build.with? "config-file"
  end
end
