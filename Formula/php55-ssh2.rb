require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Ssh2 < AbstractPhp55Extension
  init
  desc "Provides bindings to the functions of libssh2 which implements the SSH2 protocol."
  homepage "https://pecl.php.net/package/ssh2"
  url "https://pecl.php.net/get/ssh2-0.12.tgz"
  sha256 "600c82d2393acf3642f19914f06a7afea57ee05cb8c10e8a5510b32188b97f99"
  head "https://github.com/php/pecl-networking-ssh2.git", :branch => "php5"

  bottle do
    cellar :any
    sha256 "e254f2108673113391d08b7223af30d95559e8ebeb5a2989d0e9cba417a7f4da" => :el_capitan
    sha256 "6e4068648b923a0e4f28cbeab484c99e03805299e4e67d696dabcb79ccbdf149" => :yosemite
    sha256 "708777ec6e62fa42a86a8ee0a7396e0f267c99f11af46322f73d55deb9b54eaf" => :mavericks
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
