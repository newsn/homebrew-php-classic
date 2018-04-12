require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Apcu < AbstractPhp72Extension
  init
  desc "APC User Cache"
  homepage "https://pecl.php.net/package/apcu"
  url "https://github.com/krakjoe/apcu/archive/v5.1.8.tar.gz"
  sha256 "09848619674a0871053cabba3907d2aade395772d54464d3aee45f519e217128"
  head "https://github.com/krakjoe/apcu.git"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "b6dd92f03b31a521b4ad88a677f8f94d8ca094951c911813b7f5da1d04527298" => :sierra
    sha256 "60bcb709ff7d55fcab39e84ecade5a04b1ae758de01b56509b4b38906ee84bc4" => :el_capitan
    sha256 "d2529346a06fbf8c51442c478fb8ee9e08c4227ec1adfc65cc293babac157a26" => :yosemite
  end

  depends_on "pcre"

  def install
    args = []
    args << "--enable-apcu"

    safe_phpize

    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          *args
    system "make"
    # Keep all the headers that are needed to build php-apc-bc
    include.install [
      "php_apc.h",
      "apc.h",
      "apc_globals.h",
      "apc_cache.h",
      "apc_stack.h",
      "apc_lock.h",
      "apc_pool.h",
      "apc_cache_api.h",
      "apc_lock_api.h",
      "apc_sma.h",
      "apc_pool_api.h",
      "apc_sma_api.h",
      "apc_arginfo.h",
      "apc_iterator.h",
    ]
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
