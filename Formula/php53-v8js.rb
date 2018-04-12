require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53V8js < AbstractPhp53Extension
  init
  desc "PHP extension for Google's V8 Javascript engine"
  homepage "http://pecl.php.net/package/v8js"
  url "http://pecl.php.net/get/v8js-0.4.0.tgz"
  sha256 "0d52b999c12f9f74a0642f6c3f349002a39355295187e0b50344ea0ec64ae0bd"
  revision 2

  bottle do
    cellar :any
    sha256 "554516ad61e051d3ed3df44045c104697d80181dd37d4807e1ffacb310c5a46a" => :el_capitan
    sha256 "3b1ea6cda3e972b50d18cd8285a2dd0df67253813be1a79c2b0c1a3b6ed43a6d" => :yosemite
    sha256 "3409a554f1b5d16a5217a8f08da72e82fe82178849d02a52f8302267cd30733f" => :mavericks
  end

  depends_on "v8"

  def install
    Dir.chdir "v8js-#{version}" unless build.head?

    ENV.universal_binary if build.universal?
    ENV["CXXFLAGS"] = "-Wno-reserved-user-defined-literal"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/v8js.so"
    write_config_file if build.with? "config-file"
  end
end
