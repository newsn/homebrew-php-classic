require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Apcu < AbstractPhp55Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://pecl.php.net/get/apcu-4.0.11.tgz"
  sha256 "454f302ec13a6047ca4c39e081217ce5a61bbea815aec9c1091fb849e70b4d00"
  head "https://github.com/krakjoe/apcu.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "df836b0716914b0a0c08d8a50db78d9f3c2c251550abc2ff560e62e1c137a62a" => :el_capitan
    sha256 "0fbb49c139c21644f20712c6e4d143df88c5a7377746b3d49db7b9f7615468d7" => :yosemite
    sha256 "6d1dd1e87c527f535dc33a56564481f705766e89aab8102562f04816779885fd" => :mavericks
  end

  option "with-apc-bc", "Whether APCu should provide APC full compatibility support"
  depends_on "pcre"

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
