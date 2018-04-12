require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Yaml < AbstractPhp54Extension
  init
  homepage "https://pecl.php.net/package/yaml"
  desc "YAML-1.1 parser and emitter"
  url "https://pecl.php.net/get/yaml-1.3.0.tgz"
  sha256 "bf4696386fbd4e8435628d84ccb8c261c9e481888c7e1ce537cccceadcb57500"
  head "https://github.com/php/pecl-file_formats-yaml.git"

  bottle do
    sha256 "4a6adb310388f21372e4a7ca8248bc8cb4840ebb49c4c529a6a50b2a5b694a37" => :sierra
    sha256 "011ff1f07dbf0ac00785481e42dbddc553b6c815a996e9809a3fffc5f1d7c97d" => :el_capitan
    sha256 "b7c3cd6466927103cb8ef6c9c60d54aef978d08fb6caba953dccd8c2aec2672b" => :yosemite
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
