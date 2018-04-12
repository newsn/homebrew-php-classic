require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Maxminddb < AbstractPhp54Extension
  init
  desc "Extension for MaxMind DB file format"
  homepage "https://github.com/maxmind/libmaxminddb"
  url "https://github.com/maxmind/MaxMind-DB-Reader-php/archive/v1.2.0.tar.gz"
  sha256 "b1d0166ac9d7a2df2ec33c2fd3e2ccfcb556f013c8f58df3610e08bbf7e9c383"

  bottle do
    cellar :any
    sha256 "422ddb20c7c06d40622e3d77e3c6b02c2626a966ecd640d9c8be06b5e1b9586e" => :high_sierra
    sha256 "aebdf3913378bf900fd023db1f0a756c87266810cf89ed1ae4f3131bf9906bb2" => :sierra
    sha256 "00556f55f63215248e57c2c21c1fc8d73131a07809d759ee12549454f45b1490" => :el_capitan
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
