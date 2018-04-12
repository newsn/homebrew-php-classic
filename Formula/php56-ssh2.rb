require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Ssh2 < AbstractPhp56Extension
  init
  desc "Provides bindings to the functions of libssh2 which implements the SSH2 protocol."
  homepage "https://pecl.php.net/package/ssh2"
  url "https://pecl.php.net/get/ssh2-0.12.tgz"
  sha256 "600c82d2393acf3642f19914f06a7afea57ee05cb8c10e8a5510b32188b97f99"
  head "https://github.com/php/pecl-networking-ssh2.git", :branch => "php5"

  bottle do
    cellar :any
    sha256 "dda6e7dccd230ade62ad7255a056cfd89a33fa946ba9fb1a963174512b15d819" => :el_capitan
    sha256 "c2c29f5d2cacc712fc8c2d88b00f6787ba32d2b466bdb2d408d10525bb66c329" => :yosemite
    sha256 "c2be20bd46953dbfd2b48e2815d846440af1bd8c2a1a1b1ba173563e41ce06b8" => :mavericks
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
