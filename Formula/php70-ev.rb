require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Ev < AbstractPhp70Extension
  init
  desc "interface to libev library"
  homepage "https://pecl.php.net/package/ev"
  url "https://pecl.php.net/get/ev-1.0.3.tgz"
  sha256 "3c03fde9e72745e6ce6c32d680218389e0f4310908187f1529b7f227b295aeee"
  head "https://bitbucket.org/osmanov/pecl-ev.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "db5f3bb9fef3ef8e1e707c16c54116b029ff839f53674bf8747911da20c5494f" => :el_capitan
    sha256 "028d6d1e66d4369c960d690ea999ff4418e4fb35c349419e43382f525deb9df2" => :yosemite
    sha256 "b9f2b5e08a531df1038e536a11a718b723fa174bb317d8a8bcd19a327b1838a9" => :mavericks
  end

  depends_on "libev"

  def install
    Dir.chdir "ev-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-libev=#{Formula["libev"].opt_prefix}"
    system "make"
    prefix.install "modules/ev.so"
    write_config_file if build.with? "config-file"
  end
end
