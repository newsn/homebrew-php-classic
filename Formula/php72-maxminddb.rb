require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Maxminddb < AbstractPhp72Extension
  init
  desc "Extension for MaxMind DB file format"
  homepage "https://github.com/maxmind/libmaxminddb"
  url "https://github.com/maxmind/MaxMind-DB-Reader-php/archive/v1.2.0.tar.gz"
  sha256 "b1d0166ac9d7a2df2ec33c2fd3e2ccfcb556f013c8f58df3610e08bbf7e9c383"

  bottle do
    cellar :any
    sha256 "2921ba9d2e2d2aeb4ce239127761f94f9f5a66de6b9f4d74d1e17d222ef4d969" => :high_sierra
    sha256 "fc21808fe33ecdb00d096dac823f6dd57c710e12e40a73f82ce12be77c798566" => :sierra
    sha256 "378fc42d1ad0047eb2f71b76f34d22e928f321ef4e9140958ad1f8df67c8689c" => :el_capitan
  end

  depends_on "libmaxminddb"

  def install
    Dir.chdir "ext"

    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-maxminddb=#{Formula["libmaxminddb"].opt_prefix}", phpconfig
    system "make"
    prefix.install "modules/maxminddb.so"
    write_config_file if build.with? "config-file"
  end
end
