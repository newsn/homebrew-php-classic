require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Sundown < AbstractPhp54Extension
  init
  desc "Sundown is a fast, robust Markdown parsing library for PHP5"
  homepage "https://pecl.php.net/package/sundown"
  url "https://pecl.php.net/get/sundown-0.3.11.tgz"
  sha256 "0a143a268f43f5f2a07988116acfa62671fad4636b84c0750327042f9cb8004f"

  bottle do
    cellar :any_skip_relocation
    sha256 "8df72255a4db975e13bdf31f51b6640a7b44fa69b395d636a66273c4693129a1" => :el_capitan
    sha256 "465164249bf3800cb10909fffafbfe509f21136ab5b9ec163af58801c3a2cef8" => :yosemite
    sha256 "613dfe5f5ae03b3a396f6058933ac2df1c2115f360dd1b65bc3c2f5209635588" => :mavericks
  end

  def install
    Dir.chdir "sundown-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/sundown.so"
    write_config_file if build.with? "config-file"
  end
end
