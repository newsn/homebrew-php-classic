require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Ev < AbstractPhp56Extension
  init
  desc "interface to libev library"
  homepage "https://pecl.php.net/package/ev"
  url "https://pecl.php.net/get/ev-1.0.3.tgz"
  sha256 "3c03fde9e72745e6ce6c32d680218389e0f4310908187f1529b7f227b295aeee"
  head "https://bitbucket.org/osmanov/pecl-ev.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "cb3de2c2e8aed2e59c176066be7305aeeb53a3d5c7a26ce041d1a962fe0d8bb9" => :el_capitan
    sha256 "30675f58906b43e28cb60c0a36ba5d9b203c8291d0002bbf1f4f03b62edcfc9b" => :yosemite
    sha256 "55b8cff3ab9faff6cfc7d8ec675cbbc185d98b15acf3c0a9be99a35bd1c342a5" => :mavericks
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
