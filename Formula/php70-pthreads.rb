require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pthreads < AbstractPhp70Extension
  init ["with-thread-safety"]
  desc "Threading API"
  homepage "https://pecl.php.net/package/pthreads"
  url "https://pecl.php.net/get/pthreads-3.1.6.tgz"
  sha256 "bb13da909a7a7ae1f9e499166103a2d24628993238ce03a8aae3eaa492c0b736"
  head "https://github.com/krakjoe/pthreads.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "1788eb9884e09851dfba1c7812f492f37212169058d97c17c0e998c679487046" => :sierra
    sha256 "06df847578c7dfccc17b3752b61f92bff5f5f8f96ca5697519f4e0425b48f415" => :el_capitan
    sha256 "dd8af777dc292e69d00795ad59ae0e37b56be191349759be5e923ec55514aea0" => :yosemite
  end

  def install
    Dir.chdir "pthreads-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/pthreads.so"
    write_config_file if build.with? "config-file"
  end
end
