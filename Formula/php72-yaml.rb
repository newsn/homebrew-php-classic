require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Yaml < AbstractPhp72Extension
  init
  desc "YAML-1.1 parser and emitter"
  homepage "https://pecl.php.net/package/yaml"
  url "https://pecl.php.net/get/yaml-2.0.0.tgz"
  sha256 "ef13ff56c184290c025a522bf9ae2e1b3ecc8543c3a5161dd02adec90897a221"
  head "https://github.com/php/pecl-file_formats-yaml.git", :branch => "php7"
  revision 1

  bottle do
    sha256 "75bd9238267a0b1f173e08aa6464aa9d237eaff7dd373165efbe7e4e63ad4c6a" => :high_sierra
    sha256 "22a40f5c39736c6a91c34ce4ddc3019cefba394da794dc77ad294d2d773bd8c7" => :sierra
    sha256 "a6027cba46870bc7d51de83e30568a6aad8eb6b898d2ef2f63bb00803fb8b9dd" => :el_capitan
  end

  depends_on "libyaml"

  def install
    Dir.chdir "yaml-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-yaml=#{Formula["libyaml"].opt_prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/yaml.so"
    write_config_file if build.with? "config-file"
  end
end
