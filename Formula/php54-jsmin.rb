require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Jsmin < AbstractPhp54Extension
  init
  desc "PHP extension for minifying JavaScript."
  homepage "https://pecl.php.net/package/jsmin"
  url "https://pecl.php.net/get/jsmin-1.1.0.tgz"
  sha256 "9cf4180a816bac08300c45083410ca536200bd4940db0174026b9a825161f159"
  head "https://github.com/sqmk/pecl-jsmin.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 2
    sha256 "c936358a2d26ee3b6be79109d89b7929a94997ada27992bb5d707e5ae0c03b1c" => :el_capitan
    sha256 "7187d78a3be670b9ed4296e30e257f9646fa38790a818a9bcea699faba19ceff" => :yosemite
    sha256 "85a86e2652342cf7b43cf942cd4806154dd61780ffe4a764c03ce239a76e9e50" => :mavericks
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
