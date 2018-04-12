require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Htscanner < AbstractPhp55Extension
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
    sha256 "ccb30c5dd2246505ab4beb9e76b1c2556c11b235d3003a8cf05614be5ef2d2e6" => :el_capitan
    sha256 "c9258fb2664f1df843d51f08709b72189353af268c00d710960e166ed20cfd4b" => :yosemite
    sha256 "ada79f2529a927f0f3405998a4cc1714630a08d766218136dcc28439687e3932" => :mavericks
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
