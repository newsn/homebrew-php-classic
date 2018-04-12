require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Lzf < AbstractPhp72Extension
  init
  desc "handles LZF de/compression"
  homepage "https://pecl.php.net/package/lzf"
  url "https://pecl.php.net/get/LZF-1.6.5.tgz"
  sha256 "dd116d12a3be985f42256650ce9a033fd3c4e8da4f2280c79fb9fd6a73199a4c"
  head "https://github.com/php/pecl-file_formats-lzf.git"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "ccaa8cdf1be424f858b0fcc04681fbccd22d576ea63cab5d4eb74d378748beb7" => :high_sierra
    sha256 "c7277d17636bd18fdf5916507829be0708e7911687f30a3afe6cf9ad6c84559f" => :sierra
    sha256 "d511d82bba167b247731350f3ad7e1417c482a55f3b9fa5613c6b08041ff9fa7" => :el_capitan
  end

  def install
    Dir.chdir "LZF-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/lzf.so"
    write_config_file if build.with? "config-file"
  end
end
