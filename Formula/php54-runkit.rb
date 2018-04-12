require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Runkit < AbstractPhp54Extension
  init
  desc "Extension to modify consts/functions/classes"
  homepage "http://php.net/manual/en/book.runkit.php"
  url "https://github.com/zenovich/runkit/archive/27f33f55eae4459448fc39fac49daba26bb6b575.tar.gz"
  sha256 "4b19ca9d4003eac6af51dd3b6b8e4365a74351a4fd248f2fe5c546b656a16a99"
  head "https://github.com/zenovich/runkit.git"
  version "5e179e9"

  bottle do
    cellar :any_skip_relocation
    sha256 "f58dc9c01dc732a53e21c0dbcbaacaffb5ca9deb522770d7a3acd93bdc00898b" => :el_capitan
    sha256 "82561b208a813e1558d3b835ee3b52bc9ae72f5def5da7c82d0759feae060345" => :yosemite
    sha256 "3f949098c44fecc6f4a859608d9fd0d5ff1e3cf5f8821ad4d512e73840caa1f4" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/runkit.so"
    write_config_file if build.with? "config-file"
  end
end
