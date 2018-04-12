require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Jsmin < AbstractPhp56Extension
  init
  desc "PHP extension for minifying JavaScript."
  homepage "https://pecl.php.net/package/jsmin"
  url "https://pecl.php.net/get/jsmin-1.1.0.tgz"
  sha256 "9cf4180a816bac08300c45083410ca536200bd4940db0174026b9a825161f159"
  head "https://github.com/sqmk/pecl-jsmin.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 2
    sha256 "54a471c4d0d7db20ca28e32c51ccdc2a62eb2f8fcce158781ad8f03c977b76bd" => :el_capitan
    sha256 "b00729b16571641993488d9d0900f4cb5ccab0f485383c27cc92cf27f411bbce" => :yosemite
    sha256 "9f9c3b3db797c8a1ce8010abdc1ca575cbf4e579e8c28ec48df276fd0ef3aef5" => :mavericks
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
