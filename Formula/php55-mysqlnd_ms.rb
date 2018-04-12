require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55MysqlndMs < AbstractPhp55Extension
  init
  desc "Replication and load balancing plugin for mysqlnd"
  homepage "https://pecl.php.net/package/mysqlnd_ms"
  url "https://pecl.php.net/get/mysqlnd_ms-1.5.2.tgz"
  sha256 "22b9ba1afb36b3df11c1051c813bc07889c815d1d9993bb07ffda182665b472f"
  head "https://svn.php.net/repository/pecl/mysqlnd_ms/trunk/"

  bottle do
    sha256 "9588bf7a71ef1769001a5d649d99ac017eeedff4f4e43f85f41cae480622d85a" => :yosemite
    sha256 "73653dada3bfca5d04673499c3447830a4277cd472409a752a8860b2432b497d" => :mavericks
    sha256 "4077d0f58ccfa498c3335f76264b677a2aad90173c4d4c41c8dbbdcdc206bd8b" => :mountain_lion
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
