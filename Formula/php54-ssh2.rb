require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Ssh2 < AbstractPhp54Extension
  init
  desc "Provides bindings to the functions of libssh2 which implements the SSH2 protocol."
  homepage "https://pecl.php.net/package/ssh2"
  url "https://pecl.php.net/get/ssh2-0.12.tgz"
  sha256 "600c82d2393acf3642f19914f06a7afea57ee05cb8c10e8a5510b32188b97f99"
  head "https://github.com/php/pecl-networking-ssh2.git", :branch => "php5"

  bottle do
    cellar :any
    sha256 "4655bb01c119db2ca5dd30d05ddc019ad940c4ec2d2d4253835480ac23b8ea1f" => :el_capitan
    sha256 "8c6f533277363266175f65a03f2ae4d67c7a030fb5d209b38342277cebfb2912" => :yosemite
    sha256 "8f64534ed66b98407cf47ab6e831271e679dae26def4eff66c1a29c83ab68954" => :mavericks
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
