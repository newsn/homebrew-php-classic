require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Redis < AbstractPhp54Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/3.1.4.tar.gz"
  sha256 "656cab2eb93bd30f30701c1280707c60e5736c5420212d5d547ebe0d3f4baf71"
  head "https://github.com/phpredis/phpredis.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "aeafb2f3999e580108165446bf52249c583728d88137b2960ed705754888bdf2" => :high_sierra
    sha256 "a5a4fb84e894764373255f66b323ad0d319192d886e8c800fc4a3efa8edc452d" => :sierra
    sha256 "5c120d34fca0ca93fbbd0fea7d4b3900e67fc0fa06da7cf2c7056c9361cc7f0b" => :el_capitan
  end

  depends_on "php54-igbinary"
  depends_on "igbinary" => :build

  def install
    args = []
    args << "--enable-redis-igbinary"

    safe_phpize

    # Install symlink to igbinary headers inside memcached build directory
    (Pathname.pwd/"ext").install_symlink Formula["igbinary"].opt_include/"php5" => "igbinary"

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          *args
    system "make"
    prefix.install "modules/redis.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<~EOS

      ; phpredis can be used to store PHP sessions.
      ; To do this, uncomment and configure below
      ;session.save_handler = redis
      ;session.save_path = "tcp://host1:6379?weight=1, tcp://host2:6379?weight=2&timeout=2.5, tcp://host3:6379?weight=2"
    EOS
  end
end
