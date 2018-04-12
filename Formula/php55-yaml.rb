require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Yaml < AbstractPhp55Extension
  init
  homepage "https://pecl.php.net/package/yaml"
  desc "YAML-1.1 parser and emitter"
  url "https://pecl.php.net/get/yaml-1.3.0.tgz"
  sha256 "bf4696386fbd4e8435628d84ccb8c261c9e481888c7e1ce537cccceadcb57500"
  head "https://github.com/php/pecl-file_formats-yaml.git"

  bottle do
    sha256 "f1d23e893f8e7c60c9ee59e2bd3237b546f4f3aa4ccfee82548c1fedb118d6c9" => :sierra
    sha256 "7f60aab1e57fae5fd4d8f11be0301f333972a22a517dd69607a84f000a79e3d1" => :el_capitan
    sha256 "21d6d302c4cfb18caf7e9b9847338dcf179c198466add4e5b0935659474979e6" => :yosemite
  end

  depends_on "libyaml"

  def install
    Dir.chdir "yaml-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-yaml=#{Formula["libyaml"].opt_prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/yaml.so"
    write_config_file if build.with? "config-file"
  end
end
