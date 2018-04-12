require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72ApcuBc < AbstractPhp72Extension
  init
  desc "APC User Cache - BC"
  homepage "https://pecl.php.net/package/apcu_bc"
  url "https://pecl.php.net/get/apcu_bc-1.0.3.tgz"
  sha256 "40b63ada315ffce81e2e8d75162606090e1cc72fe94207bc7daa6dd260694919"
  head "https://github.com/krakjoe/apcu-bc.git"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "29036fe68b6eb06c43036618f04acfbc1968ef0cbdd84bc97977f975a2c78c65" => :high_sierra
    sha256 "8bea9ebfd8e60e4d225df409d5ecd0fc894b8195f0b3fccda496106b76141ae5" => :sierra
    sha256 "dd02cf01ff9db6d2ab6448c4be5bbffe19b514d9eddc570eb101dd0a04f6adab" => :el_capitan
  end

  depends_on "php72-apcu"

  def install
    Dir.chdir "apcu_bc-#{version}" unless build.head?

    args = []
    args << "--enable-apc"

    safe_phpize

    # link in the apcu extension headers
    mkdir_p "ext/apcu"
    cp Dir.glob("#{Formula["php72-apcu"].opt_prefix}/include/*.h"), "ext/apcu/"

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
