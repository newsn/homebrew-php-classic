require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Raphf < AbstractPhp55Extension
  init
  desc "A reusable split-off of pecl_http's persistent handle and resource factory API."
  homepage "https://pecl.php.net/package/raphf"
  url "https://pecl.php.net/get/raphf-1.0.4.tgz"
  sha256 "461be283e89d94186a3ed4651b92c7c1a067bad7b6476d0ca7ac8863dc1ed8bf"

  bottle do
    sha256 "5a8d7f32ef0fca8a2fb7d7053a1c383d8e5ff3ed30721f2727314dda878212bc" => :yosemite
    sha256 "46baa813e95c08820b316567b9e2042d16a82015fa8bfe003f551c5dff546f24" => :mavericks
    sha256 "5575d48f00debf739c73e12f4f86e713aab59d8d708696e739795de4691a1de7" => :mountain_lion
  end

  def install
    Dir.chdir "raphf-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    include.install "php_raphf.h"
    prefix.install "modules/raphf.so"
    write_config_file if build.with? "config-file"
  end
end
