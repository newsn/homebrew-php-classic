require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Htscanner < AbstractPhp54Extension
  init
  desc "Fork of the htscanner project with additional settings to facilitate shared webhosting providers."
  homepage "https://github.com/piannelli/htscanner-enhanced"
  url "https://github.com/piannelli/htscanner-enhanced/archive/b62ad43105758fe9f513a0730c3bbef0dfd2ee37.tar.gz"
  sha256 "b014dafb36313c67f88b961799b9841e816de1fd3dc66bbf2ce5964c40f4e221"
  version "b62ad431"
  head "https://github.com/piannelli/htscanner-enhanced.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "4959e686b3405e91783182dc4240ce48bc1cf0b5519e9062ccf7d159b0422ed8" => :el_capitan
    sha256 "520181a4fbcf44d7d28c08522f60b12641e1784f616aafe3dd81168ea0405d79" => :yosemite
    sha256 "8b13ba61684e8e790231ebb0a500b0c85f6cbee6a8c87ea14468b1a04afe6e58" => :mavericks
  end

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/htscanner.so"
    write_config_file if build.with? "config-file"
  end

  def config_file
    super + <<~EOS
      htscanner.config_file = .htaccess
      htscanner.default_ttl = 300
      htscanner.stop_on_error = 0
      htscanner.verbose = 0
    EOS
  end

  def caveats
    super + <<~EOS
      With this small modification in htscanner,
      you can force it to always use the default docroot set in the php.ini configuration.

      Getting back to the previous example,
      assuming you are hosting your vhosts under /home/public_html,
      you might set the following parameters :

        htscanner.default_docroot = /home
        htscanner.force_default_docroot = 1

        and place a .htaccess inside /home/ that cannot be modified/deleted (and even not be read) by the user.
    EOS
  end
end
