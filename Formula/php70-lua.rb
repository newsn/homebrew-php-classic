require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Lua < AbstractPhp70Extension
  init
  desc "This extension embeds the lua interpreter.."
  homepage "https://pecl.php.net/package/lua"
  url "https://pecl.php.net/get/lua-2.0.5.tgz"
  sha256 "bb49431ce5494ebebba98d9c477537df97234e13d4bd46529809ca1a2b8c287e"
  head "https://github.com/laruence/php-lua.git"

  bottle do
    sha256 "87777bd523ab40829c788e9b52368b71bfa064b0ce67597c0df709cdfa5d960a" => :high_sierra
    sha256 "7710f0cbfc0bb3dcac6cf4a2a44dd85adbc8bed07d31600f00cbc5aa6f89a7de" => :sierra
    sha256 "2719fb55ce107f456b7213afee441360e1b8423d1b660eedffed75a3cda16b5c" => :el_capitan
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
