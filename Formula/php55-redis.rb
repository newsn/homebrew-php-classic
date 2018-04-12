require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Redis < AbstractPhp55Extension
  init
  desc "PHP extension for Redis"
  homepage "https://github.com/phpredis/phpredis"
  url "https://github.com/phpredis/phpredis/archive/3.1.4.tar.gz"
  sha256 "656cab2eb93bd30f30701c1280707c60e5736c5420212d5d547ebe0d3f4baf71"
  head "https://github.com/phpredis/phpredis.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "ace5d16d5e63b5083ebd4114e05f01144609ce7a5af6a4b13b06105baa56375d" => :high_sierra
    sha256 "cbfb981f1084fd2fa9673d84b77f9c7716abc9917633d03b20dbd7b1fe3ce065" => :sierra
    sha256 "828fc4cbeecf803b65f7ae253d61094c680052d91f653c8e76ae6fc006fc3911" => :el_capitan
  end

  depends_on "php55-igbinary"
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
