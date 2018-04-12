require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Amqp < AbstractPhp53Extension
  init
  desc "Communicates with any AMQP 0-9-1 compatible server."
  homepage "https://pecl.php.net/package/amqp"
  url "https://pecl.php.net/get/amqp-1.9.1.tgz"
  sha256 "219cdad0ef26d30c9d820be3d0c06a9b35d3d1cb6b7e049948bc952223721119"
  head "https://github.com/pdezwart/php-amqp.git"

  bottle do
    cellar :any
    sha256 "fb1d505f77d8339084146686a9aae5e14693e674d0da77755d229bb0c3a95768" => :sierra
    sha256 "25e564ff0d462a3d50eab4676f2dbf4fe39e99caeba731ef7430828faa821288" => :el_capitan
    sha256 "642c796b50255ea30b9049261690f85d52780d743b44956b5c6881ec53662814" => :yosemite
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
