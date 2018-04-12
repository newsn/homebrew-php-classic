require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Riak < AbstractPhp56Extension
  init
  desc "Riak client for PHP."
  homepage "http://phpriak.bachpedersen.dk/"
  url "https://pecl.php.net/get/riak-1.2.0.tgz"
  sha256 "696c1999bc08a054b81de3737a130db96abef9f9333b59d55c1bdbb2d50e0593"
  head "https://github.com/TriKaspar/php_riak.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "cec87a5f311acbffb661f5ba4606467f09a9af26bbfc8b3752f23da37482d463" => :el_capitan
    sha256 "b1d7030b5ba9abefb022672f5e563f05c65a696e498dff87d8a40d15c9d4aa0b" => :yosemite
    sha256 "504d20917a421824950138193c5447741976d82ff3c009da6c92c80c47a74d2f" => :mavericks
  end

  option "with-riak", "Also install Riak locally"

  depends_on "riak" => :optional

  def install
    Dir.chdir "riak-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/riak.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<~EOS
      riak.persistent.connections=20
      riak.persistent.timeout=1800
      riak.socket.keep_alive=1
      riak.socket.recv_timeout=10000
      riak.socket.send_timeout=10000
    EOS
  end

  def caveats
    super + <<~EOS

      Note that this formula will NOT install Riak unless you intall
      it with --with-riak option.

      If you want to ensure Riak is installed:
        brew install riak

    EOS
  end
end
