require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Riak < AbstractPhp55Extension
  init
  desc "Riak client for PHP."
  homepage "http://phpriak.bachpedersen.dk/"
  url "https://pecl.php.net/get/riak-1.2.0.tgz"
  sha256 "696c1999bc08a054b81de3737a130db96abef9f9333b59d55c1bdbb2d50e0593"
  head "https://github.com/TriKaspar/php_riak.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "0e744d483ce3115a02f746180d375a4ebfe281aef937ed4acad4eb23d4c47399" => :el_capitan
    sha256 "dca1030c0c3f17700586981acfd899a218067c94312ac188b9ef5ae29baf93a5" => :yosemite
    sha256 "32bc84b264979e7535f3c49f0b9f269ced1687d04d123bf5dd81ebb9154898ac" => :mavericks
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
