require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Apc < AbstractPhp54Extension
  init
  desc "Alternative PHP cache"
  homepage "https://pecl.php.net/package/apc"
  url "https://pecl.php.net/get/APC-3.1.13.tgz"
  sha256 "5ef8ba07729e72946e95951672a5378bed98cb5a294e79bf0f0a97ac62829abd"
  head "https://svn.php.net/repository/pecl/apc/trunk/"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "8aa922f5df52fd402f89829b5512df93794243dc907d1b352db8104fb63d0bc1" => :el_capitan
    sha256 "810fb3ca352857b8dfec0956a02d19aea2f5c5b5d6ed848ce3b9a753587a345a" => :yosemite
    sha256 "65f120d04ea19ea5b8da40517cd3f382306c1cee5eb167b61b353d4778deccf9" => :mavericks
  end

  depends_on "pcre"
  conflicts_with "php54-apcu", :because => "Provides conflicting functionality"

  def install
    Dir.chdir "APC-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-apc-pthreadmutex"
    system "make"
    prefix.install %w[modules/apc.so apc.php]
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<~EOS
      apc.enabled=1
      apc.shm_segments=1
      apc.shm_size=64M
      apc.ttl=7200
      apc.user_ttl=7200
      apc.num_files_hint=1024
      apc.mmap_file_mask=/tmp/apc.XXXXXX
      apc.enable_cli=0
    EOS
  end
end
