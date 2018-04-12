require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Augmentedtypes < AbstractPhp54Extension
  init
  desc "A PHP extension to enforce parameter and return type annotations"
  homepage "https://github.com/box/augmented_types"
  url "https://github.com/box/augmented_types/archive/v0.6.6.tar.gz"
  sha256 "54b295f902e56daf1347b1e1f7d633a84c3e03aacac78424e6314adfd922e4db"
  head "https://github.com/box/augmented_types.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 2
    sha256 "2b3e32eddda4f5f7e353ea3b158967910bd516c1d494b40a9f714885134f9372" => :el_capitan
    sha256 "32d98cbf66f51200ff31aec85ddb63285b2e1ec9b3d7a4a97e2692ca9dc109bf" => :yosemite
    sha256 "8d9f3b24c7fbee4cced4d3ff22ce5f691dd5d06e23d1b82452d8f1bbd148c6ef" => :mavericks
  end

  option "without-default-enforcement", "Turn off Augmented Types enforcement by default"

  def extension_type
    "zend_extension"
  end

  def extension
    "augmented_types"
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-augmented_types"
    system "make"
    prefix.install "modules/augmented_types.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    if active_spec.build.with? "default-enforcement"
      super + <<~EOS
        augmented_types.enforce_by_default = 1
      EOS
    else
      super
    end
  end
end
