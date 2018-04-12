require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Apcu < AbstractPhp54Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://pecl.php.net/get/apcu-4.0.11.tgz"
  sha256 "454f302ec13a6047ca4c39e081217ce5a61bbea815aec9c1091fb849e70b4d00"
  head "https://github.com/krakjoe/apcu.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "290903d4aafd2804639f1f26bfa625e7c92a35c927e1cb6f76a395b2ed30d315" => :el_capitan
    sha256 "41eff81439112260d92a285cec34a7775300f5d25b934664791dbee8a6c442ee" => :yosemite
    sha256 "118bb2d1044a056998fc616e2bfb4f4a641bf90a82fbe87196a11323cb0e703c" => :mavericks
  end

  option "with-apc-bc", "Whether APCu should provide APC full compatibility support"
  depends_on "pcre"
  conflicts_with "php54-apc", :because => "Provides conflicting functionality"

  def install
    Dir.chdir "apcu-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    args = []
    args << "--enable-apcu"
    args << "--enable-apc-bc" if build.with? "apc-bc"

    safe_phpize

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          *args
    system "make"
    prefix.install "modules/apcu.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<~EOS
      apc.enabled=1
      apc.shm_size=64M
      apc.ttl=7200
      apc.mmap_file_mask=/tmp/apc.XXXXXX
      apc.enable_cli=1
    EOS
  end
end
