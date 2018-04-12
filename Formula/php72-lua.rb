require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Lua < AbstractPhp72Extension
  init
  desc "This extension embeds the lua interpreter.."
  homepage "https://pecl.php.net/package/lua"
  url "https://pecl.php.net/get/lua-2.0.5.tgz"
  sha256 "bb49431ce5494ebebba98d9c477537df97234e13d4bd46529809ca1a2b8c287e"
  head "https://github.com/laruence/php-lua.git"

  bottle do
    sha256 "26e940be2456ae32e982103d2e2230b2e521be36088e111e7a4a038174a1d9a4" => :high_sierra
    sha256 "86d2c09ffb494636c638190f6152c6e61d1d748991b4df856a921492f786ad06" => :sierra
    sha256 "5e4fa78d0272729298fa1ba47edccb1e0964dbbc909d198629fba757af028314" => :el_capitan
  end

  depends_on "lua"

  def install
    Dir.chdir "lua-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-lua=#{Formula["lua"].opt_prefix}"
    system "make"
    prefix.install "modules/lua.so"
    write_config_file if build.with? "config-file"
  end
end
