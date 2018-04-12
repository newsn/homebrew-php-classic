require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Maxminddb < AbstractPhp71Extension
  init
  desc "Extension for MaxMind DB file format"
  homepage "https://github.com/maxmind/libmaxminddb"
  url "https://github.com/maxmind/MaxMind-DB-Reader-php/archive/v1.2.0.tar.gz"
  sha256 "b1d0166ac9d7a2df2ec33c2fd3e2ccfcb556f013c8f58df3610e08bbf7e9c383"

  bottle do
    cellar :any
    sha256 "ce9cc958a65218101f1e6bacfaf569ffc1c0a54045622c67c7212fb4b2f9a841" => :high_sierra
    sha256 "6a7b5eb85432731ac01a45da621bdd918ee42e634f2a864edf4d8bba00c0b69d" => :sierra
    sha256 "5d224239413cd88605433157c0e74f22c3fe4562a47f659128b6e756ae5659df" => :el_capitan
  end

  depends_on "libmaxminddb"

  def install
    Dir.chdir "ext"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-maxminddb=#{Formula["libmaxminddb"].opt_prefix}", phpconfig
    system "make"
    prefix.install "modules/maxminddb.so"
    write_config_file if build.with? "config-file"
  end
end
