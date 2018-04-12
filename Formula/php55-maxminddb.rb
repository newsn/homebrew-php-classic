require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Maxminddb < AbstractPhp55Extension
  init
  desc "Extension for MaxMind DB file format"
  homepage "https://github.com/maxmind/libmaxminddb"
  url "https://github.com/maxmind/MaxMind-DB-Reader-php/archive/v1.2.0.tar.gz"
  sha256 "b1d0166ac9d7a2df2ec33c2fd3e2ccfcb556f013c8f58df3610e08bbf7e9c383"

  bottle do
    cellar :any
    sha256 "362425a6f18dd3912d15cfe6d2a770a662080ce2f0c2b9f741db37578681d0ee" => :high_sierra
    sha256 "680c8a9fbc6c6845286cc9dcda36493bdf47f40c4e882eb42fc5d131b0d800dc" => :sierra
    sha256 "181619f360e8501615ed8867aa3793aa26a66dc46cc4737548c46f279a2818b2" => :el_capitan
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
