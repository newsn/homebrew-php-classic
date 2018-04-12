require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Maxminddb < AbstractPhp56Extension
  init
  desc "Extension for MaxMind DB file format"
  homepage "https://github.com/maxmind/libmaxminddb"
  url "https://github.com/maxmind/MaxMind-DB-Reader-php/archive/v1.2.0.tar.gz"
  sha256 "b1d0166ac9d7a2df2ec33c2fd3e2ccfcb556f013c8f58df3610e08bbf7e9c383"

  bottle do
    cellar :any
    sha256 "5dc1d518ad454aa7291cecf5aee43b34a1e074ce4b4289b22715aee75cdf89f3" => :high_sierra
    sha256 "13558fb296e0a547651a4f228000a8e6f0c25f94ceb2b0ba9af951d294ab17ad" => :sierra
    sha256 "d4e858f137279aa2a6a1499463f69f224cf21fbe2602f0c9efb338fd2c824b1a" => :el_capitan
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
