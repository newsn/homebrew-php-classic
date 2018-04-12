require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Maxminddb < AbstractPhp70Extension
  init
  desc "Extension for MaxMind DB file format"
  homepage "https://github.com/maxmind/libmaxminddb"
  url "https://github.com/maxmind/MaxMind-DB-Reader-php/archive/v1.2.0.tar.gz"
  sha256 "b1d0166ac9d7a2df2ec33c2fd3e2ccfcb556f013c8f58df3610e08bbf7e9c383"

  bottle do
    cellar :any
    sha256 "5a2e49aa0159dc55b0ed4fbc6c96b59f80e210bf475f7d6321b50e9e314c92f1" => :high_sierra
    sha256 "58d6ddb97645ac4ffcc3a04393eeb45a4727eff849cae770159d904bc9f6268d" => :sierra
    sha256 "80ebb55a38893ee9b87f14ee462094042d8eb2c4b5b552b887d4b4d9cc1e0a0a" => :el_capitan
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
