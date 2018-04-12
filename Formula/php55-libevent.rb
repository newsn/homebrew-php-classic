require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Libevent < AbstractPhp55Extension
  init
  desc "This extension is a wrapper for the libevent event notification library."
  homepage "https://pecl.php.net/package/libevent"
  url "https://pecl.php.net/get/libevent-0.0.5.tgz"
  sha256 "04c6ebba72a70694a68141a897e347a7f23e57117bffb80ac21e524529b6af78"
  head "http://svn.php.net/repository/pecl/libevent/trunk/"

  bottle do
    rebuild 1
    sha256 "fe99f493d79f243a3ccad314e6342f0ee90ec5ef912dc068abf579009967ece3" => :el_capitan
    sha256 "bb341e274cf91f892867ac6c5468cc29bae73ccf709fa1c95d06eb75fc5d221d" => :yosemite
    sha256 "fad5ab08259e3e3af93a56dd7ac958a45b1cf3d7b0ed9199a45bf85df0b8a5ab" => :mavericks
  end

  depends_on "libevent"

  def install
    Dir.chdir "libevent-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-libevent=#{Formula["libevent"].opt_prefix}"
    system "make"
    prefix.install "modules/libevent.so"
    write_config_file if build.with? "config-file"
  end
end
