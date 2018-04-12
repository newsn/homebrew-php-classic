require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Maxminddb < AbstractPhp53Extension
  init
  desc "Extension for MaxMind DB file format"
  homepage "https://github.com/maxmind/libmaxminddb"
  url "https://github.com/maxmind/MaxMind-DB-Reader-php/archive/v1.1.0.tar.gz"
  sha256 "0c80f55bc56dd8f26b04358b5533f78adcb060f721b4347f510cbf43f32848b4"

  bottle do
    cellar :any
    sha256 "94eda058a4f61587dccaf5f8c84a19ce18ab00e3aa409b051cc70c44f478cb64" => :el_capitan
    sha256 "ffab3d31c50796c9adfd8b372db1ae6160933d5349340a8ebf1a1eb1c7c0df4d" => :yosemite
    sha256 "152f22a85f52dfd907319a0d3a39813674035d8949986ffa735b6e881cd1ee1f" => :mavericks
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
