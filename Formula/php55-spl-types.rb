require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55SplTypes < AbstractPhp55Extension
  init
  desc "SPL Types is a collection of special typehandling classes."
  homepage "https://pecl.php.net/package/SPL_Types"
  url "https://pecl.php.net/get/SPL_Types-0.4.0.tgz"
  sha256 "b44101401b2664822fd17e6f491d912203496108ff9d0b86b043bff67c5f724f"

  bottle do
    cellar :any_skip_relocation
    sha256 "f33b4049c4e032dfc3e2eab93fc7c0fbf3570bced50f4a7924fe40a168d1aba2" => :el_capitan
    sha256 "d2cf616b7444f975dc0f22d78f48415592784d37cecfea68bbc167b46a5dadfd" => :yosemite
    sha256 "b46c05419cdc25fb7a079a4b8ce760c0bff2582d152238d19b9e0bb3bbd6ea5c" => :mavericks
  end

  def install
    Dir.chdir "SPL_Types-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/spl_types.so"
    write_config_file if build.with? "config-file"
  end

  def extension
    "spl_types"
  end
end
