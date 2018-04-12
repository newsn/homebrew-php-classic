require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Gearman < AbstractPhp70Extension
  init
  desc "PHP wrapper to libgearman"
  homepage "https://github.com/wcgallego/pecl-gearman"
  url "https://github.com/wcgallego/pecl-gearman/archive/gearman-2.0.3.tar.gz"
  sha256 "f71e8ff218f31e3b9a15534e18846b9f9526319daffcc12e76b545889e44e130"
  head "https://github.com/wcgallego/pecl-gearman.git"

  bottle do
    sha256 "0e4e36c3a76c147de987773e487313da112b06495ab1dc3d577ff4c4f8e4a9e1" => :sierra
    sha256 "d8cae1a69fb8c91ae6e088060ce996529cc760df2478973ad64065a9c04d3a94" => :el_capitan
    sha256 "a2ddcff230e2441c8773cfc01c9c7895f7c986487811b2599700de8bc22f4c58" => :yosemite
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
