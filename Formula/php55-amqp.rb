require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Amqp < AbstractPhp55Extension
  init
  desc "Communicates with any AMQP 0-9-1 compatible server."
  homepage "https://pecl.php.net/package/amqp"
  url "https://pecl.php.net/get/amqp-1.9.1.tgz"
  sha256 "219cdad0ef26d30c9d820be3d0c06a9b35d3d1cb6b7e049948bc952223721119"
  head "https://github.com/pdezwart/php-amqp.git"

  bottle do
    cellar :any
    sha256 "58c1c02986ee2a300492052e8aa06608f9b7142a96291b22fc34c1c046972a3f" => :sierra
    sha256 "3993b111c8db77542e45b3f5da25ecc6bb4242423bebd4f11d907376bf2a1601" => :el_capitan
    sha256 "917a4a0cd103dea3cec9fbdc060ad27bb226ea8d53801c5d22112333b8756fac" => :yosemite
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
