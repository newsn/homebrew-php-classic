require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Msgpack < AbstractPhp53Extension
  init
  desc "MessagePack serialization"
  homepage "https://pecl.php.net/package/msgpack"
  url "https://pecl.php.net/get/msgpack-0.5.7.tgz"
  sha256 "b8ee20cd0a79426c1abd55d5bbae85e5dcfbe0238abf9ce300685fbe76d94cdf"
  head "https://github.com/msgpack/msgpack-php.git"

  bottle do
    cellar :any
    sha256 "fa5e840c1a12ae9985b7963a1e8117d228db7c376d5dc38725c3ccad2e2d4bd6" => :yosemite
    sha256 "788cfde7d51d8105c828bd92cf4b818d3d9eaaf19ec00b647c539456a2a17f0a" => :mavericks
    sha256 "9f0fd3d531a294d271220399b809f238bb751880aa515bb838441859baff57e1" => :mountain_lion
  end

  def install
    Dir.chdir "msgpack-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/msgpack.so"
    write_config_file if build.with? "config-file"
  end
end
