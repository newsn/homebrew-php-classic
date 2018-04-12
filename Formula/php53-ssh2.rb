require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Ssh2 < AbstractPhp53Extension
  init
  desc "Provides bindings to the functions of libssh2 which implements the SSH2 protocol."
  homepage "https://pecl.php.net/package/ssh2"
  url "https://pecl.php.net/get/ssh2-0.12.tgz"
  sha256 "600c82d2393acf3642f19914f06a7afea57ee05cb8c10e8a5510b32188b97f99"
  head "https://github.com/php/pecl-networking-ssh2.git", :branch => "php5"

  bottle do
    cellar :any
    sha256 "77fa972a8737eae7b5788ae7f763863dba6997ed7d0507707c81b949ce461023" => :el_capitan
    sha256 "dab535c9987d78d4324b6f52fea394ed1e4f3d745863af55f9f36efe7fded262" => :yosemite
    sha256 "3c72385f38a94bfce3f82d7382b388f55502595844e5e723b0b55823d00ac262" => :mavericks
  end

  depends_on "libssh2"

  def install
    Dir.chdir "ssh2-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-ssh2=#{Formula["libssh2"].opt_prefix}"
    system "make"
    prefix.install "modules/ssh2.so"
    write_config_file if build.with? "config-file"
  end
end
