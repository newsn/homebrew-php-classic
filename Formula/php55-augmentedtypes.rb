require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Augmentedtypes < AbstractPhp55Extension
  init
  desc "A PHP extension to enforce parameter and return type annotations"
  homepage "https://github.com/box/augmented_types"
  url "https://github.com/box/augmented_types/archive/v0.6.6.tar.gz"
  sha256 "54b295f902e56daf1347b1e1f7d633a84c3e03aacac78424e6314adfd922e4db"
  head "https://github.com/box/augmented_types.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 2
    sha256 "04d79c57961677753ca462fb4b29e7f81999d9d0370159faffd3c11ee6949aac" => :el_capitan
    sha256 "d4918039698baa527b5d221e2beb5a358faea88ff97d559fbc596fe6889c9b8a" => :yosemite
    sha256 "32b2caa811eafc42964d13a232b5b8a2b92f4830290d75a94e18de2ec4de72ab" => :mavericks
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
