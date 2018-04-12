require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Amqp < AbstractPhp54Extension
  init
  desc "Communicates with any AMQP 0-9-1 compatible server."
  homepage "https://pecl.php.net/package/amqp"
  url "https://pecl.php.net/get/amqp-1.9.1.tgz"
  sha256 "219cdad0ef26d30c9d820be3d0c06a9b35d3d1cb6b7e049948bc952223721119"
  head "https://github.com/pdezwart/php-amqp.git"

  bottle do
    cellar :any
    sha256 "bbe30708e50f9cbee973b976fb646464d12bed1035d333305394daa77cab31f7" => :sierra
    sha256 "11383235a79b7fbdb3813cfd6e5c12c59f71613e1bc23ae01990b2a374138960" => :el_capitan
    sha256 "e0f08e4a105c7bb0897682faa432ee5e4c9706c25e8ae1c4436d3608f55b1989" => :yosemite
  end

  depends_on "rabbitmq-c"

  def install
    Dir.chdir "amqp-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/amqp.so"
    write_config_file if build.with? "config-file"
  end
end
