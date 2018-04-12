require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71ApcuBc < AbstractPhp71Extension
  init
  desc "APC User Cache - BC"
  homepage "https://pecl.php.net/package/apcu_bc"
  url "https://pecl.php.net/get/apcu_bc-1.0.3.tgz"
  sha256 "40b63ada315ffce81e2e8d75162606090e1cc72fe94207bc7daa6dd260694919"
  head "https://github.com/krakjoe/apcu-bc.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "37513b1f0e27f109b2ac39d05c424e5460808934b863265cfaae3e915f01c45d" => :sierra
    sha256 "65c4128fd59f141ea2ab48506c0b44b4a7e4d368ae9e46036ed44bca042b5325" => :el_capitan
    sha256 "76cebfd3e6b5751882d0e9a8fb32f200ac0f5bdea0e010f2c89f9ca3bc4a0685" => :yosemite
  end

  depends_on "php71-apcu"

  def install
    Dir.chdir "apcu_bc-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--enable-apc"

    safe_phpize

    # link in the apcu extension headers
    mkdir_p "ext/apcu"
    cp Dir.glob("#{Formula["php71-apcu"].opt_prefix}/include/*.h"), "ext/apcu/"

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          *args
    system "make"
    prefix.install "modules/apc.so"
    write_config_file if build.with? "config-file"
  end

  def extension
    "apc"
  end

  # This is changed so that it will be included after apcu
  def config_filename
    "ext-bc-" + extension + ".ini"
  end
end
