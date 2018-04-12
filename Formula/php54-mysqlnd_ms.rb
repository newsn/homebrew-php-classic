require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54MysqlndMs < AbstractPhp54Extension
  init
  desc "Replication and load balancing plugin for mysqlnd"
  homepage "https://pecl.php.net/package/mysqlnd_ms"
  url "https://pecl.php.net/get/mysqlnd_ms-1.5.2.tgz"
  sha256 "22b9ba1afb36b3df11c1051c813bc07889c815d1d9993bb07ffda182665b472f"
  head "https://svn.php.net/repository/pecl/mysqlnd_ms/trunk/"

  bottle do
    sha256 "70582aaf75d9bc6dcd9aa9c93c370c1a9da08c631c75317014fc6e9a90c90efc" => :yosemite
    sha256 "c34882192c7f22823d0e3f3ade9c75f634e91d48b586464700cac34432788386" => :mavericks
    sha256 "caff6467525dfdaa5c2f2394101ed9f146bf85553143edf09aefb6ff9cebca56" => :mountain_lion
  end

  def extension
    "mysqlnd_ms"
  end

  def install
    Dir.chdir extension + "-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mysqlnd-ms"

    system "make"
    prefix.install "modules/" + extension + ".so"
    write_config_file if build.with? "config-file"
  end
end
