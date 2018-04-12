require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Ev < AbstractPhp71Extension
  init
  desc "interface to libev library"
  homepage "https://pecl.php.net/package/ev"
  url "https://pecl.php.net/get/ev-1.0.3.tgz"
  sha256 "3c03fde9e72745e6ce6c32d680218389e0f4310908187f1529b7f227b295aeee"
  head "https://bitbucket.org/osmanov/pecl-ev.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "9dbcdcfc67dc031245a5c8b560e035d64e0a2b7d38c6f99827f74597245adcae" => :el_capitan
    sha256 "374697cc68bae92d27061f04ac755e6816558d56b85e693daaff6cb9995cae72" => :yosemite
    sha256 "68831fa0040e0ccecb4469636ac680c73d878045e5d13e0d158f7cf171c346a2" => :mavericks
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
