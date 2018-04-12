require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Lua < AbstractPhp71Extension
  init
  desc "This extension embeds the lua interpreter.."
  homepage "https://pecl.php.net/package/lua"
  url "https://pecl.php.net/get/lua-2.0.5.tgz"
  sha256 "bb49431ce5494ebebba98d9c477537df97234e13d4bd46529809ca1a2b8c287e"
  head "https://github.com/laruence/php-lua.git"

  bottle do
    sha256 "582260b95a4d79bf57784f766bd9543958b0b0a35e5b2709e73194ea69bc2ade" => :high_sierra
    sha256 "b0aa1ef7ab888d77dbceb9967833289e64300d317fff2815cd57eea6831d3c96" => :sierra
    sha256 "9f8236a55399cd33dc19ed39e474a7f389b0eb858d41d5a760e2e0c6352332c1" => :el_capitan
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
