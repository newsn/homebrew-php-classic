require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Memcache < AbstractPhp70Extension
  init
  desc "Memcache PHP extension"
  homepage "https://github.com/websupport-sk/pecl-memcache"
  url "https://github.com/websupport-sk/pecl-memcache/archive/4991c2fff22d00dc81014cc92d2da7077ef4bc86.tar.gz"
  version "3.0.9.20160311"
  sha256 "498ae2f3fde66b471eb8662efedfe5cb2f89f5fff725791ffddbcc7d94b7bf21"
  head "https://github.com/websupport-sk/pecl-memcache.git", :branch => "NON_BLOCKING_IO_php7"

  bottle do
    cellar :any_skip_relocation
    sha256 "05354dc21b5a4fb48edc215020f8e64344be0c25f2422d64a910595acbdf7ea8" => :sierra
    sha256 "a93d88ffdcf571b57ee33466195d2da3ceb8ea14d786f7c4aa600cdf065489ab" => :el_capitan
    sha256 "6112c2a8ad25728d47f13dcd0c67c54fd8d1277666026838fb5b8432354d548e" => :yosemite
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/memcache.so"
    write_config_file if build.with? "config-file"
  end
end
