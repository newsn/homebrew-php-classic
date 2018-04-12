require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Riak < AbstractPhp54Extension
  init
  desc "Riak client for PHP."
  homepage "http://phpriak.bachpedersen.dk/"
  url "https://pecl.php.net/get/riak-1.2.0.tgz"
  sha256 "696c1999bc08a054b81de3737a130db96abef9f9333b59d55c1bdbb2d50e0593"
  head "https://github.com/TriKaspar/php_riak.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "3357c4d5a5a220321a6291a315821030236f4003bb5245deb0147b90a6a1caf0" => :el_capitan
    sha256 "cf5a73cfa61e40033ba76c18b2f39bd70d7d1d540177e5a815c2ec91f059e3f2" => :yosemite
    sha256 "27dbe536f49b6cc100cd218ca958967864293afdfcf6c68b673d67b458230931" => :mavericks
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
