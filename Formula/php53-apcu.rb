require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Apcu < AbstractPhp53Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://pecl.php.net/get/apcu-4.0.11.tgz"
  sha256 "454f302ec13a6047ca4c39e081217ce5a61bbea815aec9c1091fb849e70b4d00"
  head "https://github.com/krakjoe/apcu.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "770d3cecca184958fdde7b92687c7d3e267469978d0a9329c51c33ae99c7848f" => :el_capitan
    sha256 "c0cb061bc2037be34de55199503bcff8cdac628a70feaf3e453614f3178301e4" => :yosemite
    sha256 "2032d21936549048a92c466535691ba96ace8eef99f94dc9afcd759650b4e1fd" => :mavericks
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
