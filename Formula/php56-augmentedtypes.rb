require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Augmentedtypes < AbstractPhp56Extension
  init
  desc "A PHP extension to enforce parameter and return type annotations"
  homepage "https://github.com/box/augmented_types"
  url "https://github.com/box/augmented_types/archive/v0.6.6.tar.gz"
  sha256 "54b295f902e56daf1347b1e1f7d633a84c3e03aacac78424e6314adfd922e4db"
  head "https://github.com/box/augmented_types.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 2
    sha256 "18c3734c3665d920d61e4e5ce1a4783472087d3a30d3cf791172bca8719f32c7" => :el_capitan
    sha256 "3893468b16c008b14e659107e163bd0a4108c0929e52b23f19b930d94af13484" => :yosemite
    sha256 "c971a65afa8d30c79672f6b0e4c1f49134662053cc9887795dc5e371e0841c54" => :mavericks
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
