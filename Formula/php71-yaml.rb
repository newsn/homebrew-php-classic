require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Yaml < AbstractPhp71Extension
  init
  desc "YAML-1.1 parser and emitter"
  homepage "https://pecl.php.net/package/yaml"
  url "https://pecl.php.net/get/yaml-2.0.0.tgz"
  sha256 "ef13ff56c184290c025a522bf9ae2e1b3ecc8543c3a5161dd02adec90897a221"
  head "https://github.com/php/pecl-file_formats-yaml.git", :branch => "php7"

  bottle do
    sha256 "844ce4f439a430accbe015f18208a349a5f8ba44d8033cca0c310ba95b13e7ea" => :sierra
    sha256 "0812481119e076e37d0e08ae121e1cff29d09a28ac223c08c85286f6477ee4a8" => :el_capitan
    sha256 "a4e41bd3df6502a7d4a1d7ba6eb97b486c7bc9c5d5a3a244db762a8e1be4e032" => :yosemite
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
