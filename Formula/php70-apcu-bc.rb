require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70ApcuBc < AbstractPhp70Extension
  init
  desc "APC User Cache - BC"
  homepage "https://pecl.php.net/package/apcu_bc"
  url "https://pecl.php.net/get/apcu_bc-1.0.3.tgz"
  sha256 "40b63ada315ffce81e2e8d75162606090e1cc72fe94207bc7daa6dd260694919"
  head "https://github.com/krakjoe/apcu-bc.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "2fca217cd144746aa427b6a3487f4b97a37de34363a0286b540d601b87ee92c3" => :sierra
    sha256 "c06cb9ca8577a8fe16cbcde4e8417a48062bcb7e46851063a792f66a7a0a11da" => :el_capitan
    sha256 "a0daeba4631fc3abe5aa3cb98bd736035b81c18edf117dd399c29584c31fd37a" => :yosemite
  end

  depends_on "php70-apcu"

  def install
    Dir.chdir "apcu_bc-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--enable-apc"

    safe_phpize

    # link in the apcu extension headers
    mkdir_p "ext/apcu"
    cp Dir.glob("#{Formula["php70-apcu"].opt_prefix}/include/*.h"), "ext/apcu/"

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

