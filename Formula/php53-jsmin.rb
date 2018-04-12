require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Jsmin < AbstractPhp53Extension
  init
  desc "PHP extension for minifying JavaScript."
  homepage "https://pecl.php.net/package/jsmin"
  url "https://pecl.php.net/get/jsmin-1.1.0.tgz"
  sha256 "9cf4180a816bac08300c45083410ca536200bd4940db0174026b9a825161f159"
  head "https://github.com/sqmk/pecl-jsmin.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 2
    sha256 "f75c4c277f2e2cb999242a5d92d4e6a21dcd283d7f6c89f56f05586dd339563e" => :el_capitan
    sha256 "5f21aa64ad3368b38c3dc81aae139507602f70628de698176bb91f8fa86520ff" => :yosemite
    sha256 "b80856ff6e451d1c2db37f07b511e7dfc8f582d61bdfcb527490179e95e808ad" => :mavericks
  end

  def install
    Dir.chdir "jsmin-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/jsmin.so"
    write_config_file if build.with? "config-file"
  end
end
