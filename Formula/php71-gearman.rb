require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Gearman < AbstractPhp71Extension
  init
  desc "PHP wrapper to libgearman"
  homepage "https://github.com/wcgallego/pecl-gearman"
  url "https://github.com/wcgallego/pecl-gearman/archive/gearman-2.0.3.tar.gz"
  sha256 "f71e8ff218f31e3b9a15534e18846b9f9526319daffcc12e76b545889e44e130"
  head "https://github.com/wcgallego/pecl-gearman.git"

  bottle do
    sha256 "348ef528d05befa4725cad9865d196441f6c09e8f55d468fdcd8fd17c9599715" => :sierra
    sha256 "e58135821ab595f235a7221fd3bd3783a5009133836e6ee110ed6fc336d54464" => :el_capitan
    sha256 "d24bf4bc04ba80be00690eef0612884788c82d59f58c1f30e545719d0ebc7400" => :yosemite
  end

  depends_on "gearman"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-gearman=#{Formula["gearman"].opt_prefix}"

    system "make"
    prefix.install "modules/gearman.so"
    write_config_file if build.with? "config-file"
  end
end
